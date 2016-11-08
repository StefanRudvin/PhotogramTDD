require 'rails_helper.rb'

feature 'Creating posts' do
  before do
    user = create :user 
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    
    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')
  end
  
  scenario 'can create a post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #Coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('#Coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
  end
  
  scenario 'needs an image to create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'nom nom nom #Coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('Halt, you fiend! You need an image to post here!')
  end
  
end

feature 'Can view individual posts' do  
  scenario 'Can click and view a single post' do
    post = create(:post)

    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end
end  
