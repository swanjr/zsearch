class SearchController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(query_params)
  end

  private

  def query_params
    params.require(:search).permit(:query)
  end
end
