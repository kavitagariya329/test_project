class BookRatingsController < ApplicationController
  before_action :set_book_rating, only: %i[ show edit update destroy ]

  def new
    @book_rating = Book.find(params[:id]).book_ratings.build
    @book_id = params[:id]
  end

  def edit
  end

  def create
    @book_rating = BookRating.new(book_ratings_params)
    @book_id = book_ratings_params[:book_id]
    respond_to do |format|
      if @book_rating.stars < 3 && @book_rating.text == ''
        @book_rating.errors.add(:text, "Please review book")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_rating.errors, status: :unprocessable_entity }
      else        
        if @book_rating.save
          format.html { redirect_to books_url, notice: "Book was successfully created." }
          format.json { render :show, status: :created, location: @book_rating }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book_rating.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @book_rating.update(book_ratings_params)
        format.html { redirect_to @book_rating, notice: "Book Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @book_rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book_rating.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_rating
      @book_rating = BookRating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_ratings_params
      params.require(:book_rating).permit(:text, :stars, :book_id)
    end
end
