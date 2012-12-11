ActiveAdmin.register User do
  index do
    column :uid
    column :username
    column :name
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :current_sign_in_ip
    column :last_sign_in_ip
    default_actions
  end
end
