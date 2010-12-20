class CreateDrafts < ActiveRecord::Migration
  def self.up
    create_table :drafts do |t|
      t.string :record_type
      t.string :record_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :drafts
  end
end
