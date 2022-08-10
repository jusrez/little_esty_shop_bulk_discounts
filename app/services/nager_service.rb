class NagerService
  def get_url(url)
    HTTParty.get(url)
  end

  def get_holidays
    get_url('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end
end