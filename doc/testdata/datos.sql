BEGIN TRANSACTION;

INSERT INTO "alumno" VALUES(1, NULL);
INSERT INTO "alumno" VALUES(2, NULL);
INSERT INTO "alumno" VALUES(3, NULL);
INSERT INTO "alumno" VALUES(4, NULL);
INSERT INTO "alumno" VALUES(5, NULL);
INSERT INTO "alumno" VALUES(6, NULL);
INSERT INTO "alumno" VALUES(7, NULL);
INSERT INTO "alumno" VALUES(8, NULL);
INSERT INTO "alumno" VALUES(9, NULL);
INSERT INTO "alumno" VALUES(10, NULL);
INSERT INTO "alumno" VALUES(11, NULL);
INSERT INTO "alumno" VALUES(12, NULL);
INSERT INTO "alumno" VALUES(13, NULL);
INSERT INTO "alumno" VALUES(14, NULL);
INSERT INTO "alumno" VALUES(15, NULL);
INSERT INTO "alumno" VALUES(16, NULL);
INSERT INTO "alumno" VALUES(17, NULL);
INSERT INTO "alumno" VALUES(18, NULL);
INSERT INTO "alumno" VALUES(19, NULL);

INSERT INTO "alumno_inscripto" VALUES(1, 8, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(2, 8, 2, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(3, 8, 3, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(4, 8, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(5, 8, 5, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(6, 8, 6, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(7, 8, 7, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(8, 8, 8, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(9, 8, 9, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(10, 8, 10, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(11, 8, 11, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(12, 8, 12, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(13, 8, 13, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(14, 8, 14, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(15, 8, 15, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(16, 8, 16, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(17, 8, 17, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(18, 8, 18, 0, NULL, NULL, NULL, NULL);
INSERT INTO "alumno_inscripto" VALUES(19, 8, 19, 0, NULL, NULL, NULL, NULL);

INSERT INTO "caso_de_prueba" VALUES(4, 1, 'Demasiados par√°metros');
INSERT INTO "caso_de_prueba" VALUES(5, 1, 'Falta un par√°metro');
INSERT INTO "caso_de_prueba" VALUES(6, 1, 'No existe archivo');
INSERT INTO "caso_de_prueba" VALUES(7, 1, 'Prueba de Registros / Matematica');
INSERT INTO "caso_de_prueba" VALUES(8, 1, 'Prueba de Memoria');
INSERT INTO "caso_de_prueba" VALUES(9, 1, 'Prueba de Comparaciones / Varios');
INSERT INTO "caso_de_prueba" VALUES(10, 1, 'Prueba de Saltos');
INSERT INTO "caso_de_prueba" VALUES(11, 1, 'Chequeo de memoria');
INSERT INTO "caso_de_prueba" VALUES(12, 1, 'Bubble Sort');
INSERT INTO "caso_de_prueba" VALUES(13, 1, 'Sin par√°metros');

INSERT INTO "comando" VALUES(1, 'make -f Makefile', 'Compila C++ usando un Makefile gen√©rico que compila todo en un ejecutable llamado tp', 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, '(V__stdouterr__
tp1
.', 1, 'ComandoFuente');
INSERT INTO "comando" VALUES(2, '', 'Corre el caso de prueba sin filtros', -257, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, NULL, '(t.', 1, 'ComandoPrueba');
INSERT INTO "comando" VALUES(3, 'valgrind --trace-children=yes --track-fds=yes --num-callers=20 --leak-check=full --show-reachable=yes --leak-resolution=high', 'Chequea memoria con valgrind', -257, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, NULL, '(V__stdouterr__
tp1
.', 1, 'ComandoPrueba');
INSERT INTO "comando" VALUES(4, './tp 8 2 100 -3 prueba1.asm de mas', 'Debe fallar porque tiene par√°metros de m√°s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID¸˝˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸√\Ú>√\Ú>Nq˝˘·¸·¸ID˙˚¸˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸√\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘6˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(5, './tp 8 2 100 -3', 'Falta par√°metro de archivo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID¸˝˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸√\Ú>√\Ú>Nq˝˘·¸·¸ID˙˚¸˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸√\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘6˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(6, './tp 8 2 100 -3 no_existo.asm', 'Se pide procesar un archivo que no existe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID¸˝˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸√\Ú>√\Ú>Nq˝˘·¸·¸ID˙˚¸˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸√\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘6˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(7, './tp 16 9 50 -50 prueba1.asm', 'Prueba de Registros / Matematica / Instrucciones MOV, ADD, SUB, OUT', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 'ı[V{ÜzA=µÉúk {}Äpml<9l~x`_õPõP`ÉÛÛ‡_XvŒ;»ÚbÛ√åû~U8ní∑0fÇ$F√òbîËÓª‘Å•ØF2í$-Æ2ÙT3¡!·Å‰Id∫Àæø^¿˜K,rõº∫¶U·{4xcT&âØÛGèÊÓúVÃuS¬za¶å¢•ÀÅ
ïG·Õ©4lø≠0^Öq+˘,ë”& Zi;å¥1Z>é˘óà¿∑Ì0r≠§∞<§ÚCdÖ8¢„∞l7{QÅ†G÷•B)§k 8ã”≥CTÉ“iEYÔâ+V•Øãô"Ä7„˘ŒÇŒ?P‘Ud|BMMÊ˚ç
€ßÈ	öÒ‚x‹€gM]™ºgŸ<§9%j§K§[$f‰î>XZìô¸g@Fuùk¥µÃ≤MÃ%(ÃøZ€@ª∫l√…Òw5ôxÃBRÃHfv¡ãO¢ﬁÕ\“h“%ëIπ‰mÌ∆ÆÉ€æ§
´nﬂ¿|GOxπîí.¡{3TÃÏ≥ØYò¯ƒNA]ı*†	Pp€∂œ˘{z[äÿíÆmÏ¶óTÿÒ¶8;fs¡„ΩùÚÿ>˚[V"{ÜzA=µÉúk´å{}Äpml<9l~x`_õP`É[VQ⁄', 'ID¸˝˘˘˘˘˘C[h/†E{U	˘˘˘	˘˘˘˘˘XXlm]hnmXXNM˘¸¥\Ú>¥\Ú>Nq˝˘·¸·¸*)+),)-)&-)ID˙˚¸˘˘˘˘˘C[h/†E{U	˘˘˘	˘˘˘˘˘˘˘˘˘˙˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸¥\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘F˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(8, './tp 8 2 100 -3 prueba2.asm', 'Prueba de Memoria / Instrucciones LOAD, STORE, MOV, ADD, OUT', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 'C¿¡—ΩΩΩ≈Ω79,Û8xqmæΩΩf√ΩΩ»Ω“Ω-/2"ÔÎ0*∆Ω¿ƒO∂ƒO∂5¡Ω•¿•¿í(@˝…;|NÑ ë6‰jˇ¶]`Ô√0⁄kòÆ~sîﬁ,¯Í)º;Ü¶¥¯ÓT9Ø‚Aäï…[êîµ+æ?V‹:OòŸ≥œœÁ°-¿Ãö•ê+eì≠uÈ⁄5lèï>!≤£}FCí®◊æïâz•^I/ZToég€æ˘øæô¥~ ùŸ"B	‘$÷ﬁ™;[aÎáˇäÂwaô∞æ£â§teÁúHWw˝pÆiíDgH~ziaãL›Ë∞ß~É ˘Ã‚äÕ‚F–≠˙ÏqÂŒ)|ÿ&Õá3wªDï≤¶ï°8¬.∫>Ç´í≈·+=lÕ‹‹‹QÃúﬂµ∏ßÌó√ıÍK˙cv>ˆµ-ír‘{mîDŸ¢`æñjk÷+»«-vú≤#^çÇÅUPä·‘-≥•uAÆ]éó*«~Ì¬êÀ.êV∂ÌúMÓôEî;ı uìEÖ…k"«òéSóÍz˜Ë=‰ñAñÌ“˚÷	Í´≠µÕÏßB›˝œﬂá˜ºpΩé›=Î)«ûÏ¬)Ú**ôŒdÕzÅ˝5èAµuAÜ!j@‘ê˚À,d|zi1Æê/AÓ∏ææø‘¿—ΩΩΩ≈Ω79,Û8xqmæΩΩf√ΩΩ»Ω ΩΩΩΩΩæΩΩΩ]>ΩΩΩΩ-/2"ÔÎ0*¬Ω¿ƒO∂5ΩΩ¬√ΩΩΩΩæΩæΩΩΩΩ´æΩΩΩΩ', 'ID¸˝˘˘˘˘˘D[h/Í?yû˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸∑\Ú>∂\Ú>Nq˝˘·¸·¸&,0)*))+,ID˙˚¸˘˘˘˘˘D[h/Í?yû˘˘˘˘˘˘˘˘˘˘˘˘˙˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸∑\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘D˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(9, './tp 16 5 9999 -9999 prueba3.asm', 'Prueba de Comparaciones / Varios / Instrucciones CMP, NOP, CNT, otros', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '3.ÊÁ˜„„„Î„î_RE\&§Œ‰„„NÍ„„Ó„¯„SUXHEDDVP87Ï„ÊQu‹(Qu‹(8[Á„ÀÊÀÊ∏7.næÛ°Œ:ØTÓôºTÑg˜ô<6ÌXˇ∑¿†^3O¯ß5ºhﬂﬁq˜ ∏	 ≥Ò;πK€I°\+G/© 2®™^´+3O˙Â˝Ï6∂ëh¯ò=[Ó≤•∆ÇòŒOBÚiLrC9ƒÄ )CNˇ]∆€ç≈å~9Q‡B¿^Íü*dè¬∑-MÔZÿ3√±»rA=∏åû~˜jñƒÁ|/!Càõ? >ƒ
HQ∞Ω∏¸€òóEË5Ê˙]L√7,ﬂ›mÅ≠ÖÁ}Dº˙~1ÈêOp8≈‚ãõŒ:ÄKÔ˜Qp¸…È$aå∞Dñv‡⁄Ó(”,£ƒd$ﬂ§Á£ÄÀKÊ1eãNºÊE∫‚á]’%≠Õ¸[˝pŸÀ˜¥ãtír¯ülQ»Ó`ÿ	’àùb” œ˚$Ï§⁄ÏÒÈX’gƒ–‘G°n˝ 9<ÿA`¿ƒîKg*B+®7˝üÁ!Ï ‚˙u´ö/ÊÚw•nE)røÑô.}4-Ú[PN¨Ö_R¨≥≈:±dro∆ÖL«$Sj§¢9Oo<UÛ˛ÄC’ iÈØ©ñW)f=ŸE¿<3ôÍ®j+5“HbeªTá„E¢d’ñÉ◊“É◊ÎWå,äñâ^‹VK”|q¯ñj˛?hB3.‰Â˙Ê˜„„„Î„î_RE\&§Œ‰„„NÍ„„Ó„„„„„„‰„„„Éd„„„„SUXHEDDVP87Ë„ÊQu‹(8[„„3.ËÈ„„„„‰„‰„)„„„Â„„„„', '@;ÛÙ¯<R_&Èb¸=ˇ˙OOcdT_edOOED˘Û∞SÈ5∞SÈ5EhÙÿÛÿÛ#–"“"‘"–¬%t@;ÒÚÛ¯<R_&Èb¸=ˇ˙˝ÒîqOOcdT_edOOEDıÛ∞SÈ5Eh@;ıˆÒÒ5<', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(10, './tp 32000 100 100 -100 prueba4.asm', 'Prueba de Saltos / Instrucciones JMP, JZ, JNZ, JP, JN, JMP, NOP, otros', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 'ò∏≥kl|hhhphd‰◊ûï/ü—jhhzthhsh}hÿ⁄›Õ …úñ…€’Ωºqhkc˙a≠c˙a≠Ω‡lhPkPk=ΩCÚCòxÂ?ø¥Gﬁ)¬/ôâÌ’{≤k!HU^	wB¨≈lÒÔ^S£˙ó1™<,¯®ì¯®À9°õöÅ˙âî;/1c„x,’Z‚˙æXàüëHï‰2ÚöGæBÃËQ‘Å(\ì6!≈TŒÜº>ajªN®øÃ‡ﬂ9…€˚!D2g-€~Óâ8‚FAMÔFtã∆§B}:∑=72]æ$rßëU]∫3ÚÖ9£Øª›…mm45Ûë‹—H2ºñüö∞Õ^‘HM?+M£"µŒË£∂˚åŸíVÊ˝2°B1Ï4(<Ée√MUg	™C¸⁄’»∫$àm”€Ìàâ∂Ú˚A-Òısydc\¯AJsîÄºùÏ‘ôÄiV÷ºd~v.x\f=)É£êu*N”≤yÇ*YÇ≤1JY•Ê6®ê≤XôÎ`(¿@ˇx%¥>>ì˛^iÍ{ÍóG¡i“ÏPr√%5π^.sP{⁄ßÜ√2–À‹¸ÖO)äJ¨u“©·(CxÑ´ÿóähäxï®à®‡iúåLkÚ˘ÆiÓ©W~zeµ·¸H˜1äı`Ú¿mw)0j¨ı9ﬂ$©JÖ]*ãp[´
Ú∏ºÂ"ô¿ì1,≈≥˘ví}KË-5≠ „˘@Û∞ƒØYF‡
¿@ùìÆ£ã@Bz’’EÖçD© ï;-¨ª√œãä«ÔÄú.{zö«cÉ˘›÷ﬁÓE∆_}OœN˝‡ZÚ$xÜﬁ5Ûª™é[Y¡OÉp[LMÁÔ†Wˇ"áX^◊?ÑÂ!Ñä„7=.{l[f}f9Áh∏≥ijk|hhhphd‰◊ûï/ü—jhhzthhshuhhhhhihhhÈhhhhÿ⁄›Õ …úñ…€’Ωºmhkc˙a≠Ω‡hh∏≥mnhhhhihihÆhhhjhhhh', 'ID¸˝˘˘˘˘˘F[h/e©˝˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸ª\Ú>ª\Ú>Nq˝˘·¸·¸)*+,-.ID˙˚¸˘˘˘˘˘F[h/e©˝˘˘˘˘˘˘˘˘˘˘˘˘˙˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸ª\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘B˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(11, './tp 8192 12 20000 -1 prueba5.asm', '', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '˙VQ	
4Ñu<ﬂ/´N¸Fvx{khg;4gys[Z	>õˇK>õˇK[~
Ó	Ó	”\aU·6Ñ˝µ>i5≥.c¢:_¶z©€*∫dö«$Fn¯ 2ò~Qÿ:˜Â}ÇOoß1z∫ÿî⁄¨DD£qI‡™©Ó≤˝˜Ç®ˇöÖmˆèmBm¬´vÕ›ÌöQé?™BõøfnP‡Å!{=—_–—baÔƒ⁄›GáCóˆı·˛ca&%Ø
Í(B1Ω£é<°LÕN≠˘Gã0Ë]®VÔVü%Î¯ç2J/mª«9é^|+ÁhUÒæd(Z≈›≠ﬂ ~Y‰‚õ¬^.•A∂õñŸ™j∑äd˜	ìÎ4wˆI	5rÁŸ∂&”è“qVb—¬
óÀ@Ê∫Û’I„k|ª¡{∫ì%Vè≈∂Lù~®¨LŸ‹¯Q¨"ÏÛ”ƒû⁄ÚÙ°î„ØÒyö˜««^TQ>Bä#¿©$`Õπ>oa©¢ùŸB9±Åƒ›Iu˜Æ˘˙Óàá4ËAbπ≤ÃÃidfçB}Ë˘ë¥5†«®ñˆ1|hIï0€ú√≤+ﬁ+|¡Ø Àè–J#úÃÂ7Vt…üÔ(∞æ√bêx‚%GÍ;4®—Y_çH“P¶®¬ —+-Ìè9„Jjõ9q◊¯Z3êRíÀ2äå©;¢aá‰(eTçWUK6∏Ø~Z«õÈ◊PΩ–-•çMcé`Oãµãù[9V«Ï"Çuò=0dŒ–µò∞ˇ≥|r0*-âyK√›∏‡Â¢â⁄◊…ß¿?|[HÔâó#YqiYxà◊yö+MU]˜"πH≈d˜B]R{˘Ù’7KˆZjÃ89<˛}(zï’Tqcl—∂`ÃÒ›kﬂhˇ–Òà+(lñœBkè˚†ÿplØÔM{O‹Í”ÿG˝]˙∆~SÔâ∏ê¶¬_ô/|–∑»?+4@¶¨E∏ï[‡òä´2l*òÀıê˘π1:¬»-°qê»‡fµæî£W⁄s˛áW∞ùG9¢fÎbÄíKsÚe:D§«»‰Ó¿µ
∞∆¬3¬VQ	4Ñu<ﬂ/´N¸F¶ávx{khg;4gys[Z	>õˇK[~VQL:	', 'ID¸˝˘˘˘˘˘H[h/hxÈ(˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸æ\Ú>æ\Ú>Nq˝˘·¸·¸)*/,1-./ID˙˚¸˘˘˘˘˘H[h/hxÈ(˘˘˘˘˘˘˘˘˘˘˘˘˙˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸æ\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘A˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(12, './tp 32000 12 20000 -20000 prueba6.asm', '', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '¨§üWXhTTT\T®”√ä<BÙnYTTkTT_TiTƒ∆…π∂µäÇµ«¡©®]TW≥ÎMô≤ÎMô©ÃXT<W<W)¨Ø£7öh“Kl˝É?∏ëá ÷]tïïı∆ÂÀ=óeÆçEî[yäIYÅLCëªÇ‚Áa(≈g˝q«∆√êª:06‡e‚¬"¢‚•≥Fû‡∑F≠¯v„˚8{öJùâr£YMÊ9y<å˜2ö[¢n;E†ËÕ™¿’á#G\πXCr==/ﬁhz1LÿØ¨ïxR¸òÇª¶¯9™†h%“ìV_=≈ÃÃÿ:ﬁ◊Äƒ£úv4¨∏£≠uímvy•í∏8™Ø3´èÙåtDÒÑ`âqª—àNL˘hﬁ¬z∫≠Ç7S€EﬂæÆùö"ﬁ{¨ÕÊ¡µf^k^Îc´TkLwm	[´‹ér“Ùzô©ﬁhÈ}æß®˚¸£eîedhãvlvlvlvlvlvlvlvåvå©≤◊s‹4‹4‹4‹4‹4‹4‹De5wõÿ™‘\seív–òL‹DeeÃ>GROŸÒRH’h÷ê|{v©û6ê„≥$yV„¯)†Ù°Ë∏ÕVrÍ‹∂v¶Ã~YMD]4K≠óﬁ3ufÁ;ÃÆ]∆\î+úxº“[›ãÜ„[D˜ÕRL%)‹≤„@V%≥ƒeHØ˜œ[qˇiÖo¬2¯k´ñ≈µæ¥D•ﬂtøa¨È˚˝Ï_XÍ^È
Æ®®ß≈+ˇπe[˛.ÙA˝Ï7P–≈°v3YéI∫9‚ñ*ÿÅÍ_∞0çSaÌ@≤6ıÏ6ç¨øŸ7–MŒiÒ}œ≈Å∞.P  WT¬¢‰›*ñœ*nâƒ‚££%F«~«∞+˙né;¥Ã2Ë’wÈÜŸ©-®¢Ñ—	ˆ./Ú;‚]¿ıJPÌú∏‡BëF≈I|ÜA;#Ì†îÿ…+V–&éëÿ‹ﬂ/è?GŸPßàpÆ˙dZ∞F<Ê¶ Ú$ŸÈ¨Ÿa˝êpIœÿBÜÂ‚izxdµ(sïÒ‚4 ƒúx0µü !C™c:3˝3]®’l"&•ß»´˜Óåˆ2c∫¨Z„n~ìdÉ¸˘ﬁæ EŒÓ{—”1∫∞∑¬wâñPDŸäòNµÅØ,J®§Ü,¥ò±©4˝¥»¥÷ÂŒº!ô”‰é;Î!;•mÚK¶8Ω_„ó∆Øœ÷7mZ´!h#X>2˚¿Ì&Â”rà(µ¡Í›Õ¡u*\+õ.ñ„Dt/«M"ˆ∂Æ,à\L∫œ◊X:M—◊lû∑d∞ÿπ‹DDë Ñî[Àµ∞Ècâ»“é⁄Drîµ÷i¢3⁄ø#ƒa@v’øhe.´ºÊH$´oºı1…Ãw82ÂK8≠8ùî©
.?Ñ5œæ+€Ç7©Æc8¶Z™Õ‡YS¯3⁄£≠˛¢Q0»‰›∏NÄô≤ñÈçŸÓgfÃÍ?:@ëñ¬ZGÅ±,’Î Ôﬂ∞íÚ¡?t√q¿©rÄÃN˘’ÒÇ§ ˘“ó,	í‘*=F>Œ•,)ıWœ/`…ßíùÔ©&ÍÒ¬£Ô’äÿÒ!dÊKA¢^4¶%J≠yﬁÜ√(µÇüÜ¸Ò˛h`‘ëlP¸ØÜHﬁÃÜeYå∆o
ˆ=ˆ2?æ(∫ôÌ@C£˛x[[ﬂã–´ìñˇãâ¡k–Ç?ªM_–€∂EÔ—Îy0⁄¡	™·ßÔoaj?*¥≈/µE∫:qèÄ1∂≈Î€	øﬂ°∏≈†ˆÓª7¬W}W;>:›ÓÖÚ0ŸW(⁄øvÏ A	Ω
Ãó,âﬁDëQ\/Œ*‚W}A⁄bxu˚ã—NëÇ3«”O™⁄‡¬5£˛U§üUVkWhTTT\T®”√ä<BÙnYTTkTT_TaTTTTTUTTTÙ’TTTTƒ∆…π∂µäÇµ«¡©®YTW≥ÎMô©ÃTT§üYZTTTTUTUTöTTT¨YTTTT', '83ÎÏ¸ËËËË8JWyØs6ËËËzËËËÚË˝ËGG[\LW]\GG=<ÒËÎØK·-ØK·-=`ÏË–Î–Îıµüı®(¯¨®ÑΩƒÇ_ÂÈto™lö¿˜ı˙ÚBPãkb`òòYXŸ™dŸ+,fåLy5ˆ°ÃπâäéÁô\π5˜•‹ôŒWn˜83ÈÍˇÎ¸ËËËË8JWyØs6ËËËzËËËÚËıËËËËËÈËËËåiËËËËGG[\LW]\GG=<ÌËÎØK·-=`ËË83ÌÓËËËËÈËÈË-ËËËsËËËËË', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(13, './tp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID¸˝˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘XXlm]hnmXXNM˘¸√\Ú>√\Ú>Nq˝˘·¸·¸ID˙˚¸˘˘˘˘˘J[h/˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘˘ùz˘˘˘˘XXlm]hnmXXNM˛˘¸√\Ú>Nq˘˘ID˛ˇ˘˘˘˘˙˘˙˘>˘˘˘6˘˘˘˘˘', '(t.', 1, 'CasoDePrueba');

INSERT INTO "comando_fuente" VALUES(1, 1, 1);

INSERT INTO "comando_prueba" VALUES(2, 2, 1);
INSERT INTO "comando_prueba" VALUES(3, 2, 2);

INSERT INTO "curso" VALUES(1, 2005, 1, 1, 'Martes');
INSERT INTO "curso" VALUES(2, 2005, 1, 2, 'Jueves');
INSERT INTO "curso" VALUES(3, 2005, 2, 1, 'Jueves');
INSERT INTO "curso" VALUES(4, 2006, 1, 2, 'Martes');
INSERT INTO "curso" VALUES(5, 2006, 1, 3, 'Jueves');
INSERT INTO "curso" VALUES(6, 2006, 2, 2, 'Martes');
INSERT INTO "curso" VALUES(7, 2006, 2, 3, 'Miercoles');
INSERT INTO "curso" VALUES(8, 2007, 1, 1, 'Martes');

INSERT INTO "docente" VALUES(20, 1);
INSERT INTO "docente" VALUES(21, 1);
INSERT INTO "docente" VALUES(22, 1);
INSERT INTO "docente" VALUES(23, 1);
INSERT INTO "docente" VALUES(24, 0);
INSERT INTO "docente" VALUES(25, 0);
INSERT INTO "docente" VALUES(26, 0);
INSERT INTO "docente" VALUES(27, 0);
INSERT INTO "docente" VALUES(28, 0);
INSERT INTO "docente" VALUES(29, 0);
INSERT INTO "docente" VALUES(30, 1);
INSERT INTO "docente" VALUES(32, 0);
INSERT INTO "docente" VALUES(33, 0);
INSERT INTO "docente" VALUES(34, 0);
INSERT INTO "docente" VALUES(35, 1);
INSERT INTO "docente" VALUES(36, 0);

INSERT INTO "docente_inscripto" VALUES(1, 8, 20, 1, NULL);
INSERT INTO "docente_inscripto" VALUES(2, 8, 21, 1, NULL);
INSERT INTO "docente_inscripto" VALUES(3, 8, 22, 1, NULL);
INSERT INTO "docente_inscripto" VALUES(4, 1, 30, 0, '');
INSERT INTO "docente_inscripto" VALUES(5, 8, 32, 1, NULL);
INSERT INTO "docente_inscripto" VALUES(6, 8, 35, 1, NULL);
INSERT INTO "docente_inscripto" VALUES(7, 8, 36, 1, NULL);

INSERT INTO "entregador" VALUES(1, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(2, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(3, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(4, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(5, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(6, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(7, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(8, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(9, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(10, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(11, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(12, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(13, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(14, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(15, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(16, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(17, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(18, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(19, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(20, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(21, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(22, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(23, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(24, NULL, NULL, '', 1, 'Grupo');

INSERT INTO "enunciado" VALUES(1, 'Simulador de un microcontrolador', 2007, 1, '', 23, '2007-03-14 16:17:11', NULL);

INSERT INTO "enunciado_tarea" VALUES(1, 1);
INSERT INTO "enunciado_tarea" VALUES(1, 2);

INSERT INTO "grupo" VALUES(20, 8, '1', NULL);
INSERT INTO "grupo" VALUES(21, 8, '2', 4);
INSERT INTO "grupo" VALUES(22, 8, '3', 8);
INSERT INTO "grupo" VALUES(23, 8, '4', 11);
INSERT INTO "grupo" VALUES(24, 8, '5', 14);

INSERT INTO "miembro" VALUES(13, 24, 14, NULL, '2007-03-14 16:06:06', NULL);
INSERT INTO "miembro" VALUES(14, 24, 15, NULL, '2007-03-14 16:06:06', NULL);
INSERT INTO "miembro" VALUES(15, 24, 16, NULL, '2007-03-14 16:06:06', NULL);
INSERT INTO "miembro" VALUES(16, 24, 17, NULL, '2007-03-14 16:06:06', NULL);
INSERT INTO "miembro" VALUES(17, 20, 1, NULL, '2007-03-15 12:19:35', NULL);
INSERT INTO "miembro" VALUES(18, 20, 2, NULL, '2007-03-15 12:19:35', NULL);
INSERT INTO "miembro" VALUES(19, 20, 3, NULL, '2007-03-15 12:19:35', NULL);
INSERT INTO "miembro" VALUES(20, 22, 8, NULL, '2007-03-15 12:20:02', NULL);
INSERT INTO "miembro" VALUES(21, 22, 9, NULL, '2007-03-15 12:20:02', NULL);
INSERT INTO "miembro" VALUES(22, 22, 10, NULL, '2007-03-15 12:20:02', NULL);
INSERT INTO "miembro" VALUES(23, 21, 4, NULL, '2007-03-15 12:20:40', NULL);
INSERT INTO "miembro" VALUES(24, 21, 5, NULL, '2007-03-15 12:20:40', NULL);
INSERT INTO "miembro" VALUES(25, 21, 6, NULL, '2007-03-15 12:20:40', NULL);
INSERT INTO "miembro" VALUES(26, 23, 11, NULL, '2007-03-15 12:20:53', NULL);
INSERT INTO "miembro" VALUES(27, 23, 12, NULL, '2007-03-15 12:20:53', NULL);
INSERT INTO "miembro" VALUES(28, 23, 13, NULL, '2007-03-15 12:20:53', NULL);

INSERT INTO "rol" VALUES(1, 'admin', NULL, '2007-03-14 15:18:27', '(ccopy_reg
_reconstructor
p1
(csercom.model
Permiso
p2
c__builtin__
object
p3
NtRp4
(dp5
S''descripcion''
p6
VPermite entregar trabajos pr·cticos
p7
sS''nombre''
p8
Ventregar
p9
sS''valor''
p10
I1
sbg1
(g2
g3
NtRp11
(dp12
g6
VPermite hacer ABMs arbitrarios
p13
sg8
Vadmin
p14
sg10
I2
sbtp15
.');
INSERT INTO "rol" VALUES(2, 'alumno', NULL, '2007-03-14 15:18:27', '(ccopy_reg
_reconstructor
p1
(csercom.model
Permiso
p2
c__builtin__
object
p3
NtRp4
(dp5
S''descripcion''
p6
VPermite entregar trabajos pr·cticos
p7
sS''nombre''
p8
Ventregar
p9
sS''valor''
p10
I1
sbtp11
.');

INSERT INTO "rol_usuario" VALUES(1, 22);

INSERT INTO "tarea" VALUES(1, 'Compilar C++', 'Compila C++ usando un Makefile gen√©rico que compila todo en un ejecutable llamado tp', 'TareaFuente');
INSERT INTO "tarea" VALUES(2, 'Ejecutar + valgrind', 'Ejecuta primero de forma normal y luego con valgrind. Si no pasa la prueba, rechaza, si no pasa el valgrind, no.', 'TareaPrueba');

INSERT INTO "tarea_fuente" VALUES(1);

INSERT INTO "tarea_prueba" VALUES(2);

INSERT INTO "usuario" VALUES(1, '76335','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'JORGE EDUARDO PITARO', 'jep77ar@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(2, '78548','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'MARTIN FERRARI', 'martinferra@yahoo.com.ar', '4322-9652', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(3, '78760','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'FERNANDO CLAUDIO MARTIKIAN', 'fernando_martikian@crgl-thirdparty.com', '48211291', '2007-03-13 00:54:15', '', 1, 'Alumno');
INSERT INTO "usuario" VALUES(4, '79389','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'SEBASTIAN VERRONE', 'sebafi10@yahoo.com.ar', '4941-2939', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(5, '80843','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'MARTIN OSVALDO GORGAZZI', 'martingorgazzi@fibertel.com.ar', '44331593', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(6, '81533','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'GUSTAVO JAVIER NARCISI', 'tavojavi@speedy.com.ar', '4298-1265', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(7, '81713','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'OSCAR ALEJANDRO VICTORIANO', 'voavictoriano@hotmail.com', '42984069', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(8, '81875','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'JHONNY ROGER FUENTES MANCILLA', 'jnysaa@yahoo.com.ar', '4572-7933', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(9, '82598','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'MAXIMILIANO CROCE', 'crocemaxi@hotmail.com', '1556361402', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(10, '82634','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'FERNANDO CESAR NARDINI', 'nfrasec@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(11, '82899','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'PAULA SOLEDAD FERREYRA', 'paula_s_f@yahoo.com.ar', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(12, '82903','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'LEONARDO GORBLIUK', 'lgorbliuk@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(13, '83481','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'EZEQUIEL FERNANDO SINGER', 'ezesinger@fibertel.com.ar', '48033260', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(14, '83488','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'MARIANO EZEQUIEL KFURI', 'marianokfuri@yahoo.com.ar', '4632-7735', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(15, '83604','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'PABLO EZEQUIEL BRAGAN', 'pbragan@gmail.com', '4572-9073', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(16, '83605','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'RODRIGO SEBASTIAN MARCOS', 'rodrigomarcos4@yahoo.com.ar', '4566-6971', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(17, '83607','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'LUCIANO HAMMOE', 'lhammoe@fibertel.com.ar', '4501-2834', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(18, '83775','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'ALEJANDRO PABLO CAVALLERO', 'ale_algo@yahoo.com.ar', ' alepc253@yahoo.com', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(19, '80256','a05bd890c4868ea1807f8564055d1fba77c6ba81', 'VERONICA ANABELLA CENTANNI', 'vecentanni@yahoo.com.ar', '46537983', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(20, 'gonza', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Gonzalo Merayo', 'merayo@gmail.com', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(21, 'nico', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Nicolas Marquessi O''Neill', 'nmarquessi@fibertel.com.ar', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(22, 'luca', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Leandro Lucarella', 'llucax+7542@gmail.com', '4554-1554', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(23, 'chris', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Christian Calonico', 'ccaloni@fi.uba.ar', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(24, 'beto', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Alberto Ortega', 'aortega@fi.uba.ar', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(25, 'eze', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Ezequiel M. Gonzalez Busquin', 'ezequielinfo@yahoo.com.ar', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(26, 'santi', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Santiago Etchebehere', 'vasco_sti@yahoo.com.ar', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(27, 'marianito', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Mariano Chouza', 'mchouza@gmail.com', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(28, 'vero', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Veronica Parla', 'vparla@gmail.com', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(29, 'mariano', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Mariano Perez', 'mariano@todofrancia.com', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(30, 'andres', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Andres Veiga', 'aveiga@advtechnology.com.ar', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(32, 'daro', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Dario Griffo', 'dgriffo@fi.uba.ar', '', '2007-03-13 00:54:15', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(33, 'sony', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Juan Manuel Lopez Baio', 'jbaio@fi.uba.ar', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(34, 'pablo', 'a05bd890c4868ea1807f8564055d1fba77c6ba81', 'Pablo Riboldi', 'riboldipabloit@yahoo.it', '', '2007-03-13 00:54:15', '', 0, 'Docente');
INSERT INTO "usuario" VALUES(35, 'mazzi', NULL, 'Lautaro Mazzitelli', 'lmazzitelli@gmail.com', '', '2007-03-14 15:34:04', '', 1, 'Docente');
INSERT INTO "usuario" VALUES(36, 'lele', NULL, 'Leandro Fern√°ndez', 'drkbugs@gmail.com', '', '2007-03-14 15:39:35', '', 1, 'Docente');

COMMIT;
