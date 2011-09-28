ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :created_at
  end
end
