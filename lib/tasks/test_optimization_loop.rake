namespace :test_optimization_loop do
  task run: :environment do
    cmd = "rake parallel:spec[3]"
    puts "Running rspec via #{cmd}"
    command = TTY::Command.new(printer: :quiet, color: true)

    start = Time.now
    begin
      res = command.run(cmd)

      # Parse really executed count of examples
      # Take last item (it contains the sum of the parralel running)
      samples_executed = Integer(res.out.scan(/\d+ examples/).last.split(' ')[0])
    rescue TTY::Command::ExitError
      puts 'TEST FAILED SAFELY'
    end
    finish = Time.now

    metric = TestMetrics.write(
      user: `whoami`.strip,
      run_time_seconds: (finish - start).to_i,
      samples: samples_executed,
    )

    puts "Metric is send to InfluxDB\n\n#{metric.inspect}"
  end
end
