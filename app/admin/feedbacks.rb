ActiveAdmin.register Feedback do
  index do
    column :user_id
    column :email
    column :content
    column :created_at
  end
end
