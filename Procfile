web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c $WORKER_THREADS -q default -q mailers
release: rails db:migrate