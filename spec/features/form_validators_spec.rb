require 'rails_helper'

RSpec.feature "Form Validators", type: :feature, js: true do
  scenario "shows correct error messages on individual invalid input" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Cancer Type')

    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('(Please select stage)', from: 'cancerStage')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Cancer Stage')

    select('Stage II', from: 'cancerStage')
    select('(Please select yes or no)', from: 'chemotherapy')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Chemotherapy')

    select('No', from: 'chemotherapy')
    select('(Please select yes or no)', from: 'radiation')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Radiation')
  end

  scenario "shows multiple error messages on multiple pieces of missing input" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Stage II', from: 'cancerStage')
    select('No', from: 'radiation')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Cancer Type')
    expect(page).to have_content('Please select an option for Chemotherapy')
    expect(page).to have_content('Please enter a number between 1 and 150 for age')
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('No', from: 'chemotherapy')
    fill_in('age', with: '90')
    expect(page).to have_content('Please select an option for Cancer Type')
  end

  scenario "allows user to submit form after previously receiving errors" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Stage II', from: 'cancerStage')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content('Please select an option for Cancer Type')
    expect(page).to have_content('Please select an option for Chemotherapy')
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('No', from: 'chemotherapy')
    click_on('Find Trials')
    expect(page).to have_content('clinical trials sorted by distance from you')
  end

  scenario "show zip error when user leaves zip blank" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    click_on('Find Trials')
    expect(page).to have_content('Please enter a valid zip code')
  end

  scenario "show zip error when user enters nonsensical string" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    fill_in('zipcode', with: 'sdfgnsdfgfdgdfsgfd')
    click_on('Find Trials')
    expect(page).to have_content('Please enter a valid zip code')
  end

  scenario "allow user to submit upon re-entering valid zip after zip error" do
    visit('/')
    page.driver.browser.switch_to.alert.accept
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    fill_in('zipcode', with: 'sdfgnsdfgfdgdfsgfd')
    click_on('Find Trials')
    expect(page).to have_content('Please enter a valid zip code')
    select('Colorectal Cancer (Other types)', from: 'cancerType')
    select('Stage II', from: 'cancerStage')
    select('No', from: 'chemotherapy')
    select('No', from: 'radiation')
    fill_in('age', with: '25')
    fill_in('zipcode', with: '98117')
    click_on('Find Trials')
    expect(page).to have_content('clinical trials sorted by distance from you')
  end
end
