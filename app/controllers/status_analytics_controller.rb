class StatusAnalyticsController < ApplicationController
  def index
    @toplam = Issue.count
    @dagilim = Issue.group(:status).count
    @etiketler = @dagilim.keys.map(&:name)
    @veriler = @dagilim.values
  end
end

