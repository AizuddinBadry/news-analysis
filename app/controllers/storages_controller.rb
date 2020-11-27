class StoragesController < ApplicationController

    def create
        @storage = Storage.new(storage_params)
        if @storage.save
            flash[:success] = 'Successful uploaded pdf.' #added notice after upload
            redirect_to request.referrer
        end
    end

    def storage_params
        params.require(:storages).permit(:name, :pdf)
    end
end
