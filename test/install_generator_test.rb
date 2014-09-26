require 'test_helper'

require 'generators/createsend_cached/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination
  tests CreateSendCached::Generators::InstallGenerator

  test "should generate a migration" do
    run_generator %w(install)

    assert_migration "db/migrate/install_createsend_cached.rb" do |content|
      assert_match /class InstallCreatesendCached/, content
    end
  end
end