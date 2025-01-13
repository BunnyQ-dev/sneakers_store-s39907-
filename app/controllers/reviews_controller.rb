class ReviewsController < ApplicationController
  def create
    @sneaker = Sneaker.find(params[:sneaker_id])
    @review = @sneaker.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.append("reviews_list", partial: "reviews/review", locals: { review: @review }),
            turbo_stream.update("new_review", partial: "reviews/form", locals: { sneaker: @sneaker, review: Review.new }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Review was successfully added.' })
          ]
        }
        format.html { redirect_to @sneaker, notice: 'Review was successfully added.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("new_review", partial: "reviews/form", locals: { sneaker: @sneaker, review: @review })
        }
        format.html { redirect_to @sneaker, alert: 'Error adding review.' }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @sneaker = @review.sneaker

    respond_to do |format|
      @review.destroy
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.remove(@review),
          turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Review was successfully deleted.' })
        ]
      }
      format.html { redirect_to @sneaker, notice: 'Review was successfully deleted.' }
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :user_name)
  end
end