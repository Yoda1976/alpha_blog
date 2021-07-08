require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: "yoda", email: "a@a.com",
    password: "123456", admin: true)
    sign_in_as(@admin_user)
  end
  
  test "get new category form and create category" do
    #Process flow
    #1. Get request to create new category
    get "/categories/new"
    #2. Check that there was success loading the categories/new page
    assert_response :success
    #3. Check that upon form validation, POST request with category name, 
    #a new category was created (increment Category objects by 1)
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Sports"}}
      #4. Check that there is a redirect to ...
      assert_response :redirect
    end
    follow_redirect!
    #5. Check that the redirect page is successfully loaded
    assert_response :success
    #6. Check the content of the html file body for the word Sports (new category created)
    assert_match "Sports", response.body
   end

   test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count'do
      post categories_path, params: { category: {name: ""}}
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
   end
end
