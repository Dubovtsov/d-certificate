class PowerOfAttorneysController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_power_of_attorney, only: %i[ show edit update destroy ]
  before_action :set_employee

  def index
    @power_of_attorneys = PowerOfAttorney.all
  end

  def show
  end

  def new
    @power_of_attorney = @employee.power_of_attorneys.build
  end

  def edit
  end

  def create
    @power_of_attorney = @employee.power_of_attorneys.build(power_of_attorney_params)

    respond_to do |format|
      if @power_of_attorney.save
        # format.turbo_stream do
        #   render turbo_stream: turbo_stream.prepend('employee_positions', partial: "employee_positions/employee_position", locals: @employee_position)
        # end
        format.html { redirect_to employee_url(@employee), notice: "Employee position was successfully created." }
        format.json { render :show, status: :created, location: @power_of_attorney }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @power_of_attorney.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @power_of_attorney.update(power_of_attorney_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee position was successfully updated." }
        format.json { render :show, status: :ok, location: @power_of_attorney }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @power_of_attorney.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @power_of_attorney.destroy

    respond_to do |format|
      format.html { redirect_to employee_url(@employee), notice: "Employee position was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    def set_power_of_attorney
      @power_of_attorney = PowerOfAttorney.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def power_of_attorney_params
      params.require(:power_of_attorney).permit(:title, :end_date, :employee_id)
    end

end
