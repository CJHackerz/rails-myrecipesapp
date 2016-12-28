
require 'test_helper'
class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end

  test "chefname too long" do
    @chef.chefname = "a" * 41
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be too long" do
    @chef.email = "a" * 100 + "@example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email should be valid - true case" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.com user@example.com first.last@eem.au]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email should be valid - false case" do
    invalid_addresses = %w[@eee.com lol@eee,com lol,lolz@eee.com lolz@.com lolz@ lolz@eee lolz@eee. lolz@eee+www.com lolz@eee_www_.com]
    invalid_addresses.each do |iva|
      @chef.email = iva
      assert_not @chef.valid?, '#{iva.inspect} email not valid'
    end
  end
end