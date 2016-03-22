require 'rails_helper'

RSpec.describe "personalities/index", type: :view do
  before(:each) do
    assign(:personalities, [
      Personality.create!(
        :trait => "Trait",
        :pet => nil
      ),
      Personality.create!(
        :trait => "Trait",
        :pet => nil
      )
    ])
  end

  it "renders a list of personalities" do
    render
    assert_select "tr>td", :text => "Trait".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
