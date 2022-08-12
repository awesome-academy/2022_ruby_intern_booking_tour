class TourRequestMailer < ApplicationMailer
  def auth_tour_request tour_request
    @tour_request = tour_request
    mail to: tour_request.user.email, subject: t(".subject")
  end
end
