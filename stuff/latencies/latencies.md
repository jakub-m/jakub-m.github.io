Exemplary latencies.

Asterisks represent orders of magnitude. Each two asterisks represent x10 difference in latency.


```
                     |     0.5 ns | L1 cache                       | 	[norvig]
                     |       2 ns | L1 cache                       | 	[haswell]
*                    |       4 ns | L2 cache                       | 	[haswell]
*                    |       7 ns | L2 cache                       | 	[norvig]
**                   |      11 ns | L3 cache                       | 	[haswell]
***                  |      68 ns | RAM                            | 	[haswell]
****                 |     100 ns | RAM                            | 	[norvig]
*********            |      60 us | Optane drive                   | 	[ars_optane]
*********            |      80 us | SDD                            | 	[hdd_wiki]
**********           |     100 us | Optane drive                   | 	[ars_optane]
**********           |     160 us | SDD                            | 	[hdd_wiki]
**********           |     200 us | SDD                            | 	[anand_ssd]
***********          |     500 us | RTT in the same datacenter     | 	[jboner]
*************        |       4 ms | HDD                            | 	[hdd_wiki]
*************        |       9 ms | HDD                            | 	[hdd_wiki]
***************      |      33 ms | Light, RTT between US coasts   | 
```

[jboner] https://gist.github.com/jboner/2841832

[norvig] http://norvig.com/21-days.html#answers

[haswell] http://www.7-cpu.com/cpu/Haswell.html

[hdd_wiki] https://en.wikipedia.org/wiki/Hard_disk_drive_performance_characteristics

[ars_optane] https://arstechnica.com/information-technology/2017/03/intels-first-optane-ssd-375gb-that-you-can-also-use-as-ram/

[anand_ssd] http://www.anandtech.com/show/8104/intel-ssd-dc-p3700-review-the-pcie-ssd-transition-begins-with-nvme/3
