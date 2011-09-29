class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.string :do_not_post_sns_with
      t.string :do_not_post_sns_when
      t.string :do_not_email_me_when
      t.string :do_not_phone_push_me_when
      t.datetime :email_agreed_at
      t.datetime :term_agreed_at

      t.timestamps
    end
  end
end
