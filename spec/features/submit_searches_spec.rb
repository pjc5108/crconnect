require 'rails_helper'

RSpec.feature "SubmitSearches", type: :feature, js: true do
  let(:happy_submit) {FactoryGirl.create(:happy_submit)}
  let(:grumpy_submit) {FactoryGirl.create(:grumpy_submit)}
  let(:submission) {FactoryGirl.create(:submission)}
  let(:submission2) {FactoryGirl.create(:submission2)}
  let(:excited_submit) {FactoryGirl.create(:excited_submit)}
  let(:site) {FactoryGirl.build(:site)}
  let(:site2) {FactoryGirl.build(:site2)}

  scenario "render results page on search submit" do
    grumpy_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content('clinical trials sorted by distance from you')
  end

  scenario "render some results when given good input" do
    grumpy_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Large Cell)', from: 'cancerType')
    select('Stage IV', from: 'cancerStage')
    select('Yes', from: 'chemotherapy')
    select('Yes', from: 'radiation')
    fill_in('age', with: '16')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content('clinical trials sorted by distance from you')
  end

  scenario "render the correct results when given good input" do
    happy_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Adenocarcinoma)', from: 'cancerType')
    select('Stage I', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('Resistant to Treatment', from: 'cancerStatus')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Randomized Phase II")
  end

  scenario "render the correct results when given good input part 2" do
    grumpy_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('Never Received Treatment', from: 'cancerStatus')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Phase III Randomized Trial")
  end

  scenario "render the correct results when given good input part 3" do
    grumpy_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('Relapsed', from: 'cancerStatus')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Phase III Randomized Trial")
  end

  scenario "render the correct results when given good input part 4 (genetic markers)" do
    submission.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('None', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Study of the effects of the Phase on the status")
  end

  scenario "render the correct results when given good input part 5 (genetic markers)" do
    submission2.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('ALK Oncogene', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Very important study")
  end

  scenario "render the correct results when given good input part 6 (genetic markers)" do
    submission2.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('EGFR Mutation', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Very important study")
  end

  scenario "render the correct results when given good input part 7 (genetic markers)" do
    submission2.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('KRAS Mutation', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Very important study")
  end

  scenario "render the correct results when given good input part 8 (colorectal adeno)" do
    excited_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Adenocarcinoma)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('KRAS Mutation', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Fairly important study")
  end

  scenario "render the correct results when given good input part 9 (colorectal nonadeno)" do
    excited_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('KRAS Mutation', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Fairly important study")
    page.find(".trial-buttons").click
    expect(page).to have_content("More info")
  end

  scenario "render message for no results when search query matches no results" do
    submission2.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Adenocarcinoma)', from: 'cancerType')
    select('Stage IV', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('Resistant to Treatment', from: 'cancerStatus')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98104')
    click_on('Find Trials')
    expect(page).to have_content('98104')
    expect(page).to have_content("Your search did not match any trials.")
  end

  scenario "show correct distance from user to site and site contact info" do
    excited_submit.sites << site
    site.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('KRAS Mutation', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content("Fairly important study")
    page.find(".trial-buttons").click
    expect(page).to have_content("Closest Clinical Trial Site (1617.69 miles away)")
    expect(page).to have_content("University of Wisconsin Hospital and Clinics")
    expect(page).to have_content("Andrew J Tatar")
    expect(page).to have_content("608-263-2901")
    expect(page).to have_content("atatar@wis.edu")
  end

  scenario "show correct order of trials based on site location" do
    submission.sites << site
    site.save
    grumpy_submit.sites << site2
    site2.save
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Non-Small Cell Lung Cancer (Squamous)', from: 'cancerType')
    select('Stage III', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    select('None', from: 'geneticMarkers')
    fill_in('age', with: '50')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    sleep 1
    expect(page.text).to match(/Phase III Randomized Trial Comparing Overall.*Study of the effects of the Phase on the status/)
  end
end
