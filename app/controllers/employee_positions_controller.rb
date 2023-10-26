class EmployeePositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee_position, only: %i[ show edit update destroy ]
  before_action :set_employee

  def index
    @employee_positions = EmployeePosition.all
  end

  def show
  end

  def new
    @employee_position = @employee.employee_positions.build
  end

  def edit
  end

  def create
    @employee_position = @employee.employee_positions.build(employee_position_params)

    respond_to do |format|
      if @employee_position.save
        # format.turbo_stream do
        #   render turbo_stream: turbo_stream.prepend('employee_positions', partial: "employee_positions/employee_position", locals: @employee_position)
        # end
        format.html { redirect_to employee_url(@employee), notice: "Employee position was successfully created." }
        format.json { render :show, status: :created, location: @employee_position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_position.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee_position.update(employee_position_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee position was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_position.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee_position.destroy

    respond_to do |format|
      format.html { redirect_to employee_positions_url, notice: "Employee position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_employee_position
      @employee_position = EmployeePosition.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def employee_position_params
      params.require(:employee_position).permit(:employee_id, :position_id, :rate)
    end
end
