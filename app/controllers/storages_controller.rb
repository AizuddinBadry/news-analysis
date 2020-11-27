class StoragesController < ApplicationController
    before_action :get_storage, only: [:destroy, :extract]

    def index
        @storages = Storage.all
    end

    def create
        @storage = Storage.new(storage_params)
        if @storage.save
            @storage.update name: params[:storages][:pdf].original_filename #save filename to storage
            flash[:success] = 'Successful uploaded pdf.' #added notice after upload
            redirect_to request.referrer
        end
    end

    def destroy
        if @storage.destroy
            flash[:success] = 'Successful destroy file.'
            redirect_to request.referrer
        end
    end

    def extract
        if @storage.update scraped: true
            pdf = ActiveStorage::Blob.service.send(:path_for, @storage.pdf.key) #get pdf file from local storage
            reader = PDF::Reader.new(pdf) #read pdf file
            content = ""
            reader.pages.each do |page|
                content << page.text
            end
            Scrape.create name: @storage.name, source: 'file', content: ActionController::Base.helpers.strip_tags(content)
            redirect_to request.referrer
        end
    end

    private

    def get_storage
        params[:id] ||= params[:storage_id]
        @storage = Storage.find(params[:id])
    end

    def storage_params
        params.require(:storages).permit(:name, :pdf)
    end
end
