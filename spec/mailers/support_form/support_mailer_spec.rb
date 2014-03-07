require "spec_helper"

describe SupportForm::SupportMailer do
  describe "support_enquiry_notifier" do
    let(:mail) { SupportForm::SupportMailer.support_enquiry_notifier(@enquiry, "This is the title") }
    let(:body) { "Support query for This is the title has been received.

Name:    a
Email:   a@a.com
Message: a

Current stats are:
<p>cat_1: 1</p>
<p>cat_2: 2</p>
"
}
    before(:all) do
      DEFAULT_FROM = SupportForm::SupportMailer.default_params[:from]
      DEFAULT_TO = SupportForm::SupportMailer.default_params[:to]
    end
    before do
      @stats   = SupportForm::Stat.create(categories: {"cat_1" => "1", "cat_2" => "2"}, recipient_email: "iain@picturk.com", sender_email: "")
      @enquiry = SupportForm::Enquiry.new(name: "a", email: "a@a.com", message: "a", stats_id: @stats.id, topic: @stats['categories'].keys.first)
      @recipient_emails = proc { @stats['recipient_email'].split(",").map(&:strip) }
    end

    context "with no explicit recipient address" do
      before { @stats.update_attributes(recipient_email: "") }

      context "with default sender" do

        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq([DEFAULT_FROM])
          mail.to.should eq([DEFAULT_TO])
        end
      end

      context "with custom sender" do
        before do
          @stats.update_attributes(sender_email: "joe@picturk.com")
        end
        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq(["joe@picturk.com"])
          mail.to.should eq([DEFAULT_TO])
        end
      end
    end

    context "with one recipient address" do

      context "with default sender" do
        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq([DEFAULT_FROM])
          mail.to.should eq([DEFAULT_TO])
          mail.bcc.should eq(@stats['recipient_email'].split(",").map(&:strip))
        end
      end

      context "with custom sender" do
        before do
          @stats.update_attributes(sender_email: "joe@picturk.com")
        end
        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq([@stats.sender_email])
          mail.to.should eq([DEFAULT_TO])
          mail.bcc.should eq(@stats['recipient_email'].split(",").map(&:strip))
        end
      end
    end

    context "with multiple recipient address" do
        before do
          @stats.update_attributes(recipient_email: "iain@picturk.com, support@picturk.com")
        end
      context "with default sender" do
        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq([DEFAULT_FROM])
          mail.to.should eq([DEFAULT_TO])
          mail.bcc.should eq(@stats['recipient_email'].split(",").map(&:strip))
        end
      end

      context "with custom sender" do
        before do
          @stats.update_attributes(sender_email: "joe@picturk.com", recipient_email: "iain@picturk.com, support@picturk.com")
        end
        it "renders the headers" do
          mail.subject.should eq("#{@enquiry.name} - #{@enquiry.topic} - This is the title")
          mail.from.should eq([@stats.sender_email])
          mail.to.should eq([DEFAULT_TO])
          mail.bcc.should eq(@stats['recipient_email'].split(",").map(&:strip))
        end
      end
    end

    it "renders the body" do
      mail.text_part.body.should match(/Support query for This is the title has been received./)
      mail.html_part.body.should match(/Support query for This is the title has been received./)
    end
  end

end
