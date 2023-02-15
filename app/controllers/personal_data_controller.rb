class PersonalDataController < ApplicationController
  before_action :authenticate_user!
  before_action :set_personal_datum, only: %i[show edit update destroy]
  before_action :set_employee, except: [:import]

  def index
    @personal_data = PersonalDatum.all
  end

  def show; end

  def new
    @personal_datum = @employee.build_personal_datum
  end

  def edit; end

  def import
    PersonalDatum.import(params[:file])
    flash[:success] = 'Файл успешно импортирован'
    redirect_to employees_url
  end

  def create
    @personal_datum = @employee.build_personal_datum(personal_datum_params)

    respond_to do |format|
      if @personal_datum.save
        format.html do
          redirect_to employee_url(@employee), notice: 'Personal datum was successfully created.'
        end
        format.json { render :show, status: :created, location: @personal_datum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @personal_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @personal_datum.update(personal_datum_params)
        format.html do
          redirect_to employee_url(@employee), notice: 'Personal datum was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @personal_datum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @personal_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @personal_datum.destroy

    respond_to do |format|
      format.html { redirect_to personal_data_url, notice: 'Personal datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_personal_datum
    @personal_datum = PersonalDatum.find(params[:id])
  end

  def personal_datum_params
    params.require(:personal_datum).permit(:snils, :inn, :passport_s, :passport_n, :issued_by, :date_of_issue, :code,
                                           :date_of_birth, :place_of_birth, :phone_number, :email, :employee_id)
  end
end
