class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :email
      t.string :image_url
      t.string :name
      t.string :nickname
      t.string :secret
      t.string :token
      t.string :url

      t.timestamps
    end
  end
end
