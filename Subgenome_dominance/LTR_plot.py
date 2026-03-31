#!/usr/bin/env python3

import mpl_font.noto
import matplotlib.pyplot as plt
from brokenaxes import brokenaxes
import numpy as np

#window10
Coverage_H = "coverage_average_H_NS.txt"
Coverage_St1 = "coverage_average_St1_NS.txt"
Coverage_St2 = "coverage_average_St2_NS.txt"

coverage_x = []
coverage_y_H = []
coverage_y_St1 = []
coverage_y_St2 = []

with open(Coverage_H, 'r') as infile:
    for line in infile:
        fields = line.strip().split('\t')
        pos = int(fields[0])
        H_LTR = float(fields[1])*100
        strand = fields[2]
        if strand == "'5prime'":
            y_axis = (501 - pos) * (-10)
            
        elif strand == "'3prime'":
            y_axis = pos * 10
        coverage_x.append(y_axis)
        coverage_y_H.append(H_LTR)
        
with open(Coverage_St1, 'r') as infile:
    for line in infile:
        fields = line.strip().split('\t')
        St1_LTR = float(fields[1])*100
        coverage_y_St1.append(St1_LTR)

with open(Coverage_St2, 'r') as infile:
    for line in infile:
        fields = line.strip().split('\t')
        St2_LTR = float(fields[1])*100
        coverage_y_St2.append(St2_LTR)

output_file = "LTR_Coverage.png"
 
        
fig = plt.figure(figsize=(5,2))
bax = brokenaxes(xlims=((-5000, -10), (0.1, 5000)), wspace=0.35)
bax.plot(coverage_x, coverage_y_H)
bax.plot(coverage_x, coverage_y_St1)
bax.plot(coverage_x, coverage_y_St2)
bax.legend(loc=3, frameon=False,)
#bax.set_xlabel('Distance to coding start/stop site (bp)')
#bax.set_ylabel('LTR coverage (%)')
plt.savefig('coverage_plot_subgenome.png', format='png', dpi=300, bbox_inches='tight')
plt.show()

# Close the plot to free memory
plt.close()
