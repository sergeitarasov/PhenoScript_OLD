# this is example 1
OTU=[

OTU_model=[
  organism@o1["to_Ophu_List"="denotes", new=2] denotes. organism@o2[rdfs:label="Gryonoides brasiliensis"];
  protein@o1 !> organism@o2;
  protein !>> organism < organism << organism;
  #organism@o1 has_part. Ophu_List;

  #Uberon:multicellura_org@id11 belongs_to./rdfs:type @id22["resource ncbi taxon"]
  #Uberon:multicellura_org@id11 part_of;

  #Better organism:o1 denotes. organism:o2;
  #Better organism:o1 .denotes organism:o2;
  #Better organism:o1 evc> organism:o2;

  ]

  Ophu_List=[
  sclerite tets. 3.2;
  head !has_part. sclerite;
  abdominal_tergite_IX encircles_via_conjunctiva. sclerite@1 encircles_via_conjunctiva. sclerite@2 encircles_via_conjunctiva. sclerite@3;
  (sclerite@1, sclerite@2, sclerite@3) part_of. appendage;

  sclerite@1 has_part. (sclerite, sclerite);

  sclerite@1 has_part. (sclerite encircles_via_conjunctiva. sclerite);
  (sclerite@10 encircles_via_conjunctiva. sclerite@11) has_part. head_capsule;
  # Better no commas (sclerite:1 sclerite:2 sclerite:3) appendage:[iri=msm]

  ]

]

# this is example 2
OTU=[

  OTU_model=[
    organism@s3["to_Ophu_List"="denotes"] denotes. organism@s4["rdfs:label"="Gryonoides sp2"];

  ]

  Ophu_List=[
    sclerite tets. 5;
    head has_part. antenna;

  ]

]
