# test-service-infra

# Load test results

```Requests      [total, rate, throughput]         151201, 42.00, 41.99
Duration      [total, attack, wait]             1h0m0s, 1h0m0s, 258.901ms
Latencies     [min, mean, 50, 90, 95, 99, max]  8.803ms, 266.983ms, 263.03ms, 273.185ms, 285.382ms, 374.31ms, 1.36s
Bytes In      [total, mean]                     3779744, 25.00
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           99.99%
Status Codes  [code:count]                      0:11  200:151189  503:1  
Error Set:
503 Service Unavailable
Get "https://dev-api-gw-14qb7p37.uc.gateway.dev/service": read tcp 192.168.1.38:58441->216.239.36.56:443: read: connection reset by peer```