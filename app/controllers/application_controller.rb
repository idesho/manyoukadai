class ApplicationController < ActionController::Base
  include TasksHelper, SessionsHelper
  before_action :login_required, :logout_required

 #rescue_from ActiveRecord::RecordNotFound, with: :render_404
 #rescue_from ActionController::RoutingError, with: :render_404
 #rescue_from Exception, with: :render_500


 #def render_404
 #  render template: 'errors/404', status: 404, layout: 'application', content_type: 'text/html'
 #end
 #
 #def render_500
 #  render template: 'errors/500', status: 500, layout: 'application', content_type: 'text/html'
 #end

  private

  def login_required
    redirect_to new_session_path, flash: {warning: "ログインしてください"} unless current_user
  end

  def logout_required #ログイン中にログイン画面・アカウント作成画面へ飛んだ時の処理
    if logged_in? #current_userがnilか判断
      if request.fullpath == "/sessions/new" #request.fullpathで現在のpathを取得
        flash[:warning] = "ログアウトしてください" #ログイン画面にいたら移動
        redirect_to tasks_path
      elsif request.fullpath == "/users/new" #request.fullpathで現在のpathを取得
        flash[:warning] = "ログアウトしてください" #アカウント作成画面にいたら移動
        redirect_to tasks_path
      end
    end
  end

  
end