class CreateFileRecords < ActiveRecord::Migration
  def change
    create_table :file_records do |t|
      t.text :path, :null => false
    end
    add_index :file_records, :path, :unique => true
  end
end