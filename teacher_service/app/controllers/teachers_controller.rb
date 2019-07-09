class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :update, :destroy]

  # TODO 
  #   - remove deletes
  #   - install rspec and test
  #   - why is course_worker timing out? error_class=ActiveRecord::ConnectionTimeoutError
  
  # GET /teachers
  def index
    @teachers = Teacher.all

    render json: @teachers
  end

  # GET /teachers/1
  def show
    render json: @teacher
  end

  # POST /teachers
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      PubSub::TeachersPublisher.publish_created(@teacher)
      render json: @teacher, status: :created, location: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  def update
    if @teacher.update(teacher_params)
      PubSub::TeachersPublisher.publish_updated(@teacher)
      render json: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  def destroy
    @teacher.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :email, :phone)
    end
end
