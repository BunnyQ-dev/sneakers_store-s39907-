class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.prepend("categories", partial: "categories/category", locals: { category: @category }),
            turbo_stream.update("category_form", partial: "categories/form", locals: { category: Category.new }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Category was successfully created.' })
          ]
        }
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("category_form", partial: "categories/form", locals: { category: @category })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace(@category),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Category was successfully updated.' })
          ]
        }
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("category_form", partial: "categories/form", locals: { category: @category })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.remove(@category),
          turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Category was successfully deleted.' })
        ]
      }
      format.html { redirect_to categories_url, notice: 'Category was successfully deleted.' }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end