class QuotesController < ApplicationController
  before_action :find_quote, only: [:show, :edit, :update]

  def index
    @quotes = Quote
      .order(created_at: :desc)
      .page(params[:page])
      .per(10)
      .without_count
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to quote_path(@quote)
    else
      flash[:danger] = @quote.errors.full_messages.join(". ")
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quote_path(@quote)
    else
      flash[:danger] = @quote.errors.full_messages.join(". ")
      render :edit
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:text, :source, :author)
  end

  def find_quote
    @quote = Quote.find(params[:id])
  end
end
