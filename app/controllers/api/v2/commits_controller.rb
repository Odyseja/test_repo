class Api::V2::CommitsController < ApiController
  before_action :set_commit, only: [:show, :destroy]

  def index
    respond_with(:commits => Commit.all ? Commit.all : [])
  end

  def show
    respond_with(:commit => @respond ? @respond : [])
  end

  def destroy
    if @respond
      @respond.destroy
      render json: {}, status: 200
    else
      render json: {error: "Commit could not be deleted."}, status: 422
    end
  end

  private
  def set_commit
    @respond = Commit.find_by(id: params[:id])
  end
end
