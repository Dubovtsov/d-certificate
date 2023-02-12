class PositionsController < ApplicationController
  before_action :set_position, only: %i[ show edit update destroy ]
  before_action :set_department

  def index
    @positions = Position.all
  end

  def show
  end

  def new
    @position = @department.positions.build
  end

  def edit
  end

  def create
    @position = @department.positions.build(position_params)

    respond_to do |format|
      if @position.save
        # format.turbo_stream { render turbo_stream: turbo_stream.update('positions', partial: 'positions/position', locals: {position: @department.positions}) }
        format.html { redirect_to department_url(@department), notice: "Position was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update(position_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@position, partial: "positions/position", locals: {position: @position}) }
        format.html { redirect_to department_url(@department), notice: "Position was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @position.destroy

    respond_to do |format|
      format.html { redirect_to department_url(@department), notice: "Position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    def set_department
      @department = Department.find(params[:department_id])
    end

    # Only allow a list of trusted parameters through.
    def position_params
      params.require(:position).permit(:name, :department_id)
    end
end
