function p = POCEasy5pt_p(bE1_1,bE1_2,bE1_3,bE1_4,bE2_1,bE2_2,bE2_3,bE2_4,bE3_1,bE3_2,bE3_3,bE3_4,bE4_1,bE4_2,bE4_3,bE4_4,bE5_1,bE5_2,bE5_3,bE5_4,bE6_1,bE6_2,bE6_3,bE6_4,bE7_1,bE7_2,bE7_3,bE7_4,bE8_1,bE8_2,bE8_3,bE8_4,bE9_1,bE9_2,bE9_3,bE9_4,xy1,xy2,z)
%POCEASY5PT_P
%    P = POCEASY5PT_P(BE1_1,BE1_2,BE1_3,BE1_4,BE2_1,BE2_2,BE2_3,BE2_4,BE3_1,BE3_2,BE3_3,BE3_4,BE4_1,BE4_2,BE4_3,BE4_4,BE5_1,BE5_2,BE5_3,BE5_4,BE6_1,BE6_2,BE6_3,BE6_4,BE7_1,BE7_2,BE7_3,BE7_4,BE8_1,BE8_2,BE8_3,BE8_4,BE9_1,BE9_2,BE9_3,BE9_4,XY1,XY2,Z)

%    This function was generated by the Symbolic Math Toolbox version 5.8.
%    30-Sep-2013 10:34:58

t2 = bE1_1.^2;
t3 = bE4_1.^2;
t4 = bE7_1.^2;
t5 = xy1.^2;
t6 = t2.*2.0;
t7 = t3.*2.0;
t8 = t4.*2.0;
t9 = t6+t7+t8;
t10 = bE1_1.*bE2_1.*2.0;
t11 = bE4_1.*bE5_1.*2.0;
t12 = bE7_1.*bE8_1.*2.0;
t13 = t10+t11+t12;
t14 = bE1_1.*bE3_1.*2.0;
t15 = bE4_1.*bE6_1.*2.0;
t16 = bE7_1.*bE9_1.*2.0;
t17 = t14+t15+t16;
t18 = bE2_1.^2;
t19 = bE3_1.^2;
t20 = bE5_1.^2;
t21 = bE6_1.^2;
t22 = bE8_1.^2;
t23 = bE9_1.^2;
t24 = t2+t3+t4+t18+t19+t20+t21+t22+t23;
t25 = bE1_3.*z;
t26 = bE1_4+t25;
t27 = bE2_3.*z;
t28 = bE2_4+t27;
t29 = bE4_3.*z;
t30 = bE4_4+t29;
t31 = bE7_3.*z;
t32 = bE7_4+t31;
t33 = bE3_3.*z;
t34 = bE3_4+t33;
t35 = bE5_3.*z;
t36 = bE5_4+t35;
t37 = bE6_3.*z;
t38 = bE6_4+t37;
t39 = bE8_3.*z;
t40 = bE8_4+t39;
t41 = bE9_3.*z;
t42 = bE9_4+t41;
t43 = bE1_1.*bE1_2.*2.0;
t44 = bE2_1.*bE2_2.*2.0;
t45 = bE3_1.*bE3_2.*2.0;
t46 = bE4_1.*bE4_2.*2.0;
t47 = bE5_1.*bE5_2.*2.0;
t48 = bE6_1.*bE6_2.*2.0;
t49 = bE7_1.*bE7_2.*2.0;
t50 = bE8_1.*bE8_2.*2.0;
t51 = bE9_1.*bE9_2.*2.0;
t52 = t43+t44+t45+t46+t47+t48+t49+t50+t51;
t53 = bE1_1.*bE1_2.*4.0;
t54 = bE4_1.*bE4_2.*4.0;
t55 = bE7_1.*bE7_2.*4.0;
t56 = t53+t54+t55;
t57 = bE1_2.^2;
t58 = bE4_2.^2;
t59 = bE7_2.^2;
t60 = bE1_1.*bE2_2.*2.0;
t61 = bE1_2.*bE2_1.*2.0;
t62 = bE4_1.*bE5_2.*2.0;
t63 = bE4_2.*bE5_1.*2.0;
t64 = bE7_1.*bE8_2.*2.0;
t65 = bE7_2.*bE8_1.*2.0;
t66 = t60+t61+t62+t63+t64+t65;
t67 = bE1_1.*bE3_2.*2.0;
t68 = bE1_2.*bE3_1.*2.0;
t69 = bE4_1.*bE6_2.*2.0;
t70 = bE4_2.*bE6_1.*2.0;
t71 = bE7_1.*bE9_2.*2.0;
t72 = bE7_2.*bE9_1.*2.0;
t73 = t67+t68+t69+t70+t71+t72;
t74 = bE1_1.*t26.*4.0;
t75 = bE4_1.*t30.*4.0;
t76 = bE7_1.*t32.*4.0;
t77 = t74+t75+t76;
t78 = bE2_1.*t26.*2.0;
t79 = bE1_1.*t28.*2.0;
t80 = bE5_1.*t30.*2.0;
t81 = bE4_1.*t36.*2.0;
t82 = bE8_1.*t32.*2.0;
t83 = bE7_1.*t40.*2.0;
t84 = t78+t79+t80+t81+t82+t83;
t85 = bE3_1.*t26.*2.0;
t86 = bE1_1.*t34.*2.0;
t87 = bE6_1.*t30.*2.0;
t88 = bE4_1.*t38.*2.0;
t89 = bE9_1.*t32.*2.0;
t90 = bE7_1.*t42.*2.0;
t91 = t85+t86+t87+t88+t89+t90;
t92 = bE1_1.*t26.*2.0;
t93 = bE2_1.*t28.*2.0;
t94 = bE3_1.*t34.*2.0;
t95 = bE4_1.*t30.*2.0;
t96 = bE5_1.*t36.*2.0;
t97 = bE6_1.*t38.*2.0;
t98 = bE7_1.*t32.*2.0;
t99 = bE8_1.*t40.*2.0;
t100 = bE9_1.*t42.*2.0;
t101 = t92+t93+t94+t95+t96+t97+t98+t99+t100;
t102 = t26.^2;
t103 = t30.^2;
t104 = t32.^2;
t105 = t57.*2.0;
t106 = t58.*2.0;
t107 = t59.*2.0;
t108 = t105+t106+t107;
t109 = bE1_2.*bE2_2.*2.0;
t110 = bE4_2.*bE5_2.*2.0;
t111 = bE7_2.*bE8_2.*2.0;
t112 = t109+t110+t111;
t113 = bE1_2.*bE3_2.*2.0;
t114 = bE4_2.*bE6_2.*2.0;
t115 = bE7_2.*bE9_2.*2.0;
t116 = t113+t114+t115;
t117 = bE2_2.^2;
t118 = bE3_2.^2;
t119 = bE5_2.^2;
t120 = bE6_2.^2;
t121 = bE8_2.^2;
t122 = bE9_2.^2;
t123 = t57+t58+t59+t117+t118+t119+t120+t121+t122;
t124 = xy2.^2;
t125 = bE1_2.*t26.*4.0;
t126 = bE4_2.*t30.*4.0;
t127 = bE7_2.*t32.*4.0;
t128 = t125+t126+t127;
t129 = bE2_2.*t26.*2.0;
t130 = bE1_2.*t28.*2.0;
t131 = bE5_2.*t30.*2.0;
t132 = bE4_2.*t36.*2.0;
t133 = bE8_2.*t32.*2.0;
t134 = bE7_2.*t40.*2.0;
t135 = t129+t130+t131+t132+t133+t134;
t136 = bE3_2.*t26.*2.0;
t137 = bE1_2.*t34.*2.0;
t138 = bE6_2.*t30.*2.0;
t139 = bE4_2.*t38.*2.0;
t140 = bE9_2.*t32.*2.0;
t141 = bE7_2.*t42.*2.0;
t142 = t136+t137+t138+t139+t140+t141;
t143 = bE1_2.*t26.*2.0;
t144 = bE2_2.*t28.*2.0;
t145 = bE3_2.*t34.*2.0;
t146 = bE4_2.*t30.*2.0;
t147 = bE5_2.*t36.*2.0;
t148 = bE6_2.*t38.*2.0;
t149 = bE7_2.*t32.*2.0;
t150 = bE8_2.*t40.*2.0;
t151 = bE9_2.*t42.*2.0;
t152 = t143+t144+t145+t146+t147+t148+t149+t150+t151;
t153 = t26.*t28.*2.0;
t154 = t30.*t36.*2.0;
t155 = t32.*t40.*2.0;
t156 = t153+t154+t155;
t157 = t26.*t34.*2.0;
t158 = t30.*t38.*2.0;
t159 = t32.*t42.*2.0;
t160 = t157+t158+t159;
t161 = t102.*2.0;
t162 = t103.*2.0;
t163 = t104.*2.0;
t164 = t161+t162+t163;
t165 = t28.^2;
t166 = t34.^2;
t167 = t36.^2;
t168 = t38.^2;
t169 = t40.^2;
t170 = t42.^2;
t171 = t102+t103+t104+t165+t166+t167+t168+t169+t170;
t172 = t18.*2.0;
t173 = t20.*2.0;
t174 = t22.*2.0;
t175 = t172+t173+t174;
t176 = bE2_1.*bE3_1.*2.0;
t177 = bE5_1.*bE6_1.*2.0;
t178 = bE8_1.*bE9_1.*2.0;
t179 = t176+t177+t178;
t180 = bE2_1.*bE2_2.*4.0;
t181 = bE5_1.*bE5_2.*4.0;
t182 = bE8_1.*bE8_2.*4.0;
t183 = t180+t181+t182;
t184 = bE2_1.*bE3_2.*2.0;
t185 = bE2_2.*bE3_1.*2.0;
t186 = bE5_1.*bE6_2.*2.0;
t187 = bE5_2.*bE6_1.*2.0;
t188 = bE8_1.*bE9_2.*2.0;
t189 = bE8_2.*bE9_1.*2.0;
t190 = t184+t185+t186+t187+t188+t189;
t191 = bE2_1.*t28.*4.0;
t192 = bE5_1.*t36.*4.0;
t193 = bE8_1.*t40.*4.0;
t194 = t191+t192+t193;
t195 = bE3_1.*t28.*2.0;
t196 = bE2_1.*t34.*2.0;
t197 = bE6_1.*t36.*2.0;
t198 = bE5_1.*t38.*2.0;
t199 = bE9_1.*t40.*2.0;
t200 = bE8_1.*t42.*2.0;
t201 = t195+t196+t197+t198+t199+t200;
t202 = t117.*2.0;
t203 = t119.*2.0;
t204 = t121.*2.0;
t205 = t202+t203+t204;
t206 = bE2_2.*bE3_2.*2.0;
t207 = bE5_2.*bE6_2.*2.0;
t208 = bE8_2.*bE9_2.*2.0;
t209 = t206+t207+t208;
t210 = bE2_2.*t28.*4.0;
t211 = bE5_2.*t36.*4.0;
t212 = bE8_2.*t40.*4.0;
t213 = t210+t211+t212;
t214 = bE3_2.*t28.*2.0;
t215 = bE2_2.*t34.*2.0;
t216 = bE6_2.*t36.*2.0;
t217 = bE5_2.*t38.*2.0;
t218 = bE9_2.*t40.*2.0;
t219 = bE8_2.*t42.*2.0;
t220 = t214+t215+t216+t217+t218+t219;
t221 = t28.*t34.*2.0;
t222 = t36.*t38.*2.0;
t223 = t40.*t42.*2.0;
t224 = t221+t222+t223;
t225 = t165.*2.0;
t226 = t167.*2.0;
t227 = t169.*2.0;
t228 = t225+t226+t227;
t229 = t19.*2.0;
t230 = t21.*2.0;
t231 = t23.*2.0;
t232 = t229+t230+t231;
t233 = bE3_1.*bE3_2.*4.0;
t234 = bE6_1.*bE6_2.*4.0;
t235 = bE9_1.*bE9_2.*4.0;
t236 = t233+t234+t235;
t237 = bE3_1.*t34.*4.0;
t238 = bE6_1.*t38.*4.0;
t239 = bE9_1.*t42.*4.0;
t240 = t237+t238+t239;
t241 = t118.*2.0;
t242 = t120.*2.0;
t243 = t122.*2.0;
t244 = t241+t242+t243;
t245 = bE3_2.*t34.*4.0;
t246 = bE6_2.*t38.*4.0;
t247 = bE9_2.*t42.*4.0;
t248 = t245+t246+t247;
t249 = t166.*2.0;
t250 = t168.*2.0;
t251 = t170.*2.0;
t252 = t249+t250+t251;
p = [t5.*(bE1_1.*t77+bE2_1.*t84-bE1_1.*t101+bE3_1.*t91+t9.*t26+t13.*t28-t24.*t26+t17.*t34)+t124.*(bE1_2.*t128+bE2_2.*t135-bE1_2.*t152+bE3_2.*t142+t26.*t108+t28.*t112-t26.*t123+t34.*t116)+xy1.*(bE1_1.*t164+bE2_1.*t156-bE1_1.*t171+bE3_1.*t160+t26.*t77+t28.*t84+t34.*t91-t26.*t101)+xy2.*(bE1_2.*t164+bE2_2.*t156-bE1_2.*t171+bE3_2.*t160+t26.*t128+t28.*t135+t34.*t142-t26.*t152)+t28.*t156+t26.*t164+t34.*t160-t26.*t171+t5.*xy2.*(bE1_2.*t9+bE2_2.*t13-bE1_2.*t24+bE3_2.*t17-bE1_1.*t52+bE1_1.*t56+bE2_1.*t66+bE3_1.*t73)+t124.*xy1.*(-bE1_2.*t52+bE1_2.*t56+bE2_2.*t66+bE3_2.*t73+bE1_1.*t108+bE2_1.*t112-bE1_1.*t123+bE3_1.*t116)+xy1.*xy2.*(bE1_2.*t77+bE2_2.*t84-bE1_2.*t101+bE3_2.*t91+bE1_1.*t128+bE2_1.*t135-bE1_1.*t152+bE3_1.*t142-t26.*t52+t26.*t56+t28.*t66+t34.*t73)+t5.*xy1.*(bE1_1.*t9+bE2_1.*t13-bE1_1.*t24+bE3_1.*t17)+t124.*xy2.*(bE1_2.*t108+bE2_2.*t112-bE1_2.*t123+bE3_2.*t116);t5.*(bE1_1.*t84-bE2_1.*t101+bE2_1.*t194+bE3_1.*t201+t13.*t26-t24.*t28+t28.*t175+t34.*t179)+t124.*(bE1_2.*t135-bE2_2.*t152+bE2_2.*t213+bE3_2.*t220+t26.*t112-t28.*t123+t28.*t205+t34.*t209)+xy1.*(bE1_1.*t156-bE2_1.*t171+bE2_1.*t228+bE3_1.*t224+t26.*t84-t28.*t101+t28.*t194+t34.*t201)+xy2.*(bE1_2.*t156-bE2_2.*t171+bE2_2.*t228+bE3_2.*t224+t26.*t135-t28.*t152+t28.*t213+t34.*t220)+t26.*t156-t28.*t171+t28.*t228+t34.*t224+t5.*xy2.*(bE1_2.*t13-bE2_2.*t24-bE2_1.*t52+bE1_1.*t66+bE2_2.*t175+bE2_1.*t183+bE3_2.*t179+bE3_1.*t190)+t124.*xy1.*(-bE2_2.*t52+bE1_2.*t66+bE1_1.*t112-bE2_1.*t123+bE2_2.*t183+bE3_2.*t190+bE2_1.*t205+bE3_1.*t209)+xy1.*xy2.*(bE1_2.*t84-bE2_2.*t101+bE1_1.*t135-bE2_1.*t152+bE2_2.*t194+bE3_2.*t201+bE2_1.*t213+bE3_1.*t220-t28.*t52+t26.*t66+t28.*t183+t34.*t190)+t5.*xy1.*(bE1_1.*t13-bE2_1.*t24+bE2_1.*t175+bE3_1.*t179)+t124.*xy2.*(bE1_2.*t112-bE2_2.*t123+bE2_2.*t205+bE3_2.*t209);t5.*(bE1_1.*t91-bE3_1.*t101+bE2_1.*t201+bE3_1.*t240+t17.*t26-t24.*t34+t28.*t179+t34.*t232)+t124.*(bE1_2.*t142-bE3_2.*t152+bE2_2.*t220+bE3_2.*t248+t26.*t116-t34.*t123+t28.*t209+t34.*t244)+xy1.*(bE1_1.*t160-bE3_1.*t171+bE2_1.*t224+bE3_1.*t252+t26.*t91-t34.*t101+t28.*t201+t34.*t240)+xy2.*(bE1_2.*t160-bE3_2.*t171+bE2_2.*t224+bE3_2.*t252+t26.*t142-t34.*t152+t28.*t220+t34.*t248)+t26.*t160-t34.*t171+t28.*t224+t34.*t252+t5.*xy2.*(bE1_2.*t17-bE3_2.*t24-bE3_1.*t52+bE1_1.*t73+bE2_2.*t179+bE2_1.*t190+bE3_2.*t232+bE3_1.*t236)+t124.*xy1.*(-bE3_2.*t52+bE1_2.*t73+bE1_1.*t116-bE3_1.*t123+bE2_2.*t190+bE2_1.*t209+bE3_2.*t236+bE3_1.*t244)+xy1.*xy2.*(bE1_2.*t91-bE3_2.*t101+bE1_1.*t142-bE3_1.*t152+bE2_2.*t201+bE2_1.*t220+bE3_2.*t240+bE3_1.*t248-t34.*t52+t26.*t73+t28.*t190+t34.*t236)+t5.*xy1.*(bE1_1.*t17-bE3_1.*t24+bE2_1.*t179+bE3_1.*t232)+t124.*xy2.*(bE1_2.*t116-bE3_2.*t123+bE2_2.*t209+bE3_2.*t244);t5.*(bE4_1.*t77+bE5_1.*t84-bE4_1.*t101+bE6_1.*t91+t9.*t30+t13.*t36-t24.*t30+t17.*t38)+t124.*(bE4_2.*t128+bE5_2.*t135-bE4_2.*t152+bE6_2.*t142+t30.*t108+t36.*t112-t30.*t123+t38.*t116)+xy1.*(bE4_1.*t164+bE5_1.*t156-bE4_1.*t171+bE6_1.*t160+t30.*t77+t36.*t84+t38.*t91-t30.*t101)+xy2.*(bE4_2.*t164+bE5_2.*t156-bE4_2.*t171+bE6_2.*t160+t30.*t128+t36.*t135+t38.*t142-t30.*t152)+t36.*t156+t30.*t164+t38.*t160-t30.*t171+t5.*xy2.*(bE4_2.*t9+bE5_2.*t13-bE4_2.*t24+bE6_2.*t17-bE4_1.*t52+bE4_1.*t56+bE5_1.*t66+bE6_1.*t73)+t124.*xy1.*(-bE4_2.*t52+bE4_2.*t56+bE5_2.*t66+bE6_2.*t73+bE4_1.*t108+bE5_1.*t112-bE4_1.*t123+bE6_1.*t116)+xy1.*xy2.*(bE4_2.*t77+bE5_2.*t84-bE4_2.*t101+bE6_2.*t91+bE4_1.*t128+bE5_1.*t135-bE4_1.*t152+bE6_1.*t142-t30.*t52+t30.*t56+t36.*t66+t38.*t73)+t5.*xy1.*(bE4_1.*t9+bE5_1.*t13-bE4_1.*t24+bE6_1.*t17)+t124.*xy2.*(bE4_2.*t108+bE5_2.*t112-bE4_2.*t123+bE6_2.*t116);t5.*(bE4_1.*t84-bE5_1.*t101+bE5_1.*t194+bE6_1.*t201+t13.*t30-t24.*t36+t36.*t175+t38.*t179)+t124.*(bE4_2.*t135-bE5_2.*t152+bE5_2.*t213+bE6_2.*t220+t30.*t112-t36.*t123+t36.*t205+t38.*t209)+xy1.*(bE4_1.*t156-bE5_1.*t171+bE5_1.*t228+bE6_1.*t224+t30.*t84-t36.*t101+t36.*t194+t38.*t201)+xy2.*(bE4_2.*t156-bE5_2.*t171+bE5_2.*t228+bE6_2.*t224+t30.*t135-t36.*t152+t36.*t213+t38.*t220)+t30.*t156-t36.*t171+t38.*t224+t36.*t228+t5.*xy2.*(bE4_2.*t13-bE5_2.*t24-bE5_1.*t52+bE4_1.*t66+bE5_2.*t175+bE5_1.*t183+bE6_2.*t179+bE6_1.*t190)+t124.*xy1.*(-bE5_2.*t52+bE4_2.*t66+bE4_1.*t112-bE5_1.*t123+bE5_2.*t183+bE6_2.*t190+bE5_1.*t205+bE6_1.*t209)+xy1.*xy2.*(bE4_2.*t84-bE5_2.*t101+bE4_1.*t135-bE5_1.*t152+bE5_2.*t194+bE6_2.*t201+bE5_1.*t213+bE6_1.*t220-t36.*t52+t30.*t66+t36.*t183+t38.*t190)+t5.*xy1.*(bE4_1.*t13-bE5_1.*t24+bE5_1.*t175+bE6_1.*t179)+t124.*xy2.*(bE4_2.*t112-bE5_2.*t123+bE5_2.*t205+bE6_2.*t209);t5.*(bE4_1.*t91-bE6_1.*t101+bE5_1.*t201+bE6_1.*t240+t17.*t30-t24.*t38+t36.*t179+t38.*t232)+t124.*(bE4_2.*t142-bE6_2.*t152+bE5_2.*t220+bE6_2.*t248+t30.*t116-t38.*t123+t36.*t209+t38.*t244)+xy1.*(bE4_1.*t160-bE6_1.*t171+bE5_1.*t224+bE6_1.*t252+t30.*t91-t38.*t101+t36.*t201+t38.*t240)+xy2.*(bE4_2.*t160-bE6_2.*t171+bE5_2.*t224+bE6_2.*t252+t30.*t142-t38.*t152+t36.*t220+t38.*t248)+t30.*t160-t38.*t171+t36.*t224+t38.*t252+t5.*xy2.*(bE4_2.*t17-bE6_2.*t24-bE6_1.*t52+bE4_1.*t73+bE5_2.*t179+bE5_1.*t190+bE6_2.*t232+bE6_1.*t236)+t124.*xy1.*(-bE6_2.*t52+bE4_2.*t73+bE4_1.*t116-bE6_1.*t123+bE5_2.*t190+bE5_1.*t209+bE6_2.*t236+bE6_1.*t244)+xy1.*xy2.*(bE4_2.*t91-bE6_2.*t101+bE4_1.*t142-bE6_1.*t152+bE5_2.*t201+bE5_1.*t220+bE6_2.*t240+bE6_1.*t248-t38.*t52+t30.*t73+t36.*t190+t38.*t236)+t5.*xy1.*(bE4_1.*t17-bE6_1.*t24+bE5_1.*t179+bE6_1.*t232)+t124.*xy2.*(bE4_2.*t116-bE6_2.*t123+bE5_2.*t209+bE6_2.*t244);t5.*(bE7_1.*t77+bE8_1.*t84-bE7_1.*t101+bE9_1.*t91+t9.*t32+t13.*t40-t24.*t32+t17.*t42)+t124.*(bE7_2.*t128+bE8_2.*t135-bE7_2.*t152+bE9_2.*t142+t32.*t108+t40.*t112-t32.*t123+t42.*t116)+xy1.*(bE7_1.*t164+bE8_1.*t156-bE7_1.*t171+bE9_1.*t160+t32.*t77+t40.*t84-t32.*t101+t42.*t91)+xy2.*(bE7_2.*t164+bE8_2.*t156-bE7_2.*t171+bE9_2.*t160+t32.*t128+t40.*t135-t32.*t152+t42.*t142)+t32.*t164+t40.*t156+t42.*t160-t32.*t171+t5.*xy2.*(bE7_2.*t9+bE8_2.*t13-bE7_2.*t24+bE9_2.*t17-bE7_1.*t52+bE7_1.*t56+bE8_1.*t66+bE9_1.*t73)+t124.*xy1.*(-bE7_2.*t52+bE7_2.*t56+bE8_2.*t66+bE9_2.*t73+bE7_1.*t108+bE8_1.*t112-bE7_1.*t123+bE9_1.*t116)+xy1.*xy2.*(bE7_2.*t77+bE8_2.*t84-bE7_2.*t101+bE9_2.*t91+bE7_1.*t128+bE8_1.*t135-bE7_1.*t152+bE9_1.*t142-t32.*t52+t32.*t56+t40.*t66+t42.*t73)+t5.*xy1.*(bE7_1.*t9+bE8_1.*t13-bE7_1.*t24+bE9_1.*t17)+t124.*xy2.*(bE7_2.*t108+bE8_2.*t112-bE7_2.*t123+bE9_2.*t116);t5.*(bE7_1.*t84-bE8_1.*t101+bE8_1.*t194+bE9_1.*t201+t13.*t32-t24.*t40+t40.*t175+t42.*t179)+t124.*(bE7_2.*t135-bE8_2.*t152+bE8_2.*t213+bE9_2.*t220+t32.*t112-t40.*t123+t40.*t205+t42.*t209)+xy1.*(bE7_1.*t156-bE8_1.*t171+bE8_1.*t228+bE9_1.*t224+t32.*t84-t40.*t101+t40.*t194+t42.*t201)+xy2.*(bE7_2.*t156-bE8_2.*t171+bE8_2.*t228+bE9_2.*t224+t32.*t135-t40.*t152+t40.*t213+t42.*t220)+t32.*t156-t40.*t171+t42.*t224+t40.*t228+t5.*xy2.*(bE7_2.*t13-bE8_2.*t24-bE8_1.*t52+bE7_1.*t66+bE8_2.*t175+bE8_1.*t183+bE9_2.*t179+bE9_1.*t190)+t124.*xy1.*(-bE8_2.*t52+bE7_2.*t66+bE7_1.*t112-bE8_1.*t123+bE8_2.*t183+bE9_2.*t190+bE8_1.*t205+bE9_1.*t209)+xy1.*xy2.*(bE7_2.*t84-bE8_2.*t101+bE7_1.*t135-bE8_1.*t152+bE8_2.*t194+bE9_2.*t201+bE8_1.*t213+bE9_1.*t220-t40.*t52+t32.*t66+t40.*t183+t42.*t190)+t5.*xy1.*(bE7_1.*t13-bE8_1.*t24+bE8_1.*t175+bE9_1.*t179)+t124.*xy2.*(bE7_2.*t112-bE8_2.*t123+bE8_2.*t205+bE9_2.*t209);t5.*(bE7_1.*t91-bE9_1.*t101+bE8_1.*t201+bE9_1.*t240+t17.*t32-t24.*t42+t40.*t179+t42.*t232)+t124.*(bE7_2.*t142-bE9_2.*t152+bE8_2.*t220+bE9_2.*t248+t32.*t116-t42.*t123+t40.*t209+t42.*t244)+xy1.*(bE7_1.*t160-bE9_1.*t171+bE8_1.*t224+bE9_1.*t252+t32.*t91-t42.*t101+t40.*t201+t42.*t240)+xy2.*(bE7_2.*t160-bE9_2.*t171+bE8_2.*t224+bE9_2.*t252+t32.*t142-t42.*t152+t40.*t220+t42.*t248)+t32.*t160-t42.*t171+t40.*t224+t42.*t252+t5.*xy2.*(bE7_2.*t17-bE9_2.*t24-bE9_1.*t52+bE7_1.*t73+bE8_2.*t179+bE8_1.*t190+bE9_2.*t232+bE9_1.*t236)+t124.*xy1.*(-bE9_2.*t52+bE7_2.*t73+bE7_1.*t116-bE9_1.*t123+bE8_2.*t190+bE8_1.*t209+bE9_2.*t236+bE9_1.*t244)+xy1.*xy2.*(bE7_2.*t91-bE9_2.*t101+bE7_1.*t142-bE9_1.*t152+bE8_2.*t201+bE8_1.*t220+bE9_2.*t240+bE9_1.*t248-t42.*t52+t32.*t73+t40.*t190+t42.*t236)+t5.*xy1.*(bE7_1.*t17-bE9_1.*t24+bE8_1.*t179+bE9_1.*t232)+t124.*xy2.*(bE7_2.*t116-bE9_2.*t123+bE8_2.*t209+bE9_2.*t244)];
