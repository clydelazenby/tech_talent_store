class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :categories, :brands
	helper_method :current_order

	def current_order
		if !session[:order_id].nil?
			return Order.find(session[:order_id])
		else
			return Order.new
		end
	end

	def categories
		@categories = Category.order(:name)
	end

	def brands
		@brands = Product.pluck(:brand).sort.uniq
	end
		

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, ])
		devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name])
	end

	rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.json { head :forbidden }
			format.html { redirect_to main_app.product_url, alert: "Not authorized!"}
		end
	end
end
