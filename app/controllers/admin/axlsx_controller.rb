class Admin::AxlsxController < ApplicationController
  require "axlsx"

  def index
    data = JSON.parse(params[:data])
    send_xls data
  end

  private
  def send_xls data
    book = Axlsx::Package.new
    workbook = book.workbook
    sheet = workbook.add_worksheet name: "TourRequestInformation"
    sheet.add_row %w(name email price quantity count total_price)
    create_data(data).each do |item|
      sheet.add_row [item["tour_name"], item["email"], item["price"],
  item["quantity]"], item["count"], item["total_price"]]
      sheet.add_data_validation("B2",
                                {type: :list, formula1: "MasterData!$A$3:$A$7"})
    end
    send_excel_file book
  end

  def send_excel_file book
    tmp_file_path = Rails.root.join("/tmp/#{rand(36**50).to_s(36)}.xlsx")
    book.serialize tmp_file_path
    filename = "Aloha-#{Time.zone.now}.xlsx"
    file_content = File.read(tmp_file_path)
    send_data file_content, filename: filename
    File.delete tmp_file_path
  end

  def create_data datas
    datas.map do |data|
      [
        ["name", data[:tour_name]],
        ["email", data[:email]],
        ["price", data[:price]],
        ["quantity", data[:quantity]],
        ["count", data[:count]],
        ["total_price", data[:total_price]]
      ]
    end
  end
end
