Redmine::Plugin.register :redmine_status_analytics do
  name 'Redmine Status Analytics'
  author 'Mehtap Gültepe'
  description 'Project-based issue lifecycle and status analytics.'
  version '0.1.0'


  project_module :status_analytics do
    permission :view_status_analytics, :status_analytics => :index
  end

  menu :project_menu, :status_analytics, 
       { :controller => 'status_analytics', :action => 'index' }, 
       :caption => 'Analytics Dashboard', 
       :after => :activity, 
       :param => :project_id
end
