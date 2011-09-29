class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.string :post_sns_with
      t.string :post_sns_when
      t.string :email_me_when
      t.string :phone_push_me_when
      t.datetime :email_agreed_at
      t.datetime :term_agreed_at

      t.timestamps
    end
  end
end
