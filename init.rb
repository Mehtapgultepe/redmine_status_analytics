Redmine::Plugin.register :redmine_status_analytics do
  name 'Redmine Status Analytics plugin'
  author 'Mehtap Gültepe'
  description 'Bu eklenti iş durumlarını analiz eder.'
  version '0.0.1'

  # Menüye ekleme satırı:
  menu :top_menu, :status_analytics, { :controller => 'status_analytics', :action => 'index' }, :caption => 'Analiz Paneli'
end
