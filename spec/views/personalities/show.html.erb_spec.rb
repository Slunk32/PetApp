require 'rails_helper'

RSpec.describe "personalities/show", type: :view do
  before(:each) do
    @personality = assign(:personality, Personality.create!(
      :trait => "Trait",
      :pet => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Trait/)
    expect(rendered).to match(//)
  end
end
