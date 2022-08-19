class Admin::RequestsHistoriesController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin, :load_review, only: %i(destroy)

  def index
    date = check_choices
    @pagy, @requests_histories = pagy(RequestHistory
      .select_statistic_col.joins(:user, :tour)
      .group_statistic_col
      .between_date_statistic(date)
      .after_date_statistic(date)
      .before_date_statistic(date)
      .specific_date_statistic(date), items: Settings.tours_request.per_admin)
    @sum = RequestHistory.statistic_sum date
    success_format t ".filter_success"
  end

  private
  def check_choices
    start_date = params[:start_date]
    end_date = params[:end_date]
    specific_date = params[:specific_date]
    choices = params[:choices]
    date = if choices == "between" && start_date.present? && end_date.present?
             {
               start_date: start_date,
               end_date: end_date
             }
           else
             {
               specific_date: specific_date
             }
           end
    check_params date
  end

  def check_params date
    case params[:choices]
    when "between"
      date[:between] = true
    when "after"
      date[:after] = true
    when "before"
      date[:before] = true
    when "specific"
      date[:specific] = true
    end
    date
  end
end
