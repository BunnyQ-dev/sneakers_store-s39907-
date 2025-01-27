class BrandsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  def index
    @brands = Brand.all
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.prepend("brands", partial: "brands/brand", locals: { brand: @brand }),
            turbo_stream.update("brand_form", partial: "brands/form", locals: { brand: Brand.new }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Brand was successfully created.' })
          ]
        }
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("brand_form", partial: "brands/form", locals: { brand: @brand })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace(dom_id(@brand), partial: "brands/brand", locals: { brand: @brand }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Brand was successfully updated.' })
          ]
        }
        format.html {
          redirect_to brands_path, notice: 'Brand was successfully updated.'
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update(dom_id(@brand), partial: "brands/form", locals: { brand: @brand })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brand.destroy

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.remove(@brand),
          turbo_stream.update("flash", partial: "shared/flash", locals: { notice: 'Brand was successfully deleted.' })
        ]
      }
      format.html { redirect_to brands_url, notice: 'Brand was successfully deleted.' }
    end
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name, :description)
  end
end