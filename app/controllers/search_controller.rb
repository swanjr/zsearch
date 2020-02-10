# frozen_string_literal: true

class SearchController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(query_params)
    @search.run

    render :edit
  end

  private

  def query_params
    params.require(:search).permit(:query, :type)
  end
end
