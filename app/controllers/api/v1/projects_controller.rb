class Api::V1::ProjectsController < ApiController
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render 'show', formats: [:json], handlers: [:jbuilder], status: 201
    else
      render json: {error: "Project could not be created."}, status: 422
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(name: params[:project][:name])
      render 'show', formats: [:json], handlers: [:jbuilder], status: 200
    else
      render json: {error: "Project could not be created."}, status: 422
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: {}, status: 200
    else
      render json: {error: "project could not be deleted."}, status: 422
    end
  end

  def with_commits
    @projects = current_user.projects.find_by(id: params[:id])
  end

  private
    def project_params
      params.required(:project).permit(:name)
    end
end
