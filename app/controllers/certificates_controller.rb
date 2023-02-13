class CertificatesController < ApplicationController
  before_action :set_certificate, only: %i[show edit update destroy]

  before_action :set_employee, except: %i[index import]

  def index
    @certificates = Certificate.all
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

        format.html { redirect_to employee_url(@employee), notice: 'Certificate was successfully updated.' }

        format.json { render :show, status: :ok, location: @certificate }

      else

        format.html { render :edit, status: :unprocessable_entity }

        format.json { render json: @certificate.errors, status: :unprocessable_entity }

      end
    end
  end

  def destroy
    @certificate.destroy

    respond_to do |format|
      format.html { redirect_to certificates_url, notice: 'Certificate was successfully destroyed.' }

      format.json { head :no_content }
    end
  end

  private

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
