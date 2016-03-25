require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :name => "MyString",
      :pet => nil
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input#reservation_name[name=?]", "reservation[name]"

      assert_select "input#reservation_pet_id[name=?]", "reservation[pet_id]"
    end
  end
end
