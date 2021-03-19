require 'test_helper'
class UsersHelperTest < ActionView::TestCase

    test "top 10 max values function test" do
        testhash = {"a"=>2,"b"=>6,"c"=>1,"d"=>7,"e"=>0,"f"=>14,"g"=>8,"h"=>5,"i"=>105,"j"=>13, "k"=>15, "l"=>11 }
        assert_not get_max_ten_values(testhash).include?("e");
        assert get_max_ten_values(testhash).include?("i");
        assert get_max_ten_values(testhash).include?("a");
    end
end