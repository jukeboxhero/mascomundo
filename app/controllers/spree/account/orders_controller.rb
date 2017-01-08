class Spree::Account::OrdersController < Spree::StoreController
  def index
    @user ||= spree_current_user
    authorize! params[:action].to_sym, @user
    @orders = @user.orders.complete.order('completed_at desc')
  end
end