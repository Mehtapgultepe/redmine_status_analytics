class StatusAnalyticsController < ApplicationController

  menu_item :status_analytics
  before_action :find_project
  before_action :authorize # Yetkisi olmayanın girmesini engeller

  def index

    @issues = @project.issues
    @toplam = @issues.count
    @dagilim = @project.issues.group(:status).count
    
    @etiketler = @dagilim.keys.map(&:name)
    @veriler = @dagilim.values
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
