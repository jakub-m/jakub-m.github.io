#!/usr/bin/env python2.7

import re
import sys
from math import log10
import collections


PAT_STATS = re.compile(r'(\d+(?:\.\d+)?) *(.s) *(?:\[(\w+)\])?')
UNITS = { 'ms': 1e-3,
          'us': 1e-6,
          'ns': 1e-9 }


def calc_latency(number, unit):
    return float(number) * UNITS[unit]

def format_time(sec):
    if sec < 1e-9:
        return '{:.1f} {}'.format(sec/1e-9, 'ns')
    if sec < 1e-6:
        return '{:.0f} {}'.format(sec/1e-9, 'ns')
    if sec < 1e-3:
        return '{:.0f} {}'.format(sec/1e-6, 'us')
    if sec < 1e-0:
        return '{:.0f} {}'.format(sec/1e-3, 'ms')
    return str(sec)

def iter_stats():
    name = None
    for line in sys.stdin:
        line = line.strip()
        if line.startswith('#'):
            continue
        if line.startswith('---'):
            name = None
            continue
        if not name:
            name = line
            continue
        m = PAT_STATS.match(line)
        if m:
            number_str, unit_str, reference = m.groups()
            latency = calc_latency(number_str, unit_str)
            magnitude = log10(latency) + 9.
            yield {'name': name, 'latency': format_time(latency), 'magnitude': magnitude, 'reference': reference}

def format_dots(n):
    if n < 0:
        return ''
    return '*' * int(n*2)

def main():
    for s in sorted(iter_stats(), key=lambda d: d['magnitude']):
        ref = '\t[{}]'.format(s['reference']) if s['reference'] else ''
        print '{dots: <20} | {latency:>10} | {name:<30} | {ref}'.format(dots=format_dots(s['magnitude']), ref=ref, **s)

main()
