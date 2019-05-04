namespace :test_optimization_loop do
  task run: :environment do
    cmd = "rake parallel:spec[3]"
    puts "Running rspec via #{cmd}"
    command = TTY::Command.new(printer: :quiet, color: true)

    def parse_samples(output)
      Integer(output.scan(/\d+ examples/).last.split(' ')[0])
    end

    start = Time.now
    begin
      res = command.run(cmd)

      # Parse really executed count of examples
      # Take last item (it contains the sum of the parralel running)
      samples_executed = parse_samples(res.out)
    rescue TTY::Command::ExitError => e
      samples_executed = parse_samples(e.message)
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
