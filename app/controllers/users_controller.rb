class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        if params[:user][:auto_generate] == "1"
          create_installments(@user)
        end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        update_installments(@user)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :total_amount, :discount, :percentage, :emi_option)
    end

    def create_installments(user)
      if user.discount
        net_amount=user.total_amount-user.percentage
      else
        net_amount=user.total_amount
      end
      monthly_amount=net_amount/user.emi_option
      # Installment.create(:due_date=>Date.today, :payment_date=>Date.today, :status=>"paid",:amount=>monthly_amount,:user_id=>user.id)
        d= Date.today
      for i in 1..(user.emi_option)
        Installment.create(:due_date=>d, :status=>"scheduled",:amount=>monthly_amount,:user_id=>user.id)
        d=d+(12/user.emi_option).months
      end
    end

    def update_installments(user)
      old_amount = user.installments.sum(:amount)
      difference = user.total_amount - old_amount - user.percentage
      if difference != 0
        remaining_installments = user.installments.where("status != ?", 'paid')
        ri_count = remaining_installments.count
        if ri_count == 0
          Installment.create(:due_date => Date.today, :status => "scheduled", :amount => difference, :user_id => user.id)
          user.update_attributes(:emi_option => user.emi_option + 1)
        else
          remaining_installments.each do |inst|
            inst.update_attributes(:amount => inst.amount + difference/ri_count.to_f)
          end
        end
      end
    end
end
