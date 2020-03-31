class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    render plain: User.all.order(:name).map { |user| user.to_pleasant_string }
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def login
    user_name=params[:name]
    user_password=params[:password]
    user=User.find(name)
    response_text='False'
    response_text = 'Ture' if (user_password == user.password)
    render plain: response_text
  end

  # GET /posts/new
  def new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    user_name = params[:name]
    user_email = params[:email]
    user_password = params[:password]
    user_new = User.create(
      name: user_name,
      email: user_email,
      password: user_password,
    )
    response_text="New user added with name #{user_name}"
    render plain: response_text
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
