class Admin::ReviewsController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin, :load_review, only: %i(destroy)

  def destroy
    total = Review.all.count
    index = Review.all.find_index(@review)
    if @review.destroy
      cur_page = handle_page total, index
      @pagy, @reviews = pagy(Review.all.most_recent,
                             items: Settings.review.admin_per_page,
                             page: cur_page)
      success_format t ".destroy_success"
    else
      danger_format t ".destroy_danger"
    end
  end

  def new; end

  private
  def handle_page total, index
    cur_page = ((total - index + 1) / Settings.review.admin_per_page).ceil + 1
    reviews = Review.limit(Settings.user.per_page).offset(
      Settings.review.admin_per_page * (cur_page - 1)
    )
    cur_page -= 1 if reviews.empty?
    cur_page
  end

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
  end
end
