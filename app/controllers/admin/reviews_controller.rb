class Admin::ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin, :load_review, only: %i(destroy)

  def destroy
    if @review.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to @review.tour
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
  end
end
