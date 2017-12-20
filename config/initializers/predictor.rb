require 'redis'
Predictor.redis = Redis.new(:url => "redis://localhost:6379")
