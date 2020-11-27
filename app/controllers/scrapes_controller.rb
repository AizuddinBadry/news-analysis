class ScrapesController < ApplicationController
    before_action :get_scrape, only: [:show]

    def index
        if params[:keywords].presence
            @scrapes = Scrape.where('content ilike ?', "%#{params[:keywords][:k]}%").to_a.uniq { |item| item.name }
        else
            @scrapes = Scrape.all.to_a.uniq { |item| item.name }
        end
    end

    def show
        @contents = Scrape.where('content ilike ?', "%#{params[:k]}%")
    end

    private

    def get_scrape
        @scrape = Scrape.find(params[:id])
    end
    
end
