%chk=dicmolecule.chk
%mem=24GB
%nprocshared=8

#P MP2(Full,FullDirect)/6-311++G(d,p) Opt Units=Angstroms


-2 1
C 0.0 0.0 0.0
C 0.0 0.0 1.3







