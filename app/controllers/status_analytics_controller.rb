class StatusAnalyticsController < ApplicationController
  menu_item :status_analytics
  before_action :find_project
  before_action :authorize

  def index
    @issues = @project.issues
    @durum_sureleri = Hash.new(0)
    @kullanici_sureleri = Hash.new(0)
    @kategori_sureleri = Hash.new(0)
    @is_listesi = []

    @issues.each do |issue|
      gecmis_zaman = issue.created_on
      durum_degisimleri = issue.journals.joins(:details).where(journal_details: { prop_key: 'status_id' }).order(:created_on)

      kullanici_adi = issue.assigned_to ? issue.assigned_to.name : "Atanmamış"
      kategori_adi = issue.category ? issue.category.name : "Kategorisiz"
      
      son_degisiklik = durum_degisimleri.last
      last_updater = son_degisiklik ? son_degisiklik.user.name : issue.author.name

      is_detay_grafik = Hash.new(0)
      gecmis_zaman_detay = issue.created_on
      
      durum_degisimleri.each do |j|
        old_val = j.details.find_by(prop_key: 'status_id').old_value
        old_st = IssueStatus.find_by(id: old_val)
        is_detay_grafik[old_st.name] += (j.created_on - gecmis_zaman_detay) if old_st
        gecmis_zaman_detay = j.created_on
      end
      is_detay_grafik[issue.status.name] += (Time.now - gecmis_zaman_detay)

      is_verisi = {
        id: issue.id,
        subject: issue.subject,
        user: kullanici_adi,
        last_updater: last_updater,
        category: kategori_adi,
        total_time: 0,
        lifecycle: is_detay_grafik.map { |k, v| { label: k, value: (v / 3600).round(2) } }
      }

      gecmis_zaman = issue.created_on
      durum_degisimleri.each do |journal|
        su_anki_durum_id = journal.details.find_by(prop_key: 'status_id').old_value
        durum_nesnesi = IssueStatus.find_by(id: su_anki_durum_id)
        if durum_nesnesi
          gecen_sure = journal.created_on - gecmis_zaman
          @durum_sureleri[durum_nesnesi.name] += gecen_sure
          @kullanici_sureleri[kullanici_adi] += gecen_sure
          @kategori_sureleri[kategori_adi] += gecen_sure
          is_verisi[:total_time] += gecen_sure
        end
        gecmis_zaman = journal.created_on
      end

      son_sure = Time.now - gecmis_zaman
      @durum_sureleri[issue.status.name] += son_sure
      @kullanici_sureleri[kullanici_adi] += son_sure
      @kategori_sureleri[kategori_adi] += son_sure
      is_verisi[:total_time] += son_sure
      
      @is_listesi << is_verisi
    end

    @user_labels = @kullanici_sureleri.keys
    @user_data = @kullanici_sureleri.values.map { |s| (s / 86400).round(3) }
    @cat_labels = @kategori_sureleri.keys
    @cat_data = @kategori_sureleri.values.map { |s| (s / 86400).round(3) }
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
