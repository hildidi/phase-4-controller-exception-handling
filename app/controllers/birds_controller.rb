class BirdsController < ApplicationController
  rescue ActiveRecord::RecordNotFound, with :render_not_found_response #(this rescue will run if any of our controller actions into that error )

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end


  # GET /birds/:id
    # OLD GET -V
    # def show
    #   find_bird
    #   if bird
    #     render json: bird
    #   else
    #     render_not_found_response
    #   end
    # end

    #NEW GET -V:
    def show
      find_bird
      render json: bird
      
    #Don't need it anymore. Handled by rescue above ^
      # rescue ActiveRecord::RecordNotFound
    #     render_not_found_response
    end

  # PATCH /birds/:id
    #OLD PATCH
    # def update
    #   find_bird
    #   if bird
    #     bird.update(bird_params)
    #     render json: bird
    #   else
    #     render_not_found_response
    #   end
    # end

    #NEW PATCH -V 
    def update
      find_bird
      bird.update(bird_params)
      render json: bird
    
    #Don't need it anymore. Handled by rescue above ^  
    # rescue ActiveRecord::RecordNotFound
    #     render_not_found_response
    end


  # PATCH /birds/:id/like
  def increment_likes
    find_bird
    bird.update(likes: bird.likes + 1)
    render json: bird
    
    # rescue ActiveRecord::RecordNotFound
    #     render_not_found_response
    # end
  end

  # DELETE /birds/:id
  #OLD DELETE -v
  # def destroy
    #   find_bird
    #   if bird
    #     bird.destroy
    #     head :no_content
    #   else
    #     render_not_found_response
    #   end
    # end
    
  # NEW DELETE -V
    def destroy
      find_bird
      bird.destroy
      head :no_content
    
    #Don't need it anymore. Handled by rescue above ^
    # rescue ActiveRecord:: RecordNotFound #throwing an exception of this type  
    #     render_not_found_response
    end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  #Placing these two under private. Anything that doesn't responde to a route is typically made private.
  # Refactoring
  def find_bird
    bird = Bird.find(params[:id])
    # bird = Bird.find_by(id: params[:id])
  end

  # Refactoring: 
  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  
  end

end
