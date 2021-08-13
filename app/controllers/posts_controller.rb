class PostsController < ApplicationController
    before_action :authenticate_user!, except:[:index, :show]
    def index
        @posts = Post.all
    end
    def new
        @post = Post.new
    end
    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to posts_path
        else
            redirect_to new_post_path
        end
    end
    def show
        @post = Post.find(params[:id])
        @user_itself = false
        if user_signed_in?
            if current_user.id == @post.user_id
                @user_itself = true
            end
        end
    end
    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            redirect_to posts_path
        else
            redirect_to post_path
        end
    end
    def edit
        @post = Post.find(params[:id])
    end
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to post_path
        else
            redirect_to edit_post_path
        end
    end
    private
        def post_params
            params.require(:post).permit(:title, :body).merge(user: current_user)
        end
end