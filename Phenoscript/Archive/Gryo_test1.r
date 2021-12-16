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
      male_organism:G_bra > radicle:rad1 >> yellow;
      male_organism@G_bra > radicle@rad1 >> elongated; # are they the same radicles, the previous one?
      male_organism@G_bra > frontal_patch;
      #male_organism@G_bra > tenth_flagellomere has_component. multiporous_gustatory_sensillum [int=1];
      #male_organism@G_bra > tenth_flagellomere > multiporous_gustatory_sensillum has_count. 1;
      male_organism@G_bra > fifth_flagellomere !> multiporous_gustatory_sensillum;
      #----------------

      male_organism@G_bra > radicle >> length is_quality_measured_as. measurement@2brasiliensis has_measurement_unit_label. width << radicle@rad1; # !!! radicle@ ???
      measurement@2brasiliensis has_measurement_value. 5.7; # should be one value
      #mandible has_component. tooth [int=3];
      dorsal_tooth >> length |>| length << lower_tooth;

      #dorsal_tooth >> length |>| length << lower_tooth;


      lower_tooth >> length |>| length << medial_tooth_of_the_mandible;
      body > genal_patch;
      clypeus >> length is_quality_measured_as. measurement@clybrasiliensis has_measurement_unit_label. width << mandible;
      measurement@clybrasiliensi has_measurement_value. 3.0;

      male_organism@G_bra > hyperoccipital_carina;

      body > vertex_patch;
      anterior_process_of_the_pronotum >> decreased_size;
      body > epomial_carina;
      body > pronotal_cervical_sulcus;
      body > pronotal_suprahumeral_sulcus;
      pronotal_cervical_sulcus >> smooth;
      pronotal_suprahumeral_sulcus >> foveate;
      pronotal_suprahumeral_sulcus > medial_region !adjacent_to. pronotal_cervical_sulcus;
      netrion_sulcus !adjacent_to. anterior_rim_of_pronotum;
      body > netrion_sulcus;
      netrion >> foveate; # the same netrion as below
      netrion >> length is_quality_measured_as. measurement@3brasiliensis has_measurement_unit_label. length << pronoto-mesopectal_suture;
      measurement@3brasiliensis has_measurement_value. 0.67;

      body > posterior_pronotal_sulcus;
      ventral_propleural_area >> smooth;

      propleural_epicoxal_sulcus >> scalloped;
      body > subalar_pit;
      epicoxal_sulcus >> scalloped;
      scutoscutellar_sulcus > medial_region > fovea >> diameter |<| fovea < lateral region < scutoscutellar sulcus;
      anteromesoscutum > medial_region >> areolate;
      notaulus > anterior_margin anterior_to. transscutal_line;
      mesoscutal_humeral_sulcus >> scalloped;
      mesoscutal_suprahumeral_sulcus > antero-medial_region adjacent_to. anterior_region < notaulus;
      mesoscutal_suprahumeral_sulcus >> scalloped;
      scutoscutellar_sulcus > medial_region >> smooth;
      scutoscutellar_sulcus > lateral_region >> foveate;
      scutoscutellar_sulcus > lateral_region adjacent_to. axillula;
      mesoscutellum > dorsal_side > posterior_margin >> concave;
      mesoscutellum !> posteromedian_process_of_the_mesoscutellum;
      body > transaxillar_carina;
      posterior_mesoscutellar_sulcus adjacent_to. axillula;
      body > posterior_mesoscutellar_sulcus;
      posterior_mesoscutellar_sulcus >> foveate;
      mesepisternum >> areolate;
      body > mesopleural_pit;
      body > mesopleural_carina;
      body !> postacetabular_patch;
      acropleural_sulcus >> elongated;
      body > acropleural_sulcus;
      metanotal_spine !> lamella >> translucent;
      metascutellum > proximal_region >> striated;
      metanotal_spine >> length |>| length << proximal_region@brasiliensis < mesoscutellum;
      proximal_region@brasiliensis >> striated;
      metanotal_trough >> foveate;
      body > metanotal_spine;
      metanotal_spine > dorsal_side >> pointed;

      # !!! USE @ or one line
      body > metapleural_pit;

      metapleural_sulcus >> smooth;
# Remove below; Presence structure are not inded
      #body > metapleural_sulcus;

      ventral_metapleural_area berare_of. transversely_striated
      Metasomal depression !>> setose;
      body > lateral_propodeal_carina;
      lateral_propodeal_carina adjacent_to. posterior_propodeal_projection;
      lateral_propodeal_carina >> Y-shaped;

      body > posterior_propodeal_projection;
      hind_wing >> width is_quality_measured_as. measurement@3brasiliensis has_measurement_unit_label. length << marginal_cilia;
      measurement@3brasiliensis has_measurement_value. 2;
      abdominal_tergum_2 > lateral_side > dorsal_margin >> convex;

#--------------------------
      # abdominal_tergum_2 > lateral_region has_component. seta 5;
      # abdominal_tergum_2 > lateral_region > seta ?DataProp:COUNT 5;
#--------------------------

      body > felt_field;
      abdominal_tergum_3 > lateral_region > setiferous_patch;
      apical_setae_of_T3 !>> length |>| length << seta@1brasiliensis < abdominal_tergum_4;
      #!!!! !> ?
      #seta@1brasiliensis !apical_setae_of_T3;

      abdominal_tergum_4 > postero-dorsal_region > setiferous_patch;
      # we are describing one specimen
      #female !> S3_felt_field;
      (abdominal_tergum_2, abdominal_tergum_3, abdominal_tergum_4, abdominal_sternum_2, abdominal_sternum_3, abdominal_sternum_4) > basal_grooves;
      body > acrosternal_calyx;
      acrosternal_calyx >> circular;
      acrosternal_calyx >> paired;
      # !!!!
      #abdominal_tergum_9 > (lateral_apodeme@1brasiliensis, lateral apodeme@2brasiliensis);
      lateral_apodeme@1brasiliensis >> left;
      lateral_apoodeme@2brasiliensis >> right;
      lateral_apodeme@1brasiliensis !continuous_with. lateral_apodeme@2brasiliensis;
      abdominal_sternum_7 > anteromedial_region > apodeme;

      # !!! µm should be changed
      #body >> length is_quality_measured_as. measurement@0brasiliensis has_measurement_unit_label. µm;

# !!! refering to?
      #measurement@0brasiliensis has_measurement_value. [int>2300,<2400];
      head >> black;
      (interantennal_prominence, seventh_flagellomere, eighth_flagellomere, ninth_flagellomere, tenth_flagellomere) >> brown;
      (mouthparts, radicle, scape, pedicel, first_flagellomere, second_flagellomere, third_flagellomere, fourth_flagellomere, fifth_flagellomere, sixth_flagellomere) >> yellow;

      # this should be split it's a mixture of sybtax
      #(abdominal_tergum_2 > medial_region, abdominal_tergum_3 > medial_region) >> light_brown;
      # TO e.g.
      #(abdominal_tergum_2 > medial_region) >> light_brown;
      #(abdominal_tergum_3 > medial_region) >> light_brown;


      # this alos should be split
      #(abdominal_tergum_4, abdominal_tergum_6 > lateral_region, abdominal_tergum_7 > lateral_region) >> ochre;

      abdominal_tergum_5 > medial_region@1brasiliensis >> length is_quality_measured_as. measurement@4brasiliensis has_measurement_unit_label. length << abdominal_tergum_5;
      measurement@4brasiliensis has_measurement_value. 0.75;
      medial_region@1brasiliensis >> brown;

      abdominal_tergum_6 > medial_region@2brasiliensis >> length is_quality_measured_as. measurement@5brasiliensis has_measurement_unit_label. length << abdominal_tergum_6;
      #measurement@5brasiliensis has_measurement_value. [float=0.75];
      medial_region@2brasiliensis >> brown;
      abdominal_tergum_7 > medial_region@3brasiliensis >> length is_quality_measured_as. measurement@6brasiliensis has_measurement_unit_label. length << abdominal_tergum_7;
      #measurement@6brasiliensis has_measurement_value. [float=0.75];
      medial_region@3brasiliensis >> brown;
      #scape >> length is_quality_measured_as. measurement7brasiliensis has_measurement_unit_label. length << radicle; measurement7brasiliensis has_measurement_value. [float>4,<4.5];
      torular_triangle > (carina@1brasiliensis, carina@2brasiliensis);
      carina@1brasiliensis >> left;
      carina@2brasiliensis >> right;
      carina@1brasiliensis !continuous_with. carina@2brasiliensis;
      central_keel >> complete_structure;
      body > torular_triangle;
      Upper_face > anterior_side > horizontal_plane@1brasilieansis >> centered;
      torular_triangle adjacent_to. horizontal_plane@1brasiliensis;
      upper_face !> setiferous_patch >> transverse_orientation;
      upper_face > dorsal_region >> knobbled;
      upper_face > dorsal_side >> convex;
      Body > central_keel;
      head > anterior_side >> triangular;
      # head??
      #head@brasiliensis > anterior side > maximum_with dorsal_to. horizontal_plane@1 < head@brasiliensis;
      horizontal_plane@1 >> centered;
      occipital_carina > dorso-medial_region >> scalloped;
      eye > horizontal_plane@2 >> centered;
      facial_striae !> dorsal_region adjacent_to. horizontal_plane@2brasiliensis;
      vertex >> scalloped;
      vertex >> punctate;
      body > notaulus;
      notaulus > anterior_margin anterior_to. transscutal_line;
      dorsal_metapleural_area >> glabrous;
      propodeum > antero-medial_region !> pit >> paired;
      #lateral_propodeal_area > dorsal_region has_component. carina [int=2];
      lateral_propodeal_area > medial_region >> glabrous;
      posterior_propodeal_projection@brasiliensis >> length is_quality_measured_as. measurment@8brasiliensis has_measurement_unit_label. width << posterior_propodeal_projection@brasiliensis;
      #measurment@8brasiliensis has_measurement_value. [float<=1];
      abdominal_tergum_4@brasiliensis >> rugose;
      abdominal_tergum_4@brasiliensis > posterior_region@brasiliensis >> sculpted_surface;
      posterior_region@brasiliensis >> length is_quality_measured_as. measurement@9brasiliensis has_measurement_unit_label. length << abdominal_tergum_4@brasiliensis;
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
      male_organism@G_lav_fla > radicle >> yellow;

      #----------------
    ]
]
