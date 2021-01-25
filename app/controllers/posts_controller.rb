class PostsController < ApplicationController

    def index
        if (params[:user_id])
           user= User.find(params[:user_id])
           render json:user.posts,include: [:comments,:user,:reviewable]
        else
        render json:Post.all,include: [:comments,:user,:reviewable]
        end
    end

    # def create
    #   user= User.find(posts_params[:user_id])
    #   post=Post.new()
    #   post.user=user
    #   if post.save
    #     render json:post
    #   else
    #      render json:{errors:post.errors},status:400
    #   end

    # end

    # def posts_params
    #     params.require(:post)  
    #     params.permit(:user_id)
    #  end
end
