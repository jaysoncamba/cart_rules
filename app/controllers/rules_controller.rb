class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(rule_params)
    if @rule.save
      redirect_to rules_path, notice: "Rule created."
    else
      render :new
    end
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def update
    @rule = Rule.find(params[:id])
    if @rule.update(rule_params)
      redirect_to rules_path, notice: "Rule updated."
    else
      render :edit
    end
  end

  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    redirect_to rules_path, notice: "Rule deleted."
  end

  private

  def rule_params
    params.require(:rule).permit(:type, :product_code, :threshold, :new_price, :percent)
  end
end