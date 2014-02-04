module SupportForm
  class StatsController < ApplicationController
    def index
      @stats = SupportForm::Stat.all
    end

    def show
      @support_stats = SupportForm::Stat.find(params[:id])
    end

    def new
      @support_stats = SupportForm::Stat.new
    end

    def edit
      @support_stats = SupportForm::Stat.find(params[:id])
    end

    def create
      h = Hash["stats", {}, "recipient_email", ""]
      if params["support_form_stat"]["category_name"].kind_of? Hash
        h["stats"].merge!(params["support_form_stat"]["category_name"].invert)
        h["stats"].each { |k,v| h["stats"][k] = 0 }
      else
        h["stats"][params["support_form_stat"]["category_name"]] = 0
      end
      h["recipient_email"] = params["support_form_stat"]["recipient_email"]
      @support_stats = SupportForm::Stat.create(h)
      respond_to do |format|
        format.html { redirect_to(root_url) }
      end
    end

    def update
      @stat = SupportForm::Stat.find(params[:id])
      @stat.update_attributes(params[:stat])
      redirect_to("/")
    end

    def destroy
      @stat = SupportForm::Stat.find(params[:id])
      @stat.destroy
      redirect_to root_url
    end
  end
end
