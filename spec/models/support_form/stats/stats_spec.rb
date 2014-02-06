require 'spec_helper'

describe SupportForm::Stat do
  before(:all) do
    @nil_email    = {"recipient_email" => nil,                "stats" => {"cat_1" => "1"}}
    @nil_stats    = {"recipient_email" => "email@picturk.com","stats" => nil}
    @empty_stats  = {"recipient_email" => "email@picturk.com","stats" => {}}
    @one_category = {"recipient_email" => "email@picturk.com","stats" => {"cat_1" => "1"}}
    @two_category = {"recipient_email" => "email@picturk.com","stats" => {"cat_1" => "1", "cat_2" => "2"}}
  end

  describe "nil email" do
    subject { SupportForm::Stat.new(@nil_email) }
    it { expect(subject).to_not be_valid }
  end

  describe "nil stats" do
    subject { SupportForm::Stat.new(@nil_stats) }
    it { expect(subject).to_not be_valid }
  end

  describe "empty stats hash" do
    subject { SupportForm::Stat.new(@empty_stats) }
    it { expect(subject).to_not be_valid }
  end

  describe "one category in stats hash" do
    subject { SupportForm::Stat.new(@one_category) }
    it { expect(subject).to be_valid }
  end

  describe "two category in stats hash" do
    subject { SupportForm::Stat.new(@two_category) }
    it { expect(subject).to be_valid }
  end

end
