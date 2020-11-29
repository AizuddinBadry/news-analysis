class TextAnalysisJob < ApplicationJob
    queue_as :default

    def perform(storage, fastsento_api)
            pdf = open(storage.url) #get pdf file from local storage
            reader = PDF::Reader.new(pdf) #read pdf file
            
            reader.pages.each_with_index do |page, index|
                content = ActionController::Base.helpers.strip_tags(page.text.gsub(/\n\n+/, ""))
                content.stripe if content.bytesize > 5000 unless content.bytesize == 0
                resp = HTTParty.get("http://nlp.apps.fasttrade.my", 
                                    query: { text: content, label: 'industry performance,issues,market potential,challenges' },
                                    headers: {"Authorization" => "#{fastsento_api}"}) unless content.bytesize == 0
                puts ">>>>> #{resp.parsed_response}" unless content.bytesize == 0
                if !resp.nil?
                    scrape = Scrape.create name: storage.name, source: 'file', source_name: storage.name, 
                                            content: content, 
                                            page_number: index + 1, 
                                            categories: resp.parsed_response
                end
            end
    end
end
