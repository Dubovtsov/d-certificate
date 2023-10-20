module CertificatesHelper

  def status_for_select
    Certificate.status.values.each { |status| status }
  end

  def status_button_icon(status)
    case status
    when "draft"
      "fa-regular fa-file-lines"
    when "verify"
      "fa-solid fa-building-circle-exclamation"
    when "current"
      "fa-regular fa-square-check"
    when "rejected"
      "fa-solid fa-building-circle-xmark"
    when "archive"
      "fa-regular fa-file-zipper"
    else
      "fa-solid fa-ban"
    end
  end

end
