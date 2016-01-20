require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  def setup
    @controller = TribesController.new
  end

  test "should redirect if total nil" do
    params = {"auto_suggest"=>
                              {
                                "total_devs"=>"",
                               "total_cost"=>"",
                               "database"=>"0",
                               "database_lang"=>"Ruby",
                               "front_end"=>"0",
                               "front_end_lang"=>"Ruby",
                               "back_end"=>"0",
                               "back_end_lang"=>"Ruby"
                               }
              }
    post(:auto_suggest, params)
    assert_redirected_to tribe_path
  end

  test "should redirect if specialist nil" do
    params = {"auto_suggest"=>
                              {
                              "total_devs"=>"0",
                               "total_cost"=>"",
                               "database"=>"0",
                               "database_lang"=>"Ruby",
                               "front_end"=>"",
                               "front_end_lang"=>"Ruby",
                               "back_end"=>"0",
                               "back_end_lang"=>"Ruby"
                               }
              }
    post(:auto_suggest, params)
    assert_redirected_to tribe_path
  end


  test "should redirect if total less than one" do
    params = {"auto_suggest"=>
                              {
                               "total_devs"=>"0",
                               "total_cost"=>"",
                               "database"=>"0",
                               "database_lang"=>"Ruby",
                               "front_end"=>"0",
                               "front_end_lang"=>"Ruby",
                               "back_end"=>"0",
                               "back_end_lang"=>"Ruby"
                               }
              }
    post(:auto_suggest, params)
    assert_redirected_to tribe_path
  end

  test "should redirect if specialist counts dont add to total" do
    generate_devs(4)
    params = {"auto_suggest"=>
                              {
                               "total_devs"=>"4",
                               "total_cost"=>"10",
                               "database"=>"2",
                               "database_lang"=>"Ruby",
                               "front_end"=>"1",
                               "front_end_lang"=>"Ruby",
                               "back_end"=>"1",
                               "back_end_lang"=>"Ruby"
                               }
              }
    post(:auto_suggest, params)
    assert_response :success
  end
end
