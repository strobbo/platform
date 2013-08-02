require 'test_helper'

class UserTest < ActiveSupport::TestCase
	fixtures :users
		
	def test_follow
		assert_equal 0, users(:tester1).followed_users.size
		users(:tester1).follow(users(:tester2))
		assert_equal 1, users(:tester1).followed_users.size
	end

	def test_unfollow
		users(:tester1).follow(users(:tester2))
		assert_equal 1, users(:tester1).followed_users.size
		users(:tester1).unfollow(users(:tester2))
		assert_equal 0, users(:tester1).followed_users.size
	end

	def test_following?
		deny users(:tester1).following?(users(:tester2))
		users(:tester1).follow(users(:tester2))
		assert users(:tester1).following?(users(:tester2))
		users(:tester1).unfollow(users(:tester2))
		deny users(:tester1).following?(users(:tester2))
	end

	def test_followed_count
		assert_equal 0, users(:tester1).followers.size
		users(:tester2).follow(users(:tester1))
		assert_equal 1, users(:tester1).followers.size
	end

	def test_followed?
		deny users(:tester1).followed?(users(:tester2))
		users(:tester2).follow(users(:tester1))
		assert users(:tester1).followed?(users(:tester2))
		users(:tester2).unfollow(users(:tester1))
		deny users(:tester1).followed?(users(:tester2))
	end
end
