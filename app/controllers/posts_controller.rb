class PostsController < ApplicationController

    def index
        if (params[:user_id].present? and params[:movie_id].present?)
            user= User.find(params[:user_id])
            posts=user.posts.where(reviewable_id:params[:movie_id],reviewable_type:'Movie')
            render json:posts,include: [:comments,:user,:reviewable]

        elsif (params[:user_id].present? and params[:book_id].present?)
            user= User.find(params[:user_id])
            posts=user.posts.where(reviewable_id:params[:book_id],reviewable_type:'Book')
            render json:posts,include: [:comments,:user,:reviewable]

        elsif(params[:user_id].present?)
           user= User.find(params[:user_id])
           render json:user.posts,include: [:comments,:user,:reviewable]
        else
        render json:Post.all,include: [:comments,:user,:reviewable]
        end
    end

    def show
        post=  Post.find_by(id:params[:id])
        if post
        render json:post,include:[:comments,:user,:reviewable]
        else
          render json:{error:"Post with id #{params[:id]} does not exist"},status:404
        end
    end

    def create
      user= User.find(params[:user_id])
      if (params[:movie_id].present?)
       movie= Movie.find(params[:movie_id])
       @post=Post.new({:reviewable => movie,:user=> user})
     elsif(params[:book_id].present?)
        book= Book.find(params[:book_id])
        @post=Post.new({:reviewable => book,:user => user})
      end

      if @post.save
        render json:@post,include: [:comments,:user,:reviewable]
      else
         render json:{errors:post.errors},status:400
      end
    end
  
    def update
        post=  Post.find_by(id:params[:id])
        if post
            is_updated_post= post.update(posts_params)
            if is_updated_post 
                 render json:post
              else   
                 render json:{errors:post.errors},status:400
            end   
        else
          render json:{error:"Post with id #{params[:id]} does not exist"},status:404
        end
    end
  
    def destroy
        post=  Post.find_by(id:params[:id])
      if post.destroy
          render json:post
      else
        render json:{errors:post.errors},status:400
       end
    end 

  private
    def posts_params
        params.require(:post).permit(:user_id,:reviewable_id,:reviewable_type)
    
    end
end
