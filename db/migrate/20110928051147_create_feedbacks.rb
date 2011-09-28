class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :feedback_type
      t.integer :user_id
      t.string :email
      t.string :content

      t.timestamps
    end
  end
end
