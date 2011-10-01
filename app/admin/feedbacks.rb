ActiveAdmin.register Feedback do
  filter :id, :as => :numeric
  filter :user_id, :as => :numeric
  filter :email, :as => :string
  filter :content, :as => :string
  filter :created_at

  index do
    column :id
    column :user_id
    column :email
    column :content
    column :created_at
  end
end
