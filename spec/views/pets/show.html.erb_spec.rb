require 'rails_helper'

RSpec.describe "pets/show", type: :view do
  before(:each) do
    @pet = assign(:pet, Pet.create!(
      :name => "Name",
      :breed => "Breed",
      :size => "Size",
      :age => "Age",
      :personality => "Personality"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Breed/)
    expect(rendered).to match(/Size/)
    expect(rendered).to match(/Age/)
    expect(rendered).to match(/Personality/)
  end
end
