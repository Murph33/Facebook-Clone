module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
    #
    # def connect
    #   self.current_user = User.find(cookies.signed[:user_id])
    # end
    #
    #
    # def find_verified_user
    #   if User.find(cookies.signed[:user_id])
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end
    # cookie namespaces or something are causing the problem.  puma server?
  end
end
