class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  def index
    if params[:employees_search]
      @pagy, @employees = pagy(Employee.search(params[:employees_search]), items: 15)
    else
      @pagy, @employees = pagy(Employee.all, items: 15)
      respond_to do |format|
        format.html
        format.csv { send_data Employee.all.generate_csv, filename: "employees-#{Date.today}.csv" }
      end
    end
  end

  def show
    @personal_data = @employee.personal_datum
    @employee_positions = @employee.employee_positions
    @certificates = @employee.certificates
  end

  def new
    @employee = Employee.new
  end

  def import
    Employee.import(params[:file])
    flash[:success] = 'Файл успешно импортирован'
    redirect_to employees_url
  end

  def edit; end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:last_name, :first_name, :middle_name)
  end
end
