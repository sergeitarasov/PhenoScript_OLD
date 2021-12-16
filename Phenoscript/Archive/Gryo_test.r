# NON-translated
# width (i will fix it),
# measurement
#adjacent_to
#adjacent_to.[iri="RO_0002220"]

# A strcutre (the same) that occurs multiple times should be personilized/tagged with @

#-----------------------
#
# Gryonoides_brasiliensis
#
#-----------------------

OTU=[ #Gryonoides_brasiliensis
  OTU_model=
    [
      TU@CNCHYMEN_132936["to_Ophu_List"="has_phenotype", "rdfs:label"="Gryonoides_brasiliensis"] denotes. male_organism@G_bra["rdfs:label"="Gryonoides_brasiliensis"];
      TU@CNCHYMEN_132936 denotes. Gryonoides;

    ]

  Ophu_List=
    [
# Real number 1.0; Integer 1
      # This is new Phenoscript, how it should be
      male_organism@G_bra has_part. radicle@rad1 bearer_of. yellow;
      male_organism@G_bra has_part. radicle@rad1 bearer_of. elongated; # are they the same radicles, the previous one?
      male_organism@G_bra has_part. frontal_patch;
      #male_organism@G_bra has_part. tenth_flagellomere has_component. multiporous_gustatory_sensillum [int=1];
      #male_organism@G_bra has_part. tenth_flagellomere has_part. multiporous_gustatory_sensillum has_count. 1;
      male_organism@G_bra has_part. fifth_flagellomere !has_part. multiporous_gustatory_sensillum;
      #----------------

      male_organism@G_bra > radicle bearer_of. length is_quality_measured_as. measurement@2brasiliensis has_measurement_unit_label. width inheres_in. radicle@rad1; # !!! radicle@ ???
      measurement@2brasiliensis has_measurement_value. 5.7; # should be one value
      #mandible has_component. tooth [int=3];
      dorsal_tooth bearer_of. length increased_in_magnitude_relative_to. length inheres_in. lower_tooth;

      #dorsal_tooth >> length increased_in_magnitude_relative_to. length << lower_tooth;


      lower_tooth bearer_of. length increased_in_magnitude_relative_to. length inheres_in. medial_tooth_of_the_mandible;
      body has_part. genal_patch;
      clypeus bearer_of. length is_quality_measured_as. measurement@clybrasiliensis has_measurement_unit_label. width inheres_in. mandible;
      measurement@clybrasiliensi has_measurement_value. 3.0;

      male_organism@G_bra has_part. hyperoccipital_carina;

      body has_part. vertex_patch;
      anterior_process_of_the_pronotum bearer_of. decreased_size;
      body has_part. epomial_carina;
      body has_part. pronotal_cervical_sulcus;
      body has_part. pronotal_suprahumeral_sulcus;
      pronotal_cervical_sulcus bearer_of. smooth;
      pronotal_suprahumeral_sulcus bearer_of. foveate;
      pronotal_suprahumeral_sulcus has_part. medial_region !adjacent_to. pronotal_cervical_sulcus;
      netrion_sulcus !adjacent_to. anterior_rim_of_pronotum;
      body has_part. netrion_sulcus;
      netrion bearer_of. foveate; # the same netrion as below
      netrion bearer_of. length is_quality_measured_as. measurement@3brasiliensis has_measurement_unit_label. length inheres_in. pronoto-mesopectal_suture;
      measurement@3brasiliensis has_measurement_value. 0.67;

      body has_part. posterior_pronotal_sulcus;
      ventral_propleural_area bearer_of. smooth;

      propleural_epicoxal_sulcus bearer_of. scalloped;
      body has_part. subalar_pit;
      epicoxal_sulcus bearer_of. scalloped;
      scutoscutellar_sulcus has_part. medial_region has_part. fovea bearer_of. diameter decreased_in_magnitude_relative_to. fovea part_of. lateral region part_of. scutoscutellar sulcus;
      anteromesoscutum has_part. medial_region bearer_of. areolate;
      notaulus has_part. anterior_margin anterior_to. transscutal_line;
      mesoscutal_humeral_sulcus bearer_of. scalloped;
      mesoscutal_suprahumeral_sulcus has_part. antero-medial_region adjacent_to. anterior_region part_of. notaulus;
      mesoscutal_suprahumeral_sulcus bearer_of. scalloped;
      scutoscutellar_sulcus has_part. medial_region bearer_of. smooth;
      scutoscutellar_sulcus has_part. lateral_region bearer_of. foveate;
      scutoscutellar_sulcus has_part. lateral_region adjacent_to. axillula;
      mesoscutellum has_part. dorsal_side has_part. posterior_margin bearer_of. concave;
      mesoscutellum !has_part. posteromedian_process_of_the_mesoscutellum;
      body has_part. transaxillar_carina;
      posterior_mesoscutellar_sulcus adjacent_to. axillula;
      body has_part. posterior_mesoscutellar_sulcus;
      posterior_mesoscutellar_sulcus bearer_of. foveate;
      mesepisternum bearer_of. areolate;
      body has_part. mesopleural_pit;
      body has_part. mesopleural_carina;
      body !has_part. postacetabular_patch;
      acropleural_sulcus bearer_of. elongated;
      body has_part. acropleural_sulcus;
      metanotal_spine !has_part. lamella bearer_of. translucent;
      metascutellum has_part. proximal_region bearer_of. striated;
      metanotal_spine bearer_of. length increased_in_magnitude_relative_to. length inheres_in. proximal_region@brasiliensis part_of. mesoscutellum;
      proximal_region@brasiliensis bearer_of. striated;
      metanotal_trough bearer_of. foveate;
      body has_part. metanotal_spine;
      metanotal_spine has_part. dorsal_side bearer_of. pointed;

      # !!! USE @ or one line
      body has_part. metapleural_pit;

      metapleural_sulcus bearer_of. smooth;
# Remove below; Presence structure are not inded
      #body has_part. metapleural_sulcus;

      ventral_metapleural_area berare_of. transversely_striated
      Metasomal depression !bearer_of. setose;
      body has_part. lateral_propodeal_carina;
      lateral_propodeal_carina adjacent_to. posterior_propodeal_projection;
      lateral_propodeal_carina bearer_of. Y-shaped;

      body has_part. posterior_propodeal_projection;
      hind_wing bearer_of. width is_quality_measured_as. measurement@3brasiliensis has_measurement_unit_label. length inheres_in. marginal_cilia;
      measurement@3brasiliensis has_measurement_value. 2;
      abdominal_tergum_2 has_part. lateral_side has_part. dorsal_margin bearer_of. convex;

#--------------------------
      # abdominal_tergum_2 has_part. lateral_region has_component. seta 5;
      # abdominal_tergum_2 has_part. lateral_region has_part. seta ?DataProp:COUNT 5;
#--------------------------

      body has_part. felt_field;
      abdominal_tergum_3 has_part. lateral_region has_part. setiferous_patch;
      apical_setae_of_T3 !bearer_of. length increased_in_magnitude_relative_to. length inheres_in. seta@1brasiliensis part_of. abdominal_tergum_4;
      #!!!! !has_part. ?
      #seta@1brasiliensis !apical_setae_of_T3;

      abdominal_tergum_4 has_part. postero-dorsal_region has_part. setiferous_patch;
      # we are describing one specimen
      #female !has_part. S3_felt_field;
      (abdominal_tergum_2, abdominal_tergum_3, abdominal_tergum_4, abdominal_sternum_2, abdominal_sternum_3, abdominal_sternum_4) has_part. basal_grooves;
      body has_part. acrosternal_calyx;
      acrosternal_calyx bearer_of. circular;
      acrosternal_calyx bearer_of. paired;
      # !!!!
      #abdominal_tergum_9 has_part. (lateral_apodeme@1brasiliensis, lateral apodeme@2brasiliensis);
      lateral_apodeme@1brasiliensis bearer_of. left;
      lateral_apoodeme@2brasiliensis bearer_of. right;
      lateral_apodeme@1brasiliensis !continuous_with. lateral_apodeme@2brasiliensis;
      abdominal_sternum_7 has_part. anteromedial_region has_part. apodeme;

      # !!! µm should be changed
      #body bearer_of. length is_quality_measured_as. measurement@0brasiliensis has_measurement_unit_label. µm;

# !!! refering to?
      #measurement@0brasiliensis has_measurement_value. [int>2300,<2400];
      head bearer_of. black;
      (interantennal_prominence, seventh_flagellomere, eighth_flagellomere, ninth_flagellomere, tenth_flagellomere) bearer_of. brown;
      (mouthparts, radicle, scape, pedicel, first_flagellomere, second_flagellomere, third_flagellomere, fourth_flagellomere, fifth_flagellomere, sixth_flagellomere) bearer_of. yellow;

      # this should be split it's a mixture of sybtax
      #(abdominal_tergum_2 has_part. medial_region, abdominal_tergum_3 has_part. medial_region) bearer_of. light_brown;
      # TO e.g.
      #(abdominal_tergum_2 has_part. medial_region) bearer_of. light_brown;
      #(abdominal_tergum_3 has_part. medial_region) bearer_of. light_brown;


      # this alos should be split
      #(abdominal_tergum_4, abdominal_tergum_6 has_part. lateral_region, abdominal_tergum_7 has_part. lateral_region) bearer_of. ochre;

      abdominal_tergum_5 has_part. medial_region@1brasiliensis bearer_of. length is_quality_measured_as. measurement@4brasiliensis has_measurement_unit_label. length inheres_in. abdominal_tergum_5;
      measurement@4brasiliensis has_measurement_value. 0.75;
      medial_region@1brasiliensis bearer_of. brown;

      abdominal_tergum_6 has_part. medial_region@2brasiliensis bearer_of. length is_quality_measured_as. measurement@5brasiliensis has_measurement_unit_label. length inheres_in. abdominal_tergum_6;
      #measurement@5brasiliensis has_measurement_value. [float=0.75];
      medial_region@2brasiliensis bearer_of. brown;
      abdominal_tergum_7 has_part. medial_region@3brasiliensis bearer_of. length is_quality_measured_as. measurement@6brasiliensis has_measurement_unit_label. length inheres_in. abdominal_tergum_7;
      #measurement@6brasiliensis has_measurement_value. [float=0.75];
      medial_region@3brasiliensis bearer_of. brown;
      #scape bearer_of. length is_quality_measured_as. measurement7brasiliensis has_measurement_unit_label. length inheres_in. radicle; measurement7brasiliensis has_measurement_value. [float>4,<4.5];
      torular_triangle has_part. (carina@1brasiliensis, carina@2brasiliensis);
      carina@1brasiliensis bearer_of. left;
      carina@2brasiliensis bearer_of. right;
      carina@1brasiliensis !continuous_with. carina@2brasiliensis;
      central_keel bearer_of. complete_structure;
      body has_part. torular_triangle;
      Upper_face has_part. anterior_side has_part. horizontal_plane@1brasilieansis bearer_of. centered;
      torular_triangle adjacent_to. horizontal_plane@1brasiliensis;
      upper_face !has_part. setiferous_patch bearer_of. transverse_orientation;
      upper_face has_part. dorsal_region bearer_of. knobbled;
      upper_face has_part. dorsal_side bearer_of. convex;
      Body has_part. central_keel;
      head has_part. anterior_side bearer_of. triangular;
      # head??
      #head@brasiliensis has_part. anterior side has_part. maximum_with dorsal_to. horizontal_plane@1 part_of. head@brasiliensis;
      horizontal_plane@1 bearer_of. centered;
      occipital_carina has_part. dorso-medial_region bearer_of. scalloped;
      eye has_part. horizontal_plane@2 bearer_of. centered;
      facial_striae !has_part. dorsal_region adjacent_to. horizontal_plane@2brasiliensis;
      vertex bearer_of. scalloped;
      vertex bearer_of. punctate;
      body has_part. notaulus;
      notaulus has_part. anterior_margin anterior_to. transscutal_line;
      dorsal_metapleural_area bearer_of. glabrous;
      propodeum has_part. antero-medial_region !has_part. pit bearer_of. paired;
      #lateral_propodeal_area has_part. dorsal_region has_component. carina [int=2];
      lateral_propodeal_area has_part. medial_region bearer_of. glabrous;
      posterior_propodeal_projection@brasiliensis bearer_of. length is_quality_measured_as. measurment@8brasiliensis has_measurement_unit_label. width inheres_in. posterior_propodeal_projection@brasiliensis;
      #measurment@8brasiliensis has_measurement_value. [float<=1];
      abdominal_tergum_4@brasiliensis bearer_of. rugose;
      abdominal_tergum_4@brasiliensis has_part. posterior_region@brasiliensis bearer_of. sculpted_surface;
      posterior_region@brasiliensis bearer_of. length is_quality_measured_as. measurement@9brasiliensis has_measurement_unit_label. length inheres_in. abdominal_tergum_4@brasiliensis;
      #measurement@9brasiliensis has_measurement_value. [float=0.8];

    ]
]

#-----------------------
#
# Gryonoides_flaviclavus_flaviclavus
#
#-----------------------

OTU=[ #Gryonoides_flaviclavus_flaviclavus
  OTU_model=
    [
      TU@id_here2["to_Ophu_List"="has_phenotype", "rdfs:label"="Gryonoides laviclavus flaviclavus"] denotes. male_organism@G_lav_fla["rdfs:label"="Gryonoides laviclavus flaviclavus"];
      TU@id_here2 denotes. Gryonoides;
    ]

  Ophu_List=
    [
      # This is new Phenoscript, how it should be
      male_organism@G_lav_fla has_part. radicle bearer_of. yellow;

      #----------------
    ]
]
