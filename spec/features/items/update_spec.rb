require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Update Item Page' do
  describe 'As a Merchant' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
			@andrew = User.create!(user_name: "ajohnson", password: "123",  password_confirmation: "123", role: 1, name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401, merchant_id: @megan.id)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@andrew)
    end

    it 'I can click a link to get to an item edit page' do
      visit merchant_items_path(@megan.id)

      click_button 'Update Item'

      expect(current_path).to eq(edit_merchant_admins_item_path(@ogre.id))
    end

    it 'I can edit the items information' do
      name = 'Ogre'
      description = "I'm an Ogre!"
      price = 25
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 12

      visit edit_merchant_admins_item_path(@ogre.id)

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Update Item'

      expect(current_path).to eq "/merchants/#{@megan.id}/items"
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content("Price: #{number_to_currency(price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{inventory}")
      expect(page).to have_content(" #{@ogre.name} has been updated")

    end

    it 'I can not edit the item with an incomplete form' do
      name = 'Giant'

      visit edit_merchant_admins_item_path(@ogre.id)

      fill_in 'Name', with: name
			fill_in 'Description', with: " "
			fill_in 'Price', with: "abc"
			fill_in 'Inventory', with: "abc"
      click_button 'Update Item'

      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Price is not a number")
      expect(page).to have_content("Inventory is not a number")
      expect(page).to have_button('Update Item')
    end
  end
end
