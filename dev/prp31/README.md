# Goal
We perform a detection of PRP31 homologs in Eukaryotes, Bacteria and Archaea since this protein seems somehow related to Nop5 (structures superimpose very well).

# Methods
- As usual we start from a profile HMM of Prp31 animal orthologs (cured, n=287). 
- hmmsearch hits (n=17,311) are cured (e-value < 1e-5) and only proteins with 200 < len < 1000 are kept (n=16,853).

# Results

### Taxonomic distribution of Prp31
- We get three hits in the human genome which are Prp31, Nop56 and Nop58. This allows to caibrate the GA score of the profile HMM ; we set it to 210 to be a bit conservative.
- We get no hits in Archaea using the inclusion criterion which is coherent with the literature (since Archaea do not perform alternative splicing).
- We get not hits in Bacteria neither, which was also expected.

### Similarity between Nop56/Nop58 and Prp31
- We notice that we take 3 hits in the human genome, which correspond to Prp31 (e-value < 1e-257), Nop56 (e-value < 1e-30) and Nop58 (e-value < 1e-26).
- We take the curated hits (e-value < 1e-5, n=17,311) of Prp31 and compare them to the curated hits of Nop56/Nop58 (n=17,232). There are only n=1,031 hits differing between both searches over 17,331 hits in Prp31.
- This strengthens even more the similarity between Prp31 and Nop56/Nop58. 
