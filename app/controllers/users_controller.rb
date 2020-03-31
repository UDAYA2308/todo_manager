class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    render plain: User.all.order(:name).map { |user| user.to_pleasant_string }.join("\n")
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user_id=params[:id]
    user=User.find(user_id)
    user.to_pleasant_string
  end

  def login
    user_email = params[:email]
    user_password = params[:password]
    user=User.find_by(email: user_email, password: user_password)
    response_text = "True"
    response_text = "False" if user == nil
    render plain: response_text
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user_name = params[:name]
    user_email = params[:email]
    user_password = params[:password]
    user_new = User.create(
      name: user_name,
      email: user_email,
      password: user_password,
    )
    response_text = "New user added with user_id #{user_new.id}"
    render plain: response_text
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
