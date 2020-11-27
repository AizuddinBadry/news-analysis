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
            client = Aws::Comprehend::Client.new #initialize aws client
            
            reader.pages.each_with_index do |page, index|
                content = ActionController::Base.helpers.strip_tags(page.text.gsub(/\n\n+/, ""))
                content.stripe if content.bytesize > 5000
                resp = client.classify_document({
                    text: content, # required
                    endpoint_arn: "arn:aws:comprehend:ap-southeast-1:022593771809:document-classifier-endpoint/n1", # required
                })
                sleep 3
                Scrape.create name: @storage.name, source: 'file', source_name: @storage.name , content: content, page_number: index + 1, categories: resp.classes.to_json
            end
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
