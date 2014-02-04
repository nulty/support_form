require 'pry'
require 'spec_helper'

describe SupportForm::StatsController do

  before(:each) do
    @stat = SupportForm::Stat.create(stats: {"category_1" => "4"}, recipient_email: "iain@picturk.com")
  end

  after(:each) do
    SupportForm::Stat.destroy_all
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "assigns variable correctly" do
      get 'index'
      expect(assigns(:stats)).to match_array([@stat])
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @stat
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "assigns a new stat" do
      get 'new'
      expect(assigns(:support_stats)).to be_a_new(SupportForm::Stat)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: @stat
      expect(response).to be_success
    end

    it "assigns a new stat" do
      get 'edit', id: @stat
      expect(assigns(:support_stats)).to eq @stat
    end
  end

  describe "POST 'create'" do
    context "with ONE category name" do
      it "returns http success" do
        post 'create', {"support_form_stat" => {"category_name" => {"category_1" => "1", "category_2" => "2"}, "recipient_email" => "iain@picturk.com"}}
        expect(response).to be_redirect
      end

      it "creates a new Stat" do
        expect{
          post 'create', {"support_form_stat" => {"category_name" => {"category_1" => "1", "category_2" => "2"}, "recipient_email" => "iain@picturk.com"}}
          }.to change{SupportForm::Stat.count}.by(1)
      end
    end
    context "with TWO category names" do
      it "returns http success" do
        post 'create', {"support_form_stat" => {"category_name" => {"category_1" => "2"}, recipient_email: "iain@picturk.com"}}
        expect(response).to be_redirect
      end

      it "creates a new Stat" do
        expect{
          post 'create', {"support_form_stat" => {"category_name" => {"category_1" => "2"}, "recipient_email" => "iain@picturk.com"}}
          }.to change{SupportForm::Stat.count}.by(1)
      end
    end
  end

  describe "PUT 'update'" do
    it "changes the record" do
      expect{
        put 'update', {id: @stat, stat: { recipient_email: "new@picturk.com" }}
        }.to change{ @stat.reload.recipient_email }.to("new@picturk.com").from("iain@picturk.com")
    end

    it "renders the page" do
        put 'update', {id: @stat, stat: { recipient_email: "new@picturk.com" }}
        expect(response).to be_redirect
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys a record" do
      expect{
        delete 'destroy', id: @stat
        }.to change{SupportForm::Stat.count}.by(-1)
    end

    it "redirects to root url" do
      delete 'destroy', id: @stat
      expect(response).to be_redirect
    end
  end

end
