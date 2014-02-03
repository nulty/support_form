require 'pry'
module SupportForm
  class StatsController < ApplicationController
    def index
    end

    def show
      @support_stats = SupportForm::Stat.find(params[:id])
    end

    def new
      @support_stats = SupportForm::Stat.new
    end

    def edit
    end

    def create
      @support_stats = SupportForm::Stat.create(params[:stat])
    end

    def update
    end

    def destroy
    end
  end
end
