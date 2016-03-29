require 'rails_helper'

RSpec.describe "appointments/edit", type: :view do
  before(:each) do
    @appointment = assign(:appointment, Appointment.create!(
      :pet => nil,
      :user => nil
    ))
  end

  it "renders the edit appointment form" do
    render

    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do

      assert_select "input#appointment_pet_id[name=?]", "appointment[pet_id]"

      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"
    end
  end
end
