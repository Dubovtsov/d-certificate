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
end
