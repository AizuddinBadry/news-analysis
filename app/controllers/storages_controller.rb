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
            AwsComprehendJob.perform_later(@storage)
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
