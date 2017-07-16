require 'rails_helper'

describe "Filtering events" do
  before(:each) do
    @user = create(:user)

    @event_past_hosting_1 = create(:event, archived: true)
    @event_past_hosting_2 = create(:event, archived: true)
    @event_host_1 = EventHost.create(event_id: @event_past_hosting_1.id, host_id: @user.id)
    @event_host_2 = EventHost.create(event_id: @event_past_hosting_2.id, host_id: @user.id)

    @event_past_attending_1 = create(:event, archived: true)
    @event_past_attending_2 = create(:event, archived: true)
    @event_host_1 = EventGuest.create(event_id: @event_past_attending_1.id, guest_id: @user.id)
    @event_host_2 = EventGuest.create(event_id: @event_past_attending_2.id, guest_id: @user.id)

    @event_future_hosting_1 = create(:event, archived: false)
    @event_future_hosting_2 = create(:event, archived: false)
    @event_host_1 = EventHost.create(event_id: @event_future_hosting_1.id, host_id: @user.id)
    @event_host_2 = EventHost.create(event_id: @event_future_hosting_2.id, host_id: @user.id)

    @event_future_attending_1 = create(:event, archived: false)
    @event_future_attending_2 = create(:event, archived: false)
    @event_host_1 = EventGuest.create(event_id: @event_future_attending_1.id, guest_id: @user.id)
    @event_host_2 = EventGuest.create(event_id: @event_future_attending_2.id, guest_id: @user.id)
  end

  scenario "user can visit dashboard" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    expect(page).to have_content("Dashboard")
    click_on("Dashboard")

    expect(current_path).to eq('/dashboard')
  end

end
