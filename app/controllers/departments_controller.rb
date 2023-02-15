class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[show edit update destroy]

  def index
    if params[:departmens_search]
      @pagy, @departments = pagy(Department.search(params[:departmens_search]), items: 15)
    else
      @pagy, @departments = pagy(Department.all, items: 15)
      respond_to do |format|
        format.html
        format.csv { send_data Department.all.generate_csv, filename: "departments-#{Date.today}.csv" }
      end
    end
  end

  def show
    @positions = @department.positions.order(created_at: :desc)
  end

  def new
    @department = Department.new
  end

  def edit; end

  def import
    Department.import(params[:file])
    flash[:success] = 'Файл успешно импортирован'
    redirect_to departments_url
  end

  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('departments', partial: 'departments/department',
                                                                   locals: { department: @department })
        end
        format.html { redirect_to department_url(@department), notice: 'Department was successfully created.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('modal',
                                                    partial: 'shared/modal',
                                                    locals: { model: @department, title: 'Error' })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1 or /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@department, partial: 'departments/department',
                                                                 locals: { department: @department })
        end
        format.html { redirect_to department_url(@department), notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1 or /departments/1.json
  def destroy
    @department.destroy

    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def department_params
    params.require(:department).permit(:name)
  end
end
