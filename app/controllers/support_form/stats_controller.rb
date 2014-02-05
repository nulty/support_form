require 'pry'
module SupportForm
  class StatsController < ApplicationController
    def index
      @stats = SupportForm::Stat.all
    end

    def show
      @support_stat = SupportForm::Stat.find(params[:id])
    end

    def new
      @support_stats = SupportForm::Stat.new
    end

    def edit
      @support_stats = SupportForm::Stat.find(params[:id])
    end

    def create
      @support_form = SupportForm::Stat.new

      if params["support_form_stat"]["category_name"].kind_of? Hash
        @support_form.stats = params["support_form_stat"]["category_name"].invert
        @support_form.stats.each_key { |k| @support_form.stats[k] = 0 }
      else
        @support_form.stats[params["support_form_stat"]["category_name"]] = 0
      end
      @support_form.recipient_email = params["support_form_stat"]["recipient_email"]

      respond_to do |format|
        if @support_form.save
          format.html { redirect_to(root_path) }
        else
          format.html { render :new }
        end
      end
    end

    def update
      @stat = SupportForm::Stat.find(params[:id])
      names = params["support_form_stat"]["category_name"].values.to_a
      values = params["support_form_stat"]["category_name_value"].values.to_a
      params["support_form_stat"]["stats"] = Hash[names.zip(values)]
      params["support_form_stat"].delete("category_name")
      params["support_form_stat"].delete("category_name_value")

      @stat.update_attributes(params["support_form_stat"])
      redirect_to(support_form_stats_path)
    end

    def destroy
      @stat = SupportForm::Stat.find(params[:id])
      @stat.destroy
      redirect_to root_url
    end
  end
end
