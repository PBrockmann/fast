#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

# Have colormaps separated into categories:
# http://matplotlib.org/examples/color/colormaps_reference.html

cmaps = [('PSU',  # Perceptually Uniform Sequential'
                            ['viridis', 'inferno', 'plasma', 'magma']),
         ('Seq1', # Sequential
			    ['Blues', 'BuGn', 'BuPu',
                             'GnBu', 'Greens', 'Greys', 'Oranges', 'OrRd',
                             'PuBu', 'PuBuGn', 'PuRd', 'Purples', 'RdPu',
                             'Reds', 'YlGn', 'YlGnBu', 'YlOrBr', 'YlOrRd',
			     'afmhot', 'autumn', 'bone', 'cool',
                             'copper', 'gist_heat', 'gray', 'hot',
                             'pink', 'spring', 'summer', 'winter']),
         ('Div',  # Diverging
			     ['BrBG', 'bwr', 'coolwarm', 'PiYG', 'PRGn', 'PuOr',
                             'RdBu', 'RdGy', 'RdYlBu', 'RdYlGn', 'Spectral',
                             'seismic']),
         ('Qual', # Qualitative   
		             ['Accent', 'Dark2', 'Paired', 'Pastel1',
                             'Pastel2', 'Set1', 'Set2', 'Set3']),
         ('Misc', # Miscellaneous 
		             ['gist_earth', 'terrain', 'ocean', 'gist_stern',
                             'brg', 'CMRmap', 'cubehelix',
                             'gnuplot', 'gnuplot2', 'gist_ncar',
                             'nipy_spectral', 'jet', 'rainbow',
                             'gist_rainbow', 'hsv', 'flag', 'prism'])]

levels = 101

for cmap_category, cmap_list in cmaps:
    for cmap_name in cmap_list:
        print cmap_category+'_'+cmap_name

	for rev in '', '_r':

		cmap_name1 = cmap_name + rev
		file = open('mpl_' + cmap_category + "_" + cmap_name1 + ".spk", "w")

		cmap = plt.get_cmap(cmap_name1)
		colors = cmap(np.linspace(0, 1, levels))

		for i,c in enumerate(colors):
    			r,g,b,a = c
    			file.write("%f %f %f %f\n" %(i*100./(levels-1), r*100, g*100, b*100))

		file.close()
	
