class AddCategoryToScrape < ActiveRecord::Migration[6.0]
  def change
    add_column :scrapes, :categories, :text
  end
end
