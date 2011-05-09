class PostsController < ApplicationController
  before_filter :find_Post, :only => [:show, :edit, :update, :destroy]

  def index
#    @posts = Post.all
#    @posts = Post.where(:is_public => true)
    @posts = Post.is_publiced(true).paginate(:page => params[:page], :per_page => 3)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    #@post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    #if @post.save
      #redirect_to(@post, :notice => 'Posted!!')
    #else
      #render :action => "new"
    #end

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Posteeeeeeed!!') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    #@post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post updated!!<O>!!')
    else
      render :action => "edit"
    end
  end

  def destroy
    #@post = Post.find(params[:id])
    @post.destroy

    redirect_to(posts_url)
  end

  def not_public
    @posts = Post.is_publiced(false)
  end

  protected

  def find_Post
    @post = Post.find(params[:id])
  end
end