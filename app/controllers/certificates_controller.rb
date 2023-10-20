class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: %i[show edit update destroy]
  before_action :get_request_path, only: %i[update]
  before_action :set_employee, except: %i[index import]

  def index
    @certificates = Certificate.all
    if params[:legal_entity].present?
      @certificates = @certificates.where(legal_entity: params[:legal_entity]) if params[:legal_entity].present?
    elsif params[:status].present?
      @certificates = Certificate.select_by_status(params[:status])
    elsif params[:one_months_left].present?
      @certificates = Certificate.select{|c| c.one_months_left}
    elsif params[:two_months_left].present?
      @certificates = Certificate.select{|c| c.two_months_left}
    else
      @pagy, @certificates = pagy(Certificate.all, items: 11)
      respond_to do |format|
        format.html
        format.csv { send_data Certificate.all.generate_csv, filename: "Certificates-#{Date.today}.csv" }
      end
    end
  end

  def show; end

  def import
    Certificate.import(params[:file])
    flash[:success] = 'Файл успешно импортирован'
    redirect_to employees_url
  end

  def new
    @certificate = @employee.certificates.build
  end

  def edit; end

  def create
    @certificate = @employee.certificates.build(certificate_params)
    respond_to do |format|
      if @certificate.save
        format.html { redirect_to employee_url(@employee), notice: 'Certificate was successfully created.' }
        format.json { render :show, status: :created, location: @certificate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @certificate.update(certificate_params)
        if @request.include?("employee")
          format.html { redirect_to employee_url(@employee), notice: "Certificate was successfully updated." }
          format.json { render :show, status: :ok, location: @certificate }
        else
          format.html { redirect_to certificates_url, notice: "Certificate was successfully updated." }
          format.json { render :show, status: :ok, location: @certificate }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @certificate.destroy
    respond_to do |format|
      format.html { redirect_to employee_url(@employee), notice: "Certificate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def get_request_path
    @request = request.env["HTTP_REFERER"]
  end
  

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def certificate_params
    params.require(:certificate).permit(:legal_entity, :request_number, :request_link, :end_date, :status,
                                        :e_service, :employee_id)
  end
  
end
