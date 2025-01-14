class PaymentTypesController < ApplicationController
  before_action :signed_in_user
  before_action :set_payment_type, only: [:show, :edit, :update, :destroy, :payments_report]
  before_action :check_current_user_admin, only: [:new, :create, :update, :destroy]


  def payments_report
    if request.path_parameters[:format] == 'xlsx'
      @start_date =  params[:payment_date_start]
      @end_date = params[:payment_date_end]
      @payments = Payment.between_dates(@start_date, @end_date)
    end
  end

  # GET /payment_types
  # GET /payment_types.json
  def index
    @payment_types = PaymentType.all
  end

  # GET /payment_types/1
  # GET /payment_types/1.json
  def show
  end

  # GET /payment_types/new
  def new
    @payment_type = PaymentType.new
  end

  # GET /payment_types/1/edit
  def edit
  end

  # POST /payment_types
  # POST /payment_types.json
  def create
    @payment_type = PaymentType.new(payment_type_params)

    respond_to do |format|
      if @payment_type.save        
        format.html { 
          flash[:success] = t(:payment_type_created)
          redirect_to edit_payment_type_path(@payment_type)           
        }        
        format.json { render action: 'show', status: :created, location: @payment_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_types/1
  # PATCH/PUT /payment_types/1.json
  def update
    respond_to do |format|
      if @payment_type.update(payment_type_params)        
        format.html { 
          flash[:success] = t(:payment_type_updated) 
          redirect_to edit_payment_type_path(@payment_type)           
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_types/1
  # DELETE /payment_types/1.json
  def destroy
    @payment_type.destroy
    respond_to do |format|
      format.html { redirect_to payment_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_type
      @payment_type = PaymentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_type_params
      params.require(:payment_type).permit(:name, :frequency, :amount)
    end
end
