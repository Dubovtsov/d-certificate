module CertificatesHelper
  STATUS = [
    'черновик',
    'на проверке',
    'действующий',
    'отклонен',
    'архив',
    'аннулирован'
  ]

  def status_for_select
    STATUS.each { |status| status }
  end

  def status_button_icon(status)
    case status
    when "черновик"
      "fa-regular fa-file-lines"
    when "на проверке"
      "fa-solid fa-building-circle-exclamation"
    when "действующий"
      "fa-regular fa-square-check"
    when "отклонен"
      "fa-solid fa-building-circle-xmark"
    when "архив"
      "fa-regular fa-file-zipper"
    else
      "fa-solid fa-ban"
    end
  end
  
end
