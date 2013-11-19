module ApplicationHelper

  def validation_error(message)
    if message.class.to_s == "Array"
      message = message.join(", ")
    end
    return !message.to_s.blank? ? ("<div class='form_error'>"+message.to_s+"</div>").html_safe : ""
  end

  def deal_image(deal)
    image_tag((deal.images.first and !deal.images.first.image_url.nil?) ? deal.images.first.image_url(:thumb) : "no_image.gif")
  end
  
end
