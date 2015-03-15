class Api::V1::BranchesController < ApiController
  before_action :set_branch, only: [:show, :destroy]

  def index
    render json: Branch.all, each_serializer: BranchSerializer
  end

  def show
    render json: @respond, each_serializer: BranchSerializer
  end

  def destroy
    if @respond
      @respond.destroy
      render json: {}, status: 200
    else
      render json: {error: 'Branch cannot be deleted'}, status: 422
    end
  end
  private
  def set_branch
    @respond = Branch.find_by(id: params[:id])
  end
end

