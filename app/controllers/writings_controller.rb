class WritingsController < ApplicationController

  include Asignature
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_writing, only: [:show, :edit, :update, :destroy]
  before_action :check_authorization, only: [:edit, :update]
  respond_to :json

  def show
    set_meta_tags title: @writing.title,
                  description: Nokogiri::HTML(@writing.body).css('p').text,
                  reverse: true,
                  keywords: @writing.title + ', ' + @writing.user.first_name + ' ' + @writing.user.last_name + ', ' + @writing.user.school + ', Schoolawn, writing, student, blog, article'
    impressionist(@writing, unique: session_hash)
  end

  def index
    if params[:topic]
      @writings = Writing.tagged_with(params[:topic]).where(is_approved: true).order(created_at: :desc)
    else
      @writings = Writing.where(is_approved: true).order(created_at: :desc)
    end
    set_meta_tags title: helpers.topic_name_for(params[:topic]),
                  description: "Discover #{helpers.topic_name_for(params[:topic])} related writings on The Youth Review",
                  reverse: true,
                  keywords: 'The Youth Review, student, blog, article' + ', ' + helpers.topic_name_for(params[:topic])
  end

  def destroy
    @writing.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'The writing was deleted.' }
      format.json { head :no_content }
    end
  end

  def edit
    @hash = Asignature::data_hash
    cookies[:writing_slug] = @writing.slug
    set_meta_tags title: 'Edit writing',
                  reverse: true
  end

  def update
    if @writing.update(writing_params)
      flash[:success] = 'Success! Your writing has been updated.'
    else
      format.html { render :show, notice: 'Something went wrong.' }
      format.json { render json: @writing.errors, status: :unprocessable_entity }
    end

    # respond_to do |format|
    #   if @writing.update(writing_params)
    #     format.html { redirect_to @writing, notice: 'The writing was updated.' }
    #     format.json { render :show, status: :ok, location: @writing }
    #   else
    #     format.html { render :show, notice: 'Something went wrong.' }
    #     format.json { render json: @writing.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # POST /writings
  def create
    @hash = Asignature::data_hash
    @writing = current_user.writings.new(writing_params)
    if @writing.save
      cookies[:writing_slug] = @writing.slug
      if @writing.user.is_trusted
        flash[:success] = "Success! Your writing is now published and shared with many young people like you."
      else
        flash[:success] = "Success! Your writing will be public once it's approved by our editors. After that your new writings will be approved automatically."
      end
    else
      format.html { render notice: 'Something went wrong.' }
      format.json { render json: @writing.errors, status: :unprocessable_entity }
    end
  end

  private

  def check_authorization
    unless current_user == @writing.user
      redirect_to writing_path
    end
  end

  def set_writing
    @writing = Writing.friendly.find(params[:id])
  end

  def writing_params
    params.require(:writing).permit(:title, :body, :slug, :draft_token, :tag_list)
  end

end
