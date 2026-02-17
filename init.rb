Redmine::Plugin.register :redmine_status_analytics do
  name 'Redmine Status Analytics'
  author 'Mehtap Gültepe'
  description 'İş durumlarını, kullanıcı performansını ve kategori bazlı zaman dağılımını analiz eden eklenti.'
  version '0.0.1'

  project_module :status_analytics do
    permission :view_status_analytics, :status_analytics => :index
  end
  menu :project_menu, :status_analytics, 
       { :controller => 'status_analytics', :action => 'index' }, 
       :caption => 'Analytics Dashboard', 
       :after => :activity, 
       :param => :project_id
end

