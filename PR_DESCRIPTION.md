# Оптимизация

На тайминге ниже преставлено время рендеринга шаблона `articles/_single_story.html.erb`

![Template](/pr_images/template_render.png)

Было предложено попробовать закэшировать шаблон.

### AB testing

Before

```
Concurrency Level:      5
Time taken for tests:   3.375 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1729700 bytes
HTML transferred:       1725470 bytes
Requests per second:    2.96 [#/sec] (mean)
Time per request:       1687.285 [ms] (mean)
Time per request:       337.457 [ms] (mean, across all concurrent requests)
Transfer rate:          500.56 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0       1
Processing:  1097 1452 276.3   1555    1861
Waiting:     1093 1449 276.0   1555    1849
Total:       1097 1452 276.4   1555    1862

Percentage of the requests served within a certain time (ms)
  50%   1555
  66%   1637
  75%   1663
  80%   1737
  90%   1862
  95%   1862
  98%   1862
  99%   1862
 100%   1862 (longest request)
```

After

```
Concurrency Level:      5
Time taken for tests:   0.958 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1733960 bytes
HTML transferred:       1729730 bytes
Requests per second:    10.44 [#/sec] (mean)
Time per request:       478.951 [ms] (mean)
Time per request:       95.790 [ms] (mean, across all concurrent requests)
Transfer rate:          1767.74 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.3      0       1
Processing:   245  437 143.3    401     712
Waiting:      245  435 142.8    395     710
Total:        245  437 143.5    401     712

Percentage of the requests served within a certain time (ms)
  50%    401
  66%    458
  75%    576
  80%    578
  90%    712
  95%    712
  98%    712
  99%    712
 100%    712 (longest request)
```

На мониторинге это выглядит так

![Monitoring](/pr_images/template_mon.png)

Before

![Monitoring](/pr_images/template_mon_was.png)

After

![Monitoring](/pr_images/template_mon_now.png)
