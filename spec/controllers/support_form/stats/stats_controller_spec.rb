require 'spec_helper'

describe SupportForm::StatsController do

  before(:each) do
    @stat = SupportForm::Stat.create
  end

  after(:each) do
    SupportForm::Stat.destroy_all
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @stat
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: @stat
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end

    it "creates a new Stat" do
      expect{
        post 'create', {stat: {stats: {"category_1" => "2"}, recipient_email: "iain@picturk.com"}}
        }.to change{SupportForm::Stat.count}.by(1)
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update', id: @stat
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', id: @stat
      response.should be_success
    end
  end

end
