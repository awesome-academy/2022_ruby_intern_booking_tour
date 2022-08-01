class TourMailer < ApplicationMailer
  def send_update_tour tour
    tour_requests = TourRequest.pending.by_tour_id(tour.id)

    emails = tour_requests.map(&:user_email)

    emails.each do |email|
      new_request(email, tour).deliver_now
    end
  end

  def new_request email, row
    @tour = row

    mail(to: email, subject: I18n.t(".subject"))
  end
end
