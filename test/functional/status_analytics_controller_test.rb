require File.expand_path('../../test_helper', __FILE__)

class StatusAnalyticsControllerTest < ActionController::TestCase
  fixtures :projects, :users, :issues, :issue_statuses, :journals, :journal_details

  def setup
    @project = Project.find(1)
    @request.session[:user_id] = 2 # admin kullanıcı
  end

  # Proje bulunabiliyorsa sayfa yüklenmeli
  def test_index_returns_success
    get :index, params: { project_id: @project.id }
    assert_response :success
  end

  # Geçersiz proje id ile 404 dönmeli
  def test_index_with_invalid_project
    get :index, params: { project_id: 99999 }
    assert_response 404
  end

  # is_listesi boş olmamalı
  def test_index_assigns_is_listesi
    get :index, params: { project_id: @project.id }
    assert_not_nil assigns(:is_listesi)
  end
end
