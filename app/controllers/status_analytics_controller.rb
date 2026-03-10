class StatusAnalyticsController < ApplicationController
  menu_item :status_analytics
  before_action :find_project
  before_action :authorize

  def index
    # N+1 FIX: tüm ilişkili veriler tek sorguda çekiliyor
    @issues = @project.issues.includes(
      :status, :assigned_to, :category, :author,
      journals: { details: [] }
    )

    @durum_sureleri = Hash.new(0)
    @user_sureleri  = Hash.new(0)
    @cat_sureleri   = Hash.new(0)
    @is_listesi     = []

    @issues.each do |issue|
      # Sadece status_id değişikliği olan journal detayları
      durum_degisimleri = issue.journals.select do |j|
        j.details.any? { |d| d.prop_key == 'status_id' }
      end

      kullanici_adi = issue.assigned_to&.name || "Atanmamış"
      kategori_adi  = issue.category&.name    || "Kategorisiz"

      son_degisiklik = durum_degisimleri.last
      last_updater   = son_degisiklik ? son_degisiklik.user&.name : issue.author&.name
      last_updater ||= "Bilinmiyor"

      # Lifecycle hesaplama — nil guard ile
      is_detay_grafik   = Hash.new(0)
      gecmis_zaman_detay = issue.created_on

      durum_degisimleri.each do |j|
        detail  = j.details.find { |d| d.prop_key == 'status_id' }
        next unless detail  # nil guard: status_id detayı yoksa geç

        old_st = IssueStatus.find_by(id: detail.old_value)
        if old_st
          is_detay_grafik[old_st.name] += (j.created_on - gecmis_zaman_detay)
          gecmis_zaman_detay = j.created_on
        end
      end
      is_detay_grafik[issue.status.name] += (Time.now - gecmis_zaman_detay)

      is_verisi = {
        id:           issue.id,
        subject:      issue.subject,
        user:         kullanici_adi,
        last_updater: last_updater,
        category:     kategori_adi,
        total_time:   0,
        lifecycle:    is_detay_grafik.map { |k, v| { label: k, value: (v / 3600).round(2) } }
      }

      gecmis_zaman = issue.created_on
      durum_degisimleri.each do |journal|
        detail = journal.details.find { |d| d.prop_key == 'status_id' }
        next unless detail  # nil guard

        durum_nesnesi = IssueStatus.find_by(id: detail.old_value)
        if durum_nesnesi
          gecen_sure = journal.created_on - gecmis_zaman
          @durum_sureleri[durum_nesnesi.name] += gecen_sure
          is_verisi[:total_time]              += gecen_sure
          @user_sureleri[kullanici_adi]       += gecen_sure
          @cat_sureleri[kategori_adi]         += gecen_sure
        end
        gecmis_zaman = journal.created_on
      end

      @is_listesi << is_verisi
    end

    gun = 86400.0
    @user_labels = @user_sureleri.keys
    @user_data   = @user_sureleri.values.map { |v| (v / gun).round(2) }
    @cat_labels  = @cat_sureleri.keys
    @cat_data    = @cat_sureleri.values.map { |v| (v / gun).round(2) }
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
