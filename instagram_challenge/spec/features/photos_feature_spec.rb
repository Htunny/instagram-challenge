require 'rails_helper'

feature 'photos' do
  context 'no photos have been added' do
    scenario 'should display a prompt to add a photos' do
      visit '/photos'
      expect(page).to have_content 'No photos yet!'
      expect(page).to have_link 'Add a photo'
    end
  end


context 'photos have been added' do
  before do
    Photo.create(caption: 'NYC')
  end

  scenario 'display photos' do
    visit '/photos'
    expect(page).to have_content('NYC')
    expect(page).not_to have_content('No photos yet')
  end
end

context 'adding photos' do
  scenario 'prompts user to fill out a form, then displays the new photo' do
    visit '/photos'
    click_link 'Add a photo'
    fill_in 'Caption', with: 'NYC'
    click_button 'Create Photo'
    expect(page).to have_content 'NYC'
    expect(current_path).to eq '/photos'
  end
end

context 'viewing photos' do

  let!(:nyc){Photo.create(caption:'NYC')}

  scenario 'lets a user view a photo' do
   visit '/photos'
   click_link 'NYC'
   expect(page).to have_content 'NYC'
   expect(current_path).to eq "/photos/#{nyc.id}"
  end

end
end
