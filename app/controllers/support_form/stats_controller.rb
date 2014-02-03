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
      @support_stats = SupportForm::Stat.create(params[:stat])
      respond_to do |format|
        format.html {redirect_to(root_url)}
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
