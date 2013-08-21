module ApplicationHelper

  def conditional_tag(tag, condition, options={}, &block)
    if condition
      concat content_tag(tag, capture(&block), options)
    else
      concat capture(&block)
    end
  end

end
