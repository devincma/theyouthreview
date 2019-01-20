class DraftsController < ApplicationController
  include Asignature
  before_action :authenticate_user!
  before_action :set_draft_with_token, :check_authorization, only: [:show, :update, :destroy]
  respond_to :json

  def new
    @draft = Draft.new
    @hash = Asignature::data_hash
    set_meta_tags title: 'New Draft',
                  description: 'Create a new draft and share your thoughts on The Youth Review.',
                  reverse: true
  end

  def show
    @hash = Asignature::data_hash
    set_meta_tags title: 'Draft: ' + @draft.title,
                  reverse: true
  end

  def destroy
    @draft.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'The draft was deleted.' }
      format.json { head :no_content }
    end
  end

  # PUT /drafts/uYsZ9o5g7HDxN3m1YipnFdzF
  def update
    respond_to do |format|
      if @draft.update(draft_params)
        format.json {  }
      else
        format.html { render :show, notice: 'Something went wrong.' }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @draft.update(draft_params)
    #     format.html {  }
    #     format.json {  }
    #   else
    #     format.html { render :show, notice: 'Something went wrong.' }
    #     format.json { render json: @draft.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # POST /drafts
  def create
    @hash = Asignature::data_hash
    @draft = current_user.drafts.new(draft_params)
    respond_to do |format|
      if @draft.save
        format.html { }
        format.json { render edit_url: edit_draft_path(@draft), update_url: draft_path(@draft) }
      else
        format.html { render :new, notice: 'Something went wrong.' }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
    # render json: {
    #     edit_url: edit_draft_path(@draft),
    #     update_url: draft_path(@draft)
    # }
  end

  # POST /autocreate
  def autocreate
    @hash = Asignature::data_hash
    @draft = current_user.drafts.new(draft_params)

    unless Draft.exists?(token: cookies[:draft_token])
      if @draft.save
        cookies[:draft_token] = @draft.token
      end

      # respond_to do |format|
      #   if @draft.save
      #     format.json { }
      #     cookies[:draft_token] = @draft.token
      #     # puts @draft.token
      #     # puts Draft.exists?(token: @draft.token)
      #   else
      #     format.html { render :new, notice: 'Something went wrong.' }
      #     format.json { render json: @draft.errors, status: :unprocessable_entity }
      #   end
      # end
    end
  end

  private

  def set_draft_with_token
    @draft = Draft.find_by(token: params[:token])
  end

  def draft_params
    params.require(:draft).permit(:title, :body, :token, :is_writing_published)
  end

  def check_authorization
    unless @draft.user == current_user
      redirect_to root_url
    end
  end

end
