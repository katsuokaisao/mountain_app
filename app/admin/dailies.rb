ActiveAdmin.register Daily do
  menu label: '日記', priority: 3
  includes :mountain, :user
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :mountain_name, :title, :comment, :user_id, :mountain_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:mountain_name, :title, :comment, :user_id, :mountain_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
