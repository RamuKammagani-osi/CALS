# frozen_string_literal: true

if Rails.env.test?
  $redis = Redis::Namespace.new('CALS', redis: MockRedis.new)
  # else
  #   $redis = Redis::Namespace.new("CALS", :redis => Redis.new)
end
