class ApplicationController < ActionController::Base
  module AuthConcern
    extend ActiveSupport::Concern

    included do
      helper_method :current_user
    end

    class_methods do
      def guest!(*args)
        before_action(*args) { redirect_to :home if current_user.present? }
      end

      def user!(*args)
        before_action(*args) { redirect_to :root if current_user.blank? }
      end

      def admin!(*args)
        user!(*args)
        before_action(*args) { redirect_to main_path unless current_user.admin? }
      end
    end

    def current_user
      return nil if session[:cu].blank?
      @current_user ||= User.find_by(session_token: session[:cu])
    end

    def set_current_user_to(user)
      session[:cu] = user&.session_token
    end

    def unset_current_user
      set_current_user_to nil
    end
  end
end
