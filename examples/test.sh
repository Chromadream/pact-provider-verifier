#!/usr/bin/env ruby

puts "=> Starting API"
pipe = IO.popen("ruby api.rb")
sleep 2

puts "=> Running Pact"
puts "=> Test FAILING Pact"
res = `pact-provider-verifier --provider-base-url http://localhost:4567 --pact-urls ./fail.json --provider_states_setup_url http://localhost:4567/provider-state --provider_states_url http://localhost:4567/provider-states`
puts res

puts "=> Test SUCCESSFUL Pact"
res = `pact-provider-verifier --provider-base-url http://localhost:4567 --pact-urls ./me-they.json,./another-they.json --provider_states_setup_url http://localhost:4567/provider-state --provider_states_url http://localhost:4567/provider-states`
puts res

puts "=> Shutting down API"
Process.kill 'TERM', pipe.pid

puts "Test exit status: #{res}"
puts
puts
exit code.exitstatus
