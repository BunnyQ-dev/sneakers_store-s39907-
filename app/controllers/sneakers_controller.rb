class SneakersController < ApplicationController
  before_action :set_sneaker, only: [:show, :edit, :update, :destroy]

  def index
    @sneakers = Sneaker.all.includes(:brand, :category)
  end

  def show
    @review = Review.new
  end

  def new
    @sneaker = Sneaker.new
  end

  def create
    @sneaker = Sneaker.new(sneaker_params)

    respond_to do |format|
      if @sneaker.save
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.prepend("sneakers", partial: "sneakers/sneaker", locals: { sneaker: @sneaker }),
            turbo_stream.update("sneaker_form", partial: "sneakers/form", locals: { sneaker: Sneaker.new }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Sneaker was successfully created.' })
          ]
        }
        format.html { redirect_to @sneaker, notice: 'Sneaker was successfully created.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("sneaker_form", partial: "sneakers/form", locals: { sneaker: @sneaker })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @sneaker.update(sneaker_params)
      redirect_to @sneaker, notice: 'Sneaker was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sneaker = Sneaker.find(params[:id])

    respond_to do |format|
      if @sneaker.destroy
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.remove(@sneaker),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Sneaker was successfully deleted.' })
          ]
        }
        format.html { redirect_to sneakers_url, notice: 'Sneaker was successfully deleted.' }
      else
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.update("flash", partial: "shared/flash",
                                locals: { alert: 'Could not delete sneaker.' })
          ]
        }
        format.html { redirect_to sneakers_url, alert: 'Could not delete sneaker.' }
      end
    end
  end

  private

  def set_sneaker
    @sneaker = Sneaker.find(params[:id])
  end

  def sneaker_params
    params.require(:sneaker).permit(:name, :price, :description, :size, :color, :brand_id, :category_id, :stock)
  end
end