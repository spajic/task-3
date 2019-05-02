# Optimisation loop

Run `RAILS_ENV=test SAMPLE=50 rake test_optimization_loop:run` command. Number of `SAMPLE` can be different depending on speed of execution or can be ommited. Taget metric is the count of RSpec examples executed per second.

`SELECT "samples" / "run_time_seconds" FROM db..test WHERE tmpltime()`
