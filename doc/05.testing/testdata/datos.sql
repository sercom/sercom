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

INSERT INTO "caso_de_prueba" VALUES(4, 1, 'Demasiados parámetros');
INSERT INTO "caso_de_prueba" VALUES(5, 1, 'Falta un parámetro');
INSERT INTO "caso_de_prueba" VALUES(6, 1, 'No existe archivo');
INSERT INTO "caso_de_prueba" VALUES(7, 1, 'Prueba de Registros / Matematica');
INSERT INTO "caso_de_prueba" VALUES(8, 1, 'Prueba de Memoria');
INSERT INTO "caso_de_prueba" VALUES(9, 1, 'Prueba de Comparaciones / Varios');
INSERT INTO "caso_de_prueba" VALUES(10, 1, 'Prueba de Saltos');
INSERT INTO "caso_de_prueba" VALUES(11, 1, 'Chequeo de memoria');
INSERT INTO "caso_de_prueba" VALUES(12, 1, 'Bubble Sort');
INSERT INTO "caso_de_prueba" VALUES(13, 1, 'Sin parámetros');

INSERT INTO "comando" VALUES(1, 'make -f Makefile', 'Compila C++ usando un Makefile genérico que compila todo en un ejecutable llamado tp', 0, NULL, 64, NULL, 200, 1000, NULL, 1, 1, 1, 't�׏����������C�[����^�����������������������X�����t�t��g�g	�K����=��Sի6g^ .�VԪU�a2%����,�^#���,ۅ
Z��1��O#~*�wạ�\rw@GL��������k��Z��/��d���Ѫ���ߙյ>�L����t���z=%��e��Dذ�鐸�m���뽜g��.Z�XD�Ǩ�ׂ��길���D�aK%�\J����e`�D�Þ��5��`������~��町�?\�#:�3�ݖH�.="��Oq���)�u�;
w؊�+K�*EPYV@ !�����C��������M�[,��Jt���Uմp�!���b��k�k�M�sK�1L�4�E���z��@=�5ر�Ĳ��O��UA!�^�ܓ�;Mw�wms�ߵ֨��Q��2����K���oQ���T�k|�A���H�_*X XP����%�+��v��7�s*��r�=c"94Y�o��+VD��~6�DBX����*;��Z}sJ���{u�D����H<п�l�Y����.l�?��+��ޯ�d�׹�-=��a6it�=��x�W`J���A�4�g�]&�K��(<�2lH�PTr+F�9KS�l�i��i�"��I��qLǩv8mf�\��V�h�Gaj�J��9��D.8J�+{)�g\Z�B_��^A��Z�f��5�%�J��D�3��X(I΅#K�R�2��Ěʂ�4�h3�2#9�q8<qN�|n�I�Nci���gz�4�w������j��x�|}ӄWŶ"�P˞5-
tp1
.', 1, 'ComandoFuente');
INSERT INTO "comando" VALUES(2, '', 'Corre el caso de prueba sin filtros', -257, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, NULL, '(t.', 1, 'ComandoPrueba');
INSERT INTO "comando" VALUES(3, 'valgrind --trace-children=yes --track-fds=yes --num-callers=20 --leak-check=full --show-reachable=yes --leak-resolution=high -v', 'Chequea memoria con valgrind', -257, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, NULL, '(V__stderr__
tp1
.', 1, 'ComandoPrueba');
INSERT INTO "comando" VALUES(4, './tp 8 2 100 -3 prueba1.asm de mas', 'Debe fallar porque tiene parámetros de más', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID�������J[h/��������������XXlm]hnmXXNM���\�>�\�>Nq������ID��������J[h/�����������������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���6�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(5, './tp 8 2 100 -3', 'Falta parámetro de archivo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID�������J[h/��������������XXlm]hnmXXNM���\�>�\�>Nq������ID��������J[h/�����������������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���6�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(6, './tp 8 2 100 -3 no_existo.asm', 'Se pide procesar un archivo que no existe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID�������J[h/��������������XXlm]hnmXXNM���\�>�\�>Nq������ID��������J[h/�����������������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���6�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(7, './tp 16 9 50 -50 prueba1.asm', 'Prueba de Registros / Matematica / Instrucciones MOV, ADD, SUB, OUT', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '�[V{�zA=���k {}�pml<9l~x`_�P�P`����_Xv�;��b�Ì��~U8n��0f�$FØb����ԁ��F2�$-�2�T3�!�
�G�ͩ4l��0^�q+�,��&�Zi;��1Z>�������0r���<��Cd�8��l7{Q��G֥B)�k 8�ӳCT��iEY�+V����"�7��΂�?P�Ud|BMM���
ۧ�	���x��gM]��g�<�9%j�K�[$f�>XZ���g@Fu�k��̲M�%(��Z�@��l���w5�x�BR�Hfv��O���\�h�%�I��m�Ʈ�۾�
�n��|GOx���.�{3T�쳯Y���NA]�*�	Pp۶��{z[�ؒ�m즗T��8;fs�㽝��>�[V
INSERT INTO "comando" VALUES(8, './tp 8 2 100 -3 prueba2.asm', 'Prueba de Memoria / Instrucciones LOAD, STORE, MOV, ADD, OUT', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 'C
INSERT INTO "comando" VALUES(9, './tp 16 5 9999 -9999 prueba3.asm', 'Prueba de Comparaciones / Varios / Instrucciones CMP, NOP, CNT, otros', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '3.��������_RE\&�����N�������SUXHEDDVP87���Qu�(Qu�(8[������7.n���:�T��T�g��<6�X����^3O��5
HQ�������E�5��]L�7,��m����}D��~1��Op8�⋛�:�K��Qp���$a��D�v���(�,��d$������K�1e�N��E���]�%���[�p�����t�r��lQ���`�	Ո�b����$�����X�g���G�n��9<�A`�ĔKg*B+�7���!����u��/��w�nE)r���.}4-�[PN��_R���:�dro��L�$Sj��9Oo�<U���C� i鯩�W)f=�E�<3��j+5�Hbe�T��E�dՖ��҃��W�,���^�VK�|q��j�?hB3.����������_RE\&�����N���������������d����SUXHEDDVP87���Qu�(8[��3.����������)��������', '@;�������<R_&�b�=����������OOcdT_edOOED���S�5�S�5Eh������#�"�"�"��%t�@;��������<R_&�b�=�������������������q����OOcdT_edOOED���S�5Eh��@;����������5���<�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(10, './tp 32000 100 100 -100 prueba4.asm', 'Prueba de Saltos / Instrucciones JMP, JZ, JNZ, JP, JN, JMP, NOP, otros', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '���kl|hhhphd�מ�/��jhhzthhsh}h�����ɜ���ս�qhkc�a�c�a���lhPkPk=�C�C�x�?��G�)�/����{�k!HU^	
��"���1,ų�v�}K�-5����@�į
�@�����@Bz��E��D� �;-���ϋ��.{z��c������E�_}O�N��Z�$x��5󻪎[Y�O�p[LM��W�"�X^�?��!���7=.{l[f}f9�h��ijk|hhhphd�מ�/��jhhzthhshuhhhhhihhh�hhhh�����ɜ���ս�mhkc�a���hh��mnhhhhihih�hhhjhhhh', 'ID�������F[h/e����������XXlm]hnmXXNM���\�>�\�>Nq������)*+,-.ID��������F[h/e�������������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���B�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(11, './tp 8192 12 20000 -1 prueba5.asm', '', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '�VQ	
4�u<�/�N�Fvx{khg;4gys[Z	>��K>��K[~
�	�	�\aU�6���>i5�.c�:_�z��*�d��$Fn� 2�~Q�:��}�Oo�1z�ؔڬDD�qI����������m��mBm«v���Q�?�B��fnP��!{=�_��ba����G�C�����ca&%�
�(B1���<�L�N��G�0�]�V�V�%���2J/m��9�^|+�hU�d(Z��
��@���I�k|��{��%V�ŶL�~���L���Q�"���Ğ�������y����^TQ>B�#��$`͹>oa����B9����Iu����4�Ab����idf�B}����5�Ǩ��1|hI�0ۜò+�+|�� ˏ�J#���7Vtɟ�(���b�x�%G�;4��Y_�H�P��� �+-��9�Jj�9q��Z3�R��2���;�a��(eT�WUK6��~ZǛ��P��-��Mc�`O���
���3�VQ	4�u<�/�N�F��vx{khg;4gys[Z	>��K[~VQL:	', 'ID�������H[h/hx�(��������XXlm]hnmXXNM���\�>�\�>Nq������)*/,1-./ID��������H[h/hx�(�����������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���A�����', '(t.', 1, 'CasoDePrueba');
INSERT INTO "comando" VALUES(12, './tp 32000 12 20000 -20000 prueba6.asm', '', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '���WXhTTT\T��Ê<B�nYTTkTT_TiT��ɹ���������]TW��M���M���XT<W<W)���7�h�Kl��?�����]t������=�e��E�[y�IY�LC�����a(�g�q��Ð�:06��e
�����+��e[�.�A��7P�šv3Y�I�9�*؁�_�0�Sa�
.?�5Ͼ+ۂ7��c8�Z���YS�3ڣ���Q0��ݸN�������gf��?:@���
�=�2?�(���@C��x[[��Ы������kЂ?�M_�۶E���y0��	
̗,��D�Q\/�
INSERT INTO "comando" VALUES(13, './tp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'ID�������J[h/��������������XXlm]hnmXXNM���\�>�\�>Nq������ID��������J[h/�����������������������z����XXlm]hnmXXNM����\�>Nq��ID����������>���6�����', '(t.', 1, 'CasoDePrueba');

INSERT INTO "comando_ejecutado" VALUES(2, NULL, 'ComandoFuenteEjecutado');
INSERT INTO "comando_ejecutado" VALUES(3, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(4, '83���������qXO�oم����������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� ! ! ! ! !������� �!��������� �!��������� �!��������� �!��������� �!���83���������qX8���a���a�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&!$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&!$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qXO�oم������������������������GG[\LW]\GGLQNN83�����������qX8���a���a��������������������GG[\LW]\GGP\UT83����������b���X�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(5, '83���������qX\:������������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� ! ! ! ! !83���������qX+aO����������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX\:��������������������������GG[\LW]\GGLQNN83�����������qX+aO������������������������GG[\LW]\GGP\UT83����������b��� ����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(6, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(7, '83���������qX8��E���E�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� � ��83���������qX�},�����������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG
&N$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG
&N$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
& $\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
& $\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX8��E���E���������������������GG[\LW]\GGLQNN83�����������qX�},���������������������r���GG[\LW]\GGP\UT83����������b���P�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(8, '83���������qXUJ�i7���7�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� 83���������qX��>Y�����������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qXUJ�i7���7���������������������GG[\LW]\GGLQNN83�����������qX��>Y���������������������d���GG[\LW]\GGP\UT83����������b���*�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(9, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(10, '83���������qXx/]Q,���,�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83���������qX��b������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qXx/]Q,���,���������������������GG[\LW]\GGLQNN83�����������qX��b����������������������Y���GG[\LW]\GGP\UT83����������b���k�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(11, '
INSERT INTO "comando_ejecutado" VALUES(12, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(13, '
INSERT INTO "comando_ejecutado" VALUES(14, '
INSERT INTO "comando_ejecutado" VALUES(15, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(16, '
INSERT INTO "comando_ejecutado" VALUES(17, '
INSERT INTO "comando_ejecutado" VALUES(18, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(19, '
INSERT INTO "comando_ejecutado" VALUES(20, '83���������qX��
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX��
INSERT INTO "comando_ejecutado" VALUES(21, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(22, '83���������qX.�M���M�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((������83���������qX�TZ���Z�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX.�M���M���������������������GG[\LW]\GGLQNN83�����������qX�TZ���Z�����������������z���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(23, 'Z�񩪺������/ܦi�������������
�
����
�		ư����
�
ư�������������������������������񩪺������/ܪ�����������
������������������������������������������������Ȱ�����������������

�䰰�䰰�
�������������Ȱ����������	�����	���������������������������������	�����������
�!�����
�
�#����������

�!	
�	�����#���������
�

�!�
�!	
�	��	�	�	�#����������


�!	
�	��#����������
	
�	����#����������
�!	
�	��#����������
䰰�
����ư������	��
��
��
	


�����	��
�����������	�����	��

��
�		�����	��
�����������	�����	��

��
�
��������
����������
����������������
�	��
��
��
	
	
��
�	��

��
����������
��
�������	��
���������
��
�	��
�������
	
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
��������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
��������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
����������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
���������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
���������
��
�	��
����
��
�	��

����
��
�������
��������������
��������������	��
�����
���������������	�������
��������������������
����
����������������������������������������������������������������������
�	��


�����


����
�����������������������������
�	��
	
��
������������������������������
�	��
���
��
����������������������������
���������������
����
�����������������������������������	����������������������������������������
����	
������������������������������
����	
������������������������������
�����
����������������������������
��������������
䰰����񧨺��������/ܦi���������������������������
�
�񧨺��������/ܪ���������������������%���
��񫬦������� ���������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(24, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(25, 'Z�񩪺������/�Jْ�����������
�
����
�		ư����
�
ư����������������������������������ְ��ְ��ְ��ְ���ְ�񩪺������/�R�~"����������
������������������������������������������������Ȱ�����������������

�䰰�䰰�
�������������Ȱ����������	�����	���������������������������������	�����������
�!�����
�
�#����������

�!	
�	�����#���������
�

�!�
�!	
�	��	�	�	�#����������


�!	
�	��#����������
	
�	����#����������
�!	
�	��#����������
䰰�
����ư������	��
��
��
	


�����	��
�����������	�����	��

��
�		�����	��
�����������	�����	��

��
�
��������
����������
����������������
�	��
��
��
	
��
�	��

��
����������
��
���������
��
�	��
����
��
�	��

��
����������
��
���������
�������������������
�	��
����
��
�	��

��
����������
��
���������
��
�	��
����
��
�	��

��
����������
��
���������
�������������������
�	��
����
��
�	��

��
����������
��
����������
��
�	��
����
��
�	��

��
����������
��
����������
�������������������
�	��
�������
	
��
�	��

��
����������
��
�������	��
���������
��
�	��
�������
	
��
�	��

����
��
�������
��������������
��������������	��
�����
���������������	�������
��������������������
����
����������������������������������������������������������������������
�	��


�����


����
�����������������������������
�	��
	
��
������������������������������
�	��
���
��
����������������������������
���������������
����
�����������������������������������	����������������������������������������
����	
������������������������������
����	
������������������������������
�����
����������������������������
��������������
䰰����񧨺��������/�Jْ�������������������������
�
�񧨺��������/�R�~"��������������������<���
��񫬦������� ���ݲ����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(26, '83���������qX��s�<���<�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83���������qXtB�V���V�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX��s�<���<���������������������GG[\LW]\GGLQNN83�����������qXtB�V���V�����������������i���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(27, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(28, '83���������qX�q�J���J�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�������83���������qX���T���T�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX�q�J���J���������������������GG[\LW]\GGLQNN83�����������qX���T���T�����������������w���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(29, '83���������qX�u�8���8�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83���������qX����6���6�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qX�u�8���8���������������������GG[\LW]\GGLQNN83�����������qX����6���6�����������������e���GG[\LW]\GGP\UT83����������b���������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(30, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(31, '
INSERT INTO "comando_ejecutado" VALUES(32, '83���������qXx/]Q,���,�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83���������qX�7s������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\W!GG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\W!GG
&$IPZMN%
LQNNTQJGKPOG\W!GG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWU!G
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\W!GG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83�����������qXx/]Q,���,���������������������GG[\LW]\GGLQNN83�����������qX�7s����������������������Y���GG[\LW]\GGP\UT83����������b���p�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(34, NULL, 'ComandoFuenteEjecutado');
INSERT INTO "comando_ejecutado" VALUES(36, NULL, 'ComandoFuenteEjecutado');
INSERT INTO "comando_ejecutado" VALUES(38, NULL, 'ComandoFuenteEjecutado');
INSERT INTO "comando_ejecutado" VALUES(39, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(40, '83��������qXO�oم����������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� ! ! ! ! !������� �!��������� �!��������� �!��������� �!��������� �!���83��������qX¿�l���l�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&!$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&!$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qXO�oم������������������������GG[\LW]\GGLQNN83����������qX¿�l���l��������������������GG[\LW]\GGP\UT83����������b���c�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(41, '83��������qX\:������������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� ! ! ! ! !83��������qX݄�&��&������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&!$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX\:��������������������������GG[\LW]\GGLQNN83����������qX݄�&��&��������������������GG[\LW]\GGP\UT83����������b���W ����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(42, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(43, '83��������qX8��E���E�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� � ��83��������qXҐ������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG
&N$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG
&N$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
& $\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
& $\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX8��E���E���������������������GG[\LW]\GGLQNN83����������qXҐ����������������������r���GG[\LW]\GGP\UT83����������b���]�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(44, '83��������qXUJ�i7���7�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((� 83��������qX�������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
& $[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qXUJ�i7���7���������������������GG[\LW]\GGLQNN83����������qX�����������������������d���GG[\LW]\GGP\UT83����������b���2�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(45, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(46, '83��������qXx/]Q,���,�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83��������qX����������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qXx/]Q,���,���������������������GG[\LW]\GGLQNN83����������qX��������������������������Y���GG[\LW]\GGP\UT83����������b���p�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(47, '
INSERT INTO "comando_ejecutado" VALUES(48, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(49, '
INSERT INTO "comando_ejecutado" VALUES(50, '
INSERT INTO "comando_ejecutado" VALUES(51, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(52, '83��������qXx/]Q,���,�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83��������qX���������������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\W GG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\W GG
&$IPZMN%
LQNNTQJGKPOG\W GG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWU G
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\W GG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qXx/]Q,���,���������������������GG[\LW]\GGLQNN83����������qX�������������������������Y���GG[\LW]\GGP\UT83����������b���p�����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(53, '
INSERT INTO "comando_ejecutado" VALUES(54, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(55, '
INSERT INTO "comando_ejecutado" VALUES(56, '83��������qX��
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG 
& $\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG!
&!$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX��
INSERT INTO "comando_ejecutado" VALUES(57, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(58, '83��������qX.�M���M�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((������83��������qX�&�~Z���Z�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX.�M���M���������������������GG[\LW]\GGLQNN83����������qX�&�~Z���Z�����������������z���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(59, 'Z�񩪺�����q/ܦi�������������
�
����
�		ư����
�
ư�������������������������������񩪺�����q/��"������������
������������������������������������������������Ȱ�����������������

�䰰�䰰�
�������������Ȱ����������	�����	���������������������������������	�����������
�!�����
�
�#����������

�!	
�	�����#���������
�

�!�
�!	
�	��	�	�	�#����������


�!	
�	��#����������
	
�	����#����������
�!	
�	��#����������
䰰�
����ư������	��
��
��
	


�����	��
�����������	�����	��

��
�		�����	��
�����������	�����	��

��
�
��������
����������
����������������
�	��
��
��
	
	
��
�	��

��
����������
��
�������	��
���������
��
�	��
�������
	
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
��������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
��������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
����������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
���������
��
�	��
����
��
�	��

����
��
�������
�������������������
�	��
����
��
�	��

��
����������
��
�������	��
���������
��
�	��
����
��
�	��

����
��
�������
��������������
��������������	��
�����
���������������	�������
��������������������
����
����������������������������������������������������������������������
�	��


�����


����
�����������������������������
�	��
	
��
������������������������������
�	��
���
��
����������������������������
���������������
����
�����������������������������������	����������������������������������������
����	
������������������������������
����	
������������������������������
�����
����������������������������
��������������
䰰����񧨺�������q/ܦi���������������������������
�
�񧨺�������q/��"����������������������%���
��񫬦������� ���������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(60, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(61, 'Z�񩪺�����q/�Jْ�����������
�
����
�		ư����
�
ư����������������������������������ְ��ְ��ְ��ְ���ְ�񩪺�����q/���E����������
������������������������������������������������Ȱ�����������������

�䰰�䰰�
�������������Ȱ����������	�����	���������������������������������	�����������
�!�����
�
�#����������

�!	
�	�����#���������
�

�!�
�!	
�	��	�	�	�#����������


�!	
�	��#����������
	
�	����#����������
�!	
�	��#����������
䰰�
����ư������	��
��
��
	


�����	��
�����������	�����	��

��
�		�����	��
�����������	�����	��

��
�
��������
����������
����������������
�	��
��
��
	
��
�	��

��
����������
��
���������
��
�	��
����
��
�	��

��
����������
��
���������
�������������������
�	��
����
��
�	��

��
����������
��
���������
��
�	��
����
��
�	��

��
����������
��
���������
�������������������
�	��
����
��
�	��

��
����������
��
����������
��
�	��
����
��
�	��

��
����������
��
����������
�������������������
�	��
�������
	
��
�	��

��
����������
��
�������	��
���������
��
�	��
�������
	
��
�	��

����
��
�������
��������������
��������������	��
�����
���������������	�������
��������������������
����
����������������������������������������������������������������������
�	��


�����


����
�����������������������������
�	��
	
��
������������������������������
�	��
���
��
����������������������������
���������������
����
�����������������������������������	����������������������������������������
����	
������������������������������
����	
������������������������������
�����
����������������������������
��������������
䰰����񧨺�������q/�Jْ�������������������������
�
�񧨺�������q/���E��������������������<���
��񫬦������� ���ݲ����', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(62, '83��������qX��s�<���<�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83��������qX�<�V���V�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX��s�<���<���������������������GG[\LW]\GGLQNN83����������qX�<�V���V�����������������i���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(63, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(64, '83��������qX�q�J���J�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�������83��������qXE
��T���T�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
\WG
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX�q�J���J���������������������GG[\LW]\GGLQNN83����������qXE
��T���T�����������������w���GG[\LW]\GGP\UT83����������b��������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(65, '83��������qX�u�8���8�������GG[\LW]\GGLQNNGG[\LW]\GGKWZZMK\W�GG[\LW]\GGMV\ZMOILW�((((�83��������qX_��N6���6�������GG[\LW]\GGP\UT�$	,7+<A8-P\UT8=*41+
?+,<,@0<54<ZIV[Q\QWVIT-6
�
P\\X"____WZO<:`P\UT,<,`P\UT\ZIV[Q\QWVITL\L
&��$P\UT&��$PMIL&�$UM\IP\\XMY]Q^%
+WV\MV\<aXM
�KWV\MV\%
\M`\P\UT#KPIZ[M\%1;7  !
&�$\Q\TM&$\Q\TM&�$[\aTM\aXM%
\M`\K[[
&�\IJTMLQNNcNWV\NIUQTa"+W]ZQMZ#JWZLMZ"UMLQ]U#e�LQNNGPMILMZcJIKSOZW]VLKWTWZ"MMMe�\LLQNNGPMILMZc\M`\ITQOV"ZQOP\e�LQNNGVM`\cJIKSOZW]VLKWTWZ"KKKe�LQNNGILLcJIKSOZW]VLKWTWZ"IINNIIe�LQNNGKPOcJIKSOZW]VLKWTWZ"NNNNe�LQNNG[]JcJIKSOZW]VLKWTWZ"NNIIIIe�$[\aTM&�$PMIL&��$JWLa&��$\IJTMKTI[[%
LQNN
QL%
LQNNTQJGKPOG\WGG\WX
�KMTT[XIKQVO%

KMTTXILLQVO%

Z]TM[%
OZW]X[
&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&$KWTOZW]X&�$\PMIL&$\Z&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGKWZZMK\W$\P&$\PKTI[[%
LQNNGVM`\
&$JZ&$\P&$\PKWT[XIV%

KTI[[%
LQNNGPMILMZ
&GG[\LW]\GGMV\ZMOILW$\P&$\Z&$\PMIL&�$\JWLa&�$\Z&$\LKTI[[%
LQNNGVM`\
QL%
LQNNTQJGKPOG\WGG
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$IPZMN%
LQNNTQJGKPOG\WGG\WX
&\$I&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
QL%
NZWUG
&$\L&$\LVW_ZIX%
VW_ZIX
&$[XIVKTI[[%
LQNNG[]J
&VJ[X#$[XIV&$\L&$\LKTI[[%
LQNNGVM`\
&$\L&$\LKTI[[%
LQNNGPMILMZ
&$\L&$\LVW_ZIX%
VW_ZIX
&$\L&$\Z&�$\JWLa&�$\IJTM&�$\IJTMKTI[[%
LQNN
[]UUIZa%
4MOMVL[
&�$\Z&$\PKWT[XIV%

&4MOMVL[$\P&$\Z&�$\Z&$\L&$\IJTMJWZLMZ%

[]UUIZa%
+WTWZ[
&�$\Z&$\P&+WTWZ[$\P&$\Z&�$\Z&$\LKTI[[%
LQNNGILL
&VJ[X#)LLMLVJ[X#$\L&$\Z&�$\Z&$\LKTI[[%
LQNNGKPO
&+PIVOML$\L&$\Z&�$\Z&$\LKTI[[%
LQNNG[]J
&,MTM\ML$\L&$\Z&�$\IJTM&$\L&�$\L&$\IJTMJWZLMZ%

[]UUIZa%
4QVS[
&�$\Z&$\PKWT[XIV%

&4QVS[$\P&$\Z&�$\Z&$\L&NQZ[\KPIVOM$\L&$\Z&�$\Z&$\L&VM`\KPIVOM$\L&$\Z&�$\Z&$\L&\WX$\L&$\Z&�$\IJTM&$\L&$\Z&�$\IJTM&�$JWLa&��$P\UT&83����������qX�u�8���8���������������������GG[\LW]\GGLQNN83����������qX_��N6���6�����������������e���GG[\LW]\GGP\UT83����������b���������', 'ComandoPruebaEjecutado');
INSERT INTO "comando_ejecutado" VALUES(66, NULL, 'Prueba');
INSERT INTO "comando_ejecutado" VALUES(67, '
INSERT INTO "comando_ejecutado" VALUES(68, '

INSERT INTO "comando_fuente" VALUES(1, 1, 1);

INSERT INTO "comando_fuente_ejecutado" VALUES(2, 1, 1);
INSERT INTO "comando_fuente_ejecutado" VALUES(34, 1, 33);
INSERT INTO "comando_fuente_ejecutado" VALUES(36, 1, 35);
INSERT INTO "comando_fuente_ejecutado" VALUES(38, 1, 37);

INSERT INTO "comando_prueba" VALUES(2, 2, 1);
INSERT INTO "comando_prueba" VALUES(3, 2, 2);

INSERT INTO "comando_prueba_ejecutado" VALUES(4, 2, 3);
INSERT INTO "comando_prueba_ejecutado" VALUES(5, 3, 3);
INSERT INTO "comando_prueba_ejecutado" VALUES(7, 2, 6);
INSERT INTO "comando_prueba_ejecutado" VALUES(8, 3, 6);
INSERT INTO "comando_prueba_ejecutado" VALUES(10, 2, 9);
INSERT INTO "comando_prueba_ejecutado" VALUES(11, 3, 9);
INSERT INTO "comando_prueba_ejecutado" VALUES(13, 2, 12);
INSERT INTO "comando_prueba_ejecutado" VALUES(14, 3, 12);
INSERT INTO "comando_prueba_ejecutado" VALUES(16, 2, 15);
INSERT INTO "comando_prueba_ejecutado" VALUES(17, 3, 15);
INSERT INTO "comando_prueba_ejecutado" VALUES(19, 2, 18);
INSERT INTO "comando_prueba_ejecutado" VALUES(20, 3, 18);
INSERT INTO "comando_prueba_ejecutado" VALUES(22, 2, 21);
INSERT INTO "comando_prueba_ejecutado" VALUES(23, 3, 21);
INSERT INTO "comando_prueba_ejecutado" VALUES(25, 2, 24);
INSERT INTO "comando_prueba_ejecutado" VALUES(26, 3, 24);
INSERT INTO "comando_prueba_ejecutado" VALUES(28, 2, 27);
INSERT INTO "comando_prueba_ejecutado" VALUES(29, 3, 27);
INSERT INTO "comando_prueba_ejecutado" VALUES(31, 2, 30);
INSERT INTO "comando_prueba_ejecutado" VALUES(32, 3, 30);
INSERT INTO "comando_prueba_ejecutado" VALUES(40, 2, 39);
INSERT INTO "comando_prueba_ejecutado" VALUES(41, 3, 39);
INSERT INTO "comando_prueba_ejecutado" VALUES(43, 2, 42);
INSERT INTO "comando_prueba_ejecutado" VALUES(44, 3, 42);
INSERT INTO "comando_prueba_ejecutado" VALUES(46, 2, 45);
INSERT INTO "comando_prueba_ejecutado" VALUES(47, 3, 45);
INSERT INTO "comando_prueba_ejecutado" VALUES(49, 2, 48);
INSERT INTO "comando_prueba_ejecutado" VALUES(50, 3, 48);
INSERT INTO "comando_prueba_ejecutado" VALUES(52, 2, 51);
INSERT INTO "comando_prueba_ejecutado" VALUES(53, 3, 51);
INSERT INTO "comando_prueba_ejecutado" VALUES(55, 2, 54);
INSERT INTO "comando_prueba_ejecutado" VALUES(56, 3, 54);
INSERT INTO "comando_prueba_ejecutado" VALUES(58, 2, 57);
INSERT INTO "comando_prueba_ejecutado" VALUES(59, 3, 57);
INSERT INTO "comando_prueba_ejecutado" VALUES(61, 2, 60);
INSERT INTO "comando_prueba_ejecutado" VALUES(62, 3, 60);
INSERT INTO "comando_prueba_ejecutado" VALUES(64, 2, 63);
INSERT INTO "comando_prueba_ejecutado" VALUES(65, 3, 63);
INSERT INTO "comando_prueba_ejecutado" VALUES(67, 2, 66);
INSERT INTO "comando_prueba_ejecutado" VALUES(68, 3, 66);


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

INSERT INTO "ejecucion" VALUES(1, '2007-03-16 17:07:37', '2007-03-16 17:08:17', 1, '', '�yt,-=)))1)a��]*�|��*)),))2)>)�rjmmW���~}2),EumEum~�-),,�|zx�Y9����2���OM+XMQ�m��8�}�B��#i����I�O�� ��&��e̒Z��˼$!�f̼u��y�n�*D�.�L���Yy���fQ���B���n��~��)��9
)�%�nG�^StJ�<i�,�4��@@瀧Hkͷ-$���mK�l�z�?y>wV��,�t�y*��Fh�֭
8yt,-=)))1)a��]9�b+))�0))2)>)�rlvyW���~}2),EumEum~�-),,��t��Y9��������>m̈́��
k��^�GHW^������{S�.��ە���m��M��d�9��D�/��|�������Z�@">�H�XIZiڈ�a4�\z�-.��i1V2D����VB����{&�
�X�"Տ��\�r۸���&�P����D(4yt,-=)))1)b��]��dմ*))�,))2)>)�rsw�W���~}2),GumGum~�-),,�|vx+Z9f�r(���NT���
)P5�Z����S�Uv�,��&+������ ��w���|�
Lw��Jˬ�P�ۘY����˯%�u����	ڊ�7�aĺ�-^��5���7T��[w?)l�������Oh!�>������GbW�ܷ�)w��cvyw��Ic����^u��w��	o�&)� Kۧy�0j���-��Pe�t.����q��h������!�$/yt,-=)))1)b��]5�~��*))�,))1)>)�rsyW���~}2),GumGum~�-),,�|�x�Y=����>�ΆO�G`	*�YQ�m��8�}�B��#i�D��O����� ��ׂk�t�x?��瘄�n?�}KL��.�9-d�e�:�i�g��̖����uM���E���������L�f��<����[J�lc��4�1���ǖ���U��|��qII�QJ%��׼�����	1�G���X�x8���F�$Ă�{z|�#8j��j��]c���}Q7@oC��3Hz�.u�A�{�q��Z���믾P���>���L���������;���F������c�����Q��g��!/H����HE0�9���帶�������c���z�8�OQ�ۿ1v���Gߋ���h�G�c�>�����X�58��kbh�M�e�c�n��"���#/yt,-=)))1)b��]���*)),))1)>)�rs�W���~}2),GumGum~�-),,�|�x�Y=����>�ΆO�G`
*�YQ�mG]g�{ʏ�t,��䘫<ĝ�v�� ܄�2��^�g�g8ߦ�V[x�;BJ�PW��Iy^R�9/�ޖ�4�;}�K���y��u�v]�"Yk����e���u1��7Y��S+��V�a�t2��un+*�o2
����wW�
0�s�.�WOH���T���=����o���sn#�ˇ���X����zg�Fr$�o��p ����<1~�#�s+�/Cm�t�����/��C^���g��01�-�T�G�h�b�X��iV���zT��ZTfA9���?)�cA��˪Շ$`(��c��qbl
rE��G��(YWlE&.yt,-=)))1)c��]��.��*)),))2)>)�rvxW���~}2),IumIum~�-),,�|���YA���(�N�9Ŭp�g������І��ߕ8�&��k�2ʈ���bf^���	a�<"[�f�$ϊC��1�\�Rt��P��J��{CJ4Y|��`6�@P[2M
��0�{�6]l�o�������y��7Z�D��`�v��p�{`y�(l�M��S"/c�J�n!��:9�-LQ����,�y���qVx�-n�Z���ca�	W��_Eq���&
�R!�G��v����y�jl耀��d�`(��%&8Q�p)�b@�	�7��\
_X������_�>(�ѝC���a�zz{�.�����Q��\5Aa� [����Q�S�z���~fux�s��Q�=����7��42�����@��������O�����
x]��}W
�e0�(yi�3$�9�2Ө=P�3�ܷ�Zt�Rxx���1�!kdغ3���YmT��
�mxϒ5������N�4�`+���Y����1H�s3t}GD|9�.Z�>���ݵ�J7�q�9{vb�=���(���ߝ��]��Q{�����6�]H"� Hyt,-=)))1)c��]	B�u*))�,))@)>)�r����������v������W���~}2),IumIum~�-),,��v��Y9���dez2N9��t����k.��o	��h�=�t +^O�m�K�C��\���oq�>����a@s�y�݉����ҹ?F�Z���s�y�#A�<O�����M摴���@���{E�O������\�5o���s���o�ϜR����s!U�G���$��ϾR����
6�]�������b��Q�*(N�^#�pS=�BD�x;XJ�>�0�:5ʺ.w[�QୈD�bB.�Q�xؑrМ"N�}�`m�_��-h�
��]0�w�,��"�E��Ï�p���QG��hS������Fhf��6��>#�*�"ct���p�,����^�w��`������K�{j9f��תU���C鰸�C��
�g,�1|Tw&i�t�*YB�ً����NX�D�X���b8����������S���N��!5���e�I�����J0�@��"����N��8�qo	&$�`Oi+^���Ы�79?"�t���63�^1�_��&f5��]���6U�Z�.\�?UY����*r�G"P����
�	L�P������ �o�%���9��2�n��G^}ݕu�����T��[��w�.�L�5 �muQ0h`�3�^m���/gj<����,Uq�4��_�[��]H:�թ1�5�M��9�q�QL`�=�nGaV��=(����%A�1΂������:�KE��g
�ѣ��筁�ٙ)z	P�ROzzԁ�q/�3�YvV����d?w���(��ܽ�A�9�B����Q�͢�
�,"���7z�:��jÑ�4�2
��
k�g�r	7/��m%������kRn�t�����k]BF{14��N�1�	њ���1㮌U97�E��;��)�k�X]�I.�jGǑ��J��;jPm)�z����]
k4S��[#�)>�O̵RLA�ZmAM\<�����]�X�.V�[���Oߓ��3�#�pP@Pb���")�J�i3���T-�B�pO2N���x�)BeNu�`��q�S iV�//v����iB��\5��F���ZI�]�zb
jrG�U�js��J���|>[G0.�M�k��3
=���ҹ�9Ͻt���Q�**o
��ӹ�I�^�I���h��򘥼�E�`&�΄%7���ח�|���6c恁���x.�����]a�6�~\jo+�L5AA�ٍ�&�D������t����f!0ȣh �Y��Ԇ]G��B�o����~ .Z�\&�x;N�IJF�D�Gqb�vX�?ˌ�
�}bQխJ@	���t��kҁ���g+�Ij&&�c�/��)���{�14�����4U��*8���2��]���q幤�
c����y���&cǞb%w�J��u�x;Y;�/�F�%)�i9�+U����n�^ԯC*�b{b�����E@J�%��aG7������v��W�3c,��iԎ\�F��9����"���a�� O៟}� �Cd���]>��d��ǋ��#
�����iH
]T�Z�5%S�P}׃��vH��r4�m@ّ�V�|�9��<s�t�a�k�P����)HX�w1���Fc	�İ����>j��P��[@���F�s�1���&�u���QAɺ�ZrJT���Yy�����&M�
��)i-:Q<�\���x�I�ż؎��
>g|(י$���3.�b85J\�6�+j�t&��Q�3��T�M�j�]���k���u�3����I��K�;�����@qy^��~;�[	!�T�1��A�X���7�IO��WU�k���4jNݙ�;\Q	w=�fm���2A��< 
	I#����]FҡAϨ17�؂��#a�]�2&�A�Bۘ��T��7Ylʪ5�Hb�aI��9�`c����TR����ch�jG;wa�E�!���9Z^�U&��w��|.#�}���]Z���9qG��}|n�탴��������O�(�)�P��!9E�/E����Ƀ}�B��/p\Y�#��Ȝ˶�<�k�;���`����V�T�4���H�k�2�-��x�|��:��L�!�Y�����s�s��dF3��@Y �j�!���i������m��`������q0��ODU&��쒤�.yt,-=)))1)a��]*�v�+))�.))0)>)�rjmmW�~}2),EumEum~�-),,�}xY9�w�%8P�y~��9��vl�,�����AN����r�x�x��>8ɂ���H�gdH0��,�"��Ƹnݷ�7��Ps�Φ�p"	偅���入�U_Zds�ϳN�����#�p����Z�"��f^�3l)�iY�O?�^�2���LV���$���_�����&EsK~Fj�;�5QD���~���Ó?
�MY�twL�P�W��}*@x��;v�3+��FD-���S�d�SAK���{ji�Ɉ�3S��@���Ax���>���������k�Exݺ�Ǎ�g�_p�����ܗ��}�۞X�}��y�ى֯D��hW���ۅ�����vI����@Y7T�+]Aٽ��^��̹
��2��
��`�/��1o���%s-�N�2���#�C����c���f��P���k<,���!0yt,-=)))1)b��]���yr+))F.))0)>)�rlw}W�~}2),GumGum~�-),,�}wDZ9��HoI�9���/�lzXq=9���G�������x 0���vznVN�����ģeav8��� ��E�<���
��E��9H?�
��B�E��͎�j+����oSF��<�z�~%��Ng9��
=aK8�]�vV}O��T���ѮUd�;�F%10�^f�R�h�4��
�����X&���#ݐD<���(1l^��.�Kc���6�#0H��d�;���9���G�	��O%,yt,-=)))1)b��]6TO�),))�0))0)>)�rsvyW�~}2),GumGum~�-),,�~vxDZ9f��%�:qQ�Kg�u9��Ϋ;*fp�9�_���S~��|�M�4�ٳ=������ �$?�8爇�$e]?5����4���""��%��!�?��[=1Я�yV�c��#����f��v�SjtA�i>���*��#fJH��i������{��?!�b�z�u�lֵԬS�n�)���6`����B�y�2E;W�\bCj����d�+�*�>+[�S�s2ӟO8^2o[c��D��&K�[��5dj�#J/�l�����o8��g6�Fk�J���1=x=}
���AG�?3�9_̽����xK�@��ž�-4��	�V����$@{����C�V@x���1�aw�9n;��.��ω�D�Z�<ZWZnx2Gp)�U�n���`�Up����B�V�F���u�D��+���Ãx�^|�C�^�y�Q�D����~�����UEv!*��ゔx6�/0��H촼%����&���%ߐ�m��^�d)��uO�/7ө�d�4��Zq��ɢ����
$�T�ohZ�a�wXSH��R�!0yt,-=)))1)b��]|��߂+))l.))/)>)�rswW�~}2),GumGum~�-),,�}vxi9fd�(�1M=��=�*�)�S>.-b�ذّ���s~$�$0c\7�R���a�������5^g�������@yx�fDZ��Ž����"�"�����B��^����o]�f�>�֞=W�f��ON��0?�
�_��䦁i��oJ
J�|�z��A�<�M]����\
�MYCtwL�зW���}*@X��ñ>-+�_1���~������VԔr.*b����:}�IX3�Y�+"?�*�����
J�<�z��A��q�W�UH��U���	Մ�W�ɕf2���=�5?Ց�?����Ex��6Ʀ�U�Rr��Rf�
NB�6z*�5���
^��̹
i�1����(G҄�g�܋��v���(̉���/�jF��͇_��	���R���@xFpK�ՙ�Lh���gfe������Q��
&�&.yt,-=)))1)c��]�5�0|+))].))1)>)�ruxjmW�~}2),IumIum~�-),,�}�Y9���(��krl�g��ٞDT�������ҳ�M�5�x �x�F��0�I�� �ͥۘ�r "�~g@�csC���
��?T�;�}�aG�y�U��&w�<q&My7��#ƳB5e�
Ҳ�@X60����m�������3����]�{S�g~�0�Ъ8�,���0�:?����3Vc��f�?G`�I֭bed��X���J�P�����%9�(QAÛ��hE��兵�"�Z��h.|q��"I��d�ms�
���X��W(}_��ϐS棛P����8yt,-=)))1)c��]���b+))
�_�eW�t��4�d��a��-�8+��S�1]�~+�0-r�T]ZlE��t{�^��>f��5k�ly�LR�V6�C��C�9z5��kiL�1DB�~��?,B�7�P:�"�R�
�\��EP��:@�
ҭC��l����nxɡ��ʉ{����V��	�m�
��P��x��B$�?l��{_��nUԄ:J&-0]f�-J�>����
�<φF#t��,������O#*��(QA�U��K�]:f �^w�8*&b�2�%�ɼk��?_q�4�9�(+yt,-=)))1)c��]�4�d�+))Y.))0)>)�rx~}W�~}2),IumIum~�-),,�}t�DZ9g؊(�i�D�݀d
sܽJU	�F���4̾�Y��� ��^<%K��#������h?���@��⋾�j�A��	��|��
\�A����
�&�)�ı�/Jc/�/f���ë�M+W� ���^?�I��GBÓ�\�*�xy��S11��qT����56�<��9��M�/t-��"�{j�te�}�����ɳ������l�O��s�EHtL�b�ۥM�Jp����4���{��9��q�D�=�~�}l^�H���t��zې�¢`.��\L�Ǭz�3y��5�^ֲ@�Zr�k�t(��G�!��E�	�r�uCT̯sR:��Bf�]��j�Kzʁ&R�裟�~�j��v7Ge�BՑ}p,�y��>�p.�;��k����uw�xS P��+������s��8h/&jbv���:G�`���֭R�c�X�s���綕�������Zn��a�L��6l O�٦)��\�����_���35𘭧�f��2�+&�Ǉ�v��m��yt,-=)))1)d��]����~+))�.))0)>)�r|~kW�~}2),KumKum~�-),,�}v�Y5f�(,�+n;���{���3����i��}�L���5A�h�wL��l�2qu��˽���4��$$Uf����d�,T�?��΂�V����giR���i�_
!��e�(�RTx�E��!�d�
{��
V}K\�%r�G�U\�M���7�)�����V��Ԙ	�d P]������e����4^�22��u�,Wө����oF �)Zb|eB���N��14�L��1hA������6�8S��R8yt,-=)))1)c��]9Lڐ&*))d-))7)>)�r����������W�~}2),IumIum~�-),,�|�DZ9��&�J��C�
o�87��#u�;�3���H�����
��?��h���s�� I@��mR^���%��n@D����S��WPpB	
�f,��m�Lm4����inip�����l,L�MD]=J�����k,���U�Q5�-���+�܎�˚���p
]N��6+�R�T�k����nL/Y7f��:��z�4���2�A2�$9H	L��P�w�S���/_�]R;��/��@u�=6Nm�Z_Ҩu��Wj�jM�g}��w{���!��awo�x��w��!T�t����
�7l�?GF�c��nw�XQ�Z���h]�]p�n���]8�(K���w>���5X	���%\�47�h�`���7<f�a&�
�U�ʒA���i�]\K�rU�_0t���C��0�䤠���dr�0���؅�:�X�MFo�w����W��Q}`�vt��/�M�z/D{s��L�T"%�I:�Z`��J�-P�H)�8���l�4�h
y9�[�f:�5y4�g����z��ͤB��������$&2�6��P��܁9��|W�aj:�߱Kd�Cue�f��`�9׿���Fe�Ps�>�
{D���Q�U;uך����l���zSG��te��I�s�A��??v�M�C��w�	lÖ<���,Id��}r�����<B��)��m�}�t�U��yp�èt���^Qy��M1T��żFP�蚎�Q�ֽ2	T��m�8�,��}�3f��j�N�������6�����_��,�BSL���|ĚT�O�{$y�4���怷���B5�^��SgXA����>%Q��gZA6(�_�z�L@yt,-=)))1)d��]Y���*))+-))>)>)�u����r������������W�~}2),KumKum~�-),,�|v��i9fP�(YmQ�l��I�{j���SN�`��ٕ�_��x$0cD<�]�G�&���_d��;�f�0���k�����N�m�+haM��g�fx�����c�V@��!J��1@{E��O1�+���S
�\����ѭBa�ί;�;T}�,�Ɏ��ɶ	�I>��2#�m���o�Н{z���䝮��E�c��wAη��+���}N��:����%��T����wuؽi,�[xŪ�?lO�Tbe��^��$�n�^�pݹQ�إ��PYTq��{���ïu�n�J���z�T#��U��\��NHZ16�s�7x��;��S����DͥOM�d��
�����	���1��2����.��T�e��>�94������?m�*��������}e4v!A�����)�5f�H�j�ro�/ߺoJ�5���!����	�ӓe|ß��I�/⩂+;YWw���5�&�l&��֚!��&�w�Zh#��P̢ 1�O6���H<���H&�BD������`*6��V|���]rS��x�i8�5�7�춮am��QF-X�({=������2��1XB����5��#��&@�7&FS��3U��F�\�Ns�<NeL.��:��3��:7ܤ2�zdw����P�z�ܵ-�[�F.��|�c�W�������Ҝ�G)�qlu�Ҫ�.�E�����k7���%*yt,-=)))1)d��]��9��,))�4))<)>)�v���������������W�~}2),KumKum~�-),,��_5�*�,,-��_��.�64�_j��A5n��6����7��gXYs�E(톏-�U�%�=�$I��A�	$�$it�ʦ,$�v���� %oa�G������� �@&Enp&z*�LrBLk�a��k?�Jt�F�4��}�兝��B�d�?�N��d��$P�N�>tT��`�-̉ �Y����B�+�
��q��<�fޝ���&Sn���9Ǜ��D;]�����^��[X8�	���;[V����KX^|�ɬi�_w�mF�v�Nk�/�����U���%eZ�7���D�Ԁ�9�B����m�>�����-Ҏ{���x�3la��pOc��o��#nMAA��ɻ}���#��̨�w
���� �$��(�OT^z�*����L_E�w�S�1��)�ό�],̀2*6xvj�ko7���ᵽ�i�P��K�����J\�|��npef[˫N]�|db��Z�d��)����d���.ɕ��mC�
�!��,y�t��i�R���$
ukL��o�yt,-=)))1)e��]a�ᩤ,))a3))4)>)�y�������W�~}2),MumMum~�-),,���Y=�G{�~S~y~� ss���m*ڟ8�O���	��w���㨉7J2���k�a�ǤќM{��3��
YE��y(���Q�S:���߼���%����^�h���*�o��M1���<R��������zq���al��j�����3n��A5���2�`�Y_�6��z���Hp�k��Ǿ
�
!Sm�B�7�̚�!We���9o�$��
��4�����j�~��	�p!�\���VJFu��8̖�#��{�*uϬgы2���3�N�AA�B�ћ/.&>>̫�i.�_t���Wx�q��ɅLɭ^�ymku��ً�?���W�oU�]�?2M:��Ψ���B|�/+������}�Z�
	������z��k�b�Á��Z��}i��R:���"�W=PON3�\+�.�y�	*@@�[���PX�`ù|�By�O<p>�=x#&��`�ȫ������;���
4��\�<���ɀ��M^ujo���]!�ɼaP\I��y���]6۸�ۙ/�������+��,���R>vI�D�{���.E�����m�eH��a��j\������p�R��HO�w/����m��.�E�"� ͍�:r�s�*^,��6Cvk7\c7&�?OXq��?�/q8Eo��Кe꾡q�̼��D����
F!1D���)\�g�j����n,53���O��"�� �$
:HrL�H���h6x�ۣ�y(�z�$���Gپ�d"ڰ�{�8$]��WQ���i�v@�<�b�>�J�S��o�g�|�f�t��C�����x�Z�
l:42�~״��ⱒZ��/e9�^�g����
Vz����˛x!橊hּ��<��r�L����žF���_m�{�A�N8���
����򁑒W ����N��
^e�U?���k��iغe�]L�8Uar��� �]�O8r>���Q�5l0��}+Ԗp�-W�e>A�Qx�3B��:��b�ۧ�2+De���(G!o�C��b���)TZx.�lqѩ��	U���t����\G��]�-��˲<���b����*�f�_��t�)�.ϫj�Qh��y0b#�W�(�4�A��x3�}\/I�kF��;��q��6�i� �Nk{�7��:�9��=�L�+R���q�
�fz�7#��w_�s�����D�R@^�p�M�>�џ���"��8Vz�[��=���q�ʝ(�Z�"-yt*+@,=)))1)a��]*�|��*)),))2)6)))))*)))ͪ))))�rjmmW���~}.),Eum~�))yt*+@,=)))1)a��]9�b+))�0))2)6)))))*)))ͪ�*))�rlvyW���~}.),Eum~�))yt*+@,=)))1)b��]0��*))y,))2)6)))))*)))ͪ]-))�rlw}W���~}.),Gum~�))yt*+@,=)))1)b��]�s��Y*))�+))2)6)))))*)))ͪ�.))�rnwmW���~}.),Gum~�))yt*+@,=)))1)b��]�}�,$*))".))2)6)))))*)))ͪk0))�rsvyW���~}.),Gum~�))yt*+@,=)))1)b��]��|��*)),))1)6)))))*)))ͪ�2))�rswW���~}.),Gum~�))yt*+@,=)))1)b��]��dմ*))�,))2)6)))))*)))ͪf4))�rsw�W���~}.),Gum~�))yt*+@,=)))1)b��]5�~��*))�,))1)6)))))*)))ͪ-6))�rsyW���~}.),Gum~�))yt*+@,=)))1)b��]���*)),))1)6)))))*)))ͪ�7))�rs�W���~}.),Gum~�))yt*+@,=)))1)c��]�,^-!*))�-))3)6)))))*)))ͪ�9))�ruxjmW���~}.),Ium~�))yt*+@,=)))1)c��]��.��*)),))2)6)))))*)))ͪ�;))�rvxW���~}.),Ium~�))yt*+@,=)))1)c��]Ͽ�h)))C+))2)6)))))*)))ͪ�=))�rwxyW���~}.),Ium~�))yt*+@,=)))1)c��]���B�*))V,))2)6)))))*)))ͪ�>))�rx~}W���~}.),Ium~�))yt*+@,=)))1)d��]���*)){-))4)6)))))*)))ͪl@))�r|}x{nW���~}.),Kum~�))yt*+@,=)))1)d��]	_|��*))&,))2)6)))))*)))ͪ[B))�r|~kW���~}.),Kum~�))yt*+@,=)))1)c��]%��>*))�,));)6)))))*)))ͪC))�r����������kxW���~}.),Ium~�))yt*+@,=)))1)c��]B8��)))�*));)6)))))*)))ͪyE))�r����������vxW���~}.),Ium~�))yt*+@,=)))1)c��]	B�u*))�,))@)6)))))*)))ͪlF))�r����������v������W���~}.),Ium~�))yt*+@,=)))1)d��]Mr�P*))`.))@)6)))))*)))ͪG))�u����r������������W���~}.),Kum~�))yt*+@,=)))1)e��]�oaP^0))<J))6)6)))))*)))ͪ/J))�y�������W���~}.),Mum~�))yt*+@,=)))1)e��])�5�z*)),))1)6)))))*)))ͪ�Q))����W���~}.),Mum~�))yt*+@,=)))1)a��]�O�,C-))�4)):)6)))))*)))ͪ0S))�k����{��������W�~}.),Eum~�))yt*+@,=)))1)a��]*�v�+))�.))0)6)))))*)))ͪ�W))�rjmmW�~}.),Eum~�))yt*+@,=)))1)b��]�]U�+))\1))0)6)))))*)))ͪY))�rlvyW�~}.),Gum~�))yt*+@,=)))1)b��]���yr+))F.))0)6)))))*)))ͪ5]))�rlw}W�~}.),Gum~�))yt*+@,=)))1)b��]��vo+))].))0)6)))))*)))ͪ�_))�rnwmW�~}.),Gum~�))yt*+@,=)))1)b��]6TO�),))�0))0)6)))))*)))ͪ8b))�rsvyW�~}.),Gum~�))yt*+@,=)))1)b��]|��߂+))l.))/)6)))))*)))ͪre))�rswW�~}.),Gum~�))yt*+@,=)))1)b��]��|�+))}.))0)6)))))*)))ͪg))�rsw�W�~}.),Gum~�))yt*+@,=)))1)b��])��_�+))m.))/)6)))))*)))ͪ�j))�rsyW�~}.),Gum~�))yt*+@,=)))1)c��]*l���+))�.))/)6)))))*)))ͪ5m))�rs�W�~}.),Ium~�))yt*+@,=)))1)c��]�5�0|+))].))1)6)))))*)))ͪ�o))�ruxjmW�~}.),Ium~�))yt*+@,=)))1)c��]���b+))
INSERT INTO "ejecucion" VALUES(2, '2007-03-16 17:07:53', '2007-03-16 17:08:13', 1, '', 'HC���������h.�yi���������WWkl\gml]jjWW_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[A9<<&g[A9<<&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[A;EH&g[A;EH&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[A;FL&g[A;FL&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[A=F<&g[A=F<&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ABEH&g[ABEH&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ABF&g[ABF&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ABFR&g[ABFR&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ABH&g[ABH&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ABR&g[ABR&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[ADG9<&g[ADG9<&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[AEGN&g[AEGN&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[AFGH&g[AFGH&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[AGML&g[AGML&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[AKLGJ=&g[AKLGJ=&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[AKM:&g[AKM:&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[Afkljm[[agf:G&g[Afkljm[[agf:G&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[Afkljm[[agfEG&g[Afkljm[[agfEG&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[Afkljm[[agfE]egjaY&g[Afkljm[[agfE]egjaY&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[DaklYAfkljm[[agf]k&g[DaklYAfkljm[[agf]k&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[Hjg_jYeY&g[Hjg_jYeY&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%geYaf&geYaf&[hh[Afkljm[[agf&`2)02oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##[A9<<&g[A;EH&g[A;FL&g[A=F<&g[ABEH&g[ABF&g[ABFR&g[ABH&g[ABR&g[ADG9<&g[AEGN&g[AFGH&g[AGML&g[AKLGJ=&g[AKM:&g[Afkljm[[agf:G&g[Afkljm[[agfEG&g[Afkljm[[agfE]egjaY&g[DaklYAfkljm[[agf]k&g[Hjg_jYeY&geYaf&g%glhHC����������h.�yi������������������y����WWkl\gml]jjWWHC����������3��������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(3, '2007-03-16 17:08:13', '2007-03-16 17:08:14', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(4, '2007-03-16 17:08:14', '2007-03-16 17:08:14', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(5, '2007-03-16 17:08:14', '2007-03-16 17:08:14', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(6, '2007-03-16 17:08:14', '2007-03-16 17:08:15', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(7, '2007-03-16 17:08:14', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(8, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(9, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(10, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(11, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(12, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(13, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(14, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(15, '2007-03-16 17:08:15', '2007-03-16 17:08:16', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(16, '2007-03-16 17:08:15', '2007-03-16 17:08:15', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(17, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(18, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(19, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(20, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(21, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(22, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(23, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(24, '2007-03-16 17:08:16', '2007-03-16 17:08:17', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(25, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(26, '2007-03-16 17:08:16', '2007-03-16 17:08:16', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(27, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(28, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(29, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(30, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(31, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(32, '2007-03-16 17:08:17', '2007-03-16 17:08:17', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(33, '2007-03-16 17:10:47', '2007-03-16 17:10:53', 0, '', '���IJZFFFNF���zp��
�]�a1���9�.�R�λ:ۦ���y��"�D�lJo�����@ޅz?��I��qKd�*X9S�Y�X�Pi���~Y����i�OQo􆻛���[�aO_�g�GQ�}Ǒ�zۮ������2��)=\/ҧ�2�$+�:)�=+��Y�ԧS�ېh
����I��C< �X"��!*(2�}s�z��-v��@>�s,��x��[���|�
� 
�	g���I��B��w�u����@��m������җ�􉐏ߤX�-��N���4#,+�o��ŽR��{��?u����4��W�A3���~ڋ��Կ�y��!@���y���"�vk��;�z�"�^ �l�1�^Z�(��Y:BI ��U?�iy��CH�eSX����~"�V���ե�<)ߜ�D�����y��J$�YY]o�3�I�����0��[WU�*/a��IJZFFFNF���z?���GFF�JFFKF[F���t���OFI�Δ��Δ���JF.I.I���vV#i7er��J��sVL�n��Z��׷t&p�)��/���
�g��0��5�������-:�G�P_ p�A�L�R��Vi��H0����W�ac@ m�*�H��b�k@�K��<��
�I6W��pV���q��<%��K�pp"�����Z����O���l�v�l�r��;%�� ��e*z� �E�4?%z�����=�JL(Y-��
�)��9 ���s�X���r���W>u��0<�����=�ey��|=_K<��-�[A�������B��3�3<�~o*f�M���MM��/u��IJZFFFNF���z<So�GFF�IFFKF[F���t���OFI�Δ��Δ���JF.I.I��vV�����n(�S�M&�T�V��$�q
Q�����d2�1���ن/�������*�j������P���+@�<��$�q����/�ww�lkl٪X{��o�YA�O�%?礼�����i�����ڿ�)�첼$�\�Q�.px&�
��<���;�����.���p�&VӚ��(���IJZFFFNF���z�EdtGFF3HFFKF[F���t���OFI�Δ��Δ���JF.I.I��vV���ΚK���{IK����0{x<H��c�u[��3�g��0��yA^�L|\չ�tL�~�銲Z
#VLWX4�b~B����u���C���u����#�����٤%>5A�99���0��4�;v�>T��IJZFFFNF���za	��jGFF�HFFSF[F�����������t���OFI�Δ��Δ���JF.I.I��w�vV�=�?Umh�Ɩ.bfIv��o�/b<���2���8!1zSJ�p;lA-9�}cu�(�8����:���c7�uK4g�(ݔ޴�
�b2�<�$}9��i%�AU����k��tR�l�c^��
��j��J�k��������{�`��°�T%y���V����T�h�&?(֋���KM���2i%�@d�xSl����p˓�^KYFg]����y*x{�B�~Hb�d�s���dp�?:1���	U*˧`H����_���[�l�"K
�țf�J��[�-�t*l�h�T�M��[��P�h`/�ێ���ΈM�AzyK�k�h���DV���y�[md�/��x0���!_��;1����d������jN��sn�$�/c�����V<�}Lk�͗��z���揝�ø]��֨@�۵���1�}��1���o`R�*��a�h�kA}��IJZFFFNF���z����9GFFUMFFNF[F������t���OFI�Δ��Δ���JF.I.I3���)vVa8e�I�[�:.˳�L{���*�騡�ru��D<�r��惺����}y��9js��y��
f�b����~Y�pT�RM�!�U�V2�2����R�֓���t�·v��z��H�,OqP8�*8�ŴO"m�1����>
��~��b�H�f<2"R�oX��u��H<r7AL�W��������,�r{��1�`��9�H;�g��<��.�H�Gu[�(8�ܷ�MW�Ј�r2�2|�,�M֐Z�G;�ɓ4�&�e��ـFrk%X�����dCeo��M��Z.���&�M�e�9�db��1�4������D�Z>����²r2�9���$�}Oe"���k-��-�LE��(�"�I�u�)������R6}�j�$�+�a����a�%�i��Ӱvªܫ�?�<���f�Xy��gҪ�$��Zv_�)x}��.-�S�;
Ñ�mU�LG0m�?R�}���|�����{3�������mQ�<
:��=���tچ,H��7�N�TC�h��,(:�Ē����S��*e�պ,�/E�B��7�U6:�������L�e��#�yJ���B}��IJZFFFNF���z�2�c�GFF�JFFLF[F����t���OFI�Δ��Δ���JF.I.I���qwVå.�^r��ts<�qȠ�����|�0|o�u��?.��"�;/�˲l-
��md�������V{�`����>u,��#�{OV���.(h���uG�hv�MH����y����x)R�3�T����i/oV7S���Gl��X��K��}wS^�hI��aR"_�2��ׇ��䱽��K��\����%{���u�R!��lE�Vi+?��Epw����ML}R%O@Yoj�B�5,����Ԍ����N~ڋ��Ipn�5WD��[9O�	a����,�|�~�ncWS!hdq-O�~��!
S1L��Q�4+�(�e�C0ӱ �J�R� ��3т���TC���RU@�zفCj����.�Ր=DQ��IJZFFFNF���z���M�GFFJFFOF[F�������t���OFI�Δ��Δ���JF.I.I�ؗ�vV
W���	��1�0���+�%�0p����o6?��+�<$e~�Y>��k�=l!��]
��p��*��L|���6(/:�}�]S�_~i���Mȍ�I-�;"OU˿hU K	��Ǉ������0A^$����%���x��3��{1�Μ;m�j��NS�4���b4�^�������n�6Bc`��}�߾�	K�����a�P[39R��� E�qo�V qn��eZ+���͏8�D7����TmV�An�>Y�*঑NY�l���t�\���c5n{���gD���Mc2Z�/��ƿ߄/���IJZFFFNF���zyw��GFF�JFFKF[F���t���OFI�Δ��Δ���JF.I.I���(vV�(�������Z�皰/����qxF���b͑�C3��9�3��;g7?�)}�x�:1��/�}mn^K���Kd��$#=�vl��2�eh��]NU����Qk��M1�l����;���o�����9�̖�����(��5?�����PT�{�ź��&�ZF�ќL�h9�E k�ǂ�U��X<?��]�Q(�z��aB���/z�Q0�20���������%Ni�SV8]l��b����pŊ�Z��Ҿ���Tj�t��/� 
�(��hM�y�!����h;�.��Z6М��	$#3��cPc����.���Q#��L��6h�%�2Q4� ���i�����D�>EM��u�~��X���O~���k���z9�k��HI�+�
_+Cͯ6�4����
P@2^�L�%���X�&���qY���^{^?3��L�l���p�"S�� &���v��k�t7��C�qg�u��>4s�}w�FҮ,P
���ܛ��E�����a��rQÖSCU*������0_���P�)|��N��0i�1�n.�z�z����U�Ϡ������Ӛ��n�!�����k�Q�{݆���Ē�aC�I�Ėe;���@�MYa�s���f�<�vh�����s�35�����(�J��I�X�.<�/V��W�͌J*<z�����m����5�yN7���&����eZ:�$�H5@C��I���W�G�@�K�\t<`edx�!��~p���~�q5v+�e�S���	�ᙝ���%j�~*�b��P��H�K������j����W��r
�y�3ު1i5�*&�4�
�*��M��%��V�eN�]����&���s_��~%��$68�c�a����^^K��ܩƈI�5ti��y��\q�AHy#�4@ӕ�̅P0����H�D~��:ž*�M���:[fx��w���	�a_�n��rZ�B%���/��T"�^@17~`��ރ���{�F����f��V��kJ�~ȿ�8z��*�֖���Z����V
�nɊeT\i���RƸYB2�vo	�M�̞�3��Ć�R��U(����\0f��N
�):l7T`X�)ߒ����?��6C��{k����-�z n��G,��m~����V~��04Z�싇�yu�t�m9b8/8�D���4+z���8�]3j%Z�ص�wC�{3�
A=�)��/���)ʹ�����ߧ<����n�}����#\P8�bk���,�?���Ԭ����.U�
Wfe�J�ƎH2�nGP��n�Jn����Wa����%�%��؈ZW*�������q��veՐ���f����s��]��{�/���Z��\�ԋ��
���:	N���9;v�X���h2Y����;_��m�����mEV��[O��k��l; ������DG��IJZFFFNF���zkR%�GFFlJFFPF[F��������t���OFI�Δ��Δ���JF.I.I㙓�	vRM8eRz���}�t��҈��s��HO�YPkC3��u�|�*m/���]y��!�=#�y�a�}�ܳ�v(g��%J3AXsg*���d�rJ����7B!��ʙ�r�zk���嚼��i�
���s��
XHO���x]����U�d��rTRI���}�?��厳h��*^f�ԁܮ��~�wju�b���-��HM�o�����=+n�KrD�AQo���g#��0�����i=Z�A���iiۺ=8�Iط/!Gvh�S�ݔK���Lz�0�F��V"�?�H��^wl����2A_��<��+�{:�I{@q�f���=���Gd������IJZFFFNF���z�U�%LGFF�HFFRF[F����������t���OFI�Δ��Δ���JF.I.Iۖ��	vZ�U:��;�}""��R�
[�ۀ<��<�L��ZJ%��@��T�}-�����ϝ/	�B���~�,���tHZ�����X�t���̈�wG��}f�$\�mX�����R�&�,�G�-�|S$� �-�������+i��F�JN1��*d�qiM�/A;���?`��@mF���)L]n�Dxd�0�k�-�b��G��"r�9���]\����1�2�#�!�cc[N�<�%4M�9��u��o���N���>S��IJZFFFNF���z�;���GFF�JFFMF[F�����t���OFI�Δ��Δ���JF.I.I���)vVa8eLH�������.ɴ��s�{�z����+�:��U
F�pQ,rˠ1L���g�"%9ǡ��/���:KlD�$���6Q��X����V���xK��T\�I�>�و���=���ٓ����;�@�P��%z��$]��`�|���EZ?��ϩ��A�v.E�G��E���"E�B���Q�t�z@�ɆɇZ�nѐPL����>~w(�+ky��V�b�$��,}��gt�@�E�H~�LIp�`�/�&\bѕUQՅ��b`�͌갗��-L�c����3ߪ9Xw�k����\�6�Ճ2>�2�|�b�LsXAr��Rz�k*%$F��IJZFFFNF���z��콿GFF(HFFMF[F��yt�����OFI�Δ��Δ���JF.I.I���vZ�u>U�c�aЋ#<�V����W���r�{铐`ͩ2%݊��n���4�}}��y�=�=n��s5ط���P�s�(P�|I�`�yң�[���^��N��n�t�鄰�H^����^`���v)V�[ܱXG�O��%坧A���
INSERT INTO "ejecucion" VALUES(34, '2007-03-16 17:10:51', '2007-03-16 17:10:53', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 2.
', '83��������BqXڮ����������GG[\LW]\MZZGGO?ITTIV[QXMLIV\QKMZZWZ[7,6,-*=/NVWQVTQVMKWMRWMRKXX�1VNQTMQVKT]LMLNZWU][ZTQJOKKQ TQV]`OV]QVKT]LMKJIKS_IZL^MK\WZP"!�NZWUJIVKWLMZMOQ[\ZW[P" �NZWUQV[\Z]KKQWVP"�NZWURUXP"�NZWURXWZbP"�NZWUXZWOZIUIP"�NZWUMRKXX""�][ZTQJOKKQ TQV]`OV]QVKT]LMKJIKS_IZLJIKS_IZLG_IZVQVOP"""_IZVQVO"_IZVQVO<PQ[NQTMQVKT]LM[I\TMI[\WVMLMXZMKI\MLWZIV\QY]I\MLPMILMZ8TMI[MKWV[QLMZ][QVOWVMWN\PMPMILMZ[NW]VLQV[MK\QWVWN\PM+[\IVLIZL-`IUXTM[QVKT]LM[]J[\Q\]\QVO\PM$@&PMILMZNWZ\PM$@P&PMILMZNWZ+QVKT]LM[WZ$QW[\ZMIU&QV[\MILWN\PMLMXZMKI\MLPMILMZ$QW[\ZMIUP&<WLQ[IJTM\PQ[_IZVQVO][M?VWLMXZMKI\ML�1VNQTMQVKT]LMLNZWUXZWOZIUIP"�NZWUMRKXX""�W]\P"""MZZWZ"VWVM_TQVMI\MVLWNNQTM�ZMOQ[\ZW18P"1VKWV[\Z]K\WZ�h�K:MOQ[\ZW18$<QXW&""K:MOQ[\ZW18<QXW�h�"�ZMOQ[\ZW18P" "MZZWZ"�h�>ITWZ�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�ZMOQ[\ZW18P"!"MZZWZ"�h�>5I`�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�ZMOQ[\ZW18P""MZZWZ"�h�>5QV�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�ZMOQ[\ZW18P"1VUMUJMZN]VK\QWV�h�<QXWK:MOQ[\ZW18$<QXW&""4MMZ�h�"�ZMOQ[\ZW18P""MZZWZ"\PMZMIZMVWIZO]UMV\[\W�h�7J\MVMZ>ITWZ�h�\PI\LMXMVLWVI\MUXTI\MXIZIUM\MZ[WILMKTIZI\QWVWN�h�7J\MVMZ>ITWZ�h�U][\JMI^IQTIJTM�ZMOQ[\ZW18P""MZZWZ"QNaW]][M�h�NXMZUQ[[Q^M�h�/_QTTIKKMX\aW]ZKWLMJ]\ITTW_QVO\PM][MWNIV]VLMKTIZMLVIUMQ[LMXZMKI\ML�ZMOQ[\ZW18P""MZZWZ"\PMZMIZMVWIZO]UMV\[\W�h�7J\MVMZ>ITWZ�h�\PI\LMXMVLWVI\MUXTI\MXIZIUM\MZ[WILMKTIZI\QWVWN�h�7J\MVMZ>ITWZ�h�U][\JMI^IQTIJTM�RXWZbP"1VKWV[\Z]K\WZ�h�K2XWZB$<QXW&""K2XWZBQV\JWWTJWWTQV\<QXW�h�"�RXWZbP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP"1VUMUJMZN]VK\QWV�h�JWWTK2XWZB$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�RXWZbP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZbP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�IZQ\UM\QKIP"1VUMUJMZN]VK\QWV�h�JWWTK)ZQ\UM\QKI$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�IZQ\UM\QKIP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�KV\P"1VUMUJMZN]VK\QWV�h�JWWTK+V\$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�KV\P" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�KV\P" "MZZWZ"\PMZMIZMVWIZO]UMV\[\W�h�WJ\MVMZGKWV\ILWZGQWGUMUWZQI�h�\PI\LMXMVLWVI\MUXTI\MXIZIUM\MZ[WILMKTIZI\QWVWN�h�WJ\MVMZGKWV\ILWZGQWGUMUWZQI�h�U][\JMI^IQTIJTM�KUXP"1VUMUJMZN]VK\QWV�h�JWWTK+UX$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�KUXP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�MVLP"1VUMUJMZN]VK\QWV�h�JWWTK-VL$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�MVLP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�TWILP"1VUMUJMZN]VK\QWV�h�JWWTK4WIL$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�TWILP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP""MZZWZ"�h�KWV\ILWZGQWGUMUWZQI�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�TWILP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�UW^P"1VUMUJMZN]VK\QWV�h�JWWTK5W^$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�UW^P""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�W]\P"1VUMUJMZN]VK\QWV�h�JWWTK7]\$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�W]\P""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�[\WZMP"1VUMUJMZN]VK\QWV�h�JWWTK;\WZM$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�[\WZMP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP" "MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP""MZZWZ"�h�KWV\ILWZGQWGUMUWZQI�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�[\WZMP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�RXWZUUP"1VKWV[\Z]K\WZ�h�K2XWZ5U$<QXW&""K2XWZ5UQV\JWWTJWWTQV\<QXW�h�"�RXWZUUP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP"1VUMUJMZN]VK\QWV�h�JWWTK2XWZ5U$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\�h�"�RXWZUUP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP""MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP" "MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP""MZZWZ"�h�J:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP"!"MZZWZ"�h�:�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�RXWZUUP""MZZWZ"�h�+\M�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�XZWOZIUIP"1VUMUJMZN]VK\QWV�h�K1V[\Z]KKQWV$<QXW&K8ZWOZIUI$<QXW&""WXMZI\WZCE]V[QOVMLQV\KWV[\�h�"�XZWOZIUIP""MZZWZ"�h�>MK\WZ1V[\Z]KKQWVM[�h�_I[VW\LMKTIZMLQV\PQ[[KWXM�QV[\Z]KKQWVP")\OTWJIT[KWXM"�QV[\Z]KKQWVP"1VQV[\IV\QI\QWVWN�h�K1V[\Z]KKQWV$QV\&�h�"�IZQ\UM\QKIP""QV[\IV\QI\MLNZWU�h�K)ZQ\UM\QKI$QV\&�h��XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�QV[\Z]KKQWVP""_IZVQVO"�h�KTI[[K1V[\Z]KKQWV$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�IZQ\UM\QKIP"1VQV[\IV\QI\QWVWN�h�K)ZQ\UM\QKI$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�IZQ\UM\QKIP""_IZVQVO"�h�KTI[[K)ZQ\UM\QKI$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�QV[\Z]KKQWVUMUWZQIP"1VQV[\IV\QI\QWVWN�h�K1V[\Z]KKQWV5MUWZQI$QV\&�h�"�KV\P" "QV[\IV\QI\MLNZWU�h�K+V\$QV\&�h��XZWOZIUIP" "QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�QV[\Z]KKQWVUMUWZQIP"!"_IZVQVO"�h�KTI[[K1V[\Z]KKQWV5MUWZQI$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�KV\P"1VQV[\IV\QI\QWVWN�h�K+V\$QV\&�h�"�XZWOZIUIP" "QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�KV\P" "_IZVQVO"�h�KTI[[K+V\$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�KUXP"1VQV[\IV\QI\QWVWN�h�K+UX$QV\&�h�"�XZWOZIUIP" "QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�KUXP""_IZVQVO"�h�KTI[[K+UX$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�RUXP"1VQV[\IV\QI\QWVWN�h�K2UX$QV\&�h�"�XZWOZIUIP"!"QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�RUXP""_IZVQVO"�h�KTI[[K2UX$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�RXWZbP"1VQV[\IV\QI\QWVWN�h�K2XWZB$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�RXWZbP"!"_IZVQVO"�h�KTI[[K2XWZB$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�RXWZUUP"1VQV[\IV\QI\QWVWN�h�K2XWZ5U$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�RXWZUUP"!"_IZVQVO"�h�KTI[[K2XWZ5U$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�MVLP"1VQV[\IV\QI\QWVWN�h�K-VL$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�MVLP"!"_IZVQVO"�h�KTI[[K-VL$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�TWILP"1VQV[\IV\QI\QWVWN�h�K4WIL$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�TWILP" "_IZVQVO"�h�KTI[[K4WIL$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�UW^P"1VQV[\IV\QI\QWVWN�h�K5W^$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�UW^P""_IZVQVO"�h�KTI[[K5W^$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�VWXP"1VQV[\IV\QI\QWVWN�h�K6WX$QV\&�h�"�XZWOZIUIP""QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�VWXP"!"_IZVQVO"�h�KTI[[K6WX$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�W]\P"1VQV[\IV\QI\QWVWN�h�K7]\$QV\&�h�"�XZWOZIUIP" "QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�W]\P""_IZVQVO"�h�KTI[[K7]\$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�[\WZMP"1VQV[\IV\QI\QWVWN�h�K;\WZM$QV\&�h�"�XZWOZIUIP"!"QV[\IV\QI\MLNZWU�h�K8ZWOZIUI$<QXW&""K8ZWOZIUIKPIZC_Q\P<QXW%QV\E�h��MRKXX"!"QV[\IV\QI\MLNZWUPMZM�[\WZMP""_IZVQVO"�h�KTI[[K;\WZM$QV\&�h�PI[^QZ\]ITN]VK\QWV[J]\VWV^QZ\]ITLM[\Z]K\WZ�UQKZWKWV\ZWTILWZP"1VUMUJMZN]VK\QWV�h�^WQLK5QKZWKWV\ZWTILWZ$<QXW&""-RC_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�UQKZWKWV\ZWTILWZP""_IZVQVO"]V][ML^IZQIJTM�h�I]`�h��[\WZMP"1VUMUJMZN]VK\QWV�h�JWWTK;\WZM$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�[\WZMP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�W]\P"1VUMUJMZN]VK\QWV�h�JWWTK7]\$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�W]\P""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�UW^P"1VUMUJMZN]VK\QWV�h�JWWTK5W^$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�UW^P" "_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�TWILP"1VUMUJMZN]VK\QWV�h�JWWTK4WIL$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�TWILP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�MVLP"1VUMUJMZN]VK\QWV�h�JWWTK-VL$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�MVLP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�KUXP"1VUMUJMZN]VK\QWV�h�JWWTK+UX$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�KUXP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�IZQ\UM\QKIP"1VUMUJMZN]VK\QWV�h�JWWTK)ZQ\UM\QKI$<QXW&""MRMK]\IZK*IVKW,M:MOQ[\ZW[$<QXW&K5MUWZQI$<QXW&K:MOQ[\ZW18$<QXW&[\L""W[\ZMIUKWV[\C_Q\P<QXW%QV\E�h�"�MRKXX""QV[\IV\QI\MLNZWUPMZM�IZQ\UM\QKIP""_IZVQVO"VWZM\]ZV[\I\MUMV\QVN]VK\QWVZM\]ZVQVOVWV^WQL�UISM"CMRWE-ZZWZ�83����������BqXڮ������������������i����GG[\LW]\MZZGG83����������#�������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(35, '2007-03-16 17:12:53', '2007-03-16 17:12:55', 0, '', '���DEUAAAIA|��u΁�AAA�BAAIAVA����o�����JADc���c�����EA)D)D���qM�r9^�H�b�_s�|M���׻e��&����7���>?��xb�b��ּ1�~��+Ω����D=��sY8���-�S�E��a׼�t7�B8�d���}�{����j5R~ݦ��a�0{kS�d���m��6�V����뫏�TߐǡW�a4�H#������!�N��@s>������ ��4>�
]�y$���A��DEUAAAIAz��u�;<3)AAA@BAAIAVA����o�����JAD_���_�����EA)D)D�҂�qQ�j5�}�����n��H�=D�����wj��9 ��o�_K�ȁ33�
Fo4-tw�"j���Ӊ����է��g6j�fj��7-�7��J��mN�3�o02�1�bŁ��etT�Ə`9��M��߂W�B0a�uʑ�c��<��2$���WJ�O�7֨ ��DEUAAAIA{��u�7�I�AAA�AAAIAVA����o�����JADa���a�����EA)D)D�̂KqQ�N%O���}�moKo�I#N�s��g���ֹ�l��?8 �%�#R��������h�!�Yh��n6wz�"QetJ�sS(du���!oY��>49D��(l�f�YS���q�a\���w�tX%�|�֗V�o�!�hė����DEUAAAIA|��uj��AAA�AAAPAVA�����������o�����JADc���c�����EA)D)D�
�+��6J[nMDӐ���m�6ݏ1]�w�ȯ���a�_e�9Qzq��s��o�|K�}	�=��il�����"��p��DEUAAAIA|��u�����AAA^BAAIAVA����o�����JADc���c�����EA)D)D��KqM��IK��M��2!��Q���X����ۻR {^_}f �3�����Rg�6&��֗��WY�K1�wˢ	.�����Q�A�f�v
Ʋ�_��0����8W3V�G1V��ˁ)\&��ŉ�X�#v�J��D���h��6�R��Ư`�o��P��|I�[�n��Jj�
|��z�iT+B$�������%m����>_���k��߲^���s�^�A��ĭ��\1P��PgpR`:�jze@,2�ƭ�P_��R�Ocf�z=h��DEUAAAIA}��u��]O0AAA�BAAIAVA����o�����JADe���e�����EA)D)D���qQ�N%^V�E��/�~����`��*���e_U �����%�@<�Ӕ$��^� ��;�#��h0n�|uN!L+UV���@��Jҽ��y����g-G5nO��;Ț	�F��Ⱦ�5O|����ɞ9��v����z�
��92�b���q�خ�r�ĉJ�s@J��DEUAAAIA}��u0ݱ{.AAA�BAAHAVA���o�����JADe���e�����EA)D)D���qQ�N%^�V�E��/�7��VUH��{�d��g�X2���K�I�?:�g�s�b�5.���ݲ7-�ƽ��B����cQ;��7��Q
H����v�`w�0�1��
F|-��ڲDb��$�FA,rb�pz�(�spa�����a2���\zʔne]!��L���
����i����OLA����*�N9�(�
���(�н��]�@6=$�����P��pI�cH�S�ݦ?T��DEUAAAIA}��u%�05�AAA�AAAJAVA�����o�����JADe���e�����EA)D)D�
|�ֺG�g~d�Fʘ�~�	�ݫb"���Jn}k\��L2{�m��{mE
��.r�}��3�Nx��<���5�]�_Q�W��VuNl/VMKg3���a�ڦ1BZ�Tp����19`�8X=���o� m�.��m�oi��+�U����n����}��r��Qy��X:P��DEUAAAIA~��up��AAA�BAAIAVA����o�����JADg���g�����EA)D)D���qQ�N%^GF��U5��P�#L�����
�9/疒P�s4�@�/�.��q����t��T�q7��@��Y��\����LU�T�3FLwժB������u�m>=g;!��N}��ib���e���MR��+�Oj�q��wg�B���	��d��q���f^�B�	h����r��x�2K��?�83�=Wi�~I����+K��DEUAAAIA~��utQ�AAAAAAIAVA����o�����JADg���g�����EA)D)D�ςKqU�N%O�K��D��|X˹B�*���:"h�ʸxc��t4��޶��d��%��Ճ�|C`N�B��Z��Vh\c��b
"I\��Lbϋ����:�]��#j���ؐ?g+�p�YT|����#f\��DEUAAAIA~��ufΐ)AAAtBAAIAVA����o�����JADg���g�����EA)D)D����qQ~x�@q�����.W�_�}K��ǯ��#�=0g�o��8��\(�m���T�n�U0b
p�eԉ�?��-�",9[�٠�0N�Z���`M�v{T��)�o�$���-0�P7&�[�7(�w���"YDP/)x@�/#���/�7�,!�//h<�72��?<^9V3�*};n�.V7>�%
9QTZл��ͳ������7�=HJ�Tc�E����kB)NUV`$�xe>؛���Ue���G�?&�����yw_�o�*�/�͔ ��9�D1��,�hF$ˎF�B5�j�B��gqfr�yP*}p��CD�k��_1�2?��t���7yL��R�j9g]�%��{U���q���Ыw�Ǖ8-�Wdj�R���}C ���R|xg˃5M/�5M"(��jY=�P���ר���]��BE�ܒ�v�yqY�	.X�@�x���ʯI��Y���t(���4�+��a�Q� �D,���;�Ӡ���U�oF.U�[Ә���C}���"Y����2k,Xr�#|��6,��䍜�������kVT�-`���Fjm=k����0ޮ֞L�x�=-Y���n=j�X���p������_׎[�rXj^�W3����PuN<ݾ��׸��Vj���"W���.#�6�v#
s������	�c�܈�`���G�L<(�0>g�xI^�����t��$���R��R����f�d�d�*�u|}jyd}0�� Y��]��"#�S���qh0(�����}m����v1���qvڳ����]{�}0m�.@��DEUAAAIA���ua�o�7AAA�BAAKAVA������o�����JADk���k�����EA)D)DΒ�qQ~x�Y������ж2a�1a	�(Sr\�t�s2c?��XVUWCt�0���"�*���qЃ�6����Q6���A �M��O�LU�\7�N��\kq8yQ|>�P�a����H�`�6�Kõ���û�&Y����%k��j���6[�FM1�����wHw�/u�"f����Om�����!X�F��j��H7B���?��*�K��XR��zT��D*{��<��ui�~I����B��DEUAAAIA���u�fytAAA�BAAIAVA����o�����JADk���k�����EA)D)D���qM�r9^�H�m�_��~U7A��f��m0s7/����޷�6*8@�16ꆙ�8���L��{Q6qu�h��mĲpwy�����ʈ���f�Xl�|]��>&Z%67Vwj� F�"k4�F���m�|��	�无�V?d�L�i��{�-:�I��Ns��h�k�y �:y��Ko�����9p���|�5��|  ����B�T��;+H��DEUAAAIA���u����@BAA�EAAIAVA����o�����JADk���k�����EA)D)D��qM~�@�.�J����]w5b�c!���Bf�F˾6��ի��+�%�322�2�����=sz�L9������������gk�0�*u� ��+�e��,}Tw�1�ف�C^�+�l�[�3��}����N�}��h]��b���!��R��}ŒbPx%�V�w	$� ��5j�蔙��ҵ����V��jH�&!�}�J�;�+�)���_�")SЁ���2�S�)��L�s�3i��%�w��B���Q�}b3�0�MҵJ{�lT�.���#�
JY�<fY;Jp���If
����.}�c5�`�V:6t�qZ]�ڣ�3U�������X[����=,��ΦP�)�����O3�N�[H*s֙�O�P���z�ɢ5$ak�_���9�jƁ��Z�UQ*���z���wD���~������|��.3����0��|��,����G�(��<�E��R9����|O@�#:ݿѫ~s%򈨇�v
?��I�,|�``��DEUAAAIAz��uX��AAA�BAAGAVA����o���JAD_���_�����EA)D)D���qQ\	|M���I����ئP�9Cb|ڷd��3$����6�0��B��E\}��=.�d�U�F�^�ΐ�M�X)`dF��t���b�~���yf%�g��k1�,�ƴ�_i�m�H6��Ǯ��64¬��_�q$f=��̊!�JY ����"q�Ş���pu%
�~���L�	��;cU�k�ǣn<o3�= �����DdZ�5ъ�=@��*ewN��E���{�(���0DZ��ۥ=V�L����C4;/�٫�_�2g@�߭���P8�ld9P�[��c4��DEUAAAIAz��uf��JBAA�BAAGAVA����o���JAD_���_�����EA)D)D����qQ}��mJE\�����7_�P�PY��|k󥗓o⾼��7c���t��s�am6l{e�0��j��v��,ؿ鬇�vO@b���qo�{(��C��cڤ�_��V9�iy����u
d�C6�H9	�Pti�<�h]s�tZ������j�UD��b:.���3N��=B��DEUAAAIA|��u�Po�AAAqBAAGAVA����o���JADc���c�����EA)D)D���CrM��)|EFZ�7B�-�_E2F�ۧ��^�7e/��H���@8�J
�D;#I������h:�������#r����O�a���cq�D������+�L\�gN�n��t�H}8�@��@��DJ��J[=�B$ƻ�����r&pe+�H��bg�������t]�Q/Dz�v_�aZT샷��i&��x��jy/�;D��DEUAAAIA|��u�#J�"AAA�BAANAVA�����������o���JADc���c�����EA)D)D���qM�v9^�D���񬛷Y-�-F��i�ˤH/�螚��>���X-�ǡ�|hre�7/*q�m��3޻`�s�V�Ǜ鬽����f�,ms��8�l��EgYkYs5ї�����wp�����kH`c�ߘ�:�y���T�����8W)���J��$����X���c�h� �@2?K��N.��ݱ(���v���(I�_W��Q>����˝��DEUAAAIA|��ug��� AAA�BAAKAVA��������o���JADc���c�����EA)D)D���C�M�O
�����LK���z �4�Εr�#&26$Z��Ѱ2E��O*W�$�l�64Yθ<]�?�"�
��QƇ����a]���r,�ܤ)�3T]~๾Aj{�m[�k�f�v����7h_g�L��H�7H(���-X��DEUAAAIA|��u7:l�jBAACAAVAVA�������������������o���JADc���c�����EA)D)D���CrQ�G3O��i��7�l~5��5F�wZv�x�eTp� �����w��@��0�
3X%!Ch��eBW���`��Z�c�Jߢ_�X��G,<�����|��Я(����G�孂��Y�;�5�4���lP��DEUAAAIA|��u{`{BAA9BAAGAVA����o���JADc���c�����EA)D)D����qQ}!�MJ�E�����P�v�i>��%�䣬��Ui�>�����t�����4��v����,`��}��|9�O�k�,;듅�(*`Ө�V5N┳e�n���*iKX)��²wnG�%H�2m秽�}�މ����қnG����2�[XT��އ�3�������<U�����[��:ѸiC�=f;�����ߞ3�C}�\E��d���!;Ut���濌ՔtW�3G��_$�sS�~��юIW7�0�C�$�h,������ڀ��A毎p�g`5ە$g��ζ��	��0T�%�Y�)��_-Ѩ��DEUAAAIA}��u}`��AAA�BAAFAVA���o���JADe���e�����EA)D)D����qU���|MJEH�����/[I՟�i�䣌�ୃ�7�v���H|���^��Kj��L�{��Ђ�gY:���K|�����(�
Pӎ�G��1���z�E�&t-c6�F}Y�t������)6NOh������k��
�P�l�<�"����R��E	�T[4��J�u���	y
���	��.�WT��k�\?�1�����#X��DEUAAAIA}��uw��{AAA�BAAHAVA�����o���JADe���e�����EA)D)D���CrQ�G3P��iudt����YYH���f*�
�� �����+%ft���b�#Usc�8�ۋb�\��B�1������^�dj+Y"J��`nd�(��֣!�U���PJo�V���K����q��)o"K�F��L���^t��{C��@���`�4M}�\l�+��>�B�,?Hw��^Z��ؿ
�pK*O���=��:T��\j/��DEUAAAIA}��uE��_AAA�BAAFAVA���o���JADe���e�����EA)D)D���DrU�\	�]�i�YE�#�F�=��g��jt
��L̿�Z�/��8��P�����{�8(�U���X]�_����P�d���
ZMV�[�a��Ƒ���g�k9��2@���˲A��L.��m[7��0h�9�|Y�ǌ1��W�XT�=�(ӣ�2͞���u%�`X��v5;τN8�]��๮�����Z��k�S8�"�H@JF(|j�B��DEUAAAIA~��u�S�YAAA�BAAVAVA�������������������o���JADg���g�����EA)D)D���qQ���Y#�Ԇ����U;H�I�u�H�Q�4.�Sike|~�ě���p�
�D����j�>��V��Jtҹ����^ЩM����#]������B��r#DK�qH��#_�ٝ  V8���]��靾����=�!��p�N�_h`��y������g9��n�0`��3�-�u���=���y��͕p�@~x�E��3�폇�A��DEUAAAIA~��u�w7#AAA�BAAHAVA�����o���JADg���g�����EA)D)D�ю�qM�t9��W�K��^����N?���f��-!О7�&�.�6)d"n�-�d!�]LcH@��ɭ0\���,^��M�G,�Rev�;���ET��m��R�����v�\�/�}�*]���[��N�Q��q_ۜ�Ge���=�ՓE���\�X,r���LJO��+�N��@9qD���yU��4%��2i�u�c�H�ƣO��"8O:w3Ϝ�A��DEUAAAIA~��u�p�BAAWFAAKAVA��������o���JADg���g�����EA)D)D�qQ~!@qf�e�
��mU��q���mF��7�8P�eb�ޮ�L��2���4u��x���Z�����o�&B��SD�k8��ȡ�m�
����{-K���</����˜-����m!�@�#�#<S��.� �^!4�$R����!�����2�jS���+���F7�AS�@�4�1��hF�\F���g���	��-2���7H�FKYNu��
�=�<G4FP�tK�
��(�Ɨ-&3��\B��^��Ua
�2�1;3[��-_�)��[�(����p�z�y͗���#�뉯t4��a�,�@tF�2���lN��;L��DEUAAAIA~��udN�VPCAAFAATAVA�����������������o���JADg���g�����EA)D)D���Q~���Y�i����%9�aȁi��cw��~�V�l�Q�.൷fz��IzH�v��7�x�Fj��f���G���#Q��P������[�Jf6�}Q�|�H!?��}[�q��5��.伖#_˃�u���k���UMt�K �������J����/���p�Y{���a�f��
�#u�W���8���¦!#��,�C֋t[�N~��I�6�lZlRH����o�=�w7Q��R�d���Γ���}����T����՛��N<z"���Kλ����f7�љk��f���bI^x.>���������s=Q3��%Vt�u7��`��ש�J�#ѸGw�	/����l�Q���z`�k�m�F{髌�V���(��)�(Ԋp���9E����1�!��1l!�::e#�?���J=G9�Fߟx6$(r_~v�	}�xȉ~����ժP�=�I]h7���R{/��q*��©�y�^���Ðj#h)�:1�8	����\������O���jK�ħ!A�
�z & �$�3��F�#�F�8�Ķ���=.� l��� +�`	`N|$`*Pq�m�7����DEUAAAIA���u[�;SBAA�CAALAVA���������o���JADi���i�����EA)D)D���qQG!�M�с�wo�ӷ��HQ�u�Eχ)R����뎍c�<
�qQ~���Y1fǃ��$5`�0����i�5�f��en�p�4��ʩ�G�!���Y��(������J����I���$I&_�Τ5)�Q�����S�H��-���LD\���B�)���Z!��;�v��9�#���v���ĕ���\�Pǋt˔0#��̭<![�f�ѾGMW����*g"���y��!�08S���L�A���]R[�t���sY����:o���<���)���M?����9�V���x���X�k�,�������<�����,k��6�zJ���9��:�n�D�	��_L:T4T����NiiK�����?�X=�Þd��A��DEUAAAIA���u&�[BAA�CAANAVA�����������o���JADk���k�����EA)D)D����ÁQ~t#�o̩�~Z�0�vN�����XC��[@���[��43���	��� 
�!��%���
S$�����IJw����{=7�Ҹ�6D��DEUAAAIA���u�K`nAAA�BAAGAVA����o���JADk���k�����EA)D)D���qQ\	|M���I���Hp��FHI*���
�؆�*���4��L)�f!tF� �x�����9�|�ڢ)C>�偰��Zl٫(^d��Ɣ�
INSERT INTO "ejecucion" VALUES(36, '2007-03-16 17:12:54', '2007-03-16 17:12:55', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 2.
', 'HC���������h.Ƚ-wR���R������WWkl\gml]jjWW_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[9\\&g[9\\&[hh[:Yf[gJ]_akljgk&`2Af[ghq[gfkljm[lgj�x�[:Yf[gJ]_akljgk4L622[:Yf[gJ]_akljgk [:Yf[gJ]_akljgk4L6!�x�2[:Yf[gJ]_akljgk&`2+,2]jjgj2�x�FMDD�x�oYkfgl\][dYj]\afl`akk[gh][E]egjaY&`2Af[ghq[gfkljm[lgj�x�[E]egjaY4L622[E]egjaY [E]egjaY4L6!�x�2[E]egjaY&`2*12]jjgj2�x�FMDD�x�oYkfgl\][dYj]\afl`akk[gh][J]_akljgAH&`2Afe]eZ]j^mf[lagf�x�nga\[J]_akljgAH4L622af[WJ]_akljgAH !�x�2[J]_akljgAH&`2+(2]jjgj2l`]j]Yj]fgYj_me]flklg�x�_]lWnYdgj�x�l`Yl\]h]f\gfYl]ehdYl]hYjYe]l]j$kgY\][dYjYlagfg^�x�_]lWnYdgj�x�emklZ]YnYadYZd][J]_akljgAH&`2+(2]jjgj2 a^qgmmk]�x�%^h]jeakkan]�x�$?##oaddY[[]hlqgmj[g\]$ZmlYddgoaf_l`]mk]g^Yfmf\][dYj]\fYe]ak\]hj][Yl]\![Afkljm[[agf&`29l_dgZYdk[gh]2[Afkljm[[agf&`2))2oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[?]f]jYd&`2/2oYjfaf_2�x�[dYkk[?]f]jYd�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[9\\&`2/2oYjfaf_2�x�[dYkk[9\\�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgjeYc]2"""S[9\\&gU=jjgj)HC����������h.Ƚ-wR���R���������������y����WWkl\gml]jjWWHC����������3���}�����', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(37, '2007-03-16 17:14:15', '2007-03-16 17:14:24', 1, '', '�fa*���J� 8���-+yb��w_�����yy��{�Dy��kjĨdZĨdZk����ic��F"�1�6pv�B�O��V�qeWF>(q)i�b54̷��N�1�T�4^���P@�1�;5�-���h�K�m�cs�d�8OeS��"���">���&��R� ?c�k���p&�tE�,�i��a����3>2f�1�Dl�0�����f�;K ��
��^#+y���}�w�wDy��kjƨdZƨdZk���ro��\&�-�Ƌ��ȳଈ�h�X��V��9%"��l,g�J^�w���Q��a`��_��%^��|}|�/p u��r�F��4R
��z��4H
"�:+�ߐ+���FSzk��vC"��W�5o��g��������$q����E�-$�%q5��ew���Mz6����|��ĭWML��4���N���ԧ≥��vٌ�H��9�u�/�U�[
��֤ǋ�5�Qȯ�R�	��"��5c�\�<��~D�!���џd?v�p�����B퀷!�	�a�!��g�<&<6`�[�_�AH���o~��ˊ�B��?R��IOL;�hnhզ5���	�3�,��4�מޙ+4b=��$t�aO�;�9��S5��.~��ϒ$���,��}Iۛ�4��	�󆆐L/J���a��E]�x]����-G<WN���7��!
�	�;�1��\��i��������{Y��F��nĻ��~!����LUS�����c�Ϳ��@�A���?��ƥ줟>���\�B)��;�j^DYv�B� ����"�A�S�p9[�Y,�19�l��J/u_�
^k�Y�����6kt�A9��z���T�L�* �Y����Cd��XD>;�ҐS�R�{������Ȍ����u�����@]y0j���(:�2c���(i�������2�����P����@���|�!>�z@��*��ɡ�sH-o�v�t�p.fX�jXc"���7��"�u�P����l�í�ZVO�I��.Ha�h����[J]����[��+um�s���2o;�����č��6���J*��˅��T��N����
D�����V�ʧe��J8��hV��8f>��,2�h�V?��í���Նp(޵���?�h9���;fpN�J���:
�4�fa*���J\ٙ�~+�w�Dy��kjƨdZƨdZk����hc��V"�5Z!�D<��U$d�4���B;>���x�h�<�n��܇b�̊dIee_0s�I�>BB�qE,���t���?���Ў���1�t�ܘ�RٿpF��Â�X} !#�A���]�R�����7�ş���;r�e_#�a��J/� �@�
D�4��@l��m���t~qhμ�m��{P�5����y4�yX�uGmpƹC����5�ZW���jz\��cg�̀rg!�K�X8t+.��&F�k2A�NF�a�07m��+8|l#��I�Þ^K�^猑׶i�W�V:&��5l�����Q�hlq�ђ�P���v��N=��p��P�����:�pjA4�.�+h�)��m�#�u␦SH�k4O�;@�`��%T8xɰu�O�Rb���@�vRI~2��T��,ܧ�x�In�<ۘ���w,k�xT��~aC�$W2[3FIu��@��/E��#z�R�
b�G�a3�ϑ\�+�64X���������v���9��J��o�2}��Q��q,��:3�Ml�Be�$j!3������H�2�]/�zPfa*���J�ӎ(_u+yXw�y�h{}�����D~kj¨dZ¨dZk����lq��F*�]�U2+���:Zp��j�(�fz(�����X��G��N#��T
A��	3�p�z��@9�i͝��s��.*�[�t�����=�%0b�,�5UV;�� ���ȉ��<��rG����g����O���G�������
��+��a�Fȳ��@`�d�i�R�ϻϠ���$��g�d�������Y�fZ�d+�[@���z�a�6ᜲsc���F�Z%�Ed������@�i�L�M�}�n��@C�[qnM�	��Af��FG��2
�ފ۽�L����?N����"����h�n�-
��t�	�a	��c�-%f��z#s���}��B%�s���5�[ۯ��(0���W�fM�/�T�#��C	,���د%�}��S	�~ �Fh?��_�P���C9��
H]y�\`4� P������%�ufa*���Jj7��Du+yYcfD~kj¨dZ¨dZk����kc��F"�ޕ�06�!=���)5�3L�3��K�{Pgwa�:��
*Q1n�<m�+�W�	�i�9���F��=.V%���d�[��%|ѳ�a�����)���������t
m������45?�`sv�I�����R�.;Ck>&��ͺ�"Ц���6;/��u�fU�8<c�ݧj�O��"?Jw�^��2���B� �����1�x���7©^w �˩?.l)L��S���L��!��zcǝ��K�i.MzL�8u�6*�g�E>�-L�
9�21��jX����մ���GR_���u��;��$K��e��M�\q8��[w�S5��ҍ�IʇI�B����􂎨�E�N�Tn#��ǝ;��?��>���1}�tK^{J�읹S@���o�CSaK�>�$o
����8�>Y!,�H�YW���@�S�� �b�gǏ��,�=sk*���VC���7�Pr�X��=��Z�í�T�ő�M�cQ۝j��v�-ȱڅ{��0D�0��F�͎����3��U����x�����R@�gh4�E�9<o׼$zSO�¯�.�;5h�]��=��	�����,B�
|{F��F�~�y�*�b�Efa*���J���0u$+y_�����yy��D~kjĨdZĨdZk�����aeW"���~67x��6-O��I����d폎G���]~H����E���A[G��ut-����tR,[��+ƹ�b?Qʿ:~���>!��&ӚЋZA���Oc�T<y,c��<�A���N��c�BD��	"J�ʢ�㻟�@�h �ǥ�nbc8��ihV�;��*���dK.�[�ιwcMm˻`Q�5��h��&<�M=<�wCTd�)���!�e1[��4C��}�n$�q��)>sVg��%��	+������_o����1JTm��a��-fa*���J���?.+y_�����yy��W�}�wy��D~kjĨdZĨdZk�����U%�F&�
�ȍ5�yS��׏�<���E�!��E5�l�gfa*���J�|��(�++y_�����yy��c{���wD~kjĨdZĨdZk����hca�V&�5��*��*%(�^g�a�Q�z�dҪ��c�."8N��
��_�h�K6Z�2�	��ı���R5۝&{�c�BT-:o{�\����h��o�)$�6��{��
441p�4��/hAj,�{�\�kV����6��D_V���yL�����u���wm�?yڪ���q��v�+3Y8$��E㲊3����$H��6)�d�ْ孱��핯�[��eKUHpc���)�fa*���JEx)��^+y`cfD~kjĨdZĨdZk����jc��F"������D�
4�O�#F��Ĝ8�[�B�1fե���D`ub����j�_?Y�����`�v�zu/0E��h/�᪆;U1��h`{�%��s�\�$@��:����b�#��dA��
v(B��L�iq�.���B�Cl�o�WQ������
��$ۚ��9��Kz������ �u,��,k�^�M*��vj�?�:1��iP�����:v�Y��S�0M�8N�ict���5�1^�#u��]�-v��ĢZ�D�]*�����@�t[H���ەfa*���Jl�hea[+y`dD~kjĨdZĨdZk����kc��F&�95|�;*lB��Ye�����IŘ��$���Q�((^�$&�|�ӯ��Z8ybvӔo�U����#C���$��R\��u��P�r>��lc��C��X��D���.�EA�W��h׷)S22��=���B��k���,J�5������ꈱj�@S��h?��q.MG��:�=���ىQ������
R�?�
�OrRcj�����4à���?�.%X�+����{P�����d},�
(\|A�,��E�z�e<��tL��*�9��>�gqKľf�P�� ��mv���Y���l(_����w�Y�*�D�I�C��,K[/u��W*Z4�/l���F0����ΐ[yn�Y�\6�bA���_�;+���A(����^��d]���{9�}m1���D���m҂Z�x;�E��U)�7�t����R�kaja�a�i�r�t���=�|ii���A.T!&���0B.
@FKu������7��㕖��q�w�e�_�w��r���CZ�.�����+<�"����&S�a
2L`{��!�w�.3�mp�=��/�i��;�:E�GV��
�p�2DQ�s�B���^�+>���d�!�>����bb%w|w64�,%w�O����a�i�r�|7�7cX�-�į%aN2!&�C�0AN�����U7h\p��Y�$Pj�@3��yb�$��es�Z��LSҐ���4s�J9��C��m%�Q�Ri�����į_o�|V��Sr҈����iՀ>)��]�fa*���J�Na+y`fD~kjĨdZĨdZk����kg��F&�]�Ur��X[�]��weq�c�+/�Ę��$�QQG:�|:(T���b��׀��p�])� �נc����8r	��ns�D����,��^\7M�!�OI	AB�>����4�$��>��I�����@�W��srю�֙��փt�o�
2�`���!�|�淓�w���<D0�����4��I�18���ex�.��Ǔ�љ3p�@i	i�K��;�@��a���I�kɳ�
�)��Oe�ip���İ��U�ZW���jʢ��Z��"θB��P@z�c���$�=q[[ ��\�
�I�Rm���v���_o��U��$Sr���]�N���H+�
fa*���J1�hb+y`pD~kjĨdZĨdZk����kc��F"�ޕv16ơJ���2�𠄝#�V��Z�9����>�]ߌy�ڬ^T�Sh
b:H�����P��j^����b^��G�K>��O�X��Bˀ�΄�5�>������
A�s@N
�����~zp���kO��2�̶�D�rR\ᙶ���U�j��`�-�Y���K�JW��!����!��9���T��?�
�P��@���QN�k�H+S{0�_~���x�R�bS�r��]e����`!�tQ����}��^E1�l���3w���� �A`�d��X8t+.��&F�ȫڕf�Gy��.��������v|�]q�<?wm�4�^66m�/��M��&����6�0�;fm�z_���?��qh��5������0�
���Z���l���}gk]tAf���`�,A�����4�2jwZ�%5\yn��%���
R[ݻ?,�/	:��O� ����C�� ��+�0=Z��A0B�x~E�y���F�3y�k����?���CZ�N(Iցv���Q;����v��1pI�Rk��~�į_�q��5,Cs,�q-�ioj@*����[H�fa*���J��e�<+ybeWZD~kjĨdZĨdZk����lq��F*�]�U��h+@`���[��cx�J��[�Om�ゝ�X
��r�]�z(e�z,�������`y���f1|`!L�r�%�,H�-R{�E�6���`�4�~U4��,Q|GB��wL`q�R��X����j�d\��	�r7�O�F��h@JUF�_�Ʌ4�F�	�0��Nge�Y(���E�gĐ �u�~47Y�x{@T�J��L}k1�H3�b�k�42�O�?`�CA��i�5sxa�N"+��{���gqKľ���2a�ˎiv�5�Y��f��7l���6�~�W�I3I����q6�\|��ÓW�+��:�&��%���p��uF3P+�
[ЏPsd��P�po��P������uO�]6oH�Y#�����7�t+uz���]W�v�TBz��6���?/"^�:�w���b���ի�j?�z�yy���q�J�����	�8S.|�>��VPy�@φĐ9m��j�N6�_Z�l{��\7}�FI���;cEn�7�IP����x���F�B�/`PX�*������p��v�i�X�/[[Ӱ2�}V�m�@c��G�j���-���S3�G#�z�ȭS�M��,��:s~��#C����k�
4]��I�Z*��R�jw+L��W�a�5m��ڭy���n��ױ��
T	ڛk��/�I��U��8ظ�QJ�E��a�L�Nf&�c"̐Vɭ������:{�N|Xg.�*�^ON�A��:��DF@W�	�T�-fa*���JBR#_�+ycelD~kjƨdZƨdZk����kg��F&������ @��ŷ��{��k���\�O�Ax}��<[Q��-���3��{�O�Lu��҄ԄL	�C/�ڗ��X��&�M��N-`�H��q�2�)7�B��=E�G֟!���̻�����d	/�P~�z,��m��`���=,��+�C��V^���,�Y���K2o�Nb��0�Qw4�0��lSo�(���=�4������~t�~k�bq�H�g~qg޼�M��{P�����!}�D����:�$�,��M�����q�V���jz\̝�Y���.θ#+Ѽ ώiv�u�Y�(�m��~��6����P��/ɀXM���<8�V�[�l���_�&s�U�����}�=������p�0ۯʑ0"�	L���,{��g� �:rA���y���X@�X�����"�]\��A]n���к�4�+�`�N�t�4�jׁ��*=���g2,�z[5����AC��A"��n0"��H��V��QT�Q����L�5��{|d���-*�� �cLT4KR��R=`�4��e
q�d�c����֪f�	H9��/wXhJ�T���8�ۨ���h���`渳?��^�p�mj����˳s)l�^�F�2?��&��/�gB,���>)��QI _u"|��֍��m44������f���+�S��5���6"D@�gl��J (cW_�,yA���r�*]!�����p�7�a��b�6.�j�_m�L1&�/�ns�#�8#L"����;^#�B���/�Զr^�f��g4
T�����D~��4���M���W��_���gs+�S|��w$M-�q#i�U����(8M5A)Fo��(B���0���X^��(�Fs`OȂ+K���N���J=�n���\�l�#���#�����Y
7�.mBx�C�
��pH��Y�ow���_-�^}*�(�\�CRTSR�x�V�u�S��[��/�k�sn���	��e<//�˰�{#C��غ�;~ͪdTe�O"��6���w�V��`]�Uj{a;
FO�&4�;~�l|����C�~
��j�$��:@���fa*���Jix�O��!+yh{}����D~kjƨdZƨdZk����jc��F&�!��ظ�۴��a?�%��s�+M|�c�ڻf��%U�<����1��MI� 5_��6�4��eE�q�{��(gb�#4]ks�2�CB���4�J3�I�f�S6���}���u�8�	5pd��!�\n藉t�<�u	ErgM����چ@!?�˦�|�%;��h�8��[�\�<�&�;^֓.e�@�7�0b�}�!�&�"We����猙�r+M�e&����ZXU�2�f�K���r�Ćn�>0=�UG�a��̰�ǳ��z�7~�����
R�n����O��T�V��L�no�QJc��F5�,��f��N\YD����L�����jz��C�hK�����4��6�L�o�kP�o�%U�Xv^��rR��$
cX����^7�YrV��!fa*���J4DS!�#+yh{}�����D~kjƨdZƨdZk����ga��F&�-5 ���pۡބe`m0�J��b_hE���ك���`ԯG���b[����`$��F�P��g�����KZ�����덗�MX��s��3�������3��7K�9oU�Aq	�4�L-�qC���6���LCN�R���U�U9���8�5י��].`_
}��>Gou,
fF�c�⪚$����N41�����p����Nb�0b�\���p�]��@����1M�yn({�/i.Kd�㪝qA�IQZ�%)��ro��&�?3of�_6L	�}�b��7]]�_z1�l/m��@-��)<���j��u�"�.���B��¿%@�w�rH�(�g���?�N0�:��y�$��`�&n��&FA_� c戍:�s,�; ^!w(����Кw�:[m�줢�)2˘��ԑ�E������MO���������O���v���~ʊ�iP����o6�*�:�C0&;�db�2�:�n
S��vnv��ezsuo^����fpz/k��a!2k�`�{otu1���������I����g��T���?�aFgT���)�v���vyܑA��b������F�iH���Y^��?�A���t�3|,�X�q۳��(��0��es����P�&�
4��q>+yikXD~kjƨdZƨdZk����kg��F&�������j:�tY)��<��ʿ��2�&m�䂩c�Q<�u�	��}��8�G<�����b=�z&(QL� ��R\��u��P�r>ߞj���ч�4�Yފs\�/��v���$����J�Ù,]|�o���j~�x@>lWj�3�Hi|��s��@�#]��$(���i=��Iu�b1n�~�ݫ��<=�X���uk�9��L�~u54v�l����@�4��O��[�q��:mcP	���#�<#
���;���m��N�dDiۛ�8P�>y�b=fa*���J���� +y�{���wD~kjĨdZĨdZk�����a��F*�
�>��X���l7Ka�lw44Y=�]FZ�^[F���v�y&����Du[Ǡ2B�dا��>��CReupW��o�x�5���L���Q��.�Bt~�^J�_�)]K��I��(��	noݣ�
�a�\�
�(2�@m	���M]�>�՞y�Ő/X��&��V�����Ufa*���J�x�!+y���}�w�wD~kjƨdZƨdZk����h��F*�-���j/��礗N�+���Ӣ7G_�!��:�"�aq}qGe�O�����T\`�|��I��tг�Yf�L�vjR㛚�y�N�~y0k򚐒���fO@�2__Id��1#Ⱥ�q�/Č����O��Cn�Hy��K۰{�U�*Or����Q��W��o�m�xS��8b{�F�)R(FY2����+k#�Sg ]�����A]�h���߯�@".�1F!2tl�o��t��=b�Du�U��Dr44@!/�l#�.���X�GN���:F�s�a{�F>���p��;�_a��?�<���W�|_����A�Ǩ  �f0�>52�L���Aӭ���ef$�\����fa*���J�y�E�>#+~{wz{��_���D~kjƨdZƨdZk������$�F&:ҙ��f�&#%t��C�ʜ�
��^##��y���}�w�wDy��kjƨdZk�fa-*���J\ٙ�~#���w�Dy��kjƨdZk�fa-*���J3=��G#��� yWZZD~kj¨dZk�fa-*���J�ӎ(_u#���#yXw�y�h{}�����D~kj¨dZk�fa-*���Jj7��Du#��&yYcfD~kj¨dZk�fa-*���J6q�8#��(yYdjD~kj¨dZk�fa-*���J�h�u!#��s*y[dZD~kjĨdZk�fa-*���J���0u$#���+y_�����yy��D~kjĨdZk�fa-*���J���?.#��,y_�����yy��W�}�wy��D~kjĨdZk�fa-*���J[s�ڽ@/#��	-y_�����yy��Y���w�wy��D~kjĨdZk�fa-*���J�|��(�+#���.y_�����yy��c{���wD~kjĨdZk�fa-*���J�a�X�*#��V0y_�����yy��iw�zwD~kjĨdZk�fa-*���JGY�&�)#��<1y_�����yy��iw���D~kjĨdZk�fa-*���JEx)��^#��o2y`cfD~kjĨdZk�fa-*���Jl�hea[#��x4y`dD~kjĨdZk�fa-*���J�"��b#���6y`dpD~kjĨdZk�fa-*���J�Na#���9y`fD~kjĨdZk�fa-*���J1�hb#��;y`pD~kjĨdZk�fa-*���J��e�<#���>ybeWZD~kjĨdZk�fa-*���J�Ҵ�5�+#��SAyb��w_�����yy��{�D~kjĨdZk�fa-*���JBR#_�#���BycelD~kjƨdZk�fa-*���J����>)#��<Eycy��y������wz��D~kjƨdZk�fa-*���J��-6#��GydefD~kjƨdZk�fa-*���J�B�8�3#��bIyekjD~kjƨdZk�fa-*���Jix�O��!#��AKyh{}����D~kjƨdZk�fa-*���J4DS!�##��
4��q>#���PyikXD~kjƨdZk�fa-*���J���� #���Sy�{���wD~kjĨdZk�fa-*���J�x�!#���Uy���}�w�wD~kjƨdZk�fa-*���J�y�E�>##��SW~{wz{��_���D~kjƨdZk�fa66�9X', 'Entrega');
INSERT INTO "ejecucion" VALUES(38, '2007-03-16 17:14:16', '2007-03-16 17:14:21', 1, '', 'HC�������h.}.�C3��3�����WWkl\gml]jjWW_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[DaklYAfkljm[[agf]k&g[DaklYAfkljm[[agf]k&[hh[Afkljm[[agf&`2))2oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%g[hjg_jYeY&g[hjg_jYeY&[hh[Afkljm[[agf&`2))2oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agf9ka_fY[agf&`202oYjfaf_2�x�[dYkk[Afkljm[[agf9ka_fY[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agfE]egjaY&`202oYjfaf_2�x�[dYkk[Afkljm[[agfE]egjaY�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agfKYdlg&`202oYjfaf_2�x�[dYkk[Afkljm[[agfKYdlg�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agfKYda\Y&`202oYjfaf_2�x�[dYkk[Afkljm[[agfKYda\Y�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agf;gehYjY[agf&`212oYjfaf_2�x�[dYkk[Afkljm[[agf;gehYjY[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[9<<&`202oYjfaf_2�x�[dYkk[9<<�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[KM:&`202oYjfaf_2�x�[dYkk[KM:�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[EGN&`202oYjfaf_2�x�[dYkk[EGN�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[KLGJ=&`202oYjfaf_2�x�[dYkk[KLGJ=�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[DG9<&`202oYjfaf_2�x�[dYkk[DG9<�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[=F<&`212oYjfaf_2�x�[dYkk[=F<�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[BR&`212oYjfaf_2�x�[dYkk[BR�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[FGH&`212oYjfaf_2�x�[dYkk[FGH�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[;FL&`212oYjfaf_2�x�[dYkk[;FL�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[BH&`212oYjfaf_2�x�[dYkk[BH�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[BFR&`212oYjfaf_2�x�[dYkk[BFR�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[BF&`202oYjfaf_2�x�[dYkk[BF�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[BEH&`212oYjfaf_2�x�[dYkk[BEH�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[GML&`202oYjfaf_2�x�[dYkk[GML�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[;EH&`212oYjfaf_2�x�[dYkk[;EH�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##%OYdd%Yfka%h]\Yfla[%]jjgjk%G+%<F<=:M?%^fg%afdaf]%[%geYaf&geYaf&[hh[Afkljm[[agf&`2))2oYjfaf_2�x�[dYkk[Afkljm[[agf�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj[Afkljm[[agfE]egjaY&`202oYjfaf_2�x�[dYkk[Afkljm[[agfE]egjaY�x�`YknajlmYd^mf[lagfkZmlfgf%najlmYd\]kljm[lgj_##[DaklYAfkljm[[agf]k&g[hjg_jYeY&geYaf&g%glhHC��������h.}.�C3��3��������������y����WWkl\gml]jjWWHC����������3���^����', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(39, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(40, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(41, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(42, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(43, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(44, '2007-03-16 17:14:21', '2007-03-16 17:14:21', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(45, '2007-03-16 17:14:21', '2007-03-16 17:14:22', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(46, '2007-03-16 17:14:21', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(47, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(48, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(49, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(50, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(51, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(52, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(53, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(54, '2007-03-16 17:14:22', '2007-03-16 17:14:23', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(55, '2007-03-16 17:14:22', '2007-03-16 17:14:22', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(56, '2007-03-16 17:14:22', '2007-03-16 17:14:23', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(57, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(58, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo una señal 6 (6).
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(59, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(60, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(61, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(62, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(63, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(64, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(65, '2007-03-16 17:14:23', '2007-03-16 17:14:23', 0, 'Se esperaba terminar con un código de retorno 0 pero se obtuvo 1.
La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(66, '2007-03-16 17:14:23', '2007-03-16 17:14:24', 1, '', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(67, '2007-03-16 17:14:24', '2007-03-16 17:14:24', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', NULL, 'ComandoEjecutado');
INSERT INTO "ejecucion" VALUES(68, '2007-03-16 17:14:24', '2007-03-16 17:14:24', 0, 'La salida estándar no coincide con lo esperado (archivo "__stdout__.diff").
', 'E@��	������~e+p������������TThiYZggTTkVa\g^cY/HiVgijedgXdc[^\jgVi^dcZggdg/�8VciXgZViZXa^ZciXbYa^cZ[^aZ^c$ibe#�kVa\g^cY/JcVWaZidhiVgijeegdeZgan#<^k^c\je#�E@��	�	������~e+p���������������������v����TThiYZggTTE@����������-���������', 'ComandoEjecutado');

INSERT INTO "ejercicio" VALUES(1, 8, 3, 1, 0);

INSERT INTO "entrega" VALUES(1, 1, 8, '2007-03-16 17:06:52');
INSERT INTO "entrega" VALUES(33, 1, 8, '2007-03-16 17:10:46');
INSERT INTO "entrega" VALUES(35, 1, 8, '2007-03-16 17:12:45');
INSERT INTO "entrega" VALUES(37, 1, 8, '2007-03-16 17:14:08');

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
INSERT INTO "entregador" VALUES(25, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(26, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(27, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(28, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(29, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(30, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(31, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(32, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(33, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(34, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(35, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(36, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(37, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(38, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(39, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(40, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(41, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(42, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(43, NULL, NULL, '', 1, 'AlumnoInscripto');
INSERT INTO "entregador" VALUES(44, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(45, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(46, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(47, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(48, NULL, NULL, '', 1, 'Grupo');
INSERT INTO "entregador" VALUES(49, NULL, NULL, '', 1, 'Grupo');

INSERT INTO "enunciado" VALUES(1, 'Simulador de un microcontrolador', 2007, 1, '', 23, '2007-03-14 16:17:11', '�oj"#3��S8�df\#��#&4��RM���ts("
��~���X�6��؊�
M�����
;���^��\�����XJ�\H�(���~~¾�L���(�B�޳r��Y������>z��������V��}�m�\j�+��=Q���⾒���lt��3F�����q�[����`�m���RFC��E�ߎ�,=�MF�.$�R��,�d
ʘ�W��k�|�U2������쏊;�C��S�Ѽ9��jr ���L㖺�p	{��L�~6�
�R���1S��}��pH ��*I��"�*%�3���m�&�d�O{�ó�t6��E�V�69�1��ze�hv��#��Z*C19�-�J�#۠�7#c����l/��OY� �r��iȎ�Q��TT6`�3иU��dB�`I�9d����ǉ�BJS�85�D�=P.٦�B�����L/T�i?�4�9�_,�E��oHq����+oG��F-��X��[sK_"�����c$�9�Ȫ��v-�39�-��#6QK��}�pu�-����A����KX	9�P�R��HtU�2cA�3Y6�I�|:��Bd@v5�fX+ѣik;q#JQ�ĂeG]]�G��5�:�r,���p�<���P��kDT�m�؎m*��R3n,�8�U�[�ߘ0�C�©	@�"�.AN�EQ�tb��N�k�q�v~�EH���
�)�yׇ������$�2YF�%�Q�,8�Ǧ����p�`��0Y{��f���n�Rus�hCP�iE.&��,A�T���[�4������B�ѷ4b7�;U��I����5ʥP�g]�B���AU�[B��琵8[�lƷ�hYģ��{�����`�cU[O��o��A���;�e<w���q/��V㰉�&
`Lm�deH_)tɫ?���Ԣ�Jg�+�E|Y����Xo=�h�	�	�C�~��e�;F��ƽD!J�zT�K.�Uc�S�_�6�-E���l�
�YX�Ó�pGh�^�Y�\}��$c)��Br�^X��a7
 ,���W�c�g|b��̌�B�F�)2��WZ�sO��_Of\=��+�#{W O%p�I���A,W9q�� (�ɘdj�,�jp�HEi�1*�§��1.C����a�i��1b3�C>j+��&
W���:S��F&)�E�7�;ؤ�G<��Hp�s`4���b��V�̡(?�tP�k����������L�ۮ��۞��p]d8a1��5�pg�8`�~�R��xvcCGy<�90E�om��K�����a:E1s-c	���Σ��-�(K��(�e�3�7W\w��ӳ��P
Il�﷜���G��kG��Ssv�gZXm�q�����bsI���hty���}��i)&Ja��>��H���^d���	���zy�a�	Bг�(G#.��6�t	�ݦ�Li�0��<
��v�T��5��)h�QdL�I"ȇswr��<mߺ�q�i�)(��Tn�V�U�_�iĹg$�ܬ�٩M?��&�J����bDvI�Z��	�ߨui����l���	��ns�v�5qe�(�F�m�If�t)��t�{��&��H[�<h=��,&��ǟ��i�w7���v�\��ȉ��2�+Tz����zS���LҶ���o)
 )+�Q�7�O�Q.s�\/��vNTi�Xh�҂E����"Ћ΍YX������U�X

9�p5M�0�lo�ݗM�`Yfl���(4���-�|�V\���H1,�lf?)� ��X7Xٿz�p��gS[�h���f��7���Z\������f�]��)b��\:�h`� ���0	���
�c��׸���x:�È��&?�sʩߵ%k�QBY����i��3�H�6163��SD�/�.�H�t�S�h��,9⪳%�I8��T��F?3�y���{�-��T��hO�����nOyT3��%�V�(<	O���H;~+T�KfQ~��t���R��L@���;�
�/8�CY<�v��#Ih�m!��8f���a�?�X���fp���h��k9��!I�ѯ�2�ċ�)ǱdN;v]9�<,Tp�o���k�㕴�K�j����0���%���JϤ�����?�J��5M����k|�T7���i�qi^����5V��1$���9e�	����,W��J��� �,�ǚ |���.�PP��K#P��v3�m�A:�Et�d`�9Z��>��[o�8CHp�X�1h����X?���Hi���Z!mJ��L,�4]�S�I"Z�k���<���@*7�?[˴���EKߓ�-��f������ȕfI��zYX�N;�k]�k���(��t���U�{�����JR	�D\[���c��h�9u��8���8gW��Q���S6�Yw.�?����ײH
N���t��)M-u�������
-�w<����{!PdI7��
����l�-Ќ�6|J�/�\��2H��<��Zp�6�=��xt
�؄�c�O��z-�S/\��k=K��\��D��Q�$��L�g�����(�4�Y�:�f���R�
���s�ādX���}� �#����������U���;#!!5%�H�6����M�	m�0�A�J4Wg�P�����
$#�%�%�O�	nAl�2:@m�)��q�i�h����U������^�b�����
��N
�������<~;���Z_�W\���S�X\t��>�P%������=�^ .O�����Ј��;�T����@ـ7m���<	���1�`]+��5w��>�������e"Q�mT��H�M��]����ټ�9��_�2�ŗ(�-�&�A�<�b�"�U�S��(Q�!�<`�Y�7�e3Q�C�5�#���(�4��/�.@�s��M�n���t��D���.����uD(����)0��XLa�*x��;�P��n�@�H��l����l�UC�L�;b2.D.	#s.�ֈPp&���GP����	��fF;Z��\�o�c��}H8!�b�!�
uqpǟ����ժPF�$�J�:}�u�Pfl�gv�guX����I�l��3�T��Ś-���ץ3щ<�O˼�_�8Z�G��pm�q�����P�۾�ܢ5�>�T�%���+~j���r��J��2��RE-x�PQ��&ߤ�<ZDq�9t�±�*6/2�����������&vu��2�ӗ��e�H2��oH��Q�����������L��wv�8-��V7�W���-~f�&�G����Aݺ�$��cރP�̲�g��3�v�Q(����nRC��L�H�{C�-��F�{�oH��W)�I�L��h����␚�H�c�c�����-к_r��|\$紅Y
���[�������0�Ô�#���5:B�M�=B\yW���0V�:�DF+	�l�W��g,s��HG���j�o��B��#(�(g_������<�5חuIٶ�7�F7�5b�h�)�
�Ѭ��������{�2Ћ�ڎW_�V-f�J���V�u��`1Q�i�[���o�!��0�*7�����=���-�8���k	�Xg��8�ܽ�b�J�q9��qzo�
!�����Bj�n,-���w�����fŞ�̺c�
`�.�_�^,7N+oN�7�}1VO�KR�#���~Jڙa���`꣫���8�K<+���&_,�^�O��2:��-Fc�i��G��ڍǷ0��B̴Y��-ͨ�1ޑQCe���!yanQƚd<�&���zD��#7j/ډ{U�h��ix��u,b8�C�K�{H�F���t��u��;
�fW9��?m����s�]ĩ,%��d��t6��1�vS����wsvwS4�NZo�
0�t�s����"MIg�ۨ�Qqu0#��O��ҩI����^���]_u�N�F4�PZ�����YU��p�f.���=݉.����/O�Z�=�o\qc�m��֕�O�7��O�g� l��lnTtI?��t=�h4Pp���h!��Zzl|h�dZg$����(����1h���E�c��k3xw�g.�e�ok�hA��C�E�+�����Q�*��	�l�y���+}L�+��1�-�_D؋p�"�R���6�ֵeM�+}q���J���Y�y���i/s�4Ps>ٱ�Ȗ���5_�h
�X2�q<���q^�;��z�7ʈۨ�N�aD��z̲p�u�ǎf3K�^s��I�>��mx��)�=���^6�NX��-A��{���Q��.�
F�L�)N�eA�u�7Td��VQ�d
�yo�,n��G�M��`x�
8��~��h�J�@�����ׂ���|�
�Y���V�}��˲e�S�~�`��P��}^���,�����~���C��1����.2N���ئF��Y�|�t\������j�H�K�
g���惡�������0����f��X��X�U��87#��nO����}6�.헚k�:_q�W��fX	=�B/ZuXS�x�\]V�9&��q��7��-R����tQPJs�(�Dj�i�w�m��֛��^Y?U53;-�mU
� ��J9��D��+�
flI�4�v`�>v��ǳ`h,X�4r�W;s��}g0��Oe�l�wB�XM�:Ͳ���ə9�֓g�\�����y5��6ԯQ���d������� �Ѝ��)��	����!�q�Ō��H���r�\�CP����?�K���Z�"f>���IwVU	td��g��e)J���[���V��m�H�RO����C�n��9��-Q,9�4��4Ɠ���-���׾
�(ؚ\�w��m���ࡤE��I�F��ݻ����B���6�U����H�C��%�,���q7N:2�[�}U��s�϶��U����x�|w���j ���w{�ڈ�w�T�r+19դ�����H�	a��]H�=��
�_��]����
�[N{`�Z��g�uj�8^��.�kԱ��E970ҡW�ZD?��E�Sg��G Ѹ�G��D����[�?����}��3���]7���%7n�{�8P9^�p���5�h?^M��H[f@�l�p�.,�`9V�[��K2s)��u���5���q���`t0�iAj�8�3:sW�M�
�r�9���}s|п%&%u�������"$�������J�l�F媵+x���AlM�~��n~�x~�7��?�k���n�}g�9���V���E���7B�8dW��X�fm�UH��;��1M��+3�9�YՂ(M�K*�L�
�W��65�1�x�����BXzUo5���Xhj�^�п"��#,�D�,@�c`Y
�yy��@T�
-v�Y��	:����[�G���N��F�ؕ+lg1���t�6�a�*R�Ɂ��J+ 	jKn_���5���:Uo�����;>�%�S����c���_���1���.N��$XA�	4 r�RO�qcV�D3�Y[΂E�83���醨�
��9�X�&l̦�RH	�}I���[Y^�$۱�t
J%M�$qpQ�w�$b��@ )e�B}���=������7��Y8�)��L��?9���|;��E�f�ЅW���{amn�nI�k��Kw��\��Wl~�Üdv&4�G8]7N��2Z�5�f�&t=l
�g}ˀ�Օ����R~rY���ʿ�K��Iǘv�^��)�9Gm�K���;�~tC"~�Ÿ�����X�����n�>�~ �&��mE�HPQ6���~A��,&���Ώ̘��l,/5O����_�f�F_N��6�^�ɩú�#гyH�`?��1�s(;�p
����
��Z���"^���ݭ�Vd���ݞ���{��Z�T�Wa��I$F�ۼm�������Һh7VX�;R}�n,$��-�Rc}Wf�b|��4	�������0�<�P���Z��϶�k�]���v���-��_�����78�lț���4��5f�4d<�-����_�4b�[�6����8;=8��^}e��̀�\�˯���r�|�5Z"(���_�~�|! ��k6"38�VB����ї=l��>)�bs��tT��k�A �G��@gE����A:�W
���N��6�k�>F���@:/���_N��4>e0��A�&@��"�Pq�A�AHi&��-�R��-��B֪�W`�<bBoF�p�]x���f��o6Y���%�<#G������<5�lR|/��0񢆭�����"Y�6��J1{�
�¸����4�9%H�h�\ wgd,�b�oћ
��&�+L�p��]�`�߽R�G�V%�֦��7+#<�s,3�����A��j>8�>���r��{D�� k�w0aS�"X��DS
��a�8F�՗%<<�)9Zd�11���ZH~g��(i��ی{�<��#����)(������@~1($�Z<"�&��c�63�&���ݲ<�0��?��T�~�M�)C��A�������?:y%�M�C���p3,�pL紐��4��R����������Ǡ���2�<CG�:[?=Gq�H"��!Y5�ݑ 9��MS�ccJcm`��ph�%�ϞͥK�Ov�Yj}�B�
	E����
���V��J�N�su�=
�a��|3�=��m���*��e˕����	d���j��Ԧ_v؛�vS
�e�Z&C�:��^JX�Կ��&t`� G��R&��.͇u��y䔐qʹ-*a�4�-�h�ɢ�I���m�״ ;N+��Iq豵��%���"F,�<7Scb�}�Ҍ6SA���`mە&m��+����y6q��bYg��x�e�w�]H���f&�2[Y�Z��ErqE��N��a�1��g2ܙ��	��6HU�A=��.��a�=��w��H}���88�D}�&B��$�C��K�arދ����,��p\p}�3�b%{8��Љ�����uF�-��|lU�Ǫ�5�Ĩ=��Iׂa��`#���A.���"������"����g�C��R��#[�,>��%Õ�!�l�l��L{�#��ǎ�.s�G��WPJh٥��qXvop��ob���l����*�D/Z
&|��(�� :ФŖ,W��|��͈�iYX����Iu��+�
>�=H@
&T�*�363���<e��3���&$_ʋ��Xa�5�����I�=��r�g�-�l��!�C��Z�
0��lB�alr����AQh[
�}�
��P����ASHn�j�-W�⫷9Y9��Z�bY�s9�����~��f{VA�+ �&�ӷ����5�v7P&6�"�\�_X�e]��}D�r@ه^F&akRC-��_Ro�ZG�ɍ.E�7i��;,C�-��a�즪�K�������6������\Kn��co
�^%�f��۷V^�W�:�X
`��l��8���i��ucՎ�5�$���w�Ps���|���,*�/��G���>��(��F���o�ZN�Q7�jT��aho��%�?h��QXl��uX�2��h?�_* EgR��`Lo��.h���e��*s�ٞ���9w`Qs�N����௩����,���}�+�Ln��Kn�u���:4h�m����Y=�EŢ�[��l���r>���y�\���*�ܛ�K�;���?0at`N�:O$@�-�MHQ#U��;�8A��%�;폮�O�GK�ґ�P���_+0�$HZ��`��Dߡz��l.�����e���q+W)y���$��݆��r��.�ǻ��K0!Ҡ�@�	��(���s��^��9�d�/��#�e^fhϵ�p���E�c�7%`��یrr�)�^V�N��۸��$.G�
�G��&��.Ä99*��V������|�?>�-O�dzbh�3>�3���F#�5�[�q�|���x��}Y��ڂ��E���Z�$Z$&��R�1��L��O�ɈY*�uNN�ĄûC1Y�i��R��Q��ql�+SV(�DpF�p������
.	oF]����"��Ƕq�e�����QW�w������dr��ǐ7g�6C)�ϡX+�V��U��X��nǅz^�\�T��P�$y"����T���wq�V�k��<�3{u�L8�u��u&�F7H�-�dF�.��y��Q-k��L��<�*f�L�gI�[��" �R��9�1��<��q�
Y��B�[}6��.�B-`�����Hj���>�:���������k��e`����RLe:?B�U�V�bP�ԭ���s4���%��s��		���kď˫�h�O�Y����I�Mj��i�ӹ|�1K�Ӷ_�c^��I�[E!���1T&8��M����37�c��˿7M#��Jɑ�ޮC��\]�V��Z��v�w�L��OC��z��֣S��N�:-�_��/�~I7�D�Fo��s�5mЌ�"���]��d���<~��W�V�(��V�v���(f��9�ӯ>�eA��o��cU؍^EK��3�A�����+����_�݂�{�;��	�p��6�E��\�u��OH�_�1�R"�x<a�Of��[ʂ|h�Fo���"��ϰ�+�E�A����j0�-�dP�:��H�������fe�H��`V�%��V8w-��
�v�chR�`���.ǎ�4̮�
ɇ����>��������n n�ZX쳭�E��q�!Чq}7zW�B�U�;Ĥ[d_�TW�$U���3�S5`B��r����D�y��(Fԯ�G��;�ٚ�c�nEE��H�5ۉ+��nT}��B�apL�������|o&y�L�<�z�ܴ���(�R�?�C�8`*J&o<�b:)��:WK�+O}lۻP�t֫�:�_��9�o���S�F�ֲ��ǁ7)����9���x��KG�pZ�Z��Ń���l�9t9�&����
�����]ާ�������R�T��|�A�[�r��@
l��Fַ��5�����?"K,�O�Ɖ����A�
"·�UF�-\d�7"[�).v3x0��6mg�O���)^
pэHk@K�>T��;�^�@)u�m?!d�$����體���=
<A���K�9�H�X�(�jm{�*�O��S��,���^%�/�ev	�O������M~/�TA.�!���vS5TZ�S��9�� &�}������?GoH "D�9����0a<>����ڦ���7D�;�u��{4ߌ	�5nc�(V�U-7)É���ʯ��ה?D��i 덟�`��Ȩa���q��@o&`��)/�5��H�� {�y�_��gs}��o1�X��Te�s���O���R����-���aC�pH��#^F�b�]n10ժu�{G���o�������̭~�c�ƻE��������6��z4�b�e����+ ���2�!0�����Q�$�ks6�)P�^fX
^b�5E�X�N���N����K|1!��b�����U<��.��@@�b�_i�s�y������C�x�*���5;���H��\�S�m��)Z|04w�N��H��vF�a35�^&	Lb��Q�tc���`K<�B-�ݽ���C�P��$���K�s�����O�1�1��6?�M�mG����Rd�t�w�W��/��Tyq�yP��3&K�X�h���Y=7R9�V�M��!b
#�����|p��|�38��S�lQH�m�8t��&}+������ƿjS`�´I(��˽@���/i��VToE�N��n݊�����O?܊�����!�����1�"�K��
��t�ܫ|p�@�
c�sm�/�P��
�P�820�ch3o��7��
A��~�E�����M�/f:��U1�z���
Ɠ����29�a�FӠ`q\_��b�[7�$]�!T����yP�&��Їߢ���z�yTáfޝ��7.��{i�Ud/�m�&��.�8�Zb�?���:��-���w]�B��#Kp�<��B�^�rR+��a**e]l{��dz1��_vޠ����"�����1C2�NW�B�^�/"0�p�� �d_�Ab�+gG��a�뚿TIe`bLvo�x��ᐫ�xd
�u3�/
�V�gEQ��z]��w[#�M,�XNӆ��+E�xZ9�!U��ч�i�-��`�E)C��;���5T�B�����i#e-��1=�B�`�ph+�(���p���=6h����jI���O�tx������+�4"{�_�y"����_�9����T"z���tW�;�g�����z�
rYb��!s��B�Ї^�!���Bj��F��i 	��$]����?��/��s��?���/�i��!-�����℟�<j��3�B%#�ƹ��T��ɏ�]J;!U�%��cŞ��֜��3U?�8���*�!�10f̺�x*n/ش��T�6X�j6���!�P@E���{�/صQ�
�K=!OPB|����oB��w
J�]�9vwû���4�}�yڟ���ܽY��ij�P��ɧ��U�`
G.f^EdL@e�j8q�j��o5՗t$g� �Q_r8�Wdm�~$M�"�ީr`��e�)au�Ь
�BbwHMnTX-�$�(7�z�za*�ׇ4�%k�%���=�e�����7���WϘw?��a�z�=6����\��K3���oOLq�+��b�f><��Hg����k�Q����O���&�Cl�:��y��ĥ��:<���I��%q�Ҵ�F�Ժ�T����<a�ͬC�����:����Z��U��
|E�+}����w"�%=���*
6b�Vxp�
ę��ʟ�����vי	N�
̧yb�Y�[������
��R�����
�����c������}�z^d؜����e��	�{�Ǝ�>�vA�vMW����N�k��������ŔM[<a
�겸���TW��m��xIdF���͚��K������=w�$�ȡ������M��d/0
��qq��5��a���:����U�Ql�SM�7�<���U�t��,�SҜY������8bܱ�m�ۜ��N�����4"��:�:³M���E�f_�
�C%sa�S�
+z;U1�LiM��vBĒJPpz�tP�<	vB�0�l�F��/o��6�"ћD�IBf�4����޸�nk�v��2vʴ�nx��
�q4����~����	�����$��,���d.�M�ū">�$���04-B����ҋ��7����ӑ�*خ�5q��~��
}��_P�8�-4i�"�_<H�ݟ�&�-�b���W�,?.�d)�,�?W�iB^N��/9�ۄ��m��Q�Կܜ��]qǉ@�,$W��8(20�%
H�Z݈,�1]b�(ZńKOL�m��:�&���TsÑ.�ۻ:�Rx��		C�X���Zc��E�Iϟ�Тх���$�F[�䜫s�-�voУ���NO
��#603<�^�	���k��D�FO�S{V�k�]G��4euoi�9����vEjc�����y�����g��w�
�Y�y�?p�S��
�i�`6?{d���5�
�+RM���������6�k7a�P���^�e������j�(X4�Y���y��aa��_
6����|y��\�Az���"��>�e�{,en��Lz�ש$�Һ,�$8��� D^S�
�)�<�Xv̽7�t<���z�5��U�a$�	�ꄛD�W6�	�����w���-���O��E�lY�����|<����>?)	?sG�ٖ�#M���
��jhF�qj�|�Y����-�9WL�7I�i"6HN �|YhJ��-Qd%[ӳȯi�XP�8������:
�S!�0��cl*?�E�N�r�*xe
�kE�~;�4��j�*���u���8����>}� ID>ҔF����u0��+����϶Y}	����������J��F�}m&������7��
j�yS1����Q��[�h\	���WJ&���M�g�
:�g߮�RC�1ZH_.h��~%x�+��*[�*-a�G����Jצn��� ��`e�	m�i�p��3�1XΗ31#en�)�X�,<����to[6�.õ��1��
8�jq��?��u�C�ѱ=8:	�O.\�=%*d��B��7|���t:��9}K�L�$���/�ԮU�
���`�����	(�ǭ}�{xRVn�ډ��Ƹ{�
!QNꇅ����H����ð�PJ7��
*�Y:F8c�&�5+G31y=(){�6��[/��*��:=Dy0��ڿ=,_�ڑ>�ÍW/h�����RB9K �Giح�_<��k�̇:���a�#t.�R�K������2Aѹ�=1�)e��th�Ҡ��S���ou���1 *"�C���-��h��{X�M&����~5�K�m��o���r���P[�(��Jcc٪��HXt���/�X���T�^8��0J�KG���7��7ѧ��+�������%��_r�"
���y�3����4�Քs��#͆��#�����C�F���C_gTʾzGP��/4lٰ(���Q��1Za�@nŠ^�?((�4�J�p	�h���V�{~���"+��
��h���XE��>�WJ2��X��MpC���RJz��D]��*^��� &��
�3���K�V0cy��E۩���5�sKg�m(
B7x?5�����$�(�ж`�8��P�\�xfx��:ʷ+yHd]�������?��T�em3�	B�N�+�zE?�	"�[SXd��vt�SJ��咋O����"D{l��)
;N8׳dCo�A(����@$��8	Xd�-�Wk���K�i�R�����
�\Brc(1˚���%�R9e��e�yf�zx:�
BZ�7�b�q}�g3z��-��>��,��C���P�86�T��y*�؇��*��@�fJ}��BƂǥutGOoJ��=	k�CcE�������?(`g.6U���fLY7p��l���|�8e$J�k�E<?�%��i
�j�b�����uq�q�q��BC��9#nx�,(�2���V���-�S|s��;��޸L]5��@����t@���a/�s�̞rK���Ѽ�wy��EuH�q���o�ٻ,����b�P�����r��7җ4�1�n�^t5Y���jk0
�k�R1��-��Y��{���h"�r�!�L�m�̺�ns?S�fz=�t�ޱ��#�8s�H�0���y��$�ƭH�P
�hU�I�_����\�ү�H+��î��E�!4�Mm{�-I��R9�

cV��^2��Ζn�]�6�.@�o����ޘ���=V�@%L~Ζ�2{�2_�dR~ɓp:���[����\S(5��>����R�)���9�a�CU.���u�:���!�
�y���( ����I�;�o�Ԇ]�q�et���,SFl��n�S���^�]:�r�w[A��WSy����tŏ��v}0t1��;j�ڤ��w9�Q�־����/���G�R�붝����[� ����A��rj�ɉw��O��1��UCL�A�g�6OO�4�JzhUA����xߖ0������	����mU��b��ݰ�.��&�2����Z����Ti4�}��.���%���;w0Y>��`��$���1
�&��1��
����~0����������\�%���Qr{�_�e�ydJZ�TlM���¹�G�qT������m�wXk���CF�������k�N���8X���:�Pw����;���7u��59Xsf�b1<p��N\o46u��1�M�o���p-_�nՇ���Ռ�Ռ��Ռ�Ռ����ؖ�
Bc3��E�`��}mh��	� �C/���Ƴ��Gr���$*�z/�3�	r�����+85�2�=?Z�/��~x�ϰm_��L0#�mC�������`�����.��HP�==�nօB������LB�/�u�(�a����u�ʃYT�
�5E	�a[�
��ժhf3�~���
6ЌqH5��M	�������6�
�x���z�KZN&�G20�fk>�ט��!����%?-�񄣤1�P/��R��]�l?��P��3���X� CR�qh>�ۘ�T��z��8S_�W��؋⿎��;f��Xy���*�7� KWZK�(`�I�;6���B֫�����U�z��]�>��Yd�!�W�h"�0��#�K11A�W����K,�QƉ��4�{�s3x�[y$�3Ɛt��
32�ø_�Lz����dt��Yq�e�ތ����Ie�����N��ɂ���sJ�I�C�e�#�J��������G�+��4;��EG��f]���7�N�@OCUmh�-�13���W��+6��RK=���`,�(��;�xO��-z�J��^����q�3��pv����+R�iU��2�C
i�����4��t�u���2�2<uc�� O���Ji
W�(�V�����gp�۪v�^�B�B�/�����$��OWT_��eBНR�){�c�gs�c���F�0��e���Aʥ�_�p�,kr}1?�c���f��=�+�Y��{��%&��AWfK��m��Sa����
;��@1����ؿC�b�&`�"��[�e���ܝ�s&)n��p��^@J�V��Z\��;�
�W������3gU�x�h���!��q��Z�ּ4$_=��1�
 �7�5{����	�ٱP%e%)t,_���"�P�O�6��{8�)+c���)zU}2�
�4���=� [Y�lEM��w��h�Ƿ��GɁmFZ9pG1�n�m3�6O���9؍�+��y�i Y�q��vͣ,%z��v�`᫚57{BFz���df�sIH���q��勑�Bh�#��J$:(���@]z�`N2������OpU�o�2��|W����":��ϫ����Ԕ����j���D1&��_���W�XN��q"+��+A/)�ؑ!�ۛ�P+[=�b����@��s5�����V9\;��?�o������k+�Dךf�"OmkO��~��`?섫dv��9��@d�G%u�P��������)�5R����T��=>�����s��dRN�D%�`��ۜM�/9G0�̬=��|g����	^�*hR�b#I��\�� T]a��)�q�;����]�H�~aMV}�`���y��7�㻓�3�/�W���=t�O��;<?����i�?��{�0�A1l�w���d^t��7��������	,�t���!�"��a����_���ۼ\C��d//�d���8��,����#�[�;Q�q�y1�$ ���V�}Q���j�٬�$J8�S��*s�)�DfU����X����ü�e�g��� 1�0M7�x?w�-^Q�^���;�����=r��}|m;U:�9�\(�����jk��p�c�EbQ���W������Nr8�6���RJ���,*kPTi�|	(aŝ�&�/��,6W�}��]ޞn�%����;���aL,rfj�p���U����1rcE~δqu`%K��i����u�I�`}Ѭr7E~�x|�1�ε��j�U,�N<���6a��׬���(�������\��.�+=٬�4>��������"��dG�x�/X+&�*��aA��*������^���?��.��m�)%U���2a�{���Z�=�� sG+H
LGs�H �&GM�@��_�V?�A,V���!l�ǉ�Tt9�y���h���R����HB 
�6��R����Q�1�]sL鬓n�U3`%�S�l��,�]4��Ӑ�
�T�SD�s�Y��猖���?�*������m9Y�I�}(?��HX�A(�9�]����%�Œ52�%�H䯫�-�mpܴ��b*i�V��_Lb�3�tRV��-����
�O�ʪm)�X"I�?��!Pҕ�|��q���~�*����N�����n�V��?�3���//3I�o֏��M3=�젍ɶ���
u��v��&�h����r���S���e[��+�ȧeɸ	�٠��3�,�̝�9
�IFAKĒZvAҎ1LL2uL����Q%j��*����r@���]	���TX�������(���dᱝ�L� �e/��:s���(è�"��9[�(	e��"�rc{A]�Abl$9��M��n��.�1����;�ĨCh����:Y=��1�^���.G�:�_�s��/�s6S�i�LS:�TY#�?�ɒ�������^�z��:�Ju}Wb��� ����2l+d�"�;o������wH�@�!�t�,��]���;*��;*���]_�ĝd�������΄�4g�>@��qW}��T��lΙ���n�B3�wQNph�D#�EF\LE5Qe�3�{����Ih�2�n�|���٧�fX3ُ�1�0Tg�TR`:��[!�w�Q�|,j`��S�-a-����t9bS����Ai	����W��odnB���$9�!\�Z��
�|Q)��b�:�Tati�l���:~Q�m#��m�Oe�A#O�Q���Q�:���H1k��r
�im���5�^5��`�����
a�1��������嶐`�����-��SA_�ɣ��J�HV�����z�
^�[
�K�^.B�a�W1{d\��k�����hr�
�W¹��
d^�|�܊��)B���p=�V���=`y,��,sr)�q�F���s}�?1��]���%�̀��:U�\�a���ѡq[;z^����T;$��L�љZ������ZxZ����{w.~�ܷ����%������	Y��k~�Eڤ�7��!��ZIwfiI+���GI �Uf�
��n��#��_t�Z.�%�
�})G��f��]�s�?�F������O]W((ˇ�?_TJҗ�Pq����[�;t���t��ta������@�p����Xy�EM����K
(�x�f
Ľ_K�FT[�\�g	v����>�pcpm�d_�<2!�#�)ʱ��!,�(�K[�CJ�&��إ�ԕ��r=6Mc�;�U+�e�����<��R��`�JӨlRX�`r���^9��*���H��l��?�u7o&�b
��BDq2IlWR�n0�6	�=�D�	�]����w��r���|��N�w_> �MP�՘2��-��x���Xquse�2��g`�_����6S�L?Z<S��|�u�}E�m8yn�,WJ�r�F��&�"��6
b�ƚ6�U���:�fڭ�:�\��Ѧ��dҽZ�p6o�~��ݓ�%�&b�2T��%����@�^8_&�q�ubݢ��u������C&!��T��YN�������F�77�d
�9�,^o�P햢ai���m�m`�;�~	<�V�tWD�W�6
Z�.5
��i&Ґ
Hyi�WCY����\\,ʛ��]�9R,�.����lC
fԊ
�<�������1��X�����ݘ���
lj���-#�wA~�m�������4��ݠ�$�G�n�`�����>
c��V`b��t�@�4�1�Hmj4y�*���.�wmc,
Z�T��jh{{w�i����[H���|��q��F<�/#�B� ��2(��>ǒ�+��GJ��,�o��!h�zߕ[)�9�z��l;G�����v�|����D.ǀ�t���s
����lfKl����t��ɶ
���Ŋ��?����uO��	8qE|��|)�n��u�D���tЏw�#8�t��~��fjN�}nr�Z�(4l�b��#b��aF�EQ<d���%||��M�a��{���.�c}w�i�y��6�f��V���n�h�T�R�+��!Ǔ35�I-L���Gm�w���i<DB������qp�8�F6>]SL��ҶR����E��EZ%��`;��-$�<`+G���) � �������}IZ��*sJ�*J�L�UM�����>Em4�<�J%h�����S�J�Y�
s�-` ��I4��l��������A�;t��K��9j6�MSπk��%� �d�A^��c�|�����d+��(:?������M��ԡ#db�1���WпpL���̵ېW{�����JUg�7�AX=�����y\BmP�U5/#���㡸V��xo�V#��CN�F:o��./�f����go�$��+�i�3/��Z���;�x�2	M�f=#���-�@c쨝��h��6>x>�z��e�|��B2Y`Z-\�%���z���bqxl)L���m���O�����rHE򀁻�����;�a���K��5�A�{�m��d@KSF�}�%�G6x���ޫ&�?_D%����(�,�BG��{���,OL/?���<��Z��ϑ�����m�/i.���S�-���>��:v��
1�Z!NX���x���Lk��8��z��[����>����2ػ����dL����4��)s���0�F�P�:�B�٢�`[�SJ�����e9�������W��ݗ/�<����\
4�{g�SI���o+i�9赃�g�����h+�/�Mv|�_�Mt���(�����y����kMq��d޻
ǸӈJI�qh<R٢�s����E·�i22jTC�@`+2���f}E���s�
��}d|`D�d��ӟz�®����Q����"�ձ�����7�}R�)D�O9��&��!#���e(�1�8-���
������K����B�e����_�դ�_�ͯ%~Q➥<���r������y9z8��e�i��Ðv�/ռ:v6	�/Mz
q���@���4%>M�j�;��z߽����x(+�7���*y����/��[朄��z�����g�}���U�0��`�p9B�f����M�zY�0=
�H+

�%����=�h�\ݤ�2�fA�jt�ɴ6��p�Y���FnH�17�jv?țƯQy�u*O�)�q��V
�g����^������]�,���L�dq�J�^ڌg���1��z��P9��
5E�!�tuY�5��Zi�f�h�׍�� �
�*8K\#)�I������L�`qch�;���s��7͍}�9�r�fɎz�l��JAol��h}�M%0o5T�6 @�7�-��ϵM="�D��c͊���p^q�PƖ�=AR�%�`�t�5Io���Itɫ��֌��f�eU������i��C��u�;�u/�(¾4�w�Z�
;���$�<؁����U�����(��{�m��2��ÁZ+���٢b�J՘"~�
|qE�^��E�O5�/���\!=�E}�{����f�u?q�(�c��狒�N-UKëg�Q*�௵;3FZ"��lh_1
l�hd�|��E�@<pSf�q��B\T2��5�Zj4�GG���sf��.�ӯL�p;���Jh���;�� �斃��L�&zX��]�qT�*�J���y�7п�ui�=��	�AS��j}:{��]�_k�z�ӵ:B��4�T�A�]џp	)Ӳ���pӚ�Ǌ#�qL��;��Ƶ��1�,v���������ﰮ��=�[�˼L�V`�+I���`�����{R2� A�9b�m���0H������x���K4�z	0=��xۤf���\�>��]���O�\o8.KTis���C YB1=KW�4�A�l��4ڝL��=qi���<H<G��o��D�~��2����h
������CЉ,f8����.��>)D��	�=A���m���Z���C_I�j=�vf�Q�.sG�؝&����M�gkV���V������H:<�"��`e�����X41�ڿP5K�
�
I��8v�oS�-GD#��K�ԁ#�2�x��H�����<Qȁ:�V�Vs�S�eN���X>�O0ӡ>Qj�EGM��� �$H�\@{֟�jr�Y��^`g㯛u�@���A��Qq� ���
4��zn�eDԭ��)�r�u�*��f�|���ݛ}��v�^��&�:���J���>���C޴�k)Ϸ���>.g�h������H�_����wԱ���==?D���	����K�K\�>x� .z��6�F�L��ݐeX
��!���Gdn��g1�N|iܾt����χ?�od���M�bu�U�V����Z��ƦtYe�m�@�n�1
YQ�Օ��H����E�M�F�k���)o��w)23�+z6�![�O����=,4���=����϶��)��AyIrZ��6��-w����F�
���­��|�����
`	Õ1WF��Nf{t᚜����b�{t���O�Ѽ��`�ő]WJ0l���41.p	��`�CNw�_��	d`eo3f��ﮭ�����y�Ih�RN���S�c�LQ���!c��>勅`������\��;:䶱R�ZQ�rO?棣��έ*�H�:�ߡ�uN/�k\���Q��횅�E8)鸑���)�l�bV��]���QSuFB�jRG���e�Y{�nw#��%,�_V�~.�jZg��$hJ>	�<\���RQu漱�L)���sG�m�@�T��3�Ic}_��:�Q�nd�Z��V����R wQjJݪ�)na�*oE?���weG��J���9$�����.�|{e+�[x��><,n
�A��Q�f���<�Q�����Y�`� �.�M,vA��
�Tf�o�uE9�ң6�8lZg��Ӗf71)VWP�=Y�r�B�{�9���8��eUOP�R�\��M��Kc�1Ý̗��57b��Vэ�nQr�ӫJ�lh4ϻ����óV
�W(��Fh|E�y�c�kMל-����Ս(v���[]q����;��(���
�i^�ő�z�k]mQ;��Ş���9��Lљ{�ҍ=��f�0�zD�zC5^����ޖR�����Z��m�x檔O��{���=�}�m����O=�	����f��1<�H�k���lU�=��ϼ;�p��l����҉˻w�/�u�y|%o�PȼyS�8��g�k�yj>�V������aN_v&���㷿gS \���|�\��-���݅ëx�A��鰇����kՇ��g��+O��x�@כε �)B��H�QE˚`���a��Y��1X���Ͱ�7���珞�i�2f�_�c�맅Ym�K��9�B�0F�E�g�
��|ɈB��PŔ×vU|��r����q�@(u���E��\
����ߓ��R����E�7�k	�jyRS�N�Uʬ��d�s�)��eI���MR-�@Hܩ
�<�&z�b`��1
�h8������w�$�����҃lN�T�B�0Ɉ��P��n0
�����f��P�N�%@�WM���}
W���M�{�}�ڶ���|��i��n:�+���>j��6�5
n�{tƝ8}
6�Г�}��)�@2e�^��_���q����?�q�1,C�ŏ�˲i��E<�|{�mg-���x��s��d�c�c��UeΓrE�;8p��I[�6V1�ۍ�Ҹc~�EKm�X.2Ț�g��E���I�3Og�IQK������c=�/���
�D������N�g�6HJV��Jp?�a�G��b�uųc���`!A�����9N,�GAz[�c�����DrY��/��߻�i�����V`j܁J�Q��b�,�������(�������x�F��5~Ne*\2h3O��u�]s�͒����G�f�F�״pKW#�	��i9��a@�eT׊���x�4��)M��V�?z�-v�q�%ƺ���).�w��jU�_�ʒح���o���ӗ����@�`ɨ�v�cN	;�~�#K[��@�W^c[3�h�NȔ����&�>@~��@��fJS�4��I<���٠�T�9�{.k��CVbpv�^�����.�n�ö��N�������M���#3~���#�JV���9�RN,|�=�r{�6Cd$�?řY�٨�v
�U~�PF[0o��,ز�n��� ��;�B�P���8�\�%��Id�0��~�7���f��ߡ�
�/e�]����
J��͢���8Um.˾��Ge�����b�|���R�w�x��2�����ۜ�
v�
b�M��yք��B�Q��Ʊ�|F0�mo:�t{�^�ݎSL^ݍ7�fż��$) �`5�vL#V���c���r,A��v�*���[�o�U-�Ҿ�h��uˌX�-[�A���&O ʏ�yn��`���yv�UA���^���!̯<��Iz�4�I\�]oA&1�@���7��Zs?d�9�V�}�M�Ha�t�����ѽFIM�h=�
4
�V�]	h�~����X�Tq2��`������]�����kj�*{Zp��Q{w4`�C�-���%]<J
hL���*�&�.~��&Ԗ�V	>�����fG��6�qs�n���~��vb��R�1C���Gn�%�����&�Uc:���V��.��C���Ε|V]���P0���ӱ��_��x���S`a<���Qf�S�d<�=n��Uo��NG�l��h�ޤu���OB":���~�u�\lc���l��;L�;b�>k��>����=s�5UEm�E���U%�iQ���UO���#$���ww���x88�8Г�D���C����n������R]Z&�ޮ�T!�78w<0Q�6V�OR��o�HX������5�E�EE�y���F�x-n�x�DʲW�:c.NI4��m�Xc�7�s�C��� �nN0�8��Oժ�b��+����9�X��q<�̢|�qY��z[�u/w¬�}Wp��6�O�h>�T�P��J��h\�~��,��rBY��Z���b��������Q��\�k(:c�s��P
��FKA��Zhz��g�NVU�����į	�?�R�5�]҃�YX��
;��[�ҩ�L߆N��I�5u7ui�!��hR�hv,�%UUer��*iZh�����|��s>\�"/oe�g�#>�!�{|0�)Y)��99������٤�h��|��A��|�dj�a���ń2����Z����C����U��HP
�껚"�>�(�h��1A��އ�	�_+�6	�n?�1i���&l��g-G����R��N=Ow�2�v�3$V�r�f�jyxq�Q�p��|�������:�c������U�(���	h&J�Q�1�Eϝ1i�6���]�����=z���&0e�u�� 
�
���(�}k��lQ�_�F���tzJ���s��S�-&�*��V�#~��^�(�4�Xa����}�p�W(ےG�Wɨ���f^ת#����E�q(�r\��7n�F��8b���Ө���dm��
8]�\DM�}/��V��XS���x�$��#��k�Xl:��KsR�����\5l�j��i^B�S^�S��G�s-�|F�`�k��t#��mڲ�Y�U�����4���K��c��V��}<���͔��8!tV�nl�ua���!�p��Z�mi�ҕ8��S�#ٰ��Fx҉q��wO	2x�4��t�"y�ځ�z6�PK���~Y��T�q�Y�Y���d�X�0�i���<m닚м�]����F��QN���<������%D�X����k�zN%�&�8�G�������T�c�$���k�n�tV�Nv���[v��Uژu�ԟ�$>�<�j���U3#���K�X���s���+��������3������D�n߿�+R4E�0��r���T~R������w�=��\`�����y��9%)x�NJ;
�]G6>|�^�ѤV6�<�$  U���8����mʾu���B����}%H�U^ ����)�n�&�1���P�"��W`s�!/fk��F��{Gw:��P����$�u�ơC},�9��l](,��4�_�������������5����o��m�|�#Eq�rYN�,�XյF��0-`$AvY����&�Ꮞ�~}�w�(��,�(b��yU��"ZZ�g{���r�Q�h�ͻ�nW���\�4ê����8�ߜp*c�D,P��.�tw��0�Dfg��܊����p�5�l����XP�X�e�<�t��Ʊr���ƆF�G�H�J�Xo�o��0��c��݈���q��W��Ŕ��r*�+��Slhc/�g�gͿgJ�o��p�rג��s��A~)<�Bڊ��:9��RXW�xV�Ŀ�K���b����) fu.L�����������<���FL]S"���&.��rʱ}U����5*�|GZ���֢Έy�Y�ʨM��M��k6��ߜ�GrMi
}���-t���S���.j7����[Hɩ��
��;
��������j\�b�y�5�W	�ȓH�O�)�\��"��!xK~��>�
Q���؎X�
<����d��-�wfQ�����;zꔧJ�L}*�g =�a+��u*��^���L#��)7��H�ϩ�\�:_�j:��	�	��B&���^n*���3:������H��R�2|��L�P�(^�
~�n�	���Y��+{YE�K�c�fO�66����صK�Sy_����P�������B��D�����U��Ӈ�q�C[���
��uSh�p�1<?��6�m���N�)��1��24a�n�����s%�s�"x�8��"DSa�KF����o�+"��u饶��IH��{�#l"g<b�q��_�p���[�Z6���ɛ�H��/����Ҫ
������,+��sv�j���h���ш��|)��XQ��q���3u`[�rD�r�?�S{�զ���ѯ�T�R�&��JT���}�@�{k7������Z58�����[�Ag���㝖�spYѺK�I�����kǫ8�\�A���GfZ��&�V9+pI=kUxw���a��#����6�{܃��n��[Sܜ&��:]�W<�>��c�~�p���fΏz5�~U���iZ@*2�Z��owk$vr�Jw[�/�*p�QH�Ժ�UD���R��I헃 ��(���Ea�I�I�K�K�G�W�W�W�W�[`�8������(8�m�G�ԯ�k�H���W����>�&����Ű#xfݏ�ǆʤ����=9K�L�Z�����s{���|��@���-����
V���jb���=��@]Tc�cy�M˻�y���±��tz�,e�%s��R�2"���D35�!�S��=I�
(�͏X��mЭZF
����Q�K�6(1k�t�R���L��0�6�Q+N&D�Lzm�{:�f��:Bxǃ�Ơ(a��)n����=E�7�+��H����S��hU��p�!;�v��ժ�$���M��i}��NJ�|3KE6+�#��ʾF�7t$n�U;fU���#E撍�aZ�y��}$��)�䍚����d�N�v� ȯGJ�\$8`�!�µ?WL
��D�Os�M�MoM!��l�����BM̆Jݏ�I���18���s��
�@�PL�&���4:1��U4�a�S⛦�@�8�N�^�"�K�u�Ɖ�}Lv�6�*����;ⵆ́K�$-��z���e6�C78ˡ��{>�67�����rќ_�_ө����I����6�����)ܛޘ�~啤��+��F~~0\Df�V��dy����d�~!���N
~���☀��pD
���J�8Q��]K�W��5�?�@A8�^�]j�������`�Egu~��;�)ϫ/ȓ\���3��o̘���M��`l��쯌<lݏKH���Wv�q�]��;433����]@�IO�����@uЃ���@�2�(��N�J���;���i�j+��������N�q׿Uޟ����}�guC�0�W���q�UM��f��z��Ϯ>�O���o�aT���F[.�yU|���xǦ�݌���u��os��ș圔���N�"+G�usV��E��)��M��=���`�-L9S���-�I�_����U,
3�Л�{�Ќ`-r	@�ĵ�Y�a��ٜ�v��BJƸ��2�����H�x(�T,�Ȉ��J�(�^I�ˑ�|������9iS�蛼)(⠜�
<�<�.�����ڵ���ڑ�}�����~�ԉ�[���ź	���\����0�q����7��m���9�9�}�$��\~��2�Öл[��;;�.?廃��?˒�y��r��I]����������M��� Ie1N�&���/�^ �R6m��5�J���s��J���Si���眗	
d�����0U�B�a�,/��Nd`N�ڞf��"S	p�B"�b���|1�-���W�yfEӡ垫p���+{��7���-ǈ²�2�(���[[�9���T�%�;��D+;���ڬȎdn�ӟ"f�:�R�E�r��Z@@fݢ�2"�l/!>1Z� ����~��3�,g	q�xk��T�Fg�ڟ�62p.�%�F�v`"Я�ழ>0bt�3�P����^,�4)�.Ϙ%6x�����ʠ�=ܧ�P��ҮjH��U�v�Ws�/��vojL^������P�_NK�r6�ު���&~t��=�=!���7�L�k����}֞���7(O^/c�����Zh�,.Q����-Ϩ�Vv��1M{�z��ɒ/��J_��Y����=�A�}�h����w�\A٧�JznT�*A�.Nw\��-m���y�/[�V8&�����1
~^ڿ�F}")��r�B�{���hJ�$DC��`W�/��a�t�T�az\?�r�*�o,n}�%:]-���p T���`�V���~��9�mqH�y�9�$�P�2�͒�_+�p���.� �Y �.�Yu3���c�K��xYi�J�rՌldT�tt�u����H�ȞTg��E����9#_�Z1Mad+��
�[��:Y����ȉ���M�E��t���S�S��9Y#�_^J�O�IE����b�stqu��>FNDn	�tlsk%*�<{l�w�X�q�h{���ICN�U_|�x��*�s�s���H�>F$?�T�Y�9+����L��
���ۜD���F+���7�/���n]Wgss-�Ea^aZ=1��rKj*Yk��"N91aFQK<sX�48JJ�n�H�H�ґq�����$�<ߵ$����qv���B�������\������p�y�iY��1_ ?	�;f�_�"5fP�ѣj�RNL�_�Xy���JɈ��� ~H�,�q=!��U.�TB���� ?�vb��	I�a{q%���wB�s�ӆ0�EV�]����X*�lWt`��.��k���^C2jNa�҆hYA�@j�6q�91jFi鰮;��+��X+�b��*�[��� �-%pY�5/�L?�+23���d���J;��q5RE��%?pX�4�!6]�:�$�#
�+@T�6�7�B��M�9��\���ڛŌ��]����j���SC�w�ۙ�a����aQCm�RQ�E}��^&rƹKR�g�\ء۬w���v.��d�!{��]�k��Մ��,�G�UƼ��W�����
{_S���΅��X=߮��)B	�8ة�|���N�n������|�/�����@�b#aJ�sRӷ�4oc�����������H�+m�U����<�6����*�D����7��)\M��A��*z�z2	�T�Q�`��P�cS�Anb��u�⎽�!�ImX��R�`q��µ�fn�?��T\*��
��:�8J�:Q��xF�D�>�Êt���\�[_31}u����#J��S���fV �F��f�6��S߰�fLH{���{�,�n�}\L���4���7]���\ �s7 ;uY�+hzp@XO\?@��Ķ�����舃�ިA]W���֏�q����s�)*���=19�{�[����i�k)�n����(�0���=cw��=
P��$[���ĉ�]�[���3�x���š����<ѵM�00�/}A@�od� �5v}��U)�p��u�A���
���l�:�:��CcT�.�m��f�)z,������D�&RR���*��N���h��5��~�8�̥�r���T�]�q�v�Wx1m*����K�V������AE�����1{��4��m��#���v�WoQxqt�u�J���u��SG������l��GCL��fB�N���e�k8w�����A�f�}e�q�AǤ?
2DQk�f�ƣ�J�I����*QJ�w�=Հ�(�%�2V�?H9�i� <9���$�"i����\�٣��z�+����ud�_-���=E<�QZ�[��d�o��T��������L;�T�Ƞ������+g�?��0�=�z��
g��c�抯Yc��Į�ϼb�h��]id1����2�2��A�<�m׻�c�C��A����皯MY��2��������<�B~�yc�-��Z^D�N���DlAd��Kx@�cj��%��
��|�i:h/����֤�#��0��,O�-�C
��A�����K����������2u�z��2��.t��B0tڮ][�˞]����
�ZKT�O���8�����k6���R�����M w~��J=.N��{�E!�ee!5�-!5m�!U-����^�{umE!��~T�K;���W������e���/��Q�����������p�U�E%!e��u!U����RRR�ޥ^Y����#TCZZ����1�*�A���Xw�ۂ�?���wW�B(���A��I�������Ӓ�C�נ��#�؍!N3��$`ea!G�J���O���;�-���%����m�=��KYW\
�������[l����q��tK0�u�E����\���N��)���tV^��/8?~k�5T��H#5a��a��4׊[��Vm���w����g�v���a��fY�[ݳ
��~�V���}�M6�mGz�̘چYNާlPp�%�l#x0�����+���Mo�-�� ���;l����<H#�%-oB^�5�����$���ߑ�U��["bz.Z��;�g�Ȩk�,S�T�2���.���&<��a_��Hd� �������;�	&+���BgR-S�W�7�^���#��0u���_7NM�{`����*� Çt+�Bny7B��[�9 ��Q��XE���h�h���,�
,=]
�"Yb[��:����ð�mU���U�+��=��iE�-��xw��v�$�!��ۖ$����fY[�p��=�֢Z=��o�9Z��f������7����k��
��w�sΓ�~~�@�E�m��CrC�C	q�HȹG�����W���%�,X9���
�
�e�⛐tff#�����d�+�"�A����"7a��x�%,g�%�q�w7�O7>_�0bLg�_��|.�wb�b&	�b�s��8�S�[�����&�x>�,>U��2��:���On>�~�~�@�8ýh�h�hD���}�M|���6�k��9���N~sn���z��$:Or����4��b�2D�"ji
:�U���O�_YڰQ�Vk��r8��%��:�hK��!�l0<��������� j�,���8���2�hq���/�AP�ഩ��?�\����:�h��i����25f�^S�
 �X/�Br=���l��%tX<�>��&�1`?�X/!�hj�T�K�)ʠ֢�໗�����$����En�=�%�OTeց���.���Дb�(�� �4�mC�LQ�{2K_J�[�����VA��H�.��s��s©Ό�Vb6O�@��������2�P?}��%��?;��n�k\Uw-ѳhk���$����]�j��.���Q�x�dU�����4�������G1y�ѨG_B�Ps��	#C����\����<=����sJB�A	_�� �z_�K�� �k[g��.�*���b��\������;˓˭˘�W��U������h�h��U��L��6�� ����&Zp`�����Y�vB�q�+�qL�KiJ3�Д�]|OLEmKwԟ���XU�ȶ|�k<���E�,bZ���>�Zp|������7�k��v8���� ޟ�&񪱲�h�6�q�m,��Y_;&�����n(���1��\�
�mrb	�*���p���3�i�8��OA��	�W�(�x�\���E7�i2���JJ��[:��8�������ؔ�儕�����E�f��9|�SZ&�8L�D�� R�Zr�����U�8\�����O�1 R@��+�����9���>��y�d-��-�W���5Ƅ狋���ɑ��T���՘|��c
��EVFO���J6�!���A�3A��5����ekc�I%0��� �S�bXq�G�����]w��J�G��	�Sz��#F�^�� n�����^��K�ì��c#&��LC�oN�g���ѥP�KH�L�(��
C�^���E@�^�v5f�}[�N���pK�	�<٘,�
3ٳ礛��a��2*�C���g��Dn*��RlM�%Z�Y��-��g0�ȗ^�,ۊY���B��2�������߇C����S�Uxy3�~4����,���,��"�<�[�Y���:�ޚ�|���g��C^-%<w�O�dE�Gw� ~�#(�p�C(�P�7Bkh�)��g�Ŋ)\�[�Y�p�P��7�|J��Y�i��$�F+_#2	8�
�fC�fG3���sm��@j�����y��Y��g"����������Ex�p��%�%�%L:GY���n
5���yх������r�=Jk���c;[�.;V�����:VU<N���^�DJ濠��Tt�e�y?����6Xa|�uֹi�
���)�\�K�,��/%S
����H�%:�@{����M.��Y�P������Ģ�����F���Uߑ��9Ёv��m�䥲�!�!�!
�]cj��z���1RY�XX�u�����]���>�l��y�ф�8�gg�Ȭ��p��F����D�L�b�f��^Ê񕸦���G�ɓ.w�x>�@|�}.�t3�F�QrM�M�M�C�:\��뀀0s7{�0wH`g�!����і�\�%�2%�
�K���%��i��A$1���_�Mh�ϣE��F��\��ꭋ��v���آ����Ό��vD���ȿ}|"F����
|F2��{O{3%����s�þiٸ�`�a�*�vH]x�9l��(ï�e��
c+*J��ys)F�r��U�ݭ�谧��l!0�OEr�,�e`ȭ?K�3�*6FƖ(��f���c_{єh0Fu!�E4�j����#N���K�+7@=q(4y>#��$�/p�uDoϲ#1�&�?W��E5�
������N��c��u��`C��%�H��Z�y���"�?�vnsXV�+��.�@{��� /K2��l�Yy�xBcd1���a�y��È�N� =�&�b�0[K�,�A��I�{�o<9�J�x!ľ<����0]���u��M���`�j�$���O��+(2a>�)x#i4�(h�2�0D.����aC�(�9�㐪䋨Bc[�s���{#�	|_�v��/Pu��^�c40���[�������Cۂe,&�U0؞��ε�c�X��~Ga�o8���SFTJt����U��Y��jӍ[6
~	Db*w���[
�A�U�g��$�bH�d\i:��3�y�v��͔ΕՂ���~��V�(�o;j]�K���,��Z�\�s|���)W�"�u�\�������j0Q�/Fץ$���V�Ubu�#R����]337B�qa/�ocj~�<PRlЅ�G"Ӯ�p�gC�7K�Zˎ��	yɖ����������9�6h�Ps?AV`�L����$2�?~���0dY�� ����5UP���>��J"��:.S6}$�^Y�@)�CAm���3�d���G%�יJC�z�HpȽ+�󤮵!�U���A��=Y�
�jͮ�sR��9TDf������F��M�q���
�;�=b-�-�#�;o�6�%k���9Qz+���d��^��
�P�uK,��.������4���)#jH���s�Ҧ묩�{�����G�n�w���D|u��@�F���a����o�/�xdiO�*�ٝEVx�=-�i�����W��=��,�FWc�
�N�&���w5i�S�s����I�ĩ� @� �`��EAԾ�t�7R<b�E�!��D�BP�YЬ�B������R�gVn,6�7��"�N
b�5���~��Ra�z �An�WS~��UE�Ō����x�h@��B9F�*���Y���刌V���M�{�n
é���!!�4q�>�����P�i���� ���#����MB�e�ܻ{��Y���L����@�s�ă������"���c<L�Ǚ
��Ⱥ4k�Gڸ����p{�M�V3;�J+o�nS���DIt)~7�f:?�s7O��}	X	^a�M	xY��`�j�?S�s���:FMr�q�r�r�r�i�H��<m]E4?KNh��-m�Y����?��blأ�ɲ���U���e[%�[["�a���f�_���hQП�O�D�	]ݤ��O=Ex���j�EQ��5,0��0���H������Y����@٬��Y�����2/@+��gF,
��Yh�wݭP~��
�sP�Y��}?����P���������PE�f����PN��A�H�t���d�I�ua�
,4��!<2L�D̽��D`z��Ꭵ�o�f�ގ�i@c�
�7�9)��f�\�vʾ�{�5�:�0��G����1���n�۾B�^�ɕq�f���������>���yH��-Uz��Q�ȸTx��;SKOvhDr��@1bE��XS�O"x��NN�Mm�{9��0/en�X+|:����z�Yw9C|Q�d��&��7�1��:#�S��h4�4z�-(p
3�%.|
˒Z<�C� F��q2��ka�d��)uj� �m(���etr��+x�$�b��4#3~��o���BH��bf�cU9I���Q�v�b��*Ī�ڋlܛ�������`�o��L ���M�<e��
m�ԃ:)�X��@�Y����G�d|�8���~j*�z��M�Ѓ�v�&,)<줥㖀?���J�SN���{�
{W�^� ��J���s6{Zм�M��۔��lsX���-��(1�o�Qql���uh�˷��0"٘xs�72K�|�M�7����S�i1n�YX�6��N�kU���"B�t1{��I����qW���{!��5X��yU*�(q��#��/��Վ8Q՚���KAg��dZ򊔸�^���Kb��~g�UA%y0M���"*yϾ�
h�N�?�%gQ��
ڳ�)Ewn�ɓs�R6Ѓ�p7���Qn��~{ivp����������[4��Z���F�n�;h�i%5��7�џ�_SI/���;R����y��zX2�����-��1ڬ�����׎)�2ل�L�F���j�?��L���H�Ͳ�dI��4Fޠ�푼4EoD���<ˑ�9#d���?X;P��z\H�C�~HvH�M�6o26�:�2�y;|�
Ú�����p���LwU��6T�����9�D��#WX׵o��f*pg$�R���3Pl��v�������l�E��L��v��=�Bj��h��xE�vݕr��ju����Ǜ,<�Eʽ�׹�Ȕq�	�vθ�^A�Yţ>~!t��k���qUJİܯiKx���=��5�M��Q������ Iҕ�k믬4�(��3��-xo,�:��wv"A�^^����W�=z�:�ڝ��hd��e �0����k�ZA��RAH�2P�>T�����hh=d�	V5���O)X�^�}�N�\ϔ:B�_d�}�A̷��F�i��v�2}��z�M	h����z�2 ���N\�~m^������s$/,�i�t�R+���v`U��Zc���X^��45]*�J�_���~B��Rk
��3ۃ��7f�JwV
�M3�j�W��������!R�
�������hjX��;�Wb8���(`C[����U�Sz�������U��dW��Z(����p�������k-�`R�	�wJ�nϦg�1m\�$�T����qIu���q�$z�E���T��%$�I�d��Oy��y���4z�v���񳫽9L#�E�(�_E�C�9��̓U���7�D��8I@��/ؽ��N�?����ApQw+qO"�Ѱ�[�Ʒ�yݿ8�L,`����B��|)7���(\+�����g4�2$��Ur�j����Y�e�"p�~z���{��z��{���휊�0��A�Ē�á��ژ���c�Z��g���Qk�q��C�"�P�Z�Ċ^�R��������#3��GwupG��ʸ�^jS�(l,����Ze+>U�
�����ײ
�%������[�<�>���FS��F{h�34Qy��L�}��$������f��Ih���� �;�9���b���_�m��% Kc>܃��Qm?;,}Hb�>���	���j�oE�ql���Zc�b<�c���\*�jR�������/�ж~�3��?"G��~���
>�쉊C���传�.�����-�z[�`�Y��lɭY���ď^m]lHn\�k�ӽ�����A��tLLt�?F�w���8)�!��!�;�Ǜ��d��>h)ᾶ
�JR�YS;�zRk~M�_�b�Fo�%�_%Fd���4Hn��%�~�۔i=Hd#=���!�R��àkz�(�E������=A-Z�}�������xI��
�JB�f�ce���_�i���
�V���s�&Su����m�.�C,v��,�(�w��iH��+eƔ�@{�z����T����:��J쏤��ܣV9���޺��ܽZ_5f�;n��}�3���
�z1��g|�V|�q�*�GW���<��;�&�$�gUl��uPH�_��H]�XƉ|J�1h�&��6��"�ܚ�]�Ĵ��Α�?�w~�W������>�:w����ϱ[� �^8�\�0
b��^�.ɰy2I�s߱���V9�\�ƪs��7�s}�^�a�3���~�Z�(|��0V�<�۲�a�
����D��4M!��_�C��^-7�r�-c��A��vs|)(;&9B�m��|��x�#|�f-�{��p闯�Dń�Dq�uA$Js�-���D��4�9�Wg�h?�y���w1��58��2eccda\@� �F9�E�[N[THy�]����|O�+}#�<��n�<0A_/8�b/x܌�T�u�F4��/xS9`�%��� ��4`B!��z�{��%���T�r������3���?CȽ<���"ͫ�~p�4�T(�D�p���W���.��E
���M]qX�o�nv�z��d��j������#�=��9
}��NYY�|���|�%���{�Z��l��<���
�T�
��ݲ/+�������Jx�x�f����pރ��6-�����ȅ��������[xt2��y�*3Qs�ɱC��xX��K�߄4��j�K<��"6m�w�+��a(����_�]�d{����j���R�$�#r��x�T�#=�O��l:#��$��x덡�Cу�}��^�
.�*߮����;�`"��e��+�D�(��.7}��)C�sS
��5���P�|+��]�;.�3�k�Y1��<���c��)3� ��Oz2�,x��
{���SS<P���0z|�޺�J&�,��*ׅ2��+<�v�&���]������Il��R�3��Jw���fP��ţ���U�zӅr��8y1jK4��v�K�ie��x2�eFq�p	���E�Qߪ/��>�����{�e��P,�����C�����О������8�eRz1�sđɅ���K��^�J.�N�ߢ�i
G�s�1�8Sg[X�3���J�Zf�i�>�{��3	k���n�Ze����
�	H�Q2��`�"g�������";�X�׌�)�ۂ�r>/���z��e���ò�+����ߌ��o|fػ�lҍ�ݧ1�������jn�Յ�y	��Hk�_�nv���)U��9f-x�i��i��$c̡m��"[Hᴧy�%�2�h�,H�Ҳ����[�C�^c1C������x���3����ʩE`��S��s��@p�2�ne�@ϑe�)V٦Xp��uA��Ál���nz�e�$ʍ��r��O����9dH�S�r�ǫP�؉o\�4��&��+�Ƴ���� !$���C��I�}������`����E����|�����>�!���ʙ+����"�U�����pO:�Yz���K��v�!�L#.��1�H��>,��H�n���e]��V��=����:P��X{_���!����$����[�*F���R�u�XcFw�G�_��i{�~RK�?~���8pL&w�)�5�����q��M�Y�#���ɛ��q(�J$�q����@*�
�ؖZm�V��G�k���+W,�^浬��ƌ���������2�	D���	�
��$�D�`Ȃ��:���nį�^᮴/�m�4/��~ĜG��yd��al�x�7�L��@�C��p+�L�cS���cS�wV}�������zcBO����Y��N�=	�t(p����7<3�hc���vE�A�>|K�3)�W�oh�W��h
��]F�{xb?1d,(*�[����dVCo��+0+J�r#���j~��A75E~	` E����I�� �md��+��?%�e:^s#�,��D��A�tm���ѵ�J��:�mC��`G�bOﲻ�4��H�ꛈ�7a�+٘��`�z�.�Jx��r{6�J���&,��(<�/�!��&��?������l�a�5��U�1�h��?. j�$�2��,�g,�Aw"���M�dGG ݼ"����l���#W2�$�uAj�A:����!�m�}-�A@|�/&F�U�j�{�P�n>��+���4��|�)�$�Ԉ$���
ko�����
r���8�&"4u���l�@#ц}�dĬ�-z�S]�v�D����#��_b�N���&b�P�V���"�d��{k��FpC�5kp�T4(��G�hlN��L�ѱ
���la���������n�u�\�l&cyC6��C15x�{d0:
��V��9�h�����B�c���	"��p���]�V�?YA[C�%�ù�bV�]�5?�`o$�p��	jC(���{��Ǭ:�~�u���5m��3,�
����ԕu�d���������)کx���y���i�.���Գ�ǆ���mprn��/�����y���e\<I�Iل���K
K�����ե�r0��������KZ���oG���~?��就��۩���]v���)Z��[z3�R�#���(���c�,@��)�c/ID����&>~�"�����b�]ވ)����|r���rK���w��]{����#��*�V@j���\�U��z�|g�4$���դC�����ݩ����%�|z������X�SV���(���BY�u��F��;�^�.��j�?|��x>�~5�G�6���Q�z�Y,N�R&��-�Iw|��u?v��uv���3�y��q��~KrOaߓ�K���)�;��j������jpS6y�S�w�C�s� ���ʹ�~���z������o�4H%��3A�����p��?�0�Ђ+��J1���_��)���-]��MW!A��ɨwE��Z\��������CFl�#k!��37<��,u~���������69��A���e��MmK��/!�x���4��k$������Ӕ�����j�Ο��Ӧ>���>3�����@g�@|��¸i�̢5Lӵ5ײ��\�)׺^� ��{
�
������BM�D�(��jz
��F��Lg�7ݯ�W_���-%����G34$�E2��)�4�l��a3�@��/�}g�Pە�m�)��r�n�/�\���d&�c�*�e�9��m+��M�}6"�5MlΜ�����
����L�re�K�2vi;�b�G�c.�/�;\��*:�Δ�A9⒦�N�y_(�`\��l�6|��R��$Y6N�|�x��(�No�|��4�E���ݴ7���¬I_:v��CE�?�(��i�(�B-aa��e���zv��̢�e+�O���p�o�kte��*7s�s2ǡo!��#�$�s �i��(�O�u�*��_g2k/���f����j7PJuX�����h�Q�S�DN�R�)�a�o�yϠ�A�0}>��n��a�E�<aO2�QC-(�L/o����O�{���p"���JA�N"<�{ml�����%ӷ3�6UO;�W��ρY*&�!xo�?F�(1_�"P  �3�O_פ~s��۴�����oc��2�ٚ4���lH2�Y}[���JLF7��r�=s�/>�VT�V��](}B�Li�R���M��P$��vn&�T6+�Y�
^�,����/�7qoE�|�Q�&��Ǥ�.�G<Y(��m&_vg�$��<�`��Y���]�#y�נ㤄��
 w��v_����M���?/�A�SQ}$/VU���V�"������| ��T�och-)��Ȧ�fRQ�xC�v+�������oA�b�rc��M�c�bUP:�Zg;$Js�o�;$(�w�����c�����B���X@�/f���M74EJR���z��
�`��f�K�>�	�Q���J����t>H��A�
�	�ʆ�,�QZ��9��+��h照���XP~k�����v0L�!����=R�v^0�~�!����E׮�
�*��J���Z��{�T�w�*���oN
�e��c�NL�xJj��<j��e5���N@S�4%=�4Y�r�e�*ܨS��
�:�$�
�g{�h��2ygb�ъ�K �������-9���5F����晳f�qgyo��-�\���v]�������m���:\q�����P�zy|�I��yp��w�U6ڋ�t�.�cD�Ef�ӿ�~/aw3	�NV
��G�j/ǐ���N�m��oa���>��f�2��(��6�R�����SOD M�ZN��Y6�����^bx�a5��D>^��*��4�(������,&�b��wi�+G�9������/ĉᗀ>��hKbmo�qT*��G�2U�L�:�V��� �(�e|�<qQ�4��[�ug���#�S��:0�fY1薎���Y��B�%�R��%�6s��)��Z��HA��G>c����l$�]-�����i�\2��j�8T��8�8�%?���+#�
���<Q��x)s�̽�|,.0���U�c����~h]��g:"�V��B�4�r���ꌷ�T���#��\��X���׹1����nݻ
t.  �I���5�ǣ0�[VM�nZ�Cfu��!v!��&N�N�L?]�
#
>_УA�-nd�D_��8��|.��2���N0�r���2u��;�f��6ŭ^��:���|9�8���*���C���9!�7��&.����;�"�J/���yH�u����x��}�N��H#䕣�.�:�VŚ!���\�Ұ�(���L�&[H1Nc<�b� �,��*1 ��2<�8�P=р��)(l���a��>}�a�B�
��ݎ�����ƫPl�
.�Q�2Z��q^���MR����.��f��R@��SK�\K�3	�q[��nP����@y�ތ_\e���J*u[L_s�q@�+����%U��U�/�?:�(�=oaR0�^���ڢHϘR��]� ��8�d$
��6�cr&`�;���U��TJ��ee�e�c���9#3���@��&�Z��Z��
���0���ʴP.8�ִ�I�DR�3�x�y�I,Sߧ�����}�W�L�����#��YT}�M-��h����#Y<�r�eI�,�A���]�Ԯm�>�q� t����J����//aG#����=;�F������v�U����xu�G�I1���u!����N�:fP{ӿ����(s<�
����Y=
AОqau�8<m}�fd<�j���+)���6��ִ~�֑��縃D�B����C��r��
�p�i�����F��܍	�z�ʻ�4�U�Q¦4J��訫�2�i�n���d��m��<Y��D�8���{q�|�܅�.�i���J�����j�D�K���후,�Z�ٺ<�&v��xWp��a.�X���u6��;�h���\�G�>���y��Ğd
��5Jf�� ��0����J���3\;���e�|0Ȕ��� �U8|l[)I�ى�Ry���i!mrZ��^��en�	��O��m�Ie��{T�iФ�a��^D:�!�w	���#>C�*U�t�o�yx���D���C�0�����,_ZzBSd���)�<ӭ���@��
�59ڃ4��T~P����hG\���L����J
��:X2k�>Jە��2�2��n�|��b_�6E\_��]�K%&AT��عpo�kD�	��)�g���B��y�S�t;�������	�qi�O�q�(�(5HIJ��}�Ӂ��C�Π,�@{_l��l~��V�����mz��☿���<��i�C����G��&t�c#c�uW�y�껊�q\qX:{�׫��A��ä!kT���8��MԔ�V=^\j���jL���{ȋv��&�y�T�xo�r����	4W
����%=^���e�A�
��萖�Ŗ9���w�/��;������7� ���rh���3;io�=�����>�Ҷb]a�ilSc���w�8\��q���^��u}�I�Ji���z�T�-��"���_�� �<�J����������r�3J�H�Q�7�Đ]�gΤ!&2-E<Zܚ���7"Ɔ7��RR�wҗ��}��rM<w��l��?�E,t�#�Ց��S����pY���`-�p�E0aoVϮh���)�L�I�b��j7���8�bfR�C.a15{�]�o ��β8yv9��N�䙃,ފ�{��i02��cu5Z�yP��˫�������2�%Q��?�n,Q��+��C+���%��"6T�:�|�&���I���ɒ>�c���Kpl2/�q��4	���S��g�YM���rj~�4�`��uF�0m)��s��kBPq�SB�È��h~�&n���̓�
���b�q�nm��\p�U3r�m�c��zMK0��
��rM_��&֏GC������N�|����ƃƺAqh@�&FT�4��y�R;�������)�L��V�ȇʳ#�	�Xe(���c�7&mâڔآޕݠ��B"�U�4�/,�_ӯ�	�p%��_G��%T\`�ev���m�b�G
�ʡ��%_"_M��i�b�̈́��Aq1~�e�/f+KIFp�[�oAlIfl�]�?�&)�׿��7�C�+�4���u�mH\����a��Y
���^]Y�s-�uI���/�ԋ�-u�]]Y��8�q�{Y��ĳ2�Ⱦ�<�`̀V$�C}���R9P��I?&�����3�{�4qj�H��V������	��v�˃�5	�L��K�4>*cHZ(��fy
-
�GE��jz_%��ӥU@F�RN�-ڝ7Fs�����D�8��?��f-O��M(tQ7o�[���7��s�V��#�Ьȃ�$���yqvh�fI�n��˘\��U3t�1
g̪١�Yf���B��������-��T���U�~���țU��GM�����T���s��_|�Oz�G��8�x7J�j3pK�Ez5��ɜ����X
�0�����4�r �=�K�����|�l
u4f�)�5U��dz��O:�w�O�%����H��a��թ�|��̯��ibD�W��ϼ�:�=�h��(s��5\�Ѭ�-i�Y��wF���U���W�]��2�-��̇�lm�@���Ė���a�a�8U|�Ei�z
��j��.��ױ���U+E{��.t��h/�S9��+����D`�N��b�)�������+m��)�p�.\�6���߭�n����kG�[�������k��9~�ۍ��K������8��Y�V�_�Ć�+=2W43/��i����#[:���]c��ٗ�Ve�p�������9��_�c�&�#A�K�*�"6� �=y��` ��k�?ze�ݡ���X�i�8�� ��2A5��0�	�K[ѽ�G�&��\֧tX�r8{Hr��Ż�(
�C�卮�+1���߹�b	[�ՙ�^e���L1�o��^����!꺵$�i�V{�JO�)�CxѺ�!�/����7`9�;(�eޢyi���������F�J��{��i�r؎�U���u:�N���\�Ƌ�3���FE饺2%��e�҆:��uw�mG3N�V����A��7e��W�t���y)m�m�S���/�tr�X�H"*��(�-�1�qF�h�ﾆ
���K��4�!��:�ŝ0R��a���5�-i��8�"W���V��|g���m���Z����8U�s�!�3�χ�>��>�vc6����+�1�nt��0��ޏ�S;\g{^F���1��#���Ґ�+��w3���W�O�lK!x�9K0����j�R<hK���+K~�0��T3�t��?�/j����y[
��H9O��\�.K�y���u]���Km躵�T�����68�2�H��O`�1p�#�=x��Ow���,6�}�i��֣딢����Q��Fm��_ZQ`��	��U��e�7	7���B�5��dH*B�&nZQ�*���t=�?�C�W66����32��8
��C/��X"#0��\(7������U�t�5��f�r�dܤ��=@�g�<=�g)�����K=_h��&��
䵑�t^���"�0��U�Ɋ�_���Xa
3Ќ
c�AG�Z��/�{A@>d_��d��w%go�!ek��kY�8~�<���74�|�
�T�����0�����h��Q®�iFV��n:������{-�G@�S���7�spsl�/f��k��97�S��fAG�+x^m��(����h�X�������"(��:���+�3� �jU��DD�R�?@��C�f��L�k���I��D�ͺ$����M�HA���8g�]�-}1i����%8ESq�*qMR�$��d�BI�[y�%UX�C�h�㖉d@��>@��W%��C�t����K�d�fvOf�v�$���M�&�x>��ڐ-�>����6�g-�{�?&<��
��ĤΒ3 �[v�#\1�_�����򦀍��ܤ�k2#�F-�o��F$�(�v��yg�d����=�]��s�:��6����Q���߹M��o�>W�8��(W��p��m�m��(����������hw*05�ki}L\��c�S�_������Xv��xl
���Kf�m��m�a�����u{nA0��<p�;-�>���B�>�o묗m�n�
C=W/�69#��S��>z��X�G�y]$�:Y�:�횝��F��E�*��A��qa��p��[$q�佚1iW������\}���>v^[��-�r��a�U��k`��9����l��]VB@�bIi��QM��c?��p)�_��Hj��S��Tz�UC&,9�{��[��P������V0�����ֿ���8����	9����<.BVqp�%Yؠ�w|��q�}�(ގt����������>�
BI���1�0m\W�7R���Lm8��Rg�K�W�qC�T��K�ȕo{tb�S�$pt��q�o�cu��6̰S�
�
�\�ø����*�1��$�k�B�e3�BӦ@A�<�_^Tμm`��Iu[ܙ��r�mL�w�w��
�l��8�}����F⎒6�[���֝"C�tL�:�
�#�J�Qf����,���H#�����)�p��"�CP���M��~ܞ�fK��WE������;��W����O�ZU��󹠀*GUBY4����)o����o�!/R��v}���zˢ��#��&�-Z�Ɜ���8�to!��z�8�,5`	X&ƶo�㷳�,�	x�:	�E�L�}�I��>�2�/��gl��&�Eߢ�rc���յ"��~�W06��V�Td�۷��,�5NG�O?վv�h�8��i�Djox�h��J|	��U8LA�]S`�M=$�w�[sL��4�x>��a5u�z�kQ�o����D����:��k�]����&{��j�l`���a��Z1����;h����j���gpٟS���[��L�*���r��(�"xɏx��-�a�|�I�U��X��j�4���CtQ]��E�Gy
h˾]�bߚ(���j���sʷ�Q��%�!���=]�&\k҅�����ȧ�}��i�l�*\W��p��W��ʈ�w�9�D��!#Ʒ�h��n��@�8^���6�ъE@�`%}�tץu�t���d�z�c��9(�7Z³��$���u_�,�?�wh�B��`�}���
�>����r�u�G�U�0�TO�D��T�dl�:��2��F�lg-Y�W��Nn(���,4R@,r��%���q.�L����K�
Yj����&ĳ����Ea귝ͫ�8�	m�$���M��-B����E�RnqN��.��z�v�	$����;�o���BJS��������z����2΋z���z�K�n�~�����P�Jh�x5�� �]6�ʎTȰ�h�/~����|���%���n�b�����FzyU��U�?��Xk��.Z����Y�X���;��\bI�����T8Tn��^%��K���;Ռ�Ռ�Uό�Ռ�-�Ռ�|�����y�N��B��̯pɧ뵠d����>���U��nB۷Z��;$%"��h�,�k6��̅�҉�[����J �
\_j���.����fjp����N�i���Z-�wd�ظ��dx̸�ؙV�(��ï}���I����;���ɚ���=;դ�=8��z��oɒ$i��|q�{�ɛ,�b����6
���6$W]��r�y��a|���;Jet�!cM��4Υl/+H�0���i���<���*��WV�����H�f*��-�Z^�Cڮ��Nu���4mH��mLX���hn��7�u��
�!�(���0:�Wj�2OE0z
�G|�q/i&�7�������<}���i��jֶI�Z���X0_�;ޟR�8y��������B,�&0!#�1̱&����,�.�IwI�D��K[�>@4a��NFt9�s���4�&M�Ɲ�����4��"e+���׆�&�퓤��"���`��m��+��M0^�����,������ $�q�e[���]
4�c1�_�"�� T\o��=�ߢ1?"�!������ǲ�a��h�t��6h��:����a��#�$#
��{�ˢ���_&`&aN%�!�&S�U��
$�EG*�K{=�]5VGO�@,���c�����/�G�~/Tn��?�=�w>�-�4�����6c�ɮ���+_>}>{^0�93K�M�)�:,:D���L�Vi~��^8tl~+"XN��
>��ap���&#��!~#3��.V�!0��&*?�"�%3�/_ ހ�>5-Noei ��$e	,�F"���� �?E�ڛ!���nQ�^Q���_BM;*O���u��Z"X"y�����!�m�_�����;V S t��*�?�;)�����,);+�gߞb��@]8�?�S�N*�6cl�	Ng��\�Q���f�g��B2���b��&�_���Ϸ���{Jθ1��1��;�����cx0h�1ga%�[{������ާ�~;�GkV�I?�x3W1�!8��^!"��V[ �"�n�"�Y"��XL"T U v4��s"s!Mꖍ#`�d��&,�7!�?�b0�]0�?�!A?)�6�l�	Ng���MC> 8j"�_q6:$k�����p/�W% ���H�o֐�|�>���GNB��P�����|��|��|�|%��g��w��c�szgW�o�����S�]F���!٩���~���
ߵ
�6�4`Ǫ���h���T�J	���m�[6{��	���<��4�_�?�/�0�/�g�aY���d��?f_f��^G�T
���Db4��O���|R��민����Xa�=�ɀ�r@��O�8OŢ�a��T����������*6ѢK{OFv��:5	,*�*\*��#�Л��e�]�@���!��*�OR�%CO
Oi���۟���l�F��,�DWA%w�	��6j��5r�w؎\�u���
CFqU�6�	��:�r0�Q:;�Цm��?W=���pDHu�ޕ�%�K3���Sޙp/cw�^��)�:X�.�y����$�2/��*�@��~a�1B��l�����.O�/�yR+���lQ�4C^T$�JF��\^(@��q�*�"��½7�2K>�*��*��\o�,\5�A�����n>FkK-r���"�"�h�}v�Lz���L������sА���^���Y��rq��G�OϑO6D�Bn�V�
f��%�n����-l���$}])ކ���_=i0�Pb���m	b�X%�OʄO�g:�L:jj��X:9�;>�����!�
�6���I���7���ֆʼ>���g!��(E�>�USb�:��(f=�~W���5�6�����,3�&3�֙Z#~@f~��{���+�,p���y ~�Շ~�������Jㇻʀ�E�P���
��p��xo$��o�7Bo�mC0��"Q!�ж( �<db�\�V�m�Po5���nE�Gj�-SJ����喱�*p"
�+���W�������2c�gQ&1�zy�g�I��*q|��~=+R]�`��ʶчozT���Q!<�e��zl���ـ��!\�=��:���,��s����mFF��| ���`�%Dۨ��5�a����9\謧s�Gt���4��$jK�Qɬj��UiT���.֮���<����?s%����Y��D�R�A��T��D���RI�q:��k8�R�;��ڝ�U�K�ț����\N��YK��B��Œ���"�o�ę<�:~��q[>�z�@�R?y��3���8�D�K�q�+Dzkޏ4�f^D������$�e[E���\#���8��z���JC�S4 G�޿�c���{+�}��Vg��7���$��]�������6EY�@DQjD^�	��{�B��@�	��%t�3�M��nޫbHN)�Y��Q-�E��~��;>�E@��Q<F��8*P�<U�y|��ф��w�р�v��Ԫ���~��䖀���.hIƄC�9��c��`؏6vtţ�_�|��7���;�eb%N{F}����VI/a3���gg��c�e�jY���\6�*�ngњ��9���S��%�j�g�	kD����G��N��G�O_��;�7�}�轨�I<O�}Շ4V��߉(��V�`���T|r���yg�;#<�;�̷?�Xü��8{#�	�E�9�X��j�xbI���𶯢����ۯۿ���c:��Փ�����ϔ�s�С�	}������\>�u(ԛsj��<_�jl^6����5�����Eქ�uQ�*�Ck7���u�����3�~����e�n��j�A���r�{�
Z��x0�%�������]���yw��p$��
��<T�����x�3�k,Y�3i�b�ү/>~�7W����	�d�R>nz�&���ֹdo����G�,�ČF\m�0�R��Zjn��DԲ_(}_oi����QG_��(�*��$����:B�M�C�?%$L���Ҟ!�܉��6���jp�n�Nk��?����F���n�7
�Q�Bt�g��X��]�>;@��n�������ם����ߔS����"��^:MHH�x2W��TA)a������^���s9��[��Cɰ*P��cZE*����K�f�Qi�ؔp�򞯜�P�5��@Rd-[zA歇R�1��f.�uY�n��{Aԅ�u��M���L��)^�~AvE�ަE)��V~NxI���>&^����z
�~��+���:l�Vy�-,^m[{��Q��%�D�ewu!�����Hd�U�LU>�ن��|���y����(�9�Nw��=E{�ik�PC���zq4op7��U�C��/��?MU��F�nx�28="�cM��fqzV�nc��((��T�|[��H�I�H�M5��L�4~�~DÅ*�끦JLݶՏvvwa56���w��O,�@Z�NX�QZ�:�:
��L�me�ٱB�Қ�͈��Ғ�ٵ	���!��y���R�8"�7F��J�rѦl�;�.L��H�Iq�w���
w�[�M�:���j�V;�&�jU[p�،�cT6U�ZX��-wRˀ]��eL�WI�����|��{1-�I�4V�9C�*�5�1�њ�o�}ù,�Ą$���.�
�
B�	�Y�5���i��o���*�������*�ZǨ�E��Ő�f��L4�/�\)o~!�-{c�U�H��<,pF
tK�|Vr��D�e��9�͞��,��@�6��cccCy��gi�t�Na�X<��htw��^4��P��|�b�P�K{���3H
ɛiT#H3{^��oRu\u��I�a��l-�zW���zI��͙͙�5}(|8tH|XxǕsw���]}��93����d����m��T,�T���q��+%2WAϯm�ei�V�`-�;@=jb��H�C�1`	�*H�S����i
f�y+t#Lg����ۣ���T�%� #���>���
���1�s�w��ږ�IB���غ��U�s�����o�_y�Eg4(s���r���/�1z�Q���P�OJ��6��\��ռ�5v͚��U6;���ot%QkF���:4=TK�*;q(u�/��FƲ�׆~��9�Qǅ`][G@
A�ccD]o����2w�M�n���ҽ��/�Z	��?�,��W�,
4��C>	c�.iﳗ���$���B��S��֝�`>�$CQ�U�Z�ĸ�*L�V�yN��N�d�0��3]�XO�^^��vf*�N���Z�GmY6>x�i{	�_�AS�.���d�Y��K�����C�O��t�؛/CF���}�1��w��oqϻH����8��Ǘ
��6������.E[��-ca�l�_IM���EE�`q��_#�@[�#��m�O�g�{��g�1��w��d��:�L����������r,�{�8�|�;�z�%��I��m3��w�۠��ii���!���uռַ����^�-�O69�Cn�<���Ӽ
�T%�\P堐љ�!�\�C���g���P�8�\��/X��O�6�LNw�#����[�Q��WY���
������E{��C�
�J�WgY��f�6�3���;��6�7H�E��6����Q����*g�(�0w���$���$܊�ag"����T�=��%|���T��h���"�XW#_H����J�j
c��y��3\�q�*0z$n����������L�]�=��}���ꮦ2�vLV��2�֝ݨ�P�`;Η��i�{���ʒ�l���Wݮ��JOۿ��vA��`@��7�������{��75�w̾����P�����~D²E"-��wH���b؛��2%�pH��xN"Il`}���S��5�Yvz�a�s�B|�/�J�h�h�� �\�2ֿ<������ݧ&�[l"���p�/���k������l���r2��h�2��}��V	�|C���q��1�&�J�X���
����C��~�W_�I���D��
]4ƌ4��e��}���@���,���h��X�xT��v��d_M�_#��t(�l�w���#g"���4�mB�8k����F౗G���	�"J��.�K��רG���l��
2�#O���C����&����N����C���r�*�o�fr��d�����Uח��gd(����$�آڱ�oB�A�٦�����b�~xfݢh�����AAo�����i��l��$�p<�ό!�W�\#Z,�f�ڢ�l�r����d��QvX��xk�驑J�N|�j���\7�	ăh546���HB�S�S�r���.ZD4����	X��ش�z��[�x�9�����m�-�/��ߩ�}�0+�}���Vl�+lp��j��+����8�]����[eyO����nd�؅ȍ��r*�]kZ49�
1���^��Y�ui��`�2�T#t9�H=�hO��"�t�v�OBthc��jM0jN���J��_�С/?��j¦�5TO?:��=��J{l
6U�O�)������1Ů4Z�f1��ʀs�AK�|�@&�¼�Y��cI�pڑO�J�X�V"&$�!g�.��;�8���;)�"�5qMa`�cf�ߎ*�V!�@�%��d�̠�aT	��"��#R|� �VM�|�F�Ņ6Hi���R�[Yr��K�kr�Y�2�&��XB�p �a+�dK��כ
�T��EDP����MƟ��P�>�U��`w���P3o�4L��t��ǰ���M}$CB���r�����w�(�Hp+"w��+�6�����7`�^����9OƑ�Ď��{daF�9��餄~J�V�e��ֆ���#������j�*����3<�l�pǊ�5��*�A����8�7��xo�."�1W���5gY����5g����ć%sHo@���=u=�IfdYܵs)�^>S:�Lw9�s���Ǡko&��Y�56C���p5oy ����;v#v��j�r�
�Yb#��0�yń 7]FYN���M#rӀ`����-��;�����nd���	P�a�ٷ*"�7��&��bB�E�u
���I��Uw����ʃ��c�j���ؤ��T���vw�x~�T�څؽ����
��B4�������א�����mfM����.��X4�K�X�擾�-��^.6�jbwe��~��������Z��qJ���C���,�XO�,�[~��>j{ɀ5���E����JB��K��"gt����yC8�ȩW�C-�S�%~A7~�;���\�^�
~O��\���&.� �yU:�s�i�M���u2D���Y,�|��رNZM�,q��Z��v=-��]�|�@|�g{\}�?��7�����@zF-r�:=�D,m�X��U�D�Z7����U�%hV�c��	B}<���=�`��1� �ր{�k�w7b����h;Vl�U������%��)8&!,���\wB%�|ddk=�F��j+��Vec,VJqB��;�k�k��,��3;K᱔]�Ɣ��h��0�)$P`[��$>JIͽ�]z<���@��D����j��2���Dy>ב7���~L۫]�����s4�a�}$��u��i��0v4V

�bp�9�R����t�q�0���Qn�]�MD�7P3{2�� �t�6x�}���lv�o�aa�O1�ڌ�n�M�<��X*���H��uUH���r�Qh
vBt�b�x�s��c*n�h3�"�+>�C+�vF��&.k[gC#�%���&=�R���[�-��6��<�d��<�O$	WT׫
��+<BBZ*
�HbȼSٓ�
����=�}�>���ͺ�Q[��х��8��A&��Z��^�q�]�]���N�$��K�����A~�&-_��q(����z?��
���+�nwD���8���(�4��?�P�I3���&���&��$�
�8��@�+Y^��r���RY�)���;��*��,�Dh5n�10az��˛����f��rl��[,���?�7ƓcXB�7��F����A۸�{����(�T����"�Psq���v\c�`��S���nw�ɢQ��-i�(m�DL��Hߦ7�4�Qňf��7�Yc�5�\�M<
[�Z�\�ZS��D������5-\rZ,�CL\��$��*�6k��#���8��`�ew7iS���M�2ʶ���j�T}KC�q��W&�ռ6ݤA<D�<�,k�]��7{0��X��V�"�f��ǢXm%T-�W(��-�rU�X%����6��?B�L��Wmz�e�=S��G&��
��Bܲ��K7���7�o]j9;en�hC;�5�&�"�&�ڪ��{?S��t?�l�*>Y3Y�2���cry�w���|��L�A�K���K�s��A�� �?���S��S�N
���v{/��-+$�벫����g^ć�c�&Dm���t����m���;���ߐV�Sݾ��;mVߐ��T��y;�L��>$o���j�;��F����pU3ٶy��]�-�_�Y3;��.(V�9C���L�`�z�"�5�<
�3�zs5�9�fa��9#���������(<w�b~��J�	��K�%y�Z~���<wS�T�a��$��|��8�CA�0�eS+�<
?�����U�qI��r��t
��=��xn�5Yj�k��vNǳ]���Y�nW���,b]к��n]����n�Y��߁�f�
����/���@��G��|���*�~��וQ��=�GIo�s��RSsSi������ȸ&��E�C�B�=8r�1Q1ѱ�p���!�)�h�)�?��q�d��c�<Y�q�k|q/�O���g�5����h���cE��*=fGٴ���t#�M���hcI|C-��Io��|�D�ό����N/���&I�|�F63(tc���V��3����{�}�k�$͢�?�f��"���/ SN��5L2H�P��K=v�*&~�	�Y>tÓ�Z�U�5g�ݕ�0�E֛�fs�K,�c2r��J�I-d��:O,:z�Г��4-���9�5�Kiұ�K��ZSk��q!�}$7���eAq��ݕ��d4��/�B���@>�d�4���2���}[c��W�}�����
@�7��8"���`�wS;�W��
ڞ��0E��y��-��ɹy�J���T�R>���m��"C뇶�h�!멢�L�@�Xi�d��]�+W�Fȋ��ط�hxs������{��M�������+�M���s�͇�e�R�?�u�����o�m��r��9v̛��Bc{ɿC��j�ZR��c�mv�T�Li��ե���&�Ң&�PIr����(�Xޑ�k�5���^(t�Ņ�2BUZ�e��P�q�1�����"�"ٔ^�Q�#q�^@�JU�&�����Z���+���`��u%ͭ�5��d�S�
�1�z�i��q�i����UЛ������e/������p8�_�M�Y.�[t�Qj��D��)#u��K��T���������i�w c�٬D�l"]�K��
B����7�?҃�I`&5w�O4�;������b	�W�G(���Ah~�[n˄�h�E\��!$u��g�޴��{G�-��o=��i����!��r֦,8�[3`w�gI|�ŀW�fPݗ�k㌆��T��J����|S���Ir�����EO8��V�X3+Ԣ[���ӴuOy�:�l���<��{dY�Gy{��gc*�Ɗ�m5�{��ak�A���B
��w�ScG�v�	u
�ʽ�={kf̨�f�i�y�
E�����₞��}�L5���)�
�)I�}�rߒIGA�ql鶫�=�J�0>��j;����RG����gE��\VQlJ��H08Oٽ@�k8h�i�?��sz7����D��S2�$(��\�z�>+Ym���������+���k�M����i���AoeR���9:9Pbh`��Q�R�Y��q������=*�t%i��\�/0��`ˬr@�FC��Ӈ��]#q28Y�ai@�t�E�Cs�d5���V��Q���	 ���~ �akϛ��s`���J��������V�L�q1�/7	�D`XO�K0��vk��6U�	Ѭ8ۄ�׋�
�P����ρ��� �ss\`��ʦ����J����W���d`be5���Ϳ��g݉��_U��B����d�)���\9�8���s�pmS���x2x���a�az
�z�q�ىp�ۛiR����|�h�_a-�*�D����̆6E�O�ŗpxψ��D�c�B����m����u�ԉ©�V�����	��̬���2p�#�V܄��mɶ��g�$��n�l�
��D�"i��Q�����aq�h�9B��):�5�5R�Q:��H"ǔ�,�Jx˅=д�����s�C�ǻS��j�K�0hگ��p���Ɍ,3=0��GC����,
oxя]��CR�r�q�H�@]pEJ�F��7�U�,[Cǵ�"�j�2��H!a��C���+�z�q!����i�,�|�
�3�����ڀπ�F���3jM�Xad�q��GER�}���q��h��VT��w���uy�W�N������<����׉ۤӖ��}�lS���Ƙ��f�rg:��!�6�Ŷs-v����a�X�X5尸}_`�+�ʝ�-�rM��ڦ���Lu����0%]���] 
�� <a�#��T���F$8Fa@W.�3+U<�h��t:��{��Z��Hz�����$�)���
�G�Y�·��wFwtT��/�	�/��*��]u�2�Q�T�+������������ȝD��)�S�6��np����޸8��ͪ��t����D��KHyE&�&�g��K�kHu�Fê���$��y\�� �>���w1�m<�MUp��MN��\VJ�f�Ԝ��ɂ�^�C�RG���$H��u<d?�@Y ���{��i:��N���V+D���w�=�L��R�r�DYv_�5��� ��]:����s������ZZ�` =rrϗ�n
��)c��ǳ��A��Q�=_�d��F�;ZF��8O������5)�j(cF,>�����+������=�����t����Y��Io������X}�2�X�͗�H���%�����o��&�P
��w�xq�l�r����
y��3�Jr���B(16郄-R����ڿ�8�����}�m?��[�L�"͠�ݹ��T����0H{�T0�R�M511�ĜfG�_@�n�E�ђ���������qd�����,$ʾ����d�ە��\��s�o��XM&
C�v�������EEu>����W|��6�,:����+ؾ�J�2U��-I*G��V���ir�XE������G�O*,�;�����q���ѱ0�L
4��,������zf�-�ݻ?��C�����]��eI��6�]z��^h��|X�I��VT��
wI���
�������1/4+��6�d
��$~dľ�C��S�~+���%�0Oe�S�t�@}+������?=�l��g惷��$��o�okdq��/�ԇI�J���Gm@�.G,?h�"c)�\ �%
ác�����~S����4� �DI��)g0Qu�����1�Sud6^��-��mS��I�2�o9���&���lQ��yu��~����ϴ�f>Rm.7�0"��Q��7@�Uu6���w$��@>�K
�.l��t�ZķK8S�K/!B��@E:U�s��X��Pg6��:*z��ձ�O��qSD����<(b3jⶁ�!�7��w��%~_�p�,O����*��	j�C���s��N�kO�q��,�������W)>�l:#�<<������:�ِ�n~9�b����\Ǫ��A�T����U���%*���Ն�{g���<����q4��#���[��	���
�E��夥?d!�~�O��#*A��O�")���
��,b;��Ŀ��\E�=�r�E�,�2>ń���~��:�b���Ȧ�c	�-�uh��r�v��bȊcK΍w���⪣��bA�&8v��k>��A���<6x����@���4��.<���	�����O��i)��T�������|�݈5���uxnlΆ����=h������p
�+��Y54⿶�bV�fߊ@��z���жM5��|쿢��W������F!0W\ȍF��8�ⲅ�
|}u�\¾L���@�NEr�@�ǮNc��&�?5	��~�J#�O沋������ˠו��Km���"Jd3}}�bK�6}
�^�Y�
��
���c5�����:��;�ㄗ�I)��*CT��������}pEx�B)G.�EM�����q���Wpqe�8�I�N\]ju!��/9wS|��[��# �N����=�D�r��mכ����J�)n��Z&&����ˬ@�k��ң���	�fA��������.��io#3x̧r�B���Ϩ���i���\����L����J���QPA<�y)�M�t��s����������
�}v��>�p+t
O^u��<��3)�r�-��"��I8R�gC
J�.��2=<Q9xq���Z-�%&�Z���/�B����4�P��g����B1#�%���Y�]G1RE	��Q��Q��>
�<�K�a��n�(L�1	}��Ҧ�7��L���X����g�	��=�Θ����$]�S���suo$�������r!ݔ��9�r��Un����v�[���-���
Lzy�?������`�=_�7����ho�b�����w�tÏ��s37WW��w�t�j��F�F��>�������V���N��R���K��,}-Q.D�5l��<BKM�rjMMOM�r=��:������i+�/�0����b����c�n���@=�6�H�����\����3�Nk��h�yЏz�H�p�b�.�%��]�x�5��V0���$�Ď����m��]���������-Ar���h�D�k��L=�}��%\=����
]��c���񭦡N�1��݉��C��~�:	���͝�?=E���_@�-zj~3D=�����"�@�S����ݦ��������r�e�jz�P0����d�.2�<��T�fw��e�u���*�6�E/��Zx�g�vBKlKڗP��R�R��(]pz*#ձ���T�l��6���H��j!�NГ���TQ�]9
��+��R��(�CU:!����/$��с"R��|���n��t|X�=�f�+��9���W$]�
-(�	��P�S M_f7G1ٯQ��c��8s\+��\y���4:MG���P�=^�sX�����qC�b�ה�_�����#�P0�Q
G��<�͹X9\����� ����n[����V7�P�X��W�<fo�1.���l�A�Ց1�RT�w�oyf��wZ�Z��	���o�J���U�̮v)��Z��V�E]��FU�C�|ڀx��<��є1��g傸��A� ���
Ӓ�B8�����yYm�x���z�)�p�O^��׮[
����?��a�Y@dE.l`*)V�H[1����.R�4H�Ʈ��Ό����h-E҈-��B`��A0�O@d����3:Tw���!��L{c���]Q#dy�̘5��D��5A�́F�.Q�L��׽~#��cڕ����&%�>��[�0(�5�WZ#�7��G6Bݺƒs����}�C�Óݐٚ��}����!��O��Jb�%>��
4��*��S��셙���17~%�a�"^�*{#<)uK}EU���jQ�p�LG���2��{���M��b���Y��RAZ�*X�J���fB[����4����Uʐ�V���^f�j2Y����]�#�H.�o��^1�ZQ�Q�L��~z7�WҎ�#�"��(�h5���
0j=���ZO�f��(�Cn�Ť��"�&��y��oNQZw�	s2�5p��4���;��%�z�Ny��_é$t`�2�����T-�DE�k��M�V��\��/�p��Os �i��t�,�sR��ߵXK�m�0���?�t��S-�C�Y�A�����\��#��F�u�s�m\��
��0��J�ԉ~������)lc�PP V4��T_Q}w[?]�?��g��R!1�	#7�ǂY6[����\�V��N>�aμ�_	�) �٩Q��/�6׭w;_ؤ�¦M�;O(:�Ff0f�E�f��t#bvTr�W�ٚ�&�-V����]כ���ZB���G�<�.��|#|�xg�3��94���Τ�x���t��V4�x0m!�-�l�ʠ.�!���&*Ґ@
U
��=�.��B _������O���N�j�h�(%F��S:���g�>Ry����cV�o��H������1�C�0�t��pΆ�Q}2ߓ����R�|�?y��~���s�-d�E���w-�pꍹpT�~�>�s����Ny��P�R�X��d��f����+��^�1��/m���|c>�
jA��p%���Їv������8s��g<SޱtB�߫�HW�M�_Ȱ���q���|�M�����h�|lbv�S5/�	�6�N�T��Q��Q��K6�]��V�v ����J���Nc*,��6��~C���]��_�|�oσ�%&�>�l���Fq�u�7�{ꗃH�62�Қ�r���w~H���Q�%���z3 �+���j%)i��5����<Y�U��lfWr�o��Tw!	I\��Y�f������1u>���&B�؇\E��J�����F���C��]щ��*���Y��H}��ps��8i��7�������s~�*׮a"7�C��K�\��g�(�Ý4��׮Y���L��c�3�~�z�d��ک��55��]z�)�5X�W��r���L�z36
��E�s����bJr> ���c�"�Vgğc+[�Q��gqq/Gm�{���+xO��-˻�ݨǒ�g�_K�ɳq ��������"���έ��0�7�Za�F�������j_�����d�*y_������P����=�}��Ⱥ��
�4D۵ۆn_�=�Ǉ�U�yk����<"�LHH����ͻ��$���
�A�{{�������uN�m�c�!�j�a�9������}��MbeD������X���C@?��C����C�Z�j0��f,2*8����s��6H�U�~w׊��2�H��w�2eB�$�o�5�K`��,�#�5�*R���5�~=[�]wI���w�"���i���r������ڤ�������Jl3wh`�^p|al������)�u�JY���3�x�\S�]5B�t[g��#ʶ��8��e,B�ۃ*p��T�%
� ����癕�k�qD���G�oE}�o���e��Z vttO�p]��p��%��ȠB���5�w\�"�.?������"���h<o�u	B@ݲ�U�����W��`�舓����}�	�Y���C
����@����soAH�yS5�p�J�J�������#��.��ߟn��7J�~���C?n	)@.L�w"��B���[аr���7o��)���Y�H�3�.�8�2���5�
��V�2~\����w�&g�R~&<�lo��f�找�Q�ػ���gr�wƹ�����[8������x`�y���Ӏۈ��GR�+wU��cO5�S���@JA���q,r-�����g��˱<����8��y���=b��OB�k��N���{\lbĘ���m0%��8HDq�\�
��mR�8,���p�Ot�ǣj�%�IN�զj����,���p��(�6���7K)�����;������-z&�5��/�HնO�ݱ]bh��9�S
T����+Ԙ�գ���%tS=fx�͈Hl{�S�)�)�Znj:�	��B5U*�{iH��Ʌiٗl�������sl��۽2�Pn�򩦱�n�ufh����4��<�g�� ��C&ZW+/%�_���J^����5�^G�?k0c�]R�x{���u[��$�$���%w�T�"�LF:���0�h"ĩ�B���ei&b
gJ�"�j�3�t+l-5���6���|1=.�g�Hԉew\R&���acI���<ţ�ǣ��-��\	J����:�6.�(���-������mq�a%"l�ҽ���EM��2�;�卡Aq�Ձ#!
츈x��&�"�!S��v�_�TJ��/	3^�h��⾲��`/t�Z�~8�Ț�>��P�jm3����,����\���^�(@Xn�s.^x)�	m1U+�ڸ�Kz�����w�1S̈́��Y���Lj�Yi�J[��?��=4c��f ;ź�������E�xIQz�g�t�|��o�G�s���k0`��>]p~Qvr��H~��3()Q�8ck^�:hH{��@�%l9�Xt���Y ��gML�`Z��0�.J
�®c�����K��ei9K.nM���E�8nŠ���Z%�*�8�%�=�e�
Q���D3�ɬ�u��*���JZ�^P�Ұ��7���$�9k�pź��+g�7T� ���G���d�dk���39c0���-�s�<�ӭg̞,0o�6���:l,L�̨�~��S�:�։U���J�_[�����"�wj��Ԍ�
�wo����v����n��	��C^n��nkK���a��=�����2(��P��ʽO������������G�ިAQ��qm����= =O�Wx�X:ho���4�t|�o��3ܲݦ��Ȑ6s�*�l�3�5����K��㿽����f��U��,9�h	�M"��R�@���o�~=�jv�p/����[��KO-4�Bg>ϹHl	�`�$�� @�W/�9{��|�[����lH��J�:�o�I9�	�0��oF_��R���u-	�^�����I���,��.�f��Ve�&�KyA`oƓ�!,�ȎS��n����q�ҁ;���a����U@f��Υ[ɀ?�	�"�)�ˁ%���͓�E�P߂nWZ�+�P�{�c�|���*���/��=v�k#d���"�4D4���
3w���*i�;��˽>�l�
��.,��\����O���E=����F�QK邡�a�9�#d� Ȑ�x�����e#��kVu)���-my|T�	�����%*�o��D�bj6,��ȣ���M��>*r~rr�a�Xu�eƢ�v�0��يojHgM�U��r��%x��K�������ߎ�����c;�P�����d!�7Ө�����1�=�⏧�6�o��֢Ll�	!obH2;;���8�y�
��ރU�!�wܖr���t�"�V(҅D�7���S�r�
ZظCy��I��]^a	;<��{�].�NSzU���ZYɝ���y��o��\-_�޴���|�EF>�}���}�P���j?{�/���Yj�1r�uo�4k���]�׽sC>�QP����]�s|>W���%���M7�<��S�l��xj�\{Q{P����It�h����X�gǴ�8�nS��S[Qى�GB?M��i�{ʹ5h؞�;��{�~������M��Ռ��e�0�ՌZ8Ќ�Ռ��������]����I�>�U������q��=�U�	����lR��a��j��շ����R��;$-�s8|����P�r��ʾE����t{[|��Yz��Z���h�j�}k�/h)�wlf�
�%�Z�-��|L�t7��KS��E2�P����D��X����4��y�$s��8�W<�qL���)a���t�n����U��N�-��{`id�竰��@���mY#d"Q1l���*��)	,���)��hK��{*9=*@`K$U�h=]9WR�_��b�%*�G�^U�S�ڏ�yXҞ�M��X��us��a�͖^on��%4��{�~�a��3kwr͉��L�_N���E�G[#B$���r3��ȡ�r4ݞ�ɡx��`|�Ήeķ^�f�Hl5���E��������n�z����JyP襮��
RTq��R�8��c��¯�RB�H˂�(+�)�Z������0�Ɋ�Rkᰙ���\�EO�7yo��Ǣ�}���~�9F{a@ll;x5��I&~~W*y���)h9N9�gU��\+�M���a��-��,E�i�V���`q(�s���Am��Z�P ��]�G�����]���Յ*�|Y����v���q��y��}���RzR�d3��kC<�

%�xc��rD�CWD�j.d�3��7�����>��;�b������x5y��)��ؑ0_�W�ِ��DW�A���5�����*���mc0�R�c!�����Ry�F�H�ySw�$�3���\�~K��w���61;����@������Sǌ
�6�R��e�W���ef7<�b6�]i�jךiy��Z����h��oq~���|�r���r���z��A���	Q^���I�IK��1د̌��r�V���k�gؖR��V��v��b7�X4y�������߽���|�x_r����z�Q���g�?���.u�>\���N�\�Hє�l���^��
�S�њJg>�!�nw㉱������a��0<P�/Wc
�ׂjs_��j�S�Y��8��[��mF���x.�\c�0h݊��Bp쏶YR�����uy��	��e����/"˂=_K�:����4n�]���S�N��m
��|�@��[��G�n�=L�n�F��!8���<�Y�}�wP3KT�r��oeԯ�h�6�Ƙ�*k�/���9Kh��m���m�>��ȼ�R��Ym��>TӽM�V;��8k��j��,�+՟�\k��O���.�>���
��L[biԅ&��n��~��m:92�}���BՊ�<t7�����M�b����ē0`�6n|5d_�C(Fޯ�50�}Չ����6�r/�\�#z/��1�8�?�NL�m�	M݄�Z�i��R7�������UOƔ{����X��\�0�Y�p��U�8j$��c��ȯs��(�d�����R��(��#g�10f�w/��o�0�#��08��{f�nI(~x��(�W�0	Fo�7���
����q�g�®�B�뺂��\f,.��sO0^k�p(*m��~����LCh����q�f�Ph�*��|��&�|��7i�cu��|~�!-�;
����^%����Aݢ�����y�\�(>J������vj���z�[&sŵ��̯���&Fn�>�����z������Ģ���0���3�BA�-Y���_�K\~����5!�\�D�U�,��E!� �$�c��(��U� �J9�B��*�]u�B����G_�l�-Qe�xĠU�n��.�|	�ڼ�� <�8���*+ek1�[�y�6a�A��g楣@���@�Nɯ��AN�PG���CS�/�;P�Wf��O�𧍡\�
wJ�V]^ �@�6r��pm�*Y�O��0��u��QJr�A�[��\��l1ED:m��C���C?U#f|��p��p�O�@
t~��k�Ax�|D��iOo;wG�o�ե�?ʭ� p�7;
	F���+Z�9�#e�Ƥ������/:�n�+�"��ӹ���ȋ��!ۣ�Em��,�M���8wfR��y��A�[���Q�l~~��Z��4j�;����#��j��w��<
����j^��#CB�7������~"�מc�>�z޹r8�w4�\�;�s���?���e��|OJleH���"��,�k�$�6�@��;�;�F�O�{R]��F�ë(�䰠[�D7UM�������@���Q�����)@�7�,����Oј�ЭD����RVKs����
Cy+�R�+�����.J��H%��(���V!-⇕ؔ[U4�������p,���;���7�I/�0�Cl��Q��VF�U�ȡ��;(��Tqf�����%�����{�4j �Ч��u)�5P<�X�i�36�R�*��E~2�幧G���G�l��NldB���%UՆӄ˲1�9�����-�TP�|��&6�zc��ͻT�J{�$��N�%,�R�n���g
I����ס�D�M�Sю��hFʲ�7�U�R߅��ѵ�M�F�U�BE�|7ս����%2y��M�^*c��>F��Ϙ.��F���o.�C�fˬ�9�����JqMҷJq�ZQ����l�n2m�\Hɦ/-���[=���Ԉ��Es���0=����/����cx���n6`p�����`��:��筠B�Fݕ����Q�7k��0�u%���H��s�Ș ��@L�����)��8R`����Su��V���Y�ݠ���:f���)�	�l�>�צk���iMZ�=�_��WTl,SV�k�)��Wl-����q����1���)Z������M<�՗;Хm�l�,n�Ļ�e�7-5ۈ��-^V�.�>wڿꥠ;d�ե�����ߌk7=l���
�S�}���-�[�mk���x�~��b�ج̾F7.��ú�Tk-Mņ��kP<<��=���[�k!<��v�1�
[��Q�rc���R4*���R����f�l���p��B�Nt�n��fN���<�׏lH\���7�5��l��rK�||�/x��~��],�
X[�䑾2Ko�?��ͤ�ݰ��yH��p�{���rGB�zO[۷��D�~j�͟9��\l��^�Q��^A�k�&=�\�N޵}yzڨ(�N��?$2y:j�yi����A���_,�.ޖ/o%��ҟ:���Հܥopd}�GG0I�ئ����̒�z��t��>{���Q;(L0�6�ڜ׻�!�7\����i�i�2�D�q!��:	��^yچ��m��p\��;	�hv�=_�&yO���.��zTہ�"�Ί%�$[�*������y�K�+?";~����ZO���H���\jP��=���J��@NJUT�q*��J���5�_S`]�Y�x�K��G�N!F��&����Y~~�MN>t�O�?��~U��M����|��!��\\��$�"N�t�%���]��#���q������8#M/?�dn�L��z��Ĺ���:	#k��u.Μ����������u��$MO.��
�{���.��+�<����

���4�t�m�!���8.�u��#�� �o�S���a��|Ŧ�$k�)�U�U_EN^,�j�N���"�#��N��YS�8���#�7���5onVH��{��O���ւZ��}T,<$�m�r+���ϒ94]BM���O/�o���`��83jB��Y]S^s`Zn$ix�x����|�{HH{|��u�� �О�_\Lr��	���v1»��Ȑ���챑z(y��	��uS�qU��vE��"��#"������o���Q��Z�o,�\G�k~��s�q����X���8J��:��x�q���������⾕7l7V��}���%��ɇ:���I�6�q�������Ƨ=@Vz��,oR3�R���j�6�j5[J�P*g�4�hV�4��%���{c�Ԡ����jN�v%�/"��T���ֱ?Ћ@7fU�=��=k��<�[ų-���HN��&I\��b�Ƨ�M�!�˸9L/y6�������f纐]�ÚRf$���;�t�a��L\����#E~�G�_#X�Uvϖ
6�I&ő��V*���;�a�Ve��W�ߧD!�C4�f��X�4��-���|OJ��y�U?˧ŏ�C2ᄭq�r�p�C�q���(�y?#��تs�A�P�3X�!�����7Bp[�g�DxZ��6ݟb �����Y�W"��p�~L�
���=;�2+q�*���M����Ÿ��LFP��΋�E�A�
�[�4b�.
�DW��g�QT���M�Ŋ�Ԋ��q�ޑ�.��d�2*}U����[B�s�Z�X̥w�}�lii���U�x��%L�Z�˯$4c���OJ�.��i�1	��3���t���c�I\���T�~�x��쬵Fb.N�4
�W��	L�0^w���A)��[N��v"�NC|
���.:��ۖ�Ӛ���J�CZm^��~ՓB���,1���^���\�%�}B>6�ވ����&X��~�Lp~�2+��E=t���͑��:�W��yy��
��
6LL礅᪎!��-�n�}#��	c����NVTS:m8�_t��T���A`ڹѳ�^�e�tk
$��4!���9�V���~�r��hӁ Z�ˀ�AEK鐯���r�KZ��@�A�r�ڒ��VV�m��𛧓@�]Q�`����������A������*�Ms�މ��r��8�zwS��J��ߔ3Yl�����.���H�s
:Ohb�2�\��E�_��N�p�ϋ����9���C�u�xqpX�ӿ�ͱ���o�z�ќȲ��/�����#���9��M),��/I��H�TO��L�EЄ��r�W���`_0����]j��� �e͌owE0��!�Yz`�V�~ލr����ӌc����\_R�lj��y���H��LcR_>tu:�~������)yUWz��;:,����C���!g����ˊM��;�g�v8AG�VQ�]���ƙ��ӂ��q�=��,��n
0h~ړD����(�Fy�y�i���&�@m�I�͕	�����B;T�o�	��2�x��>�o�"��+C%5����/EE��>�.N*R�37OEP��_+��p���y6���#H7���%�r3���hqo(�e�1*��)ױb��?�EE�k8�� #f%�UY���X:82��U�5gO�$*�^�{�g.�,>aـn�&�󙏀 ���X��ǿ������P���vl�����ؽ�U+2J�p�:�w��Y����Mĺ����|T�����Q�z��m5�%2h���;>�BNM�5���a�sx:x�w�a�z�e,m��MjC���$p�XQe�k;K���NB�������v+^�w�]Q,Xχ��HB�nL�aƙ�8.
��Ú|��L���:W,��J���7Xi�����.��znm��e�`}�i�����:0�_Zt^0�?+ڠbJ�ȯ�3EnN502�D���)����4�u�^-�x��벑q^w�ՄK%M�.i�y/8D=��C��M�
A#?g��ҳZ��v�^�
���I���*7,
��EG_<!��g��tr-����SL�l���Ȃ��M��N$���������e�hŋ���,;WM�����0�zceP5��R35��~���*lz���yw�3��a�9�d���d<q�;�i�N���H��������79:������F�hگ�F����MQ�P3�9��������Ød���S�U�=�����86�����RRP�
����^�Z�˳3>��cDo�����G ������ߥ*M3����������hu��@�Ǌ��z=댒�Q��?��>�u�@ɧp5GD*�8:T�T����|��2T�ںY��֙��U+�攢�ej�>2p&D�Ǘ�	
��S�a�Vr(��o_8��5�1\6
IV��}D�>�3�FL��z��P&|H&՗84�ܠ�����-�7������
q����=�׫ݴ�&�ACR��6�B���A�2� ���8��k}�ϸ����������׬��`.x��j�А����F�,�V\����0E��u�𠰖QN�*4���Y���ʫ��l��N~8.�D]���$���zU�������U��Z�X��Dsk�ӗ����蘭e��B>���t�ٴ�B��5�Y4U]%~�B\<��,�RrTĴ>*]7���������0�ql
�Ѷ,���;i5
��z�%c���!#D
v�c9}"��/D�H��C��O#C�OwJ��W:&�k��"2w��[��ɫ]���z�}٫����zrn��i$�B�k�B�j,n��4��fЮ����M�=z�����CE��r��j�Jm)�vt�vt1����g�4���c3�d��Cj�%��g�QsW���ݏ�_��Mtb���IN\Η�S�
��j������n=��>Ʒ21+����w�"����𠳼<�Y�sѳ����!�}�* �|��`�7"���63|�p�W�<�_����T�ɸS�98�ۙ�(�偤5<o����qY��OH ��_�3��z���=x���Y��-m<̒c�)�N@� 6PJ�0Iep�]��aA�X��?4ﻦ��>�a=�@��)C7?����QR��038?�U$P?��n����L�/~3$�`]�%��z��:�uoҮ\YU��T��]y�Q�Q���̈�}�đ�P`�0u�S�j�VC�N"�;����� !�3#d����i^�g줿��z6�:�7ŇA0�Y(P�=�G����;�[%?.w��VjD�۱��Is
��v�א�(��Y,���g/@�`��$\Gļ��HEqM4
п!_��cV��}��yG�N����1�ɏ���t.�>5/**��ط�f�k����cn��ތ�V t1.�r��M�V�D��w:a/j 2�¯�il�l&�/cS�ɽ�
��E6E����:�P%ے��]2��B����?����QR�r��ψ��ə�Z֒y[��eQ@D24��W�44�Њ��yBm9C���E؁���x���2�K$��l����~��S>�����:�K�x��<�&5V�ΰD�\1�[)��m*�4Յ��^޳��*X8G����	�v³\���jD�e�\B9���\[-�=֒1�Q����D�f�j���6�Ds�",b5��UM�5����%��e���c�mi�bo��T�QA���YW-J��&L���ٓ{`��^�K�Oy�w?PPPLn:v�J���{!��j`1[�t�hd4̪���hxt�ۇ`އ���^������|���ڝ�W�l1j�uv$��P��#�{�Չ}0c�r|+۔|NHL�5�c�0�&\���\a�bh:�!�uM������ N!��*}J�]������e�e,D٢��_"�c�M45޿T{��O��j��7�wК�%p��p�Ba�P!zZ�_g�5���FZ3��c�55���c�"h�d��gB�#ȷFV���/D��O��3�U7#Я�(C�c�ʢtey���-���H\�9@�g-y���H�Iw)��B����O�e�
�T�U����G�b�¸�m$e�mqq�����}�/���w���^��l���.3����.C���<
��w�"��|,r;@��8�bKp8�Ơ���c��Ʉ�*J���黹����r���b֘`��U��KӔ�C�]*Х33�Ƿ�@y�8���O��؄��� (/U<z���mO�w������._A��� ��s@�����h^���G�b�Y���cq
YX[���3G�R����SS��Mu�Wp=������g��ź����{��y+��0^���|�xF��t��O$r�\��4�yI�8��KĲ�Ȏ
������x�y򻇌����˫4�V�l+�k�T�?���fr��}��0m�>��I��9)0ٻV�T��JN��@����lj�e��6�	��<_��1ʍnV���\�G6D�&�<�OK(�(pm��ht�3e��uZ�=�9�{��Ȃga��u�"�kۆh$#jN�R�#wҟ�쟆>��~���&MK��Bp�0�3ba/8M�o���.�͢w~]4U��ݭQ��t��QĦB	�j�r��������~Z��`��L����8�N��׃!р��
�ht>v�kc}+t���@�ΩvEsc�E������HJBb�2��1�g�x�Q��g,Ě7�bR�s��g��GI@��6���,�P*�+	|�U�	����u�ǜM1H&�D;�/�����=�v���H"2�t�c嵶f�Ȗ<!��t�������j%���LZ��������h��1|w�F�u�q�,̉��QQn�4���	�,�r��L�*���SM����8�~�d����#�;J��-��4xe%һ�^i��BK�Y7����C�TeL�U!b���U���;PMq]��Et��>����h
��(�Mu����Y�U�;�
�׌�cХC��D���Ǐ�?	�7t �~U�t��Ђ?�(��|�u��
�D�&�u��. ��0X\�ڝJ8�w�+|�>�͋TƜ�l�4Q���\��ڎ�y|&sv�ū/FK:�;��-9�~�������TK�EB7�/����
�����~��X/K�c�%!�������ͳ=q.|£Z0��?�/.X� ̼X���i�2��9�]K�b��+ٝ�K��3Ҡ�V�uh�0��+Ei���IZ�{����,�L���loO^KveM�)>��~{/�p�������*<౅���ȉ� 9�o�;0�32u�A0��*�:��g(K��҉��jx�T��*��X��q�u7pZg�C�9Y��������X1���e����2����K���5tw>=м������l޴(h�l��T����VJ�n�����8�����ʹ�8��j�Am�E®���ΝPһ5Ѵ{�a�Q[l�)I<H�@R�F�����`�fJ�_�S�c��~l��������*�:��y8�y��7/g C�������?���������g&����Q�ޗ�f�j��_�
�tN��!C���p+����|-���{�u�
��OuB�����>y���X����:B���
>��>{��Ұ�K>W�;��5F�ׄ��ׁ���xZ8fJ��$|��.�R=�!Z�7\��F�rV�\MF�9�;��[��J��:�8�N���5�����~���i�}4y;����
�e��L�j��ֹKj9�)
�Nƴ���)�%"����l�f��F��΅N��
Hr��������Q��
w�@"�}���~Q�Qe�cu�j�!RV}1���Ƀ�E��~�mN��:�v���[���
.��=��� m��<ٙ%>s���w�YD?�K���t�$O���_��Rť6�X�1v�$H�V���\����k���x��lFr��ۦR�B��D�Š�t���~S��4s~ =�UGà��1
*����X�,k1�d��Fd�Y5��K�Ԭ�K+WJ��1�]-�f���_v��S۪�N:zeɍʲ�u������*��ܺ�EH�:��]�}1�.�Ck�%�l�.]Cv��耍
�~��]���Y��ln!̏D��c��j|ՇA����t=�s��uA����QvX*�6�O��g�v �/3O��-��M<m�xi`��6�%�%���M��H��%Uo]���mG����m��,���f( �ǦU{��C�c��z%{31�X��	.k俒�m���v~�2��}R��`o����ܒBjߩCs�k�����rƭXT����i�dH�<\����
j���P�:U����)6�Z��0[�_��,5�"ǚ.�/%���
=;׍Ȏ蔴>1��D�{V69��;[5��I<�V �v��m�>��p_m���9�	�c��f��A�@�v���7��I8��<IH��ϞQ���B�v2��]ڂҲ��E�Ԫ�g�A��V�aK�hKZ�Mr*+�9�� |�,�����#�kf3}a|�2?�@�a����o}��H�q�wA��Jr��I�5�}@�b
��t�⛊��u�o��ص�? F�������Ww��~�lώc�ċ�mGL`+�й�T#��	>[Vy�8�kTB	������]��RU��^>)F��
��vp�*{�$c#��5�W����ퟚ�L�[�,�s���S��<��p،�B����
J
.,C�I�N�"~�~�4��xwW��g��z@��hb7��
��@���@�`����\׮�=�f�j�h|�)�z�v�������a�������Hƌ(�;Qt��v�Q^��m\�?�[LRӃg�/`-��_�@��>/y�&:���(���\�.U��@%LX>"H�]��yM�:+찷]��}.���{���H�b/��̡qx�M��Kb!�$�b�	&¡�W�+�,��u�[r[��f�@"��h��,O�ۀH��/R�su�E���㝧8$_���s�
.�b�Z�"2Ӡ�%�T�ԹU�J�����:�
Qđ��D�C�dǆ��~9�ʃ���4��P5��	Čiċ�<���ކJ=E=�O4�b�B¥��ģ��ơ��������^�`Kr=���N�z��G��{ɋ7]�݀�j�g(n�ȰT�~w��ӭ��j�I-Km$)B?�")}��F�{G�������3˾S2].��m ʥR4Tn��:U�R��H�=H� ��zgz�k
@��8�߭�͙�·�3<D#�W˵Fq���E�=��gEϢ{�����Y(��W��3r�]�I�b�q�j��-Ha��<��a�h>�ot��HG
^Vg��:`�⍋��^C�:�>2�6ۥ�>���Z4�s���g�M�mȡ���H�ɤ�9��EJ�n������p��T]7��Uݳ��������%�i����m��z�Y�����s�Z[�T`�x���q�����uj}b`�����r�����9
r�̍��)��@��fX��o�!�e�qqR[�Bk|���T=����$�4���Wc/m�R��36~=�r�V}�}<d��.�=ei?ݿ.�9��J����衷//��ɌLIl� ���Vz
=��>ᜥ�1M"���tTP��1�(�P���th6��Su���%�Π��m0��!���#װ�!q}��t�D�5"I"U"�"YFj�z���z��U��F�|��UZ<"#��w�O�R��sxc�oP{�ۗ¤�Y��3��4���O�1I����f��i~������T��c�z�O�yEx�k>��;ٟ��ye�:-v.l�Xb�b�zБ�D��aYh�����|�t�t�+�#A+��ݝ��B�tmH)8��]��A�C��@�F
���
��<�[�H���C�8�~����!AM��r%�C[95�/��r�(ߜ����W%��M�;�#(�x�O�_�ՉdZ��J�w�E�Ow5���ݮ ��"<-�]�c�f����D�Z��`��Q��(]���¿��b�1�k!�Ƈ�t���)��	K�x#~3j��������:�<7�^�����l��8�V���s><I�-eU�C5m!yE%U!e55u!e%%����~uL^���FPO�F�z�r�����W^H��|D��g�([1C@�>H���W����d8�#&��vaX�2�
�����s�T7{m�V����]��hj.��`Md�:�f�K�LFE
�3�K��z�����Ը�|�&t��;�$���Q�����Ͳ����~��5��q4h�*��ή����������=U>D�f
�&N��Ix޼����NT�d	�E	�����ݔܞ|��ߞu�fNt�}���f0�_�P�_c�-�����eoXk��gA�;E��@���Xp�j��8�](��<��A¨���@�H��/7�ed�Wl�?���]�@L����<6Yep-��O��M��N%C�� T��� .{Ջ0MT�t+�{~�=;�7E��?Mn01�:m����@ˋMkG3�^�z_^�L}�
~9����>
�����Q����^y-e���r9�<wM;K�xX6&^�7�BZ&�B��������:����ڑtR�0���uKW���Ջ;��^Rx���W�5-����~u��w�x�nh��M����Z�{(|MB"&���\�v�1��H����U��M}MV�+�"��D#��=K����(��P�c}���T���٠{Q��������
�u,�!q��t��)���GF�m
׃ݸ��sj���
g/�j�D�O1��H1�H��J��"��m�q���Ip�J�M+�Uz!�BG�Q�S�3J�݋�tUE�1�6�I9�SW�)�c�D݈����S��0�<�������v�{�����:�����_��.rͲ��
�|����K��_�;eR��Ezf��;`���-7
��o�&+c���A��~�Mʽ	��Q��I�������"7?��ؖiL�h�|L�L�Lt�>�Ѹ-v6Z������4����\�nv~u��o�u��H�uzu���C�KH�5���S��D�/�c���o�Ã0@p�En] e��eb�س�xm��ڳ�͉n�O�t�"����!����m�s�Mryg^"��x�J΋O��g���8����Sۚ�`�XH�s�Ш���ʻ(���\8(t�Z�,�k�iz�Ȗ!�\yG���uZt�+.8O/D�|D�y�3X��{�4U����N�HP��P��}q>�2T�6���rO:������
�#P_�Y�v1G��^A�K�oHR��3�Oc/��
�SPg]����&K���5���UX9%����ȷq&[=����ͽH"M�uS����B����#cn3��C�;�(@�|Bȳ��zh�GL
���X�y�]��h2m>�e8H�|�ɢ��MK%�-��;��j�C��閒�dn����hZ�Aے�Q"Nj[��X[D�,\�Y���������J���	�1_a]�db���?���0QL���(��M�h��~-&!ݢ����X}"��ȓ�C"��fP��%�H4,4,�3e9������rc7�yW7�y�u��nH!gxs2[#o��,z��Et�>F�wprZ���-���h������Z�:Q��*���{���"��t�Z9�t턱ы�WmfG�uxLt�}u��:�
}��0v��%b���Ue�F����Dg��F�.N��|N�/������=���*��LjG�����V�?.�Ք�� &�kl��f�
\��)/ρ(!6�)`�
@�����X�)&D	м׵#*��1��GgS ��5��:��1r�`���"�9�BLN���F�6f��Ll7[�cM��fb��v#�$����m^}F�2��21��Þ�ctN�c�e�Fj����1H�fj�gn�BZiMkUa\aX�rs�s�H�8��?z*�>DˋU���?�����č�|�z��ќ�M�|ʔA;166��yo;q���`2�Ǭ&n���n3��0R-pA�LaJ��F��
�ƈ�ԥ��|j��F��}�yy;��6�­�ڔs�J��?˓.W[T���@rW|���ُ����)�j��Re��8�iF�7G�z�7�_G(l@�uR̃���Lrz^��<��8YB��Ɇ�%�%��@���w)q��Oo$��[!D#
�8J@bbR�*	�a���?
|���>�z��.�MQ)�}�����}T/
~��P��i�K��]�y��WJO[��o5z�r#�0�#T�:�����n���(���/0e]�R�
T���Z�S��	��N9ʐ���,SR4��0Ja�ioao[��{o����Ջ��J�;���|�v�j��˨�Y,��-����C/rsy�D����SNt�W�
���4�I���ޝk����7��������=�_�W���8s�}L*�ۇ�o�)�۽��͂+���$0ydT���+L,T,R�F������z2�:Iuw����syN�w�Cԇ{=�h0B.N*b�d,�(?i޹�����{�e�� �j�{F������Z�B����,ǎWQL�\%�aJ�R�W��ܻ���xc��S��T��$��+��Z��u�#D������=gS��3�^��!0<��9��f��2LT�J��ڙ(������R���^TT�<�������[�~�6�9�-�z��|u��N�w�����?��5�����	�)y��"O@jI�E�z�*=�P\�ȕ`��r=N賾>��E3��\�&���6�
�ǜ&6���ꫯ��G����I�kD��x���?�GY��;%Y$����n�{�:�6(��N�a�i k^�P��(X�?*��7E�Ky��;Ȫ�)WBU�Sҩ�wmF�5W�ڥx#��CJ����g�r�Z��*���7,��r�V�m�
�=;�1`��	�c?��̔�_i�&e�坳qL&��d7#��O���8é�S���5��7š���/Ϛ�4��3�9�%z�I�YEe���:l!�fW9ũ��q:%j�e
j{��H3��.r܈���O�B��#�-R#�@��Y��Wq��-�
~sc�4q�K@��� �R��q�a�MsR��O�ym[�i��B+­*eS.��q�0布��"�X�k�hfݷ"i~3b1�򺹫qf��[]US@�*�l[�1HF9�:XX�"S���>�h�Bת��$Hvu�h�[ڥ��Au==���1�\��[��=��J����	�KM���u�x|�{��VO��ӯN�Vu	\��S�Ǧ�V����4ta�|�P</�I�O�{��D�iI���m��k����q
S�\6�Q�\6�Ld�/3�����Q�#�o~��U`�
D���f-w������N7��*>F`m~@b�Eɭl~Q��"��2|�&��"0l�z�.m�8�>��Z��~j�TZ|%g�Y��\���f|1֊B*��U��\t!>3LpG�a-���g�a<���ǆ���o併�
[
��_L�5<�@u��/�n���%B�9��	��T<S��kD�JU�ǰ��=|5����`��۽"�J�Xh�H�S�ՌmЏ"�Ԕ���k��^w�n��[�4�޼b�N�ro�NeM��U�\.���z5��MjT����h��2�3�%T����cU��+����Ź�ع��lT�Wp:wT�4�K�<e%�4
S�k�k�i��_�`<%�>�y����%a}��k��u�D�w-y��u����z������L�����tQŬ�n�!J���= ��4E�R�p�S�&f�����0��$=fr7��o�ԟnP>�ϣD�x��G3�BtH4�u�4��L�Q7Vn�a���,D5P����T��3�%-b+Pw����0z��Ƌ�b�H[�#e���\N�j�ű�����bV`pUVbm�����֔u~�i��Ȃ��ގ�?��I
�Z:�+�Gr��)�����H�T��M��w�8V�bm��9n]��A�^0�<U*�R�z"�0J@D��+;s��|Mf��p�8��4�+^���?�2<>�:��v�P�~�n�``�`�c�W��7��!#[g�/��G/�t�/�?�`e��A!�s`I�ל�M7��������[p!
��>�!��|k�>�P�k���vk�>�}^ݚE�w��?��~]����R�F���[���v�LI�ޢ|>��QQ�R~\�z{�y�jh�]T
?C��/�!�+#(+_
N��י���D7�%;�ۤ��z�16a+U�ӝ#W�����	t��V��3�k�2܆�74��E_�}~��[��{�JY����d��O�+�y���
b���T|�5Ż�×�����nЧ��М�?r6.�R����M�m���Y���wwu�V�R��e�魙��E��ѧ�?ɐ��ίX����I�Jzkk�T�G&�X�}�D���RY���iJ��^s�0#d?�b[�Fϐtv�r/�R�;[�M2q�@�/��_��%�7�K��(�K~5��t�߭H;Gl�K/�a�e 5C����<��2�Y<�.t��W�Ҫ���ئ��GO�!r��Wo9���E���L�l&ե+|yyd~�,"�[�=e%�SO^� g��ʛ�?	��s��&om������g��HS��	��t��]��>;���U�mB/u}��}N��;P�7�XH���&��
j듽_F�5Ps��y���(�,�"�=�h�Vй���0�9 ��qA����1��o�6r�6����ȑ͛�g�r�ჰ��!�L�v���N@�%��j�̃-~�����a��c�E��TՀ��﬐�t����h)��:ͥr���sʭ�F��Ě��ĝ�\�\<39�v��6n>ֿ��P|�!VY���b��P��f�y�A;�-b^s��s�A{����W�f����_0&����	R��
:���yY�_��a
��q��^�ƞ��L����J��������\��Ӹ����N^���CFvѻ+�=��^�a�+0�W&��!He$���U�}*�e;��T�5�_��n�LVp�2 }`>�B�4>:3�A/�APo���HU��Vg�$
�u�����*�������
?��W[}�*:�|�L=,n�"�
x�PD����MR�*KE����{�kv�3�V�I�t~]X�pGˬFKA-8D��<�O1ک��x��=����Yy��:O�d�}��2�qr\��,8ĸb�k�p]�ׄ`\*jl�ҍoK�Z��@�?h�:!����azE��;ޕ~K�-�����C��ﰰ�nv��E�uw�ڂ���`U٬)����Et�V���z��Wq������
"뿄�.M��|/sa��Զ�zE�9\�A���U�AuH��h!;K,��.	���q�嫂Ϝ��&�FV���`�7��^��6���Ռ�Ռ�Ռ���Ռ�Ռ�\�h�
|�yQf��_���.;&���C��s����(����#�����;�q_]�ϋ�\��FB�Ȝ�\�W���2������r�|���=�ʛ�*��B���V�As����=g�C�
:%v@�g�|�s��z]Գ�+U�΂�d8
��m��D���0~Z[`[��YU7��6�E���M��ぉ����,�.��׾�f�NĿ��-���Q.`$�X�^����!�]�n[�	sDi��p�7����%��߾{�衣����+��h�F��p�b���T2:O�{�v3�1v���
{^	���ҙ��=k�ړb�/�I�(����h(��ZM�s��dDp���z��ޜ�K@������MM@�I�s�g�����~�ހ���jaE���.QD2��X��P�l?���k�Q�l1���sV���%��)��x�\]s�	�= A���s�yY�ey&*��<���g���Q@��e��z��Э�e\��ºl���>@;m��br�/܉�I�g������ED��A��PU�`O"al
�������< ���|�`JzLaq��,LJ
Z��I�/?"��8%#��MSX��� �1�)O�kc�.���I��f4flP�=���9�[F��`z�y�7�|�2����q؟v`P��6�i�om�K�IN;&�+������k����M��w�o93�DK�C���R-9�j��v\��6�RUU⫋�>!�&P0�ʢ�
,e�u۫�uӁ4��?kr�k$�sPf`$�k$p-i;���Ai��(p-�8�+-����&�:���hĲ-�����^��)���yH�ݷ�=���q��W��-���O~�uI���U��6��G�=T��R����lr��_np�8�d@C�� ���C�%�F^�k�����=܎;�B=�ʦ���n�%�AZ�$"/Z�VTU���̾�t�tƄݨ�b�\�]��C�
|Z���a׆�ن�
�pVC8�o_{���g�HE����8��d\�~�ϧ���Lz䛙�ɽXLt;�6�I�����Gr��h��w������:ì8���K��o�ucߘ"t��V=�I(D�
�]:�X��=��
�i�O�W�{����&!G�n��_^����Љ��,eī��T��ʕ�q��w�@��K˱6�g`L9��z]��L%�]]�pO�A[��[��g�6��ޮ�r�a1�{o�TB�d*%���~��I�Rϒ+��<4�_m��TN���}�!o�����i�7������jı����I�4�~%�LB�m�܁�`i�.ӑ��Se��:� � 9��4��&�����y�f�c/���G�����YR�������}�̉��,ͦ5�|-�Si�ɓ�������#3�2?�?�s��y�����F�+1�Bf�5��j0"���Nkܠ=���D�N�6��#�g�a��fzafo%"K� ��_�<��/���^.+�(#�Ov߉"�$�;w&#>I��&"��l�JS2��cڷ�m�e�Z�����;wf02�2dLt�C�@p�˹Xxx�D�r��f�Ǭm$	��MQ�CI����C���f^BZx����˩5g8�k�/�S>#Pl_ڨ2�8�E����0�M��C��uM��,�3�}6�.2T�+;��"����� `i���1�9�}SU0b�b4kt_�Nck����`��§ �R-�����M�8�>"�R�{^�*��q����RN�oX*I�ͣٷ 7��Ҩ
�6V��K��i\�$���ڒ�����E��e6n
N��D�a�#�w�ݗ Շ��T�絉#c�՘�:��X�DvƇ��(���-�z
mENf��$�oF桱�� ���`#��J&�6~~̵[R��D�P�ƶ��$

���:���#�V���w���⣣�8��7�\���]��>!�;�)���%��������L
�8�-���F���PB"
��,:J" *2�w~��,���L�R&*�W������;L���;��^2:��ox��	UB�������P��Em�h��E@�k�`�G�c�?ke&�A ;?�S�8�1���@��}�!�7l��{�c����������ı��CFf31X��P��������
�1��@��1���ͤ6��C��-�Ώ�
Rlˌ$CN�
[u!��,�g�͉杣�2���<F�.��wV���m�����x�5&�����4�VK��Vɩ?0����8�$�:��2�FE~ߛ
z	�*"���
���
r���>�T�e�E2;��Әld�X�!%A��Ob4����U��a�8w�?b5���BU�\���пbu�̖��=�I��6������=���Z�Ǜ
%��[4ddlmd�vI^�񑮮���\	�b�hg�o��r�@��Ւ�UU%��7��C��U\�}�40,dZǉڋ0V�ֺ�������,�����_&���Z�@]6ڕ���F=ȍ�
�+����y����AGwr�^��C��ii�D��M���X��8�0�a�+*���D�8�Q�pqqq���r�=ݩ����qC�X,��`j*眜�7��\sf0�h1;��
.��P�S����1$["�/%�uO�&TߴNSo�T�%F�P(��\R;��7�(�&����o��r~�T!v*6&�{R��ZPG\�(�
f*C?��7�Vo�\�կ��p�C�4�oC!�d`��]/�V C΢:�GV�I )5s".2@��د�5v�~V�rW���Q�u)5{�覯�Ӟ�1~Y��_�l����W~wN9+���6��H0V�J�Ý��?PWl�k�n``��
z����������}�u��4�T��=nO���gJ�̜����B~�DΘ���h�p5E����bJ�K�Ŧ0�� �����[jwA�
����꼐)�K��.�!�`���3\J�
���n۔���q|,�9�g��M�(��Wual�p�InSR����?��@ݯ�M�rn+���\�*5A�`my���a�];��>�f��D�����xڨY�/�u%W�G�G�8NSh�-����qn�����U՚�B����ș���
�!�*n���*U9��o�{p�(u��#
o� v������Pq;p5��Dhm_~��ܳ�4��2���A��,����0����.�>�����
9B��^��B���}���������z���f���}"��4�!*�Qm��1&]�z3�G�E����;H�N*y��$)������6|q�\i`j�x=q�!��tu_�W�g+��Y�.C� 9���t�I�E�u���T�.�>�v�˼�|s��Us}s�[�����=>�5#ܟ����Ґi�#X���<L�����n���=��]
�ӑ���D��a����լ�2���]��Q^`�j�����>�J`@���[���J�a�b��aG�2+c
���u=��_
a���f����ƒ���wζ����֤��W�~P50�Rb~6�d�"h#���"��:��y�>v%���n�_�)�h�Q��&���57�|�+`�0�h�8�~�\�$�ţ��U(�.�_�H�ɬ뢕�-�W<Q� 
��I��{�����cG���bz�����������6��AU�\��ڢ�H��t��2Y�k��ä��#d�6�ϩ2�3	Hi)����P����L���Ǧ|��xZ�u��;��$^SPc��ğ�8Ru�m3p�U���K:A�=�K�8YR|�
6Rn}�
~����S�.댭�=k�����s�2�~A�ӈ6��w�����(� �z�W>w��O�O�={�N(hx�:�x���q���M�������I���B3�2����{�t��5H�?�hm�HF�`�k&��v)�Ƌ�����ķ(9�r�t�i�7g�tYvH��+�!�Sp]		:�7*��f����ޞ�^_ܘ�Đ���#:������є��|�����������iTm�)3���cR�MI�z
�i�����D�fF?Υ��OF�W6QJQ?�_5g~���J��p��~��F�aˑLm�h<�kU������\E~]qE&��;?.�Pq�J��ֽd�ڔ�%]���Ǎv����3��2��|M�Zm��r�/-�|����LC��<�R%�9�%�;8+k�w"���Ӱ���s����Hk�Ѡ��0K�k�9lTjwy�1,��Or��gݵ���#�J�R�Z
+��
̮���D�n�����
�U�K�tnõ���I�W���q�;L����M�W�6KBE<���=�ϣc�r�>�k�j(r��.���2/���� á�r�j�?{,��m��䂠+/CDV
J76*��0%���
�2�n;9��Ӝ����I��L<%w$!�Ї�G?����zմ����%��<@qk!a�r/	��g��Y���:�Y�Tq/
����،uʊx��@�2J�7��U!a�ϐl�M�Ǫ̃̄di�8|_�`V,EEd��������w�4뒺�j2?�r������~ԑ�픟^���������ݑ�PY�_d��>sԍ���� ��x��x�����Α������ ����8����Q��"b2�������D�����V�QYYY��pA�҈ƍ���^��,
�ª?%�f&%&O+k˿��b$�E��0��9{;
�)p)^����*^^e���1V ��~	&e�z�8ߞ���e��?)y;-�+�dD:�}�}��b�k����z����^�9ꪯ5�	������V�Z���U�����k��%)llMM�q���/Μ��� �8���8�M?Z�S7�<����%������ 8�����O�vFU��/-�m��=^���<`�e_y�P�ƈ��R��^�y�B2��b1�	�f��6^͠4\XЂ�r�:_�����VZ��M��{������ �8�n���"ОI*�z��a�����fP.	��W�f�����I ����Ϻ|9��wF����E��v��Ğ	x��R�����-��b����p|�
��Q���	�� S��P��
����^��+0:8
xy�8�IY�w�2���	��`�����ފ���!�?��#7V���Q��n�,4�`�y�O�AB�>8c����k�sf;R��o8B�Ȫ�F�R̑��6e�R�$�t�j��[f�>B�#�񃅉�kƓ���mx�-�S�=�?>ßo<��p�����!`�۔�����ǿM�5�����n{2U�w��pY�N��<ɦ�X彑��B�Ǫ�ٹv��;��v6�����)Y+H��4VVdd6.��*�\
��98�T��]ѳ�KY��q�����@�
]�U���IX7
���:��pY�B>�Y%�{�S��ܳ���M��P8��i�V�G���Ԃb�~9Y�{)�P����=4K�N.�:Z�<d�1���q2Ö�iT33�[c��)_�-�1F�B��{LS@���xt�2�����·�T���X��9�66w���JF�%&2mӳ|�@����K�EՋݓ�a����!�hy%f%1��h�b�1�o���"��\�?������&8v��&���~�&�3��q�Q�������1����#!�P���C�C�я~�y���i��/�8���ӿ���߽��g�fk	,k���`�G���!9����	G�3NF�؇���Z����$��`!��YSU�Y����dG-�i9��y�ۧ����si�|��F���+��y�SƓ�-c�͆xW&l
q9����YY��=;�٦�����>�D�BD��-R��t˖�Ѱ � ,>V�ھ�q½B��P�
s��r߀�\=�����������J�8�.FY�P��q5��ω��AbJ=�4
u��7<�lQ���w���݂!,�p���<��en�A��;2�x����1(��6���2��SZ�_��4F��^RR�V���B����8����쉓h5��6n7�Y0��x��U���-%a݌��;h����z<�Q�>�2&8�6�5���_Ѵ�����}��Ѻ~�y��OGI�g�������Ee�Y�G_N�#�ܙ /Uh&�@DgY�O��qL��@;�;<
�b��8�CR��g�c��_���A�omyv@Qe�o/}ۉ���x�-�~ѽl��;��]�,�*�V0����
�R��ۃ�(��y���3�/�G�J�㜬G��*��C�A�ozT*uBW���Q���e�0-hg$�!^��r�^56�[�%��i��{@_7�}:��CU��5UHOR-wwM틷S��\yď�x�π�����$Y8!�譣�u���KzYoꖂ�Q���0��p1$�0/C�p5�Չ��u2	$S�%\��qT�&%����k=%���Nf=6u7A��+I�I�-��<b��LgF���˘�s��L���P���6Ӂ�xh��f�Ybx��sn~A���ϰ���Rr+�^�Y׈�ÇdK^WtV�4�f)���۠ț�B�>J2IT�������-6�ދ)�}}ξwCsɯ�Ai����@�*°>�{�q��h��4��Br�z-�A3j�Ҋ	~�7W,��܋����N�:}UT�.��cn�+Е�����nt���T��8=���a�����Κ)Ko%�B��KV�S���;K��"I0��M�!{ݠP(��0��[6��]e:�2|�<oڒ��mS���9���������層���aK[t�i���a1C��o�	��Y�?�5��.�C.�Q`�K�RW#�oE�n�F�8{=�� w�wzz���ȹzh��gԝږ��#ߙ�O8y�:gn��&��#B�Х�����Tf�{�/�|��PU�5 ],#.g��v~_\����(
�L9)���C\���EH&���&z,�K�e���>���TN"V�Vjz��77_Ƞ��=�=���GYm�W��_c�x��[xw$!W�8��;�R�Ѳ�	כ�?<{
{�*��y-�N�}|��t�s�%�5��q{�ڋ4���@F.�륂!r
���`iﹴik1�����W��⿙r���4|}<4�)�q��J�_�"��Eۡ��~�2#�w!�����2/�y��g�=�(���s�E��$)��%�
�Z�dj}L!B4��X�P㳵�4���5"�Kx�˫��I:oe���b/���;��4s�E/{�P�kͅ�<(����M:�?I��q��1pL�z��j&=����]\$u���
�	8)㟪�;D���o�0}p�F�f)�h�X4R�= ��qʧT�0�ν$��#{4BO�ʢKiТ[��{c�9����>����=�T~0qdY�{�i����e�Ϻa(�e���p��ћ�۶.��ʧ�(�aʦ����������-d*�s�t�ӂ]�Q����B}��׬�ʟ����!1���{P���|����s3L�J,�0�B��Cכcu�T2<s��u鐿���Ͽ(�3�c�R�	�U�g��s�Ki�_��m��>�t�K�\fw�ܶf�y���&$rh���=��ɝ���̖��7���,:�8����n�E�e�
�j�.)��~�8rE���` :6^}�,r5d��ݮ�L�{n�,/q��j{����~�� �!�N������:�c�wg	���+�stà���س�CN�%v}�wO�l��~�j	n#/0
dx4�����;#���qJ6O��9�h�oPz�h}�,
)M���ve�G�����(	���9XN	�|���,���L�X���`�p� ��q����r��yFP~;����c�)����$r�]1�3��+�Iw�Qk�@Zۉ��d������O<r}�.>鮥kU�
e��d�I��[�v�3���h��=^T�n�ť,z�%AsZSdq���Ԥ�d���yB�iq�/��	jуSj�0ĭ�l"�3#�|��G\U��XA��Z��~
��Y�N�.���h���	�u��C�t���KF��`�~41`�x��b����d�bϖ�N6]���#�����6ֈݯ6h�RD�P(��f����b��S8�������}YZW�;a�gq&Յ��u\)T�%g�f�׭�A�$T����-��J�=�o�(���)[L��D��M����7MOQ9�BJ}fT���dj?]o�2�N1י\�$=�^+��mn(8M�gwF�����9-�=��NsL"�mT׽���)F�����6`R��ӈ��U�C��`
?����u�����
���<�cc�u���**"�K�b��@�F.��s���A�QR���I@6UקMRƸ�UA#z˚����*��!*Xb��@�U��<|�����������:s��?F��(:	6��)���nj��^ ����SYl�0���<�}�L�Q���P:��ۅ�;�b$��D5j�1]]G����g�����sB2e�t��H�5q����Anv�%*�����ʦ�@\�QT�@���H�����gdN�(��%��Ƃ-��ş��Y3
�}H@�O��h5���5s���=���Z�"7d�\ahkkƭ�l��Ԝ��
ږ��m��V��@�ܩ;�zTX��iP��;����C����<s�\>�$q��C�I������i.Z2�����FL?��I.�Tٲ�a��RWK��2Ei�\�� �꜑x�px7��M�+��>c�Lݷ ��1t�V1n��D�t��L���I!�I�I��o
[�LN��"��"N⨚��۵ɥ��+�Z4��0���VϬ�:�4�J�E�@��ᬫ2�c���c�HCY�/������~���Mȁ���}u���Ɠ5�ޖ��X���(��f�}1xh_��U�(�@��g�
A���^�J�A+`W�<m@nC᳁N1��!a�?�h�P}�w�e��:S LM?S���yzC��@!};�4;	���S,X�E��r|l{�F�O+*C�J�c�ѭJ��o�5�t^�u�T7#r�k�)���r��³ʽ��^hX���iG������{��s��F�+`G��2�)��������ȟ.��1�}4�k�5I����ڵ8�ӼM@�|�8��I�:~&	�(8f
�O���cIJn��0<�CR�}
aɀ�3�Q��0���/j)S��nJEv��_6t�F~�L�������v����C�;�į�Q�<��1#j�5�3�br�Q�N�c�ݢ���8""�z����
���M�G|�,Qr�5�G��@�!��į�l����+�V���N�yS8U������bq\�=�_�bK��p
ņ{Qs�@���~.d��~F���3t/htWRPW��JA��
6��\k�v_���)�����$IP{���!���L��A4�z���O��SI�&��|����Us���^ᕰ+���q���]��t��r�b��Z����7okQv�sJ�W��tZ=�Ul8ٞ����&x��$����δ�!QU�#@�>�lJ�L��`O~�-�"[�������������s�rZ���?��p�tk��²�<�!�Ԧ���8��;�4|�̩N�!���HC�a��=�MΣ����2��۹�c�~�$�����IY�NC�n[�>h#ݦxny<����
IM%�r�l�K2,}�W�X��:5�hao��pS�Ht�2��
J�Yc��]�QB��8]�bcMO���m�U;����M{��C�N	eЉW�KC�K7��;���R<x�vf�k�K�G,�a� `�E�؍%
[���@�Z�8X���2m�E���G�Rs���k�R�y��N���l�8�_��a(п�@�H�	S��J�Եl��Te#��0d`�)���1b��9�غ�2�p��3���TeJ�FJ��R��E�B�
)��L��O6b�/f%��7ԗ?Qw�4�6����GE0��ｌ�{�Ϗ�(c�:���3,�FZ}0��z�Q"0��@��q��I�����W���ɿo	,�0>Ο|�Ex1�H�የ��,�b� W��)>���->��vS��*��Wp�&*�W�������_��uw��ho�]����.�~hDҼ��5�@��:-��aYH�#l�i	���S�ŊK��WD|�Ǡ��&�k���I����ym���P�wSTG���t_��e4��+"6���v�Q�(�d��@�-��Yޠd�;�P!�
UJ�s��vT��
�z"��/�*-������VP+[�F���+��R���d��B�i3����{yp*|R�y4j���)۰
�-#dO�}���3f�i�0�`���}(����z�/3�B�y�w` ֦Z��aZS�%�/��>Y�yh��El�X�h��%����E��������s�Tv��a���)��-��L�t��q��:�[a�:��J�cS�[Lh�Ը9�����}L�Z6��
륛�Vr���cH���Ď��Ꭱ��ȞM$������;<+�g�G��ņ�NTւ�,,����FS�w���E��)�\�᪊;_�@�P݇�a~��N�VS2c{"F9���@��ɓ�O��;��`���
�5@K]7~ cF��#d����Z�tGC�u��*ɸoIܐΏ�9̕���w�C�^�!�uT��>\H�#
"�M2Z*�N<�W�&:�-N1i�ן��v_�I���|�������%���MI�I29�0A�G�IT�,����5��[�
������5���#����57�S��_���5A#��}��o���5�X.�e�/ΰ��Q`|��V>��v"��-:�kI��K��Z�s���#�O�w�1n��<*3�b}��V�s��~�D$�˵��<`=r��Rq~�=zC4��+�=��܌��>Sw�
�(���RF��%��*dc�`��� �Ne7g<��N���
���Ŧ-�*�K\ib̲%�V�͊�.q����,��.�����`�3>)�DǱ�<<��Fª�>�� Vb]%�˓lp䒪,�5+�ۥ�:�ސ3.ZE:a��q�H�χ@�|�1q��}0�xi�nQ׀��g����T��x�#�i���]����"��}�VN[�����s���(�*z��	d�uX�#��C���ͥ%C�����-�3�j��U�&.{s����]D"
(�:��)mg�7�r���:�s���."�m.*��3k;����
fY�Q�s���~).
���I�@��O��l��HMP� ����S�p�x��|Y��S�$o�Ihb��L�o*�DK���PDMʔ���m$b9nՑx6����l�(�h1A��@��gG�`�h�Q�/�E!�n.,�z��&ɸ����co@R�b��?�JA$������^cw:��l��)d�w
���p܋����Z�X8�Z}���geyF�F�Y5��ĢL;ʹ�ˇ�&�t�O�Aϕ���z
1}6K	徿�Tvq�hJù���Z��4F]�B�d���Scy�s�᰼�T�k�	�XZt�:���
F!*��R�L�J�đ�$x�}���ԃ�I�}<���I�L�Äіڦ3_��D�w|N�L@#�@����߀������/���I/v�G
�7V#`X;��Va�,���0�˜V��nh�5��*о7��C3f�*2�dN�Oe�Y��!Q���"���#o�h� l�s��:e"� ��T����E��Y��Yf�NfKkA�/A���G"���x��V�
3���-(�D	 �۝���/��^�h%�*�e2�T�����C
v����vh������F��8"T�p��HT#��6|�{�	��W���?�m�]	B����%ّ�ay�����;��U��}�?*BjL����Y�=[Fbf��=���x�2��yv�e��l��S�p-_�;����P{�]-$Oy\��f����d/I��y9t��L��/D{3v2}��1�93�uA[J������(����j�x�˻��v��-=�a�r+����H�T�ܲ��VOJ�6�sy���6ض1g�
%B�E�t]�s�{*���9�����{>LW�]a�8��ۢ�e���F���3p��r!�Q�e
��me�F�6*tBh���0��?�V��b�Y�E;h��j~J:)�Ƈ8�^��Gִ���w͟FW�~��"���b�x	P�լ�#-=ż�h�&s�������g�:���[Yq�2�?���Q�l�aUl�>5Tpy�Y���a�p[�^͒�-�"M׬�e�<�[<1�
�s�F;V����!lg����+�G��㵅0��*<����, s�[ھ�Os鬇�	��D��D��9v�����;�/��@q�^�s�!ݒ�+�b>��@T7�P���8����]�?�YѪ��!����}V���)9��q�CjGvla�[/ǧ�U~8���-7��@��D#^�9J�l�E�9�@�ш����Y��W.�w�r8J���^u��<Xj�d3#��E�>T��W{6$�=�\v-dn����t��WR?X�vJ�O{�G|@��A��� �u,)����b�/�`[���3+9�	�bH���c*�0r�B����&����RNSx�|��%����n��a e��fYk���탗ȅCs�y	и,̈��ym�d�?CAs�&�`h��I,|Pvl���Ӝ��>�%�IݟZ�%n{h� ���!�0X�Aw���6�Nε��]O�(V�����	���s������P����s6��S�㢏��y��F:Ғ����
�[g��v	��WB�c��
X��|�d٨p)��	`�o�\��
 ��:[����w�I4�R��b���4+.(�5×��?�B�5rD�����Y]F/�~��%��
Y_�Sp���ӋY���L��=N�eȗ��*�dm+&*��C�+X���9g����3ϼ�c0�毙0����Y�ÿ��|�����2�/�����O7Cpq�
�0U/$}�����ys���W�=0.	���Z W�|�[�m�w��ݱf.<��e����S�ۍ��~�XwY����d�L�2��ǁ�ӂ��k�|�X嫊��F����<�ܗ������OU{�4��;�:����3�����z�����l���=�R(AFz�K�S�1|��	��<un��W�?���y�n��!���ǳ_~QK��x�3a�AkOZ.�����%�g�<�[�"�([��v���(r�r�SFq�({	,�ns��^�jo�u��<(��Iq弄�i���S���h��2c�?�������!|:�@�צ5�;cR2�PW�.Oc,3��~�-|S$��A��Q��H.DxNAH�����V:O��KuJ9��8"U~�7r������
~~h�:��+��
42���yWފ�n����bh[1�hX��ʪH��������hEœ5�8��h��T2�]����2�=-kA�d~׽�KU�y��@�NP�/E���U�)�﫴H@;�=��u
b� r��1�:#&	�Rb}Ԯq����X
R���<FA)���j�p�j&���|=�Ւ۵�g�4#�������P3O#��I�y�p��.�Z-R�q���LM��9F��S(�~Z�8Σ���<`��H��b�1HKM[ �0h����~���F��Sm�3ޜ�|��4<��
P�W ɫ�ʿ������5����W"U��{����#0情���1[")� OHNm���̺6�jH�(��~mM��V�Mp����S�ʇ9�Teo��l�;G(���
�i�O8g%Y�>ϑ���qxe��Y݂�����H��\K���m�<=����F`�mR��]<���R�Z�}�+�/��\�����
��Մt;��6l?Ĳ�B���u��H�dh
A��"ggN
��jT�T(��ڳ/���
���|�a�Gw����U\�^�x޲w�t?#^����#��c���.cj��{��u��3]��֕̂#�\ɠuSP��?��]�y����yM`��{�7�����P���PzMP�����*��h�ݛK,��}E�q�Rv��A���1X�&���M,�C��*h��}�J�jC��@���u��4n�> ��
�m���7���R`��U4S��)f�\Bþ\Q���g�ȴK�ÓUj����eog�#���A�u�O�H�\��eB��X��L}�@~���PS�aaD�ח��캴�t��`�sߓ̓����#��ј*�bu�����������xSX4�@^+2,U$ ���L������I$_;ӭMZ�#�j�fmi���(���:n�d�q��E�rڼ�G�g�֌�&�91��	�w>:P<*;�0b:�xuH�����$f�-�U��!�[�Rb��b��{F�� �kbYb>�������%a�����U��KE�O��#?m��$�ך�=J�-� �u�$�g�� ���h�FP&�faV���X�SQa�o�!��{��SَmY��Y��;ȥ
�M�M�^������ܸB���s�������Q%꾎�	#�-��y�xb�Z���I.�-�T�!�?�^�BFV�m݁L��s������1Wl���HFp�u������e)�-��o�N�
d���I�(A5w�@�J�����0�?,�V���
�᭜�r�iRh0rJ�0b7�)�!�-G5���g��y��}�ĳ9��=6�{�q�7�V�X$����|	v�I��8�������M�㡡�n�9�o�����ҝ��o���U��<�p��?l��{s��"UUB�ZҭZ]J�%%�>�H�YA�;�z���^_�K��F�a��TrRW�P��K�!I�o
����lK�n׫�+�V@���d���tX{�{�HZ�mk������C�g��H!_���3�O�$���9�w�{n�@�n>�Ĥ��ȁ�
�u������o�:�2�0=��і��&v�F��&�d%����0�/�!��`H����Ç���j�7(�V̑��bKF}���xN�>g-{�
T	*U���ǳ�ˉGڦ
ZzWV�)�Vg��W.����i�B^��Q�Q��@֭s�a��Uh���4=�����!Ru�Ό:�狚,���Ģ�F��N�e�VΫ����;�1�H(�A��MQd�7�Q�����p-F�v�}yC0���yy�b��ޜl�wVSr
�a:����	�׫���[<�=Q|��PĊ�Q*iu�0�76��2����ӣ/P����Wl����{PT<@`*��0�u���&w������أ��(sf��A�T{�l��/�u�M��j�Ѫ�aѿ;ʋ+�eLL�Y��/�a�"7P�1V��������	����<wtR��;(�[��?�q�ChT�(������XS{�PJcS�v|�y����7W衖A�m�ee*�[��7��:�!��7b�Ӓ�A|���+Ι��GD{�!��4b�~B�����|��ǜ�u%cʲ$��ܔ�4U:��s��g�+���AU���
Aށ��qPy~0�"�>Z!2��G�{Ro��8��L�-�1ؒ��/�)�P��������B�P��J���vv�e���<�@�=�<WB��*��<@���8�πeZ�"}�%��
S;XAˇF|�?ȶ�ǳиv�﫫(ѭ�Zm�+��|��j��j�r���@���t�����?W�]����gc,0��[�V����:��J&���m�Ũ� V*
!	C�,?��Kл,����-�|b�Xd��
��#�cR�>|/����~�
���xY����AT|=�G�1b:`�Hi���.|���U�iY��	��-���g�l�"7��kPAK	E��K�q˄Yi%�N�?�:��|\ɘ�D�KӼ�Р��G8�����
Ǵ���Ļƭk*��d~
��3���3�+�Vn�ت�AЄX�9.��@o�j}�Я�}R��@���8ǆ�,D.���+��ϙ�.���pvĶ�*2%���+ &Ȱ�J�y�
��4�#�*9�v/�x�W?d?�7�<0�`V�F�|� ?cmnv/MG5.�f��-��<��S�ϧe�.؄+"WN47Z7��ḇq!�o>�Gk�O��z��
c�
�����Vā�ؔ�JfI��l���^y9
�S�L��}xM:$:����FEHj�5̣�+]^۞�H�w��P�U��Uq���	�g�#-�����o��HN�;��Kn���X/}����:��F��������_XY�3�HP�0Q/�󅗹�����p3���4_����3"�;n�h�Kb���]͑s�����ob��7���?,�9�T��j{�rE�>�!��s�@��D���
.��aV.d�@�#����W����c8�ݶ�^�ֿ��R9��_�1	sK���+R�s��у��A�m�rܙ�G^ǵBt֨���)8a�l=��Or��΅�Rʌϱ�d^���d�#VA}r>A�>���ÃŪ5���F�O}^��&֫kG�	
�	���"YyDօg~ll����4��d�^}YI���H"K�e����Wo�cA�*M���YO
�=���#�?6��_�ђ?NGͯ��|�Q�onG�6������@��k(�������)ʌtt���ض����:y*�^��ƽ	)}�"*���p�+f:-�gn��)}���������F����P6�bM��qӯ��|�ƐIE�Jk%�N=ۢg�yDqb^� 󭵱Ϣ��Wc%������5_Dj.�秨Z�o���\�ud��� �P
�ֵ1��.�϶wvc�a��V�g��z��ӧ���?h�P��y�����[t|S�@��V��ը���?f��J�rf���y�m�����e�a���N��U�y��s��U�m�_�L�KaH%=��7�q��0<�K��cx���F�*c�v����F�ɩ��D��vl���j��d���rځJw#�0L�%n��sbFI�l�oɿ1B�
��{�E攦ؒ��Iw`��Q�a���PH=!%֐qՂx���,n>�ә7��W�a{
u�Ͷ����F8�h6�:&��PC�-�rl�ST�
�b��f�?��	�x�j&����g[=e%0�H~)�����g2�H�BIU/{!�P���Eѥ�n��B��v �+L|��_�p^n	ϲ�D�3)�$�3LO��Rtl�!v"�?�4��Z�ix��v~�*k�q�p�Z�ה@_�@�3U�%+�2��vm�+"��q����1�1#:��1�y�N����@9b�{w6U�C�0�Θ�$�f�f$��⩍��u\��y�Y�W�P0D^�EqV�4��;P�yޓNk�j�x8�j�P�]Q���(A������z:on�l��拉���[��L琌�Y<r5��
<��E4�a���<��K����b��.��F���t�L���_d&�B��$Nwe���%N����9��ھ�	����f���S���V���0e��\h&��W��u">2�P?�����8xŮ�y�7
�7�c�K������7�,R�5��0R�x�D�A&]��roy��l�Xǥ��4_8 a�QEZ�]�Y)�����}}!?�T�fQ�a���D��!D�O���, �ӝ�)����	��̌;�y��&�{H|���GF�דM�
�o���}���D=W%�Z�J1��9i�������lf��W��,�m6��	��7L�݆Y��L֟���w�4�3�
H5Yp&�)E/�]G1�����:a||��N��Gc}D�}��?���b�Ye��*_��~��Ë��w��&��Z|>�x�io�/���mY#��Jo*�����26���7���V$�K�b`
�lz���>������کҊ,3�L�m�)&���e��l߬t� .!&p38ˎs#��U$~	p�R‫�
:�SڇN��?QV=IB���~.)?�-E}��o�{��DM�%�j���X�i�Ѫ$�8���\/�#ddR����,���C2�|����WO��<�A�l��-�X�O�(N!�u|1y��&���QM,7wF�Ծ��>�,[�3�/���M��G&g�UO�%�HV����0�<2`��#e������k�{������2z���^P(b:|Cm����p�Jѱ��]�[��Z��9<�C�Gma�l�/���*n��d�/�ӡ ��m�q��`��.V�w,�Ұ�+�ox�+O�#�+�c�&�/�I���Q>f)�$���������M%�#
�+A�e�4���G��#T���v����z;���M�w;��tc���
������`-����&�I�I�ε������S�A	�P��񹨗8���N��`��P\�L���K�)�݈h�.@l��V=,_NR�Ic�FE&X6�J�؆�
���-�J�ݸ�����ȱ� M��7/}@*��$�-�-�Ƙ��w�@*���]\�y��K�eL�.�˪�Z.ځ�5�~%v%k�z�+�	^��MX�y��em�Q��.f{ w�R��%���Cz�oX���ty��I*mo�y�N�М�O�o���:�.׈�[
�.�g/a(lf�4���Y2yG�mv��c:oM�8(�}�T0O9?ٯ�J]�p��Dg� ���u |S�f�#3O �<��(�Q�+ ��
��b�%K���є2����s�]�uw�dvX���:���`o��T��x)���:"d�I�����gn�y��p��xKqs���5X�b�&�0^؁�� ��PWkng���j��J^����.����K����0z|�є�-r������
!��՛�>c����E�*����++�����w�r�߼L��KodHz�c���g�e�*D�}4�g����V	��G��8[����4�� PgZ
�2c�%�	��������M���r�׶xX�%`J�P8�+6�ޙP�Q�-���1�½�9�4,�{/�UhX�J��� tM� ��ga�w��3
X�M�w(���]sH����XIʂ���E�=B���Y�;=�Ku�%89%��W������}��.�!S�����9��Q���ڴ�1�)���ځ��c��=�T0�i�?ݏ��!�m����+��-ѱ��1g�d���rU֛l�������
:�0
q���W0*=J��E�N��(�����K��Q-Ҽ���I��A���ɜI�����*���T����E��A�H�yf�ՁV]E������3>p�.��"&�~�ì.�;�s��4ML:�_�h�y��Jx�8�Cu6��O2��� �I�,��OD�!��=S�?i;_0�ɰH���[AIH������K�q���t2g��ħ��UU!|��g����?�@��2\�+�b�����+��]�H��+�2�������8a[����B�=����L-j�A�\_<�xö��4Flp�+s솼hQ�W�Wl�W~	�SuI�MA3�I��g�kT�i�.��������8T��P���8��6ٗ���&�jF@��xFB���mm��/�v��6U=O�;���A�{�ERI*�5�˿Z���Z��eg���y�-$�d��=E��[}������7�8!^$�����oHuA�lG�L�[��F��9�Y�Ý���-|�U}3���Yܹ�4��w��-�v�*Ȑ��4�(�&� ��U0�w��"�f�!�$+��%�+��k��gS��ZX����������(����/�:�Y���ʾ�ϒ��;q��SO�Rz���*���FU~YJ����U�eގ�7K��sj�oQ��������)�1%4��L9h��vZh��#���^)>ΰ�F�2�`ɲn�x��Gm��^��V��-nb���ۖ䪶R@$�h��pN��՞�+��Gl�������=�4�w����{�^g�Fwe���{�5�{y/i�P�Ja4M�o�N�,%�����%��W�5�+����Lo�^��Z�}t���ZT
�"�|���Y0���Ul��8*��I%�uU%��A-�m=T�i�f`G��SN=�Fz�y�7܎J�}���	�8���(�j���b�e�שׁƃQZ�0ξ�̥�T�Q^�kk��0���ر_�f�jD���j�;��9�@e:vG�y�4(���	z��)1�T��I5�}�0n-c5�PKb��@3�(ū�U��؛?oz{����:[��P�K�rƃ-m
��
�+�ǝx�7d�4�]���@�}��4���ډ=Ϻ��+����D<��+�����!���pvc(�1�J6�\��n�Aｦ�>1=�<��y[
����GS�p�RongϷ��Fzh��V&��j�`rH�q��5���}��0d����4y����/WP�N�yF����G�nTp�>g�б��]��82�\�: ��\/*��6�(��jXĲ�n�� AVHy4L��itxJ$�˒�<0\	v[�����4�5�s��Ud◝鲿�����b���X��_^$S���)���6���T�����1^�C�CT��,}�x�ʢ�,dt�l4L0�;�F�f���c�D��mS脌�?��q��;��6�����YN
�}	z�*a�8	����\X���h���aՄ=]��tF��$(EO<#����3�����CP�(���hVS�h.4�:���{����@^G˻�I���T��������D�j^S���u�C�B��p�XV47���,ճ❐��6���#�b"ϑe %7����q�`���%+)T��Ә��[8F��8�z����;��>�:��j����T+��R�/f=�2��t"�r�[6�K!��8s�#�M�>���*mI,8�U��V�J&i��[PL�]F�71U�?F�>n���Xg�ӋW����C+��}���n��ƾk�����
��6��:Kԧ��෥k��*fBBo�I^�1Fߐ	*!�u*��׮8�ܤ6:��_�˖����(�6�"��m����6�L�7�Ћ��
;h�F�h�ִ����)���%��羅y���H*��Av��Y�J�D���n���GB�oJkOGs�GCҙ�v�T�$w@���D\\�`�-V���Ek����ZE�����P�,p�y�4ʝZ��?�sv�u���|_�w~Fi4;�by����c�#	��t4��/�tDd�]���hڲ�a��(/��y4�;ah�t$��ח
�f�؉3%LI��(����r���ʝm��"1�Z}�m��G��K�D��wfL��Mn#��s�wc�Gx��b=,��0�_�i�ZG�"��R`�d���$��Jl�NcU?F�
�(��~�ȥ�m{�ˏ?@��qtd�����(H4�H�p~������Q�y�ӓV��%KhZ�R��F�Q-(�`^( �큎��b�\b���o���3&mM3ZW�Koo��T�^��|��v�h�(:�����D��f�xl_�ݸ�d���]	N�ĩL��#$�qsNL?�rLV~|qe	���*��m��~c$%��%ar7�l��Z:���0�+��E-�^Or�[$�5�/)�F�L�8E��B`�|�5@���,��|��1@���0|,?8Us��!@�?4,!k.Tl���V[9m��ĴE��}³=h��)ٲMy����k�$L�����^RJ �R�J����<G�����?A�x%�4���zJ49�	ye	,�m:�C�֔=�Y,}p	H=��l��ky
��Uy�5�p����_5_���?/CJA��L��Au/��$�tD����2��/��d�Kr/&;��G�g|)�lb9�
�7T,�0�ɵ/M���g/�A���G��2�|dO�K���2d���6G���:i��>�P;2�����VA��- c~9V�k��3Y�tSC��T����o��bAԏ(�f��� �M���iV	Wh�g/$�[U%R��^�|��Q����l�/Y~}�P�WfD��ּ+�vh�}Z g�3�a\I:�����~���9���ħ�!��}�<1��.������݆�wf���2T�gX�Y����E��w�D�Q~kt�����="���3�l�Qd-���)6�}+}6ˆ"�n�VV�E���s΢q!D���*#U[q|
7�z\ɕP���f�t�W&��Y��J)g��%�eJ�����H<�e��A%���^Z�`�|$g�f#��A�}��y�3xR����+� �,���\`nw� ���&���p��O�u<��|k��t��<;�V���|kzgI�@�8�z�֡N%�y�8��gtj�<�X��Vٗ�cd~9?�D_�~L�lP�����ǉ/�~�?�M�ҕJ7b,�N+:���	CJ%.
�сKyu\A\Q&qm��R�\����ƌ٘�� �IfU)Q]$�½
S��Rmq��������E������JͧYڊ�����i�Eb$�ބ�M&��r
��DO:�6�����Ȗo
�����ҹ�֏�Z�,���h��V� %-~Ļ�vח�i�T�t��i氢褣638�9#�q"n$�g����hZt�H76@��-H�kd���:���`~ q�@]���v��������呿����^գ5�zkG��ޯ�^��[�e�b���H�R���Z�x��~A�B׮������[��vrCd_*����!d4�QIv�3��zi4�����m�>�s:svt.N0i�!��)�q��9�pnj!��ˬhYfz��,jw�}<R�n���m������Y��x���4��_���}��#��ɉ���rk�*|ܡ�;^�E�j��q�oY��Z4�*<^��n���KP�,c����#�+�Ѐ]����Y6�e��单m,�(�����l��B*��Y����YČh k�R1֙��@�˴zy"b�W�=)҄Z����^���N�<x���T	�ϙ��K�">��@@�K��u��_"�V)����6�
��l�Te,����ڒL~y��{
	��b#�ǅU*&�7r�鞦�Lf��G�E���M#��U;��Q���T쒑%��H�{/S�
G>����qo�1�+�h�F���9��V��m? �<��7��]�����~-i�ǃWc4Ú4k������e�ÿSRo,O�4�"��Y�4>�6Xx�5�CC4쉳׃�A��;�8��;m��ݛ#��8�?�<X�,���"��i+]ζ�A9���F��HS��9��:Ñ�ŧ��i8+���g�9.R�������ˉv�ɵ�c�CP*�z��$��N�o(Y!��7����9|Yn����"��?V��/96���W�EB&�}��&}�+^�Z
\|�y��_�Ԧ���gKcB�Y`uVE�
��{�n�����[��Q���P���i�BE��s�InX�l[���O��2ÝL�.�B��t��+��ɍ��_�=�.���w�:k�.�FF�����G�Q8(���3�(:�H48~�T�	W����.��[��ڲ�U*S�Z���>�7�������"Ϝ�����4���t�8�G.��u�`��$��0�Hc��5����?V�O�.�������i��Hd�߿��pI�68xm�Ooąɪ�PRM�S�����~����	`�
(��@�D:�0f�М�2�.�	���M�#�.}�ӂ��/��f�^f#�>	׿�Uo�o������m�O/ ]&s��!������5�"�?��{V�4@js�q�]�2M���b�p�]���P��h��V�9�e���MH��j�&*�:hu��1�1J�z/�ʝLo�O
��`���ft�|s�ǝ�B��C�cw��Yx����eBFй��{G�	���:5�L��p�ަ-�&�J�=!?ɩC���[[�Uw@�D��T���6���_]���,(�))����I&]F��E�g	�P�6g�b���}��ux:	�%���k�n��\�z	�3�D�Gr<r�sw>��r�5щ�>���
�Г̪�&9��C��&�m���QMK˦��^(so��������q����3;Q.,�f��Qĳ1�mY�����I3F�|BA)j���qT���R�i�f-=�	
�X)h��h
�׃+��G�j1^(+��9����QMޱk�t1�s��g�A1�A4�J�GmI�������(���
�K@���#ca��Y�6ɨΎ4!�Ί��@-�k��YS��9�/���8��A���s���~�:��(n,D [��ވ�k�>��Gi��h�bNȍ͘`����Mb�eϓ�hS����Ƨ�����6_��^�<�h|q�&a?�z��pp���}�hbŮc�?A$��$���7��%�����eX��n�@��uhݩ�wު�WlDɣ�b�=�砉(YHR�4<*�c�+�h֧A����
�֎^]�#T����Wu~���;��Ʈ��X;e-I�kM�lXX��1	9�R���N)E��n]d�vh\��_}�����:�b�F6�(����s̷_-�x�Q��3-]�� �A�p�0��q�G`eNn׫!處�v�}�؜��p.���}���˯(I���.��pCi��4�
J��߅�� Y������J�N<��	[��)�BI_�:�+���i{���r�-g��#~J�~���yu����0T����=��L�<�m�J>��{LE���?�dV������NV���uvj����U���!��Nx�̯>�k�͹;߲0kLn}g�PzC엄C(��
��z+�?�N�]�u���g����"bLh�󌖁5U�X���y�o\�td,n���V�!��z��~���
��������m��Q�v���ٵ4+d��Х�O$�^�{�չ��oÚW�������;K��̗����4�$��u
ӪJ����J���d5�����7���-�/n�8�Q�v�UG�]蒞�Bc�nN�!rpo��Ln���`E%WM
�R�W��8�zQ��5��A�ڟ&��#?�{iQ�!X�xI2���{����	���2p��a���GH�#������1;�T���&��^(f�k��x�j�������Dt\w+\�K4@� ��ti����Ap�XHEv�m/n�-fX�/��_��Y�x5b�a&������R�]��5�=���A�r�FB�}�ؘ�J)/��n>�4���s�4��Ϯ��TJfN%��~��g�����:������?��x{�;�D<�s�� ]mB_��̷�z�ӏJ��?��Uaq*��N���U�l�&[%���bQG��,��^&g��J:��\��)��&6�n�C".��0�	_�r��us/��m��r�Ī�.z�����$k��%�=D4!Z�T��0�|)��Vx�nJ�B�7��Q�j��9٬@�iiw��sk�no��YO��&��7#�eo���Mp`�e>fy�	�;�ڣw�8H�m��_r��#�+Hu�2r�
�6�.�6�Q1(@�����-��Gey��+ղ��*�4]�qk��>L��$;}�g�oGC���^��ƒ����b] [���j`����U�^�NԪꉄ���T]��Z:��K�����?bH�O���tw��bS���<<\�	%3��
R�b�u��A.����l�߶-��1�`���
6�;tO�}�
x�mn��[��~��<�D�
A�EQ�|�V�8� �3c&7�B����Ж��d����{ft�`��DPG�R`�H.dqd��1a�j�������T�43h��=�N�ʹ�V�>��F�~R��v`�\�&�;?.g���1�$��A�+�A��XM�n�`�w qM��s��^�
(J&V�� ��~΍��6E�11q`3vx`���l�Z���Ev�����LM�#WҕD
ng*w0c��=�z���}r�\H�/
��F2�iP�
JZ���f�6vK]�""ڳ!+� �y��)khm��`"��
a��QNuV�޵z ���+�0�J�I���Er��Ymv���8��C����.�N-hj��Ό��"��_5���lL�+��"�ϥ:�I�8*[�[`E:����u��ho�t(b����]���08����*�>Y�@��гQ-�
��/�
v��r��n�AbB��ܼ5�X29l2\m�δlʪ����y��2����Tw��I��峩L3����a�`�Lj� �����9�M<�iH�,����$�Q��̖�������@,7�m-�����4ɬh���|��#%��7�K�DL�������L�ml2|�߰�l��<Mxמ^�`��o��+@5C̏�jL+V�I_�/�� k��?!��a~F.��c�k?)�uMX�¨Ҧ��
����(���mE��U��#�>JT�OX��!�h+�&�a�\�r�Si`n4�����<·{kt�!7^����:_F�EjYx&H��l�nwi`̀a�ۻ�}��5��ŝJ��T�~J�~�H����r��p��y��nc��
�Z�pڤ3����;����F���4�ڄ��I3���{��4���H��t��4P�#�ئ�~-د��
;�5*��e��08�fiF^q�?�r�
���9��(~�l�2�����
��y/��y����H-�ƈi6d>�tf��,�����/���9�}L_YNj)y�|�������͇9�|�R��ч?X7V��ǥ$!Lntј�x�7�ST�nI����J%���CdU�[ۇ�EI��r�B1m-!�I/�A\R��.Y��2�#�����S��Ϣ
��]�qͦ��eH��I"0�E�@5�3�´hP�ko)��]�X��/�Hیg��?��VΙ����[�i�	��8�.�7#����_9I�p*"1~Ta�}�cI�w���IU�<�:���S�)"d7h��)��&ZP��(�U ���k�賀�
�k��-�u���bR��\�Kr�zԣ��Uw�>L2�lN�/���ى��!���?�n�#�v��`�������`�����B ��a�ݒH�t�Sci|��̹ɲݛ����n�,�"8	4I���6˛	a��J$��z^�Hiƹ�����34Z&�D�, �F��O�[��,+�u�u�8��y�p�!��%�W��h2�@�lFO��IΕ����L�����S�m���w�:�^zKF�J�.}�F��Hr��=����
t�m�����3���� <�P�k�V=E�HY:C1������ؤ��E��2�ޱcvo�z�#�)����҄a�X7_e�~S�%��S;R1#P���]+��≣\ԉ�����@�%���?Kr���K>�����
)����˲ 
l�F�S�Z�����?��Zx��t�QW.��$x>�wgN�=�	m��3��5a���A��m��W�T����k�^F:��ڻ��A����� �WO�Lh?a7`�U����T��f�w¶e�<ٖ��ቮ�X�J0J2/B�x����e��5��P��L�7k��X���6�	�s���(1O�ŮH�Ԓ/��kO+
BPs=)�~zZ�P
7�/��]��@��;�;�=������7��>ڍ$�(���̲$9AZ
GC��#���>�0����䰿Oa��w�!��zO��9�\�U���"�b��<��ġMr���X�����s�J&;q�(��M�O�̐�������A������&]��/�,�pk�i����Ö�5�M����D
ʳ��${�O��@+�N|
����!KS�4���
�=��������39�^�����8���{�D��
ÐL���F 
/��wnib�0�ԋ��t$���ll#u�
*c��.Z�"��2�X/[!c���D~3K����D�wmU���1T�:����"��j�܋�ϭ %h=c�r����hW=��ל��um��L�M�9,�?eL4y�j�1�%�8��#*A_�J.R)����y�\�_1���>v
��TY�����A�^A���O��0�P�L�w,���*.�����q����1]�lX"Z˻1�#����b>����}������)�@*S1��P���;D�9���WTmR�yU�n��k[M���Jg=�:����O��/���x��2��2��f�^
�}��P�(7+!�T�<�\�cf�@��{�]V�+��b O��m��Q�����,���U�`�&��-}���6~X��������E6�Ǯ�@ߡ0��m���#��o��~4��i��xU�!V�#��E��6f�VW,�b
ϩٕ9��ͣ��7n�
�G�I�C���:�#*8����p��)����=6�T���9v���@�-�j6��|B���NL�TV�{��q��|�A�ŷ¦�è���Nn�YC��x�;����CP
�&��C�D	����Dɶ�,���Nz+�oU��*�����O47���%ok�;�hG��c�ǦT�&Uw/u;{m��"��u��&v�@�U�1��@��ʲ���<8+MA�H�ڐo�?PAE�k��(���:�tW�2�Y�6}	:P��y���h�����"#���K�j|z���9L����2*E$ݯ�3���	�<�ŭ�k��DA�� �9���W�j
ԝ����C*��������U��RwfF�I���%=�ҁ��������f��@8� ���w�_
T:���s���=�7c*G��2c���g)�T�g���#�ƙO;}Q=
�`{�A�Xo�S�q������(����EK���<$�Ǧ^,[�F/= (�g����i�#�h#�Q b�f�t	��A6_��AU}~h�O��·��
��<�)*�X���+9	�,��i#I\�&_޳޽&hg�t�~��Ϻ���5z�o�99��y�rDp�#U*��A�d���Y�>�1��.�A;0�㨦���y�I�6-*0����j,?`�r�²�=6G$W��Ea�`�y���!l���ϳ]�d�uH�W��b̵kǩ�Zr:�t��3��>骀*��n<qi�$m���٬�mϲ��T��e�1��
o��W)�����4�	�4�V�8?��T�o�B��pl�����K���9ٜ�x$�������G���3x,"P�%�*K�j�2�QR1;����d
O���Z6tG���z,V+D�0�|C��w~5�5m�Ѳ]\���
���`U۩m>�ܨǻ��A9z��T���������_j���.�fiW��#Y?�_婛܁?+Z�\P$*ž�\��ir�Y�9\]:4R���?^���0�c����,�).V�o��:|��Ad���9�t���R�c<ǰI!�:�m� �k6��pV����o4Յ3l��Z�EC4��??�ʼU�LJY/]㩔䧮U��)�*���U���������ku^���=,��
bԽRu��`ћ����s���Ѧ�?�3	���nx�[��υ��Y�=����ur�c�Seg�Y���67GXo���"�,n^�*ӄ,n�3�AJ�ݣ^���IC��>o_��/����!fm
���FO���Z�I���h�9㋉?��`�7�MU~�S�ёq8%���{����%Ȁv͵\r�����!)ׅ���ƞ�(�;��� KS�(�j��Cw�l��V����a�h�2s��n4��C�Q�`�S� �Qi�
���}�kEM�T�d���xT��SPx<F_�?dcv����/����[wp8��m��
��0T
���+�\��Ʈ�Caܣ�<����1����������s��b�����3S^��uh�#rxE{Iܷ�@P@�Y^._�/���.�R��
	
6T71V[EO�#���U��U֕�����xXٽ���"
x��`R⌛n�ڦ�)<K/4f�-ű�+�HR
�I�N�W�P��`�.),
��M�]W� O���ֈk��B������c��0L���ӥZ�W�.�K�r��Z�N)q̵؏��:WP�
�@~4��_n��*���`x��t�T!;����2BT�V�>Z*�N8Y��dC�)�M��#�g�öε�m����=�f�9�[�Aԁ�y�N�}�YU� |�G�O����k��6D��	�1�i}�2��$�>]�
P��v2��u����>��&����uɊf1�*
ve�O�����z��~b4�)�l�V��۶u�"#Za��Ir[��45l��m���]���Pn�B���/���A���qO
�����S���0����0���_���˴�)\���^&<x��U&Zu��X�^���"�$��F�㔮� ��ِ�״*f�E��P�(ĕ�5�JJ�5p?o��,�57y���b��{�W(��Q`�l�6��3�6$�L�9 ­ 7�dM2�x�p��j�@�!2P�oUo��d�!�}�k�;�v$�r)�d�Ȣ$�E��i�T-r��G��D���z���nFd�ՙ��#wT,{�nK�r�|�z��X{�Ђ�K�p��m��t���-!��2��Of;Z`�H�(�3�����`{��&_r��5:X����w̙��(]���a��}��K�7��S=9^����GԜb��W��еJ㙴o&]:����d�I�	2v�v���_,�@j4�jcK��2���{��H�@R9K���v�ɿϦ�H
E�m�|I��X-Ol��j0i&�Hg�v�������>Ӆ�~
�p֞=�s�>ߚG�P6�Ş�f4Ƌ�f@Kj���K|��迆�U8�L��ɦp6 ��>3�����ܬ1� �e����T�v1A�{jSث�W%=O��N�W_�)%��MZ���`�D��T�����~�m��b���S�������pJj��쉰y2�O�&��˪3Ĉk�3N�����!k3���-0QaWU=l8�P7���h�q����К������0v���dLN�"7�>�U�,���6xh$M�v��T�v�{�Ew�p�����P$qp�C]����E-����u���q�/X�5��DYn)T��w�QYK�K �ԃ�������cU��?����1^���n�C�jr���*��h!�=Az⻶�=����������ֆ�ãz�re`���u�����1�u��M`V&tz�<�6�\󥰗L%����iq<]>lև���7�������ƔH}��s��婓$E�(�N7��/�0��ϙ-/�3��D"u�?����*�ͭ-6�S
�?��Ȗ./��Ƌ�#�?-�AKP+��8J�a�:���A0�u3kO��q/I�@J��T�`����o��������"�ِ���^���[A�U�h�ؐn+Ae�k����hlT���A
�Y�8.��fToKG�t>!ZS�辉˔S��
B[����@�
����h_
�P��<7��v�LT\X���̴Bv��&$ǜ��R(&xh���>�������%yTI�ʳn�S_D�;3~��:�N��_(D�0����7�8u[� IN�Ø���#��"���94�wO4��㌦`rU�=�j[Q��W����3�[h���9��9
�tۚ�8�Z0V,)����:m��pC�8`��F�Go7�cy�o??}��H�C�@V-ǘK��_������S���K�yO�;����Ѯ�>���Yюy���$�8���c��y)������]�0��3Xfd�r�g�뻙�l��@�����N���"�k��[le�� �4��"P>��I���������9%�[������A��_����"�;gsߕ�Q��;m�Ą�P���	��$66k��t��Bt{��D��HV�Ȣ+;�i�^]r��e����qa���!Zp����o�
�ȟ,���
)�_���D�k8�K�=ֹ5�%��ur���k��_��Z�H̫v��3�&�b��ոp��,×�[6f,��8$nX�	j�04���C�z&�P�����B�m���j&h���W�J��Jk���ZΉ�y����Dd� 3��A*Lυv-�P=�N���A0�YC��4�AS��g��mzQ}}R���6y��?`)������[G�
��tϿ;e�uΑD��AM_�ñ�17;
�9��ؤ;�-,4f�&N!�ߔ�|���}�
�vv8��4=j��N�������/��a���Q���Ը
����{e_f��%B�G"c�[Ǵa��f��d��,���dJ��ΰ`R�%z�ˣ� �W�r��1W�8���֚\`�.kG̢F�߮BloG"o`�Kx�[9%�3��$=a�J�_N�:���pT�Ƃi#�B�e�d/�kh����rxgՏ��mw%�E�N����:���L�Ȝr���.����
����n��K\�(���^��/�Xh��[P��%���8�2�Q�ڞ���h_�}F�����||��V�w��]uzu���*����,��C�Ӌ�>��zD�c`C�#�T7;ݏ�4�fuǬj�E�k~���}��{�	`����=[�-���Ǉ������Z�0����%N���$�*k�˷t�ێ�(�����������yo�}Pv�U�K�9�v�~�إ>���.m��h�Ƀv~L�9܂��t!�ެ�$L��^L�����Fc���3߇��4�/m��_��Q[�P�
��(����t23���(���Ԙ����²�u���ֱ!�e
�r��p+͈�1��ݍ��f=�:G�����N��ÿ�J8�m��`M����va�*��
�(�F��U�oya���סA�$z��7���H���FlO�s�;�~0^���h=r����� �g���O�;|���p���mJtt�Ocl*~��/�h��bXhwf�T��#j�%Ay�r��UZ�4D�ȭ���Z��n�������H��B� uOV7���n,�"�/�x
�c�J}կ3�er���i�1X�e�ǐ����7�U)#I����ry�������<����B�x���L�|$��
DZ��Y_����|�a��J�js��%/����a���򈐀���X��8��W9��`%h��C4�H��8[�Zhy�J�%&r��H����Z�F�j��5�4�p�[>���w᝙���-}_L*�9�1{��M��I�x�,�*�i쮉e�˞O~�H&A��&��4�ʍ�bo�(��K�gQ���w�cʕ:�$�w��6ێ��\u��D=�ke��f�N��KK<�#���b7NJ�8���1%)��b��>#/���KJ:���V��y����Z�䥣׈F���II�����u�D+HR
GU�a�����in��\���v���V���F��فo)A-?�x�Y�m.tz���KKTHK���j\���i�|O�Y�8�\2f|<�@]o��!S�����ۏ� wJ�n��5����4�1�/ ���x/�ޝ��5��2�|���S�Jˁ����������&�ݭ�����B�st{��2�W4��V�9w�_�W��9t����A`�Bsv
���d!N��\�
B��d��^a�Z�I�x�ݮb8��
�&����Y�o����4���;���$�GS�zq-�{��$�����X��ܗ� ���g&g����ʡ2�Im���v���L"~!���uM��Ԡ\!;߷r��%����!��t=$�$*Nq�:�rrO����U����2^�sU�U.���Sa���U򈶴� 
L�
��e9v���
����m����m3��07Ň�Sv�G�ii��;�mQ��*����tW�j�������AO�D����l��.�/�4��-�8�NE�~�.`ZǤD/�x��T �S?]��1��{^�Q/O8��b���O[F�o\5/�P���g�>�e�
f��z	�ƵS6ګU��������!7��J�%q��|�e�UQ4���`��;q{*?JK�zH��������:f��/�+��,�����7<��K>��"�}J:����W�,�Y���+@�}���N��V9�O����t��X�,%�j�@	���:e�w~	��������ҥ�n��G����˱�x"����?dC��}e���ye���or2s�N�O5�*�T���8È��T �2���=���w�\g&XN9��dHᇄM8lڸ�B�C{�R�*K~�`�C��@������"[�d�����&��
鍻�K��$l[A��R��秩�ʇഝfa+�z�A�����v�k���?#���6"k�^����� ˭������^�OkW�(�R��ϩ�KBa�,�D�,�_��c��O��4��O���QL*�A���pڊ�O�|��&�SG��ʡ�	�ܚ����T���*��n�W-d�\|V)�	�[�p�wo�g��S��
DM��9��c<-e�2��}�w�{l��F|�7�Xs������Wkf$�"����tM������uB�*IW��v�5-��k�L�J���?ȝ
��}^�,�S��9q@2��.�]�����iʡXI���z�K��\���0qt�w�|�@N��8���4+�uo���!��TqϖCR��j�s������
׹�{2Cp)�����|��������$�tN���di]-�ݯl<���B�e���n�~D5�Cw�&�_�/?�߻�����^Bj���r�J� !��ӛ�+�tT�ڿ�s d^]�f��"9{Z��I��-*�~�ݰ!���DҌ�?���u�i�Lg�
���/;{A��Ʀ$Q5�<p��B	�|��b+��A�����g}��Ԡg�	��_~�4/*j��؋���ԞL/�k�p�E.̝��}&�D��p*V����W�G�(�T�E���u�Wτ�t�^��.�9��l<�b��c+�ZK-J|_�#�*�!.��>��9�J��0�b(�o,: ��!w�E��E���^�ekzYdc-�B˝�Ʀ=�����g��`����%�z.s�F�-N�]��cƻ��y���n���c��B�G�o�ɬ����
i�/��ٕ��Spy��}H����x!ք����l[;��@�c������o`�\,9A�٘�A��7�W!O/}B}9�0,�V��=����t������fJ6BJ�̹��.�$�uc�^[�Ϯ��x�_�3���R��%�"�7�X<L?X���TD�u���eGm�f�����m�>���I�h~�J��ۙ>��Ȭ�T����I����&Y���pv�p�_�i��~ٯ��[��bu�{�j�F����a�������CƁ��6�Ʉ�o���҃��6
�{����Z;~�ԉ��it�1��B���>��!|��
����]|;���Q5�N�QM��j��oY�Q�M讇˦V3A�k�
9�ԗ�Y�M`?�*s.�B�z2���da��>
#Xm�k�*�X�TA���G���j��W`�ޣ�����9G��E����,z�s���L�Y��xIH���������=�0�?��
m< ������
�%�4��"Ŭ�ę]����Np��#v��O��뜢�����ؓЈD��k��[[�F��H���5���1R`�K������4�dQ��AgP�(�A���cc�����\�B��iЭ���E�S��R/����X���L�Y�|V�"���;��G�77M�����^��-?���5/���q�$�+�H�*؊��&�C첌������, v� 
F��xVu�������Z�(�kT�"2�.�vM�#����( �S~����E�G[=����
hD$�j�vs^���,��#���!�˳��\q.-o]���\*��ӪJ�:<�_��N�Qi	�����9�Z��o鲙W�Y��)�(�����5�k��pHn����9>�$���a	�p�
8J��,��]�6St�,U�]�<��:��!kk�=�,��j�ZamЖ�F��f3};d�9�2Va`��b�+X��$Gm��̐��2����|Vy�g6wm�w�)��.aݱ�_2i��ӱ�n�w�Li^<(���::���K�r�G?�j@�Qt�8/9Vs�W�;X}���k��_D�vx!i+�w�|x�yX��^g����vB��؏9~�Ts`|���ǭ�D|�q�ƗIآa�voޥm*�5%EY��H
M�a�6�:Ps���8I��1hi����>�0�mC��/X�^������<�yyʊ�a?4ˏRw�TJ�̣���S֕�t��ej�ҲnX�k|N���1.@Pp�M_������������{b�:����ׁ�;l�fi�/���rk����-E�0j���U~ZR�Ct�2�<
\"��VSF�;C���f֬�e#Kvo[�	��{�O�U˯O�%�p����#����Os�;���A��st��5���&�vH,z��0��ȷa_Sq�)���.�^��!���%Ҳ��&j*�h���ԇ Ӏ�lD���4�ҩ��F6ޏ�Hy�8����_A�$V�[1�9��k)Y�v��2������һ�惽���?:�a����v�N�1�j��($��a\�]���jJ�C7�����
`~6�wi�G��΂�.]�h����J9Eo��#ء1�΍ȴ��)!��&#��56SIꃓku �IW�r�{J�T*U��`��6��Hr�2��YItrԋ����\��E�	rь��4o^������I9�d]S���pT��c�s�R�[��@��"�}���w4RЮ�ͫ�!��&=-ܱ��t�Ax80�N���ɧ^������{��9r~|�/7��v��k�]�w� �Ug)	Chټ�,��ڰ�ޖ��cw�V�������7�%��77.�G,U����}�함E,���9�]���0��G��=M��v�qp�X��+���
s�-� �-�	�����pW�ۊ�u��؆��.�2�fxU
=�)�n.x(WxHjQu�e����C"ӟ�C���6�c�7�֘uL�#�s�	m�}������xzШ��Y��u,�L2v��9-׺�嵁[
��Φ�:Yô�az�놮}�Jq׃����>�J���2�;��3L���ek���8�ZLF���{�G�VW�!z�!
��~�X6��|��E��BhnT��O㤬[��m���р�`H̹�
^�U�v%d�
�׿b>����V�°f%�OD���~�tO�2a��ʯ��L�6�)�LB^�_��V?Wwߊ;h�긺"��3�Cf�27RA��7(�n7C�5A���mv6*ԣW�
V �T6	(o�&�^�t�&mK6"I��Ivy���,�_�ฐ���^[^T*v�FE��Ky�3�h.��ܖNDO?*�����ٮ�����R�m�W��#��!l�$W��Q"�+��m1ﮂ����K��E�{Үq�9�8�w8�q@�P�PV��yq����n��
`�o˳
�V>�s��̢����h�����7A���V?�v,�S�DY$iu��݌���x��f=m���2b3��9|�Z�׭�/�;��zW����t4gN��sx�����ڠ�m�VG�V�}��|�uت�`O��f�M�QH�����:�ic�X���9sJ/a�%���M�z.����P��_M�6d!ڞG�/R�r�=�;�4`���+;m����x��������qզ�˄cJ��F���4�Tv��b���"�a�~����u��l�&��Y_������?�� S���T�Qn�uAg��|I|\���j��
	T~IQS�Ǐ��\���(	�v�v����E�g2���rZ@�˪]Vz�9dT�~/(|0k����l��"A���#�K��H�P�F?-P���9c@GU�~@�uJ�;���9�a����z,.��"��EӢۦz��@י
���A�
�9n匷�
�!�$��.@�ê�yj�l�F�i���>{��;<]��)���}ǎ����GP�(��_��V�J`j�ޝ��5�F�|�f{�LK�E(���2֟	��{�r�+���]�G$��XTCRB>	�	��oi�p���⹯�vft�q��8``kA@B)n���Ǟ�_��h]AI"|��h8mj�n�k1=(���Lb�}W0/���l�Ƕ9[w�ω�o[�T�G%�-WZ�ϝ����5�*���>
���q�p3�;�.��q�))���ܺ�K}��ӑ����ĬC]N������bl�-f�=)�:<
�!w�p$��Ek6D x��i��w�j�E�P�~��^|B��<6����=fn$9�<{��Y�f�Gh<Wg�FAK����6���.��u[����U#�Մ���`ii���� ��՝QK�}p��N&�3��DP��Z�8�7���I��Cb�B4��5+e�Ey�w�����LN�09 .9>�)jS�I��=\P"I��@o<�8:�l��_Տ���:�f�Z�	G���������S��ͧ�H�Z�ɢ��>>�)�1y���N�!�~��P��t�|��?�:���v���j��T�5�Q�^u#쬶Tfr
���}�Ɉ������S��/�ۙ�˅:s�m6�#T�:t8�N���ͼy��hͦ�0�<�H�^`�c�g�����6`MTB��/T�$�o]�S�{&�㯾2�/=�f�1?嵟dl��K�����(�[0L����j�짢=Бy�)�ܢ���g��5�:jf�u@>�Ko��|���܈�S��!���!�	0�4��V�����@�VN��Zn���0��/��;&�ǵ
:S����Uݨ*��}4:^V�K��6F��E��/���L��������SsX�^d��M7��a������K0Hh�GL;	��U8E��@�p����7�&��vPoC�V^����-=ӽ�;�FI��W�W��ˠ�]�9�����zvn	{�Ul&g)tE��"��v�?����0[����5�a�	4�1֍�]���"A@�4�Ӂ�|�CP/O�8�Xp�5N2��ByN�Nga(� ����/�Ť|�1
�������3���e��7�}�����7���I��h�����wL�d��L��>��ћ8�}7�g�%U��iD��1"A,>�_?�5���"8��۠���hw��/k��.�O&jY��"�@���X.�3=�g�7#��ͧq�ܭ>ҳ��K���$ွ;�2�wP���%�7k�g�耕-�fns��|��f�*Rk}�=Go���܃}��d�[2��f4Vs,���t,��֨=�I��Z�ܓ�ݕ)_f�f�t�In8�ʇD%��1r��w�
~��2��ˋO��(�@4Ms�����ߋA��݃�<�����4��z��te���ꜬX��A����Y�Q&{1���;��c�Dɐˎ���df}�Ia����R�;��:1�{T׀|«������%�N��S�qu|��+:�����p�W��
t��[��"o��q�Q����&�]rA��ѴH42?-jKx67����`�E��B&ĭ������퀺����b�?��\͑NM��k
�叆��?�3\��&r���1z�
�G�?����U�9T�b�BSw�����3´
�N�p���������v�;�\�?;�)I�y+F��L߉��u͝�du��� �f-�1�h#������)���gjZ���m���~��ź����
xt|f���K����n����G�C���O�d��EhMZژ]��ha�]1r��Jy8V9<R�
���e���I�F߽#��?�ŨtH�a��h�;�J�Z<�F���f����o�<�q.������r�bI<;����J��ҿ��N&8���j{,��NE���q��ԬJ��ɻ�j�����˄�eq=UV[�/��>�ɩ6��-�pr�qZ�Vx3�d�����A®�E������ &��|��P��%��dE�N�d�8%OM}�faUQ�W*V�ԑ!c�����]�+G��R��#9���й��l����ǝS6`���ùW�����t�,��R\����$��Ab%
uPa�|!GEN��
��eȼ�Di�/j`�����Z��+)�/-܄�ILZJv{�I�8�z$�(5y�H]�wܼ�_B�����w1��v)U�cCp��"��P[��sQ؁L	��L$MI�ˤ�(�J��lJ�L]$�T���h��I1�\x��v��m�G�{�x
��Դ����M�ӂ����Yx�^�t��j7�Z�a��o;�p�(�#�~�8���r9�t:�C�pD�by�w)�6����_d5��u��@��q?����$ij�EjG�h���Ni�����[�HGt�S����*��I��!w�FJk���KW5�虻`l��s��VF"�R���;��䤍��F�L�;�n��Y�Z�cA�H[��y
o,d^B|8&�崬
���	Iw��*��d����������ty(�ٴ_&���Jq(]@��3��x�.����m8;��#�7����5�	�"�8?���b[I����F�a��3��߻�k�OF��wħ!�6��/�ו��^�r�^>֮���<������k����p�1�Nh�:jO�HS\n�9�-)�o�AFI�����(��
B`hP��8.φP:�����˄7lʯ��\\ũB�^ÆM0P6�
����B�j������M=��0�O���J���>��Zl�{Hw�	J/߄\��B�Iı����|UΫk̋�:m�,�v��7��s�wrND��N��K֎O�^��T�&�50��˰�`>�k��s�����W�خq0�]U���d�F�.1&�~4[�5\��Lb�oØj�5� B^ �0�<_�0���R���������
y�^�u0Shq�&�۫��|>������N��O��-:��q������fi�i�Xf�SxX5��u�0�s�r	r�ԫw`�J��GV�a*�w~��)Q�XX��Xq�.��ǉ��3��K�O�,�dRt����6�_鄶�Us���QI�`�	����{��B�Z���Z��z���%���#��:w�h�����,���Q�A����-\wL��R�EeD�f[DX%���*yCt������j�����AT;j{�F�WO ����c�X�H�5�}����@"��w�KCT�]5�_��ҡ����=���$�ՙ��e�&��`�yu,��A_J��~&wR�O�=�K���ۦ�\�L���S`�v�bV97l����!�[�ċG���:x%���ɢ��+7����V�V�;��ʶ�5�:�n�a�Z��Q
׎]h�dV�<۝����u����R8���&��XM�0Ɉ�M�NR�����3��0��/���ѩ�Қ`S��������h��U+������a�-��7�"���3����PP��?j�[z�q�.����y5
��A���8Q�E��kg�O�$J�>73c�f���zJ�[�*jAeG|��+����DDi>��ϓD9O���bn�S�chS��i�QRW$	W��2��Rd-9~SD��.������m�|�ad��#Y�cg�_߀YYx��+!.ǉ쀰`EQ?T�
�~̉s����,�/u])������-�lg����=�W�däƴ a�?bHb]�Yj1��*�A5�z�ڄ��)�"��l3C�6�	zx4lh��	��ky���%�5��.n0:Ϸ�Q�1:so�[2������<}��煇��]�5��fv�#�r����]R�0�׆0�>�7�"����M�F�]M�l�;��԰Fp�a[I{K/��_�O?����/��!�<x ��Q�$���e�ώy(�r~�����!��\C�1]zךZ�619�}g�|�ec��D�M>K��R$ZiiK��=0���#-���ֵ�b���Z���M�G��~ۜ�|�5��D~>�[�p����F?�U���S��"W
zn�k��GT�c����x��<e2����C�F���A�nv߻9�ň{�q�t<�ߐR�KH{����Y��P��(,�3�g����5zq����ž>,��!��VE���m:i�����<�-,�����?��|OPLυ)�{@�[A`rBT&��k��a�`��]�}*�����/�T5VA!6�ೆӑןz�g�\F��ŎV=�.�#�{�>!ܢਗ����A�W og�)��b��M�o�Ʋ�1�pZ�T^���i�`��a������U�8Nb�(���tF�2�vJ�F��7���gf7�;nB������gX{ˢV�0�e�`|��ő��B6��ޙ��y�r�Y��Du�|�H�x����%�t�#QNJ?�K���Rӱ��sQ�Fe\O~�aRq��d\ʭ����|���t�ttO�F���h�|5<Ƣ������_$�?�P�V�C�&��A}�4
�1d��0���pX���EH�!���ue��cLY��:b�H3ԗż�}4=�{�8�Q=�Oツ��R�}	�7��"��=K���]i������T��)�m��q�0O��8�)��A=[U����2�c8����8{�v�/)��xA�Mf�e,yO���}j�+�\)ӄy�U�*��\����?hM��a���^�Mma��$��: (�9��k�|dȴ���q5��vu��ޙ�{�K-���F������K�QS?VK��\�z��Ƴ\��fIR�L@RA��}��N�NFf�x#8�����1�|��]��1��d���X�����S�j.���-Oݦ�!l�m8;ϥ�\Ǡ��ۇ��u_�$�N��6a�KE��d�xǴ	�����\�uٔI�K�ѹ��"P�RH�<��"�|k�p����	��`
�O*�C���)bi����0��Zvv]lO�+���5-GP#��`tK���B��@������Q[�F2���_��
��9�=;,����#����w�ξ�<�W�e�mtE��@�U�0��� ����v<���pj%ec7i�co�n�GB �q�a	��sa2�
)�@*����-4(O���g���S�4�]�e2��__�WoхB��P��Г��T��l�-�fɴ�]"����G���Ġ��`��8^�	�
�M��d�C�Vs�87qm�!0[[Bj��n徺v�-*.��B^е��V��3�_��=�e�q�Y���
�W؋֋���q�!-n4l�컁��e�-t���Hܳ�圩�������p��B����m�4��T��R��m^?��;d�@M��&��M[b�_Y���WxZ�޳Sq�/#������yK�w��������F�w#��Z�=��ǹV�21m����K�]�97@����YG%�+I�	�c��5��ߛ%�P����ep�9m۪�Q���*(Ej<#����B��sȃ1�v�U��ǣ0�����Pq��If�w���X\U��
��V|�<�\_��N�MM�F�8��v���)�!Vf��FJko�`t�W�����ȋ[E��䰉����`;T��Q؉���#�������j�D-"oEq���<��FօS�q���rs����f��Crr�hX*�T�*�ū�u�W��q1��<��;�r�y��s�������)�\�$�0�P�Q���?��P���_��Ҹ���=�z$o����Y���a�\�E�18�
ife�!L>!�W|�����2�T�_8���@p���Ы/3���%h�M)_�==�xW_�ӫ����ᓊ�Mq	R�>��ǛZmq�O�c�R�8ޢ ����\�1f�0�^.�����Z�m��}����?�#�lI��0�c�x���f����8_6���ř`�KU�N����PX�P�$^�s�Ѐ�R|4���[��n<��	y��q4���T`Q�\ht��e��NrBk��������_S�}*���M����sO? J�Q�����zB��j�7Z|��|�6����뉓���D6C�/]���y��K��1���wJi�g�-NW��0J��׍Q�l�2�{}[E��ޏ�U�عj�$8�f^���^
~è�k�:�L�����A�}E�67̥�*�Kp#�έT?��L
��X.G:�p��lʵ氬_#�(����u��I1e0�c�Zi��㚖�p��aZ��Ν���p
�r*Q��7>����!��ۅ��kJ_����l��`�VAm3=�p��Y�$$x�|�����lB���M��[$�v����d����$����%JAܗ���y��п��}L�D*������.�`L��<���,�
#;E�ؚ��ճ$�rf�5����3(M�\�|��?
?D:#q���f���J*�.��$�(I����H��A�dH�Lk��wc�ea�D\�Y��;ц�=	ZCF˪�,���@�J�l�����bX�.@s�polY^N��?|�d�NQ/i�8�P��%�dW螑�au[�w��=2z�k�J�e�?O~�Vqz�#���H`�4�%�g��騬N����N�q��DR�AD�B�����u#>�^hu���wDr�\h���8]:����O�2t�ݰ	�*k���ډ(;9_f�zab$y�,�bh.�|Mk�r���_�XX��>%�����hAa���ˤ�t)��-��]&	�#
"�P����HΘ%�Оc��P!�Dd��z��H��W�J�B\�4��{S4ԗ�MK�C\T�%*g��vQ��
pu�/1�.�Ac
���C��^l���_��$X�8�:��RE��
�_��B���V���n��薵O���H.�C�J9V֏�)�/����,T8i��s�SR�<i8��/�O�ܛSͦ��"�F���}]03��>�\��Ի�]�g$����t�P��#�}���n���A�ѯUޱ�Ч�t�������j�%�w�M%����\p-��O@��g�,+d��n�g�a/
3tg�Nh/*�]��Lid�����T+�����fAv�`H怹p)�.�J 7��:El��i�2�I�����$z��ƣ�6����͵�
��T7�!o� �;��	����$HS���A�3ս�]����\i�#
$�dꄭh����pXxQ##�*�J-?3��_Z�ieu}�)	����"k����˦�������D�֛�����l�tQ:-��	�,�u�3�ή�e����M{�¢ɐ#U��D9^�9lp!}\�X_����V����������Y�����!V����uU�MP1��P���v�L��QG��:����߇B|�>�2�O�M�G��<�鑎a��j��g7�����Sd��<����o1��"� f��4b��7��I,(��Q��b��-�揓�����xu*�wQ����gwE.Æ��Г���y��]*.����lnR���K���_Z#�>4Lrp̤G��$��:0[.�\�G/�y�����`�n�Յ�9N��JdF�R~T�I���#f�N؉!O�X�@G/v��bh�Y�0S/)Y�3�޸J���x�&��Q��3���n2{{�h��e7��y��Z2b�Z �Wg����V�a`&+��w�Cd�t���w
�C��)qfh��U�/�,��iqN�Ը�oa1F-�9!?H��K�tCO�#�.��6��F���zy��e*E5�y��}�/�T:����0$I�������[����v�f�������[�:�5}n�7z��ȣĒ��~H~s���!��7l���g�.8��9��_j�������G��F<��8�mG���f���D2�@�j��SW�.ƽ�4�v��b�V�߱�<>���9�
}��䮿�8ʮX�bZ��G�y��2�̪����B��7u�
�$��V���s�y�M��1��(u�C�0l{�*����-둴�r��V�zBl���],yZ�A��]��0�+�\ݫd�OC�����izi�V�ͼ&�g_kyp�!3X�RXy[\
��r�ԩI��g���0~��n���g|�0�w�z@l�ܳNS��v)Rي��.>�z�����.}��"�(ل$(���Bl�%ew_�p�ˌ��+����Dy�솽���*�ї�Y��r�<��/㝤�z[^���u�r�#"���K^w��������|D�<�
^�XQ�{o���UT%FHd�J�<aoc�����[�&�T9
A�C�ٺGL<�9=p	s���v��E��=Z���TR�5�c�}���6T2��){��0?��OՔ؋Wt3�������
d�=����2������
�/u���^M�y��[�#V�nyD����r�)R.�N�٤���B�5<�HD{��A�����urF���,�N]�ة��2�WZ@��5�B.��!g�TK,�;8�X��R�q�9���j���D�+�@�j`XSi��T�����%����c�8��c�°�M^9�M+&xk�
�5�|F/�����	g�]F��T�rx�.+�ߊ�䌮�[m_�ܲ�i⠰J��Ei���^�c�<!�7CR�`e�f�s����Ҁ���Zʖb,�u�ꀊ�nzg�4��>
jam+0Yc�{��A��=��1�fZK�a��/gk��<S[V�k��������^Vˊ��=R� �m�H�����@�{g��qC��g��ˡ��D�C��<j(BO��!X�<B�%����Vދl�S.f}?G�j9�F�𖃞��ww��~�xG���]iY���� �W~��K]�K��e���e8��3��IF��d֖:i�4 `�_0�Z��!��y��9z�\�����?V���3������q<�Ǹ�k�᧽�8h��Q��(��Ux������xЯ��g�C���`!uC�.��(n��J��/�	(�ݾxk�+�"Wd񊪽�2��ٮ¨*[���E$���<���t�~��,:��=#\�N�2
<�7����9����{���^\Q3M:���#t������2��~(�+ֲ����xQpV��
6F��=z�:���+nڭ»D����P�VQ3%;�g�l����/�G;��~�:<EyO�fG���{H3��GEFg����s��z\;���c����q��Vugռ��˅�^zg�;6`l�œ���g�[LQBU�D�X4��������y��)c���:?�C���So^u�x�PE@6`Cc:�h=NF�hq:������`(%�j��%B�7�/
��3;0�X����2 �Y��\c|ѱ�?80��%��.��d��:�-����Ҭ�<B̚�6����92͖�
���`��Ѯ$߷�q��}2`X"($k�����Z�ׁ�BW��ۧY���&�j���Rՠ
�sв;���
����:�L���T�%Ӯ�I�yа���-k_���TP�O8���.m
��"-��d4l�j�"�#l!_\i�/ ��$��׫DQ�,}�Ȫqh�m�U�������"��_O
?�ҢP�����H��z��F��p6�g|C#�Y��aØ*����~EO{5QZ����Ys"P�,��=�#�6��ŀї(k�ljE"@��I�����ᡝ����y@�L�������9k��$����!�b��"��+�V�/P@���p�NQ��m��)�b�T�ݷd
����-�\3V�J~I/r8XL�2�_�G��0��v7��w���oGl(r`�ޖ��ح��� �iӡC��׼e0F�x�J6�<��]��&h�,���N�k%%�m�6���?A�dmɼ�7�����g��oC�+��$�*T�ӱ��=�ٻܵ�Qs�rPud�L[�<��g���r�"��i�٪�2�!ɂB3��0���k;<1���K���b��x_/}�����k����Z_��z��#��a��X���G�H�A����|�� ����
�4Eq��.�ְV�aQR]��2@Z���9sE>e����Iζۆ��<��	�H?�l ��t���k��d�
�����>��0*^!AO������T:@F5
5�C �BH��V
o
����-�L��dD*o����}�ZH�Fok�f�
L(���Y�t��d+��r�
��1�¢3��x����(Aշ(v�P}�2��:�j����ùc]��z3���p�b*����ݓ��h�PD��c˚>��7¿�T�x�*���Vl4Xcg�^V�e	2�Q"��KÙ�t�׶B*���&rCEE_ �|D�k��W5~�	�
���{O]�l����ت3����2,c�� �k���u��-��Pc)
��s���XT��B��h���|�CY2mth��&�yt��>@t�Ԣ@��$B�1,@�uȭ�c+���Эm]+�f�2���\y��%~
7B(��N��+��PuA!�E��+�ΐ ���t�um�M�	�}}J���z�
2�MCtV���ی)��%��{j�"�E���s��0���^���Ӏ��%���$�xj\U�uZBĹ
���p��$EU_�����n�c���1K��`h�LM�$�:�t��tS�����]R�u�˾ފ!�p��6�p������o�:�V�����Sc��R~���5���I������!���(W�|V��+8B��A��[?�[���P�oHb����0@��g��Ac�Q�=Z��f����������
�JًBN��<��cA�}XU��c$h��t�MD�ݱC�bҙ�V��ѝ:��֎홥N���j�-�l�RsD+��¥�%.��g�?��jql�0ʊ�/u�r��k����z��Zz�	�s�B�d����9��G�O
�p��RD��#]�I\E8�[����������kY{#��m������\��h��uǑ�qUPdV���;Dr�A�F��űN}�g���ۮ8=�4X4K�c}g�X�l)��^@\���O�wc>��e��P��]����M��#��&Kd�.mD��i&���T��
L
�T]ʾ��J�7_rpÆ!��������O���S�.l~bE����ivU�����MBitųR�͌�F��:�8����_��0>��������G~o�	��Q8t6㼓੯,���Z�����$��U�r��5$)7�x�NH����s"�۰����Ns��;"��K-Ǹ�p$Y��)��S��#�j˸{�{���x��H���p�������fg�:g��r(�#5<|T�:y&�1cX�v�I$8n�]�̹y�3������Z�y]��W̯�c߇\釯���ݘ��ӀR����&=E��F(S�<����МzuT�VP�5Rt7�m4��O>[�O�B70�b0��u��I�y	�C��
v��8��
�o���L��NX�-%���njrF�e^��\U�"�F��_�S�e(�v�D&z+���*�Ss18if�%�5�g�%ݢ>lW;9��uC4�-\���N\>��%��W��C>�MZ�7�����c�V�`��������q��l�"yiR�s����~���m=<�V��ǘ������[��~�^�M쾮@�a�Fb����ߗn�F��ÁS<�c�n=�����0��M�Y�z&��p��}�ێM:�6J�Q�&��al��3��y.-G�t_D�FU�&Is�3}#����g�jy��c�nzIFj�{dx%`Ӭ�XB&�k��q�&�>��.�_iL]4*��Y�Ҥ�P�F�b!�,�ׯ�4�69?ڲ$
�P�tJ��7yY�Խ���m՜������a�$y����Iq��Bv�@6�^/[4HN;���I/�Ͽ�aBT�F,	���������A�l��J���.��:�.�^%g4�C����:��t�ZS�U�_dl��G�{�OD���3hT��TI��D^�V�a��0���e+t�f�����Nu�rG!��m�|?kx�m�yF˿S��˾�ApV��f0���^p��w27Y|����ڛɠY�Iz��w���d�r����F��k��̲��p����-J8_�e�Q�"��m�P���kCu�m]=�������Z
���
��ܙ�Q/G���������jj���}����󉵎�xZ쳌�<NG��򷓹b����jFe���<	��j�+i�1�G��]A�aS���O����E|��naĥ\8U
\0ud�Jxn�������࿘��$H�8=�v\tj�@:���4�����C��S��;�k`C�`Kp�&X�f)Pk�x�m����(�NN�����A���&۝ls6���.��Y��8�I�DAU�U��#��TAܒ��Z�s��~}�?W���k�E��7�u���Ta���I��ܾ�%v����um��䧉Đ��&��R��^���|��7�;�ڗt���6��,�>A���]t���p��N��@����jⅽ
��~#�	�:r+#{Z���g��M�%����8If��W[��y��		W�����r�ɠ\wf�$���Y25�q�"[���ixF�ޞ&���= B�jJt�E�t)YPr锲���i�5s�Ǜ_�#��Vi��^�ω���g��rP�,\��B�\P4�7��)�h 6ݫ������`|���i
��0ǎ1~j����zu�N��ODܛ�r��̒���e��ӓ6HiD:��!��1��Ѧ��;LҢq�~Yj�hR=��ts��W6V��ֈRo`-����r�9�2��F�ڬ��
9�������J��=�����H*�)͆8��t�f�Tm�3,c�A�od�醗y(^;������/=	�ۀ�j�dK��;Z��~Q���YJ�5���d����Q���%��M_
�h��@�@������/Z�F��Co�P�v�K�u�-K��}��ֽN`�US���L���W��m
��T`���9����9���ű���]�mad(e���RJ(�tr�AxZ�.�~R���c��e�E�G�v9?�AhB:�����q�	ZX��jK-vx���(Y1
����@$�-��Tf�����ܛ)8LY��N���a���`hmy��fTqQ:uF�h��8<����}��z����|{	��z��\�hu�sK�88���s⇵m����)�`֣�@�B��������Ͽ^���Q�<������3���R��]e�%M;�f��m�}���\�a���3{UM��Bt�6�I�zÅY����ۖ{eQ��F���C�jSz�m�؃?��0�ʐ@�����s�n#��&EU=o�����F>�Ҏ�Dr�����2x��wڪg|
��MR���T(��at{�~����hq����<�	��W��̒�� p1��u�x5�����B����܂+���1(���P5�y)���q����J|6Crt�?s�ql6,�\.+����m��<��pj�vd�������Gk^�ds�m������沐j�<�����k��Xr`��"	d���N�H�]-Ʒ~U����O]�� @�ӄ���(r��Fh���	(��1���m>�$W�a
oPn������{��x���������k�A�b�xMC�	����fn��`F�ǽAw�)��6�����e����B���d�{�M{ڍ�Dsu9ju��Hx�X���9���f���	b��6[���;�ȷ��&�e{��(�N��󀈿]Ƀ����9�jPd�>1�K��\kX��f*F�+37Q�^�Ʋg~	��TJ�>e�n$��M���N��ڬ�o��	�c�ݴ���yG~l�7��b&��
xB�o�����9Ο�_��������g�V�E=�"�E�t�%-��<I܈�U�ʛ�:V�����:���K�X0em�m�<�p�/c��.c	Mk�Ҟ�Wy���`��;�X�z��{�M�.������~�l��G�+䧎k�K���ڝ�[�H���U�����|
Vk���ƺ�w�v�1���(ހ�eR���>�T�Ȟ��e�f��@�v�c�K�J������|ٱ���1���Zp�4_c�M8�x�j�A�P��F"��������s��~H�#)��h4<#�������������������W�
�;[E1+C�F]�A����Ory0}J�b:�%�CS��YY�A��2f����"B0_�Δ��m3X/����У,�1x1��}T���e�ox��`����]}ít��R}Y��F�2�>��
)��cV�1��|ה�pa���"�;贬�"p������6��ׯ1��r��ٕ�c��c������ߋ�C��v��b]��1�Z�N�q�f
��D@��Q]O�6��̐�e�[=���XF�i4qr���B�:^���%�]�鍁6J����ak��l點��pe���؉��Fۋ�%Kۈ��q�
rs6F"eȶ��ĺ&8;ƙ�F<��cl���MCj񾞁���xH��%�j�����
ڶI�LfT�TT$/U�4��H�V�Q4�j��
�C��V�]a�\��Bl���}�6+�3�5v���>����9���[&"�o�[��k�� n����p��n��b-#	0CjP;k����[���@X���L��6>��z�T�<cu�&]�R�`{6��n�|q>}Y��������C��F�F�ۓ%^W�U�S��u�|"a��p�Yy�HК�H��$��h!�I�]L>P���u��k���zz��Z������\���AI���ҢƊ�������{�Y����!�c�
d�
��?� D��\��S�N�S�
~Q����`���BR����^G�J��P<��6A��;��2�S�\�^W�04��Fv.pK�[ħ���c��Ђ�x�L��0�C�dr#����la�*PȵK�k��T]�"�ciO�z�^�kN�ޥ%f���}a1�{q[5�vCǜ������呓�5nC>ǜ�������I�4�ټ\nT���At٤#���P;�J�4�v�BѾܿ��4����o�����_�e��1��/?���%���y��A٢�,da6+�U.�b�$(X��ÜR�LI����i.uY�;�S�����un����Y3aҭj�?�4���Z�L Ҥꢬ��M�8.�EL)l=؝g�t��߾1�BT�M)�����3�!a�p�`�a���߸�ęJ@�D�1�RQm�؝N�ٛ�����xUз��D�R��ūf����b���m$�F�tt�^Yz��U�ÆRރ7�n�~M�
V�
�d~�!�h@�h�Ի��9���f�����(s�
F�F]7}�y[���^���p{[�:J��3o��悮>�,t6�������3�
q�շ��xe��Sr��;�}k�O�̉���fi�t�q�U��[Y!?��F���"IbΩǙ�K�|GS��H�Ϳ"���ИD�{?(�4�5BZ�9���X���ȦE�R���F8HM��i�g����g.O�M�h��[P��9��LH@l��]@��G�F��Y�s�������-�i�����<�,\���W��E	rD8Bv��B+r@�f�}b�����2����N�Y��ilm��\�(l�P�w0�:��m]�kk��،�X���5����I�DΘF~�BJ�
j�u�`?��J�H"cve:e3��}���G�l��o�D
�t��p�q�[VU�KI{q�Ϸ�������D"�����,	맻a;S�>;�w��i3?#v���8�o�;�qO�|��d��]wF�K��o�*F�������勫"}�g��S��+����RLt������6�H�s��[�
ea�(��Y�Q~/�y�?�ӑ��B�����@yD�c��黖eks�=�i�Kz�D��vup��%N@X)s��kt
�#a���vs=Z<�W��Ȃ�#\���~����V�.n�))ٮ��/�*���DW����l�!�^q�Y�r���v8*h���1�S@�&�j�ǅ��ru��U����[.���<���&��h,��9>z�Q��+�n
q���N��FS��%��V�ͅ��v����C,�T.�
�9�΅�ɸ�����dɲ�p��O�`����x�c���|vBlF&�a
`8|Ľ��xf�z��3��HQ!-��/o��5������龜"�
�zF���,XW������@�ϗ���g�vL��&/C�˕;�,��Y��nt冭�����}��� ��(S�E��\�M��N��ِ��O�_4t�ʳb�����+��o��웖`��uUD�-��W�
Y�
�J���{���X�b;U��oG����H����ښ3/�r��������I����ӽN�7��<��X�mO�pa�uղ�V��|�f��\��C��?�c�H�����f��R��w-~I�ux*޼�t��E~6n�
��� �A��y�-�v�:p��:�|]���۽��n|�X�%JEu���z�Z��	
B.�x7e>^�V��iO�^c�Μ�<.X����Lo�b�T�i-�V��(��l�$v�75�#�Uu���|5��o,�R*Y��i�s;1Ά�����vO��?��C��sC?��]�G�8����>�Uu��P;#�5�i
L����tO�
��Hz�r��
���L��W�Պ�˓�^m
>�{Y��{Y��T�a�x]�
Ch���G_E��z���[%E>j.�v\K�۲��O{��,�}�|]�m	��+������hm�v�����k��m�e��~�N�����_?Z)����#gw7?�%/���bj�X�WxX�����<k��5s�����x��m�n���Ь��R�zPP��ߘ>3-�"B?W3$_���EчB:J���5U��-�����-���j�L�-A�?�����ưY��u*�#�HJ�G?��9X���n{@��I��x�L gC��Ҵ,�눺)�k�����+���Y�ڹ��V��&����ZP:%Q[)OB�V�)�1�����ߡ螺Xo�5���a�ŹHBÝo�洎\6���<�����^&Ď�_�8S����z��,ؗ
�4Σ����K7تO���q��ՂG��*<�6k����kn�o	������VB5�ܳ��6�,�I�U�M�۞�wJ�]�9q���<y����U%�d��vC�y�����b�6�����bꊵ��4M����5�8Qc��m�(8Kh�O"�`4h94�X P�L���qr�|�q��Ły�C��@q�����Â9��ɚ:񢸴J�Ff������@���Q���@��w��Y}E�99|���|��T�
I�֡Z����*i�?�-6���u;�Jٯ��f�������G�rD��5����[�|�Vjm�q�{��to�����
���(a�bM��s��R�W�݃��	@��(�S{U&���j&�͵B�&	�5�>c�G���F�M7Z�MaV#�����4�f���������=�PB���5ާ|9��u��Z_�&m퇐jB�>h��=+����uŇj�k�"�H�~__�]����ʞ�.��zK���p���������
61��n���f��#����
,7�ñ��c9JZ��9���������Z�_ JB26S���
j�I�!./��H���kK]=[a���H���R�h���!��
62>��[0W2��J��
Mx#��������n?��3����>��ޢ����\����w���J^����4�H�TtϬ!t��T!+���
<��g�P����v/�@+(���(��~3���Z[�vG���@^�z��L;;�&u�|<A��dNM��^1�Z���B��ݞ����G�-��� �U��WMӎ#!K���.�����E�^�m7L4k*��������!�r��e������>��=
�64^���?z�/O��C�bvU�ȡ��J��)���u�΁
���š������%�:��h^GL��
.���/_#abm�`��B`�N�^�E�]�>[��W��fw�,�?�����Ǿ�,��U7*�x^�I���f�bb�5�!T�/)������a�����@��Y�����Dm�#��m!�h8��m�?3�@���1� �����6��W]�$.O����>=�p��#�r�:vpW�4��Z
G�D�����u�z��H��Y ���CU�<+�U�-Yֵ/x�z���&���q]�]�����6R��6R޼������"%��%.O/��p<6ZY������X`o?����h���-�����W��_�dO��+��)6ZQq��7�n\Ю=����ppp��t��Ȯ���ۿ޶��Nm���۴�P�].3&`�???M#���/)&�E�_O;g>ʓ�����Å��>F�)u��Z��ܲȸ2��T��#�Z3��m�_��+!���x/W�>&�$E�J��\q������
宀	�㎅	A����%��F�#�_!��%�3�p�/�"_gW�ՠ_OjOc���<���8�L!O!��O�_������(쎄�U�������F���
�ބ����@7�T
�g�5d�u�#�O~L*0_k���	(jɜ-��q�?�L�G+��Xe��c��!�9F��U����8Op�W�6Ӭ����dD���ײ���.��s��^>؍�d��2r62Rƾ�K��ל3#�����\�!�Fr���U- ���L!�$D�r1�z,�o/!r@�g]?�*�

INSERT INTO "enunciado_tarea" VALUES(1, 1);
INSERT INTO "enunciado_tarea" VALUES(1, 2);

INSERT INTO "grupo" VALUES(44, 8, '1', 1);
INSERT INTO "grupo" VALUES(45, 8, '2', 6);
INSERT INTO "grupo" VALUES(46, 8, '3', 9);
INSERT INTO "grupo" VALUES(47, 8, '4', 10);
INSERT INTO "grupo" VALUES(48, 8, '5', NULL);
INSERT INTO "grupo" VALUES(49, 8, '6', 17);

INSERT INTO "instancia_de_entrega" VALUES(1, 1, 1, '2007-03-16 00:51:00', '2007-03-18 12:00:00', NULL, NULL, '', 1);
INSERT INTO "instancia_de_entrega" VALUES(2, 1, 2, '2007-03-19 01:01:00', '2007-03-21 20:00:00', NULL, NULL, '', 1);

INSERT INTO "miembro" VALUES(1, 44, 1, NULL, '2007-03-16 17:29:09', NULL);
INSERT INTO "miembro" VALUES(2, 44, 2, NULL, '2007-03-16 17:29:09', NULL);
INSERT INTO "miembro" VALUES(3, 44, 3, NULL, '2007-03-16 17:29:09', NULL);
INSERT INTO "miembro" VALUES(4, 44, 4, NULL, '2007-03-16 17:29:09', NULL);
INSERT INTO "miembro" VALUES(5, 45, 6, NULL, '2007-03-16 17:29:59', NULL);
INSERT INTO "miembro" VALUES(6, 45, 5, NULL, '2007-03-16 17:29:59', NULL);
INSERT INTO "miembro" VALUES(7, 46, 7, NULL, '2007-03-16 17:30:22', NULL);
INSERT INTO "miembro" VALUES(8, 46, 8, NULL, '2007-03-16 17:30:22', NULL);
INSERT INTO "miembro" VALUES(9, 46, 9, NULL, '2007-03-16 17:30:22', NULL);
INSERT INTO "miembro" VALUES(17, 49, 17, NULL, '2007-03-16 17:31:49', NULL);
INSERT INTO "miembro" VALUES(18, 49, 18, NULL, '2007-03-16 17:31:49', NULL);
INSERT INTO "miembro" VALUES(19, 49, 19, NULL, '2007-03-16 17:31:50', '2007-03-16 17:34:06');
INSERT INTO "miembro" VALUES(20, 48, 14, NULL, '2007-03-16 17:32:15', NULL);
INSERT INTO "miembro" VALUES(21, 48, 15, NULL, '2007-03-16 17:32:15', NULL);
INSERT INTO "miembro" VALUES(22, 48, 16, NULL, '2007-03-16 17:32:15', NULL);
INSERT INTO "miembro" VALUES(23, 47, 10, NULL, '2007-03-16 17:34:34', NULL);
INSERT INTO "miembro" VALUES(24, 47, 11, NULL, '2007-03-16 17:34:34', NULL);
INSERT INTO "miembro" VALUES(25, 47, 12, NULL, '2007-03-16 17:34:34', NULL);
INSERT INTO "miembro" VALUES(26, 47, 13, NULL, '2007-03-16 17:34:34', NULL);
INSERT INTO "miembro" VALUES(27, 47, 19, NULL, '2007-03-16 17:34:34', NULL);

INSERT INTO "prueba" VALUES(3, 1, 12);
INSERT INTO "prueba" VALUES(6, 1, 11);
INSERT INTO "prueba" VALUES(9, 1, 4);
INSERT INTO "prueba" VALUES(12, 1, 5);
INSERT INTO "prueba" VALUES(15, 1, 6);
INSERT INTO "prueba" VALUES(18, 1, 9);
INSERT INTO "prueba" VALUES(21, 1, 8);
INSERT INTO "prueba" VALUES(24, 1, 7);
INSERT INTO "prueba" VALUES(27, 1, 10);
INSERT INTO "prueba" VALUES(30, 1, 13);
INSERT INTO "prueba" VALUES(39, 37, 12);
INSERT INTO "prueba" VALUES(42, 37, 11);
INSERT INTO "prueba" VALUES(45, 37, 4);
INSERT INTO "prueba" VALUES(48, 37, 5);
INSERT INTO "prueba" VALUES(51, 37, 6);
INSERT INTO "prueba" VALUES(54, 37, 9);
INSERT INTO "prueba" VALUES(57, 37, 8);
INSERT INTO "prueba" VALUES(60, 37, 7);
INSERT INTO "prueba" VALUES(63, 37, 10);
INSERT INTO "prueba" VALUES(66, 37, 13);

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
VPermite entregar trabajos pr�cticos
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
VPermite entregar trabajos pr�cticos
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
INSERT INTO "rol_usuario" VALUES(2, 1);
INSERT INTO "rol_usuario" VALUES(2, 2);
INSERT INTO "rol_usuario" VALUES(2, 3);
INSERT INTO "rol_usuario" VALUES(2, 4);
INSERT INTO "rol_usuario" VALUES(2, 5);
INSERT INTO "rol_usuario" VALUES(2, 6);
INSERT INTO "rol_usuario" VALUES(2, 7);
INSERT INTO "rol_usuario" VALUES(2, 8);
INSERT INTO "rol_usuario" VALUES(2, 9);
INSERT INTO "rol_usuario" VALUES(2, 10);
INSERT INTO "rol_usuario" VALUES(2, 11);
INSERT INTO "rol_usuario" VALUES(2, 12);
INSERT INTO "rol_usuario" VALUES(2, 13);
INSERT INTO "rol_usuario" VALUES(2, 14);
INSERT INTO "rol_usuario" VALUES(2, 15);
INSERT INTO "rol_usuario" VALUES(2, 16);
INSERT INTO "rol_usuario" VALUES(2, 17);
INSERT INTO "rol_usuario" VALUES(2, 18);
INSERT INTO "rol_usuario" VALUES(2, 19);

INSERT INTO "tarea" VALUES(1, 'Compilar C++', 'Compila C++ usando un Makefile genérico que compila todo en un ejecutable llamado tp', 'TareaFuente');
INSERT INTO "tarea" VALUES(2, 'Ejecutar + valgrind', 'Ejecuta primero de forma normal y luego con valgrind. Si no pasa la prueba, rechaza, si no pasa el valgrind, no.', 'TareaPrueba');

INSERT INTO "tarea_fuente" VALUES(1);

INSERT INTO "tarea_prueba" VALUES(2);

INSERT INTO "tutor" VALUES(1, 44, 1, '2007-03-16 17:29:09', NULL);
INSERT INTO "tutor" VALUES(2, 45, 2, '2007-03-16 17:29:59', NULL);
INSERT INTO "tutor" VALUES(3, 46, 3, '2007-03-16 17:30:22', NULL);
INSERT INTO "tutor" VALUES(7, 49, 1, '2007-03-16 17:31:50', NULL);
INSERT INTO "tutor" VALUES(8, 48, 6, '2007-03-16 17:32:15', NULL);
INSERT INTO "tutor" VALUES(12, 49, 5, '2007-03-16 17:34:06', NULL);
INSERT INTO "tutor" VALUES(13, 47, 5, '2007-03-16 17:34:34', NULL);
INSERT INTO "tutor" VALUES(14, 47, 7, '2007-03-16 17:34:34', NULL);

INSERT INTO "usuario" VALUES(1, '76335', '462d3127e7a1dbd3cf12c1f1a7203c79238849e9', 'JORGE EDUARDO PITARO', 'jep77ar@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(2, '78548', 'e925d542f0eba2b90a62f9655a17120f7168fc6e', 'MARTIN FERRARI', 'martinferra@yahoo.com.ar', '4322-9652', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(3, '78760', '6894c67810a43114aa2cbd3d300bee4a1d79b188', 'FERNANDO CLAUDIO MARTIKIAN', 'fernando_martikian@crgl-thirdparty.com', '48211291', '2007-03-13 00:54:15', '', 1, 'Alumno');
INSERT INTO "usuario" VALUES(4, '79389', 'c8604a83aed545e0221451019d78a6a127740bdc', 'SEBASTIAN VERRONE', 'sebafi10@yahoo.com.ar', '4941-2939', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(5, '80843', 'a520945614c3fe6f7dd80915503364034dfe7273', 'MARTIN OSVALDO GORGAZZI', 'martingorgazzi@fibertel.com.ar', '44331593', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(6, '81533', '488fbc89800c3d284d488ebec4efb14213259db8', 'GUSTAVO JAVIER NARCISI', 'tavojavi@speedy.com.ar', '4298-1265', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(7, '81713', '8c14eb17ce6f36d435012597b7a0ca50a77b0090', 'OSCAR ALEJANDRO VICTORIANO', 'voavictoriano@hotmail.com', '42984069', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(8, '81875', '6db2bb28b6c94ea615749735bc48fab87d3a308d', 'JHONNY ROGER FUENTES MANCILLA', 'jnysaa@yahoo.com.ar', '4572-7933', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(9, '82598', 'c96f56f31667fd464d407e88715802bfdd6b2660', 'MAXIMILIANO CROCE', 'crocemaxi@hotmail.com', '1556361402', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(10, '82634', '641035fa8cecdc577f5d5c5e0aff9b8113d60c78', 'FERNANDO CESAR NARDINI', 'nfrasec@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(11, '82899', '7412bb9e619d93a48d61b7017b62aa126c602818', 'PAULA SOLEDAD FERREYRA', 'paula_s_f@yahoo.com.ar', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(12, '82903', 'c65ad86d70362b396e67d87961560563cef5ed73', 'LEONARDO GORBLIUK', 'lgorbliuk@gmail.com', '', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(13, '83481', '796af4852bc2f935b7057cfbbbd0ed078222e4ff', 'EZEQUIEL FERNANDO SINGER', 'ezesinger@fibertel.com.ar', '48033260', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(14, '83488', '25a5f12420f92d00df23995d57c4c406358eed5d', 'MARIANO EZEQUIEL KFURI', 'marianokfuri@yahoo.com.ar', '4632-7735', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(15, '83604', '5a06cca4a10418a75401d53491b8a8b5741bcf46', 'PABLO EZEQUIEL BRAGAN', 'pbragan@gmail.com', '4572-9073', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(16, '83605', '4453234561cb2bb4c2268625d8af63732db14d7d', 'RODRIGO SEBASTIAN MARCOS', 'rodrigomarcos4@yahoo.com.ar', '4566-6971', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(17, '83607', '9414422ea5808f27d8f8f2f209e63c770000740d', 'LUCIANO HAMMOE', 'lhammoe@fibertel.com.ar', '4501-2834', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(18, '83775', 'a6925cbd28ef9210d8e6af1b8b213674bd696f7b', 'ALEJANDRO PABLO CAVALLERO', 'ale_algo@yahoo.com.ar', ' alepc253@yahoo.com', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
INSERT INTO "usuario" VALUES(19, '80256', '773aed10ebd1d198e15032ebb447e5cee3a16e4a', 'VERONICA ANABELLA CENTANNI', 'vecentanni@yahoo.com.ar', '46537983', '2007-03-13 00:54:15', NULL, 1, 'Alumno');
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
INSERT INTO "usuario" VALUES(36, 'lele', NULL, 'Leandro Fernández', 'drkbugs@gmail.com', '', '2007-03-14 15:39:35', '', 1, 'Docente');

COMMIT;