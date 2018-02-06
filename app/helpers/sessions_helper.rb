module SessionsHelper

	def login(user)
		session[:user_id] = user.id
		remember(user)
		current_user
	end

	def remember(user)
		user.remember
		user.update_attribute(:remember_digest, user.remember_digest)
		cookies.permanent.signed[:user_id] = session[:user_id]
		cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user
		if(user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif user_id == cookies.signed[:user_id]
			user = User.find_by(id: user_id)
			if user && user.authenticate(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def log_out
		current_user.update_attribute(:remember_digest, nil)
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
		session.delete(:user_id)
		current_user = nil
	end

	def logged_in?
		!current_user.nil?
	end

end
