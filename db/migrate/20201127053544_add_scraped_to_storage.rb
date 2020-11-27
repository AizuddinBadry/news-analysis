class AddScrapedToStorage < ActiveRecord::Migration[6.0]
  def change
    add_column :storages, :scraped, :boolean
  end
end
