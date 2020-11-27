class AwsComprehendJob < ApplicationJob
    queue_as :default

    def perform(storage)
            client = Aws::Comprehend::Client.new #initialize aws client
            pdf = ActiveStorage::Blob.service.send(:path_for, storage.pdf.key) #get pdf file from local storage
            reader = PDF::Reader.new(pdf) #read pdf file
            
            reader.pages.each_with_index do |page, index|
                content = ActionController::Base.helpers.strip_tags(page.text.gsub(/\n\n+/, ""))
                content.stripe if content.bytesize > 5000 unless content.bytesize == 0
                resp = client.classify_document({
                    text: content, # required
                    endpoint_arn: "arn:aws:comprehend:ap-southeast-1:022593771809:document-classifier-endpoint/n1", # required
                }) unless content.bytesize == 0
                scrape = Scrape.create name: storage.name, source: 'file', source_name: storage.name, 
                                        content: content, 
                                        page_number: index + 1, 
                                        categories: resp.presence ? resp.classes.to_json : nil
                sleep 3
            end
    end
end