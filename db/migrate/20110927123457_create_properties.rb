class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :key
      t.string :value
      t.boolean :use_client

      t.timestamps
    end
  end
end
