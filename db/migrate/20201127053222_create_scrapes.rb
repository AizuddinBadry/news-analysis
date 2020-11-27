class CreateScrapes < ActiveRecord::Migration[6.0]
  def change
    create_table :scrapes do |t|
      t.text :name
      t.bigint :source
      t.text :source_name
      t.text :content

      t.timestamps
    end
  end
end
