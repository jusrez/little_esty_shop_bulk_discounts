class NagerSearch

  def service
    NagerService.new
  end

  def next_three_holidays
    service.get_holidays[0..2].each do |holiday|
      "#{holiday['name']}: #{holiday['date']}"
    end
  end
  
end