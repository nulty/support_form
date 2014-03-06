require "spec_helper"
describe SupportForm::SupportMailer do
  describe "support_enquiry_notifier" do
    let(:stats) { SupportForm::Stat.create(categories: {"cat_1" => "1", "cat_2" => "2"}, recipient_email: "iain@picturk.com") }
    let(:enquiry) { SupportForm::Enquiry.new(name: "a", email: "a@a.com", message: "a", stats_id: stats.id, topic: stats['categories'].keys.first) }
    let(:mail) { SupportForm::SupportMailer.support_enquiry_notifier(enquiry, "This is the title") }
    let(:body) { "Support query for This is the title has been received.

Name:    a
Email:   a@a.com
Message: a

Current stats are:
<p>cat_1: 1</p>
<p>cat_2: 2</p>
"
}


    it "renders the headers" do
      mail.subject.should eq("#{enquiry.name} - #{enquiry.topic} - This is the title")
      mail.to.should eq([stats['recipient_email']])
      mail.from.should eq([enquiry.email])
    end

    it "renders the body" do
      mail.text_part.body.should match(/Support query for This is the title has been received./)
      mail.html_part.body.should match(/Support query for This is the title has been received./)
    end
  end

end
