class AddColumnReasonRejectTourRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_requests, :reason_reject, :string
  end
end
