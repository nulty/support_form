require "spec_helper"

describe SupportForm::SupportMailer do
  describe "support_enquiry_notifier" do
    let(:stats) { SupportForm::Stat.create(stats: {"cat_1" => "1", "cat_2" => "2"}, recipient_email: "iain@picturk.com") }
    let(:enquiry) { SupportForm::Enquiry.new(name: "a", email: "a@a.com", message: "a", stats_id: stats.id, topic: stats['stats'].keys.first) }
    let(:mail) { SupportForm::SupportMailer.support_enquiry_notifier(enquiry) }
    let(:body) { "Support query for the competition has been received.

Name:    a
Email:   a@a.com
Message: a

Current stats are:
<p>cat_1: 1</p>
<p>cat_2: 2</p>
"
}


    it "renders the headers" do
      mail.subject.should eq("Support enquiry notifier")
      mail.to.should eq([stats['recipient_email']])
      mail.from.should eq([enquiry.email])
    end

    it "renders the body" do
      mail.body.should eq(body)
    end
  end

end
