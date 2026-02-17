class StatusAnalyticsController < ApplicationController
  menu_item :status_analytics
  before_action :find_project
  before_action :authorize

  def index
    @issues = @project.issues
    
    @durum_sureleri = Hash.new(0)

    @issues.each do |issue|
      gecmis_zaman = issue.created_on
      
      durum_degisimleri = issue.journals.joins(:details).where(journal_details: { prop_key: 'status_id' }).order(:created_on)

      durum_degisimleri.each do |journal|
        su_anki_durum_id = journal.details.find_by(prop_key: 'status_id').old_value
        durum_nesnesi = IssueStatus.find_by(id: su_anki_durum_id)
        
        if durum_nesnesi
          gecen_sure = journal.created_on - gecmis_zaman
          @durum_sureleri[durum_nesnesi.name] += gecen_sure
        end
        
        gecmis_zaman = journal.created_on
      end

      if issue.status
        @durum_sureleri[issue.status.name] += Time.now - gecmis_zaman
      end
    end

    # / 86400
    @etiketler = @durum_sureleri.keys
    @veriler = @durum_sureleri.values.map { |saniye| (saniye / 86400).round(2) }
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end

