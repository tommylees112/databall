ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :name
    column :created_at
    column :admin
    actions
  end


  form do |f|
    f.inputs "Identity" do
      f.input :email
      f.input :password
    end
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
  end

  permit_params :password, :email, :admin
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
