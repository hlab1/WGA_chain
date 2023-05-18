# WGA_chain

This project creates delta files and chain files for linkage between Col and other 7 Accessions.

For Jbrowse2 linear synteny view, use the results/mummer4/Col_ref_XXX_Q.filtered.delta
For liftOver, Use the results/chain/\*.chain. Need to liftOver both directions (XXX to Col and Col to XXX), then merge the peaks by peak ids. For each liftOver, lift with FWD.chain and REV.chain, then cat FWD REV > finalLiftedFile
