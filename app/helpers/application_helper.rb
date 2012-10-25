module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = 'BookStore Application'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def  price money
    number_to_currency money, precision: 2, unit: "$", separator: "."
  end
end
