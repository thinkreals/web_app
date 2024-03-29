class User::RegistrationsController < Devise::RegistrationsController
   def create
     respond_to do |format|
       format.html { super }
       format.json { 
         build_resource
         if resource.save
           render_resource_json resource, :include => [:user_setting], :message => 'Successfully signed up.'
         else
           render_fail_json(resource.errors.messages)
         end
       } 
     end
   end
end