class StudentsController < ApplicationController
  def new
    @student=Student.new
    @dojos=Dojo.all
  end

  def create
    @student = Student.create(student_params.merge(dojo: Dojo.find(student_params[:dojo])))
    if @student.valid?
      flash[:success] = "You have successfully created a student!"
      redirect_to root_url
    else
      flash[:errors] = @student.errors.full_messages
      redirect_to :back
    end

  end
  def show
    @student = Student.find(params[:id])
    @classmates = Student.where.not(id: @student.id).where(dojo: @student.dojo)
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to :back
  end

  def edit
    @student = Student.find(params[:id])
    @dojos=Dojo.all

  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params.merge(dojo: Dojo.find(student_params[:dojo])))
      flash[:success] = "You have successfully updated a Student!"
      redirect_to root_url
    else
      flash[:errors] = @dojo.errors.full_messages
      redirect_to :back
  end
end

private
 def student_params
   params.require(:student).permit(:first_name, :last_name, :email, :dojo)
 end

end
