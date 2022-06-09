Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6355457B2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiFIXCA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 19:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiFIXB7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 19:01:59 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B233A81C8
        for <linux-integrity@vger.kernel.org>; Thu,  9 Jun 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815716; bh=3o5SNPwTygO2LFJJxsuqLI+/nYBK+jKK5VhgaHDFflQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MB0GbsJpA9f+Go2z+Gg1OD7CbkwIhsEW6qVqdyv8KJQMR1TiJtdhm5PQpoa3viYnzwQ+FGEjOrmi8pt7qSAcbRGwsEso3cMrL0CMsiKuCUGoW7lBBadsxTyn7PVX5iASlMkCmIxRcKyHAe1F1pFogUWo/JmCCSawKl2sSwe37mfdyGwAyANbI6hvV7JvcSesDjDXA12Kp8p0dUNcP6sYO3dzpVXCYZaO4NXlk4j0gCKhG24Mu3Ef1J9nN6MXcv5U2LO/MiDut1OzKACGnllDWO5NX+5IuEddVGx+xcb5SvWJ4BqmlrcXViWwiunxuolPgsPIH2wX3qso4/x0jNIAYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815716; bh=ImdRA8lD7GaElGNVKGeK5gfGoIW5FujHb1sXef9nKX2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qbEDwjx3KO1UvaJyjxGwEvce1IR7kPma+s/2eL+393BK/zuWQdf524oG3/Jfowj8kJ26YIqpBpnYAp6AS0/neZuPG/zL6sJKQljpKlc6NtEZzTGwaTGe+gfiLIYDIVNzloNJDe0uqssnc0jHIMInfqMAUnP8+f9Ply/VkTqhu2Nyq0i7BVUJOGagCE/Q+6Kb6fMO+pU2C4zyhhGwC2BkBHnX4yQ8fC+QBHqtDbh77z4W5r1HiYI2xkwoLBRpMgL8fiCOrwUtK0fMJmWi/m4yN+gUAd0VGhQAU+iPLLRuxM58VDJ7exxjGnoJmkthTlI2/OjBR1Zf1AtFUkZHd9DHiQ==
X-YMail-OSG: iUOlzhAVM1l_HU.psXHgLSlUCS46SpbDejCxG0EL.cHrwH.MCXY0ci8HCty5TY0
 B22PWoVxqs0lMz0wAR5iH.ASwNmxW0Btp7WkRX727UWQM6_FsLlzt9QpwvOG17E3QdIpcEmK7siQ
 3USPrkBvjA_yKX4Yni4gCa.u4TwTHNYTnz5MgJ6wSPynmcsT6dce2ipmezBp0qlyFYwvqFuqx3EA
 8u44SycOl84w4Tvi4gaEU983uJhA9ujsZGJkSUXfzajSII1z.egsIvzirXUPpQO7G27YTg9BgcPU
 Ap3LGnUn1zuKK9ec6L2S0B2LlNWAQLg1WQ21Ov7ZOyPebGecn4bgUfggiNW70yRzWtEbuvNWRVf3
 4YmA6k.HXLUhlfiOkr1iW9mRNmRZf6dWNXSn6Za2J5p2sLc2D2HDzjiBESZ8RGXg953X6emS2orr
 fuBSwynmF821CM0rpbA8IfbB_qI8tF7vRWu7ujD0f75VuTjiJNYwdrk8n42NR4G8vbqW68lEWUJe
 JoIbFCg5ny.9kk1fx7FExuJ.811eJz5DMHzuIuf1svBK62fuT6.GmMMNYGQfjCdwI..mUJq9K1yE
 s4Bpyh_8u_FB4lHVx2DMIMQsbX3K8iwihDd1YockhMKOofzhuxdLtdaAV_NKZ8yF9ScXkJVG2tLb
 uOFwSPf4svEL8gYz7v6MbBbgkKrgOiU3uHtmoNW7asJwMbwGwKAnHEveOVS9680JylY6fDQscfw.
 X_hTW88lhZwbUFBkvGDeEHAxefoQyiFT2A0ZgQyTVuRBsnf9fojiyj.9i5RrwU3p1mfPF_TUdkdC
 pafeS_zmYEV5AKjKCR8gyte0mr1SZtDCujmdynYanH62XzvSyy53Ga8tgt5zEF0NdwHxeSBflvjF
 eXd8Yhjkfbrg2bEdajgNsFC8ioSYRORKvkpNojQfTjB6vbujE4KPawb7791bSyDX_M8DTU5cVL70
 poIEmlnlSLjPrDz1XocyLru6gCKyY95E7QY0ZHYZ_jqIJCvbXhjRbr.thxAHd3fTzFmMMA13tulg
 85BMxnoHvGotQc3aZiY7pqKZtl1XNRwiwRBA3bxzP6ddSAkoTkmxwbP5hj4oriDXKU5PS5ztxBvN
 zfOL8HzXQE5sk9Ix14FXG1MlkMmyzRLy9Y_o.rcBv8J.nJvLM3uyywB2LSprApLVv505lEx0p.Zm
 hsK3e5VRy4qLTvVf7RzdwJoz.iT2gNKZBybY3GGrDngWJXy0bpm2pTgmc7UXwFmiTAz4T9PKrtzQ
 jjx1k8YoRU72Robar0WOyAR1JqT3qZsWETWWFh5mCV0IIqe9RRsZmFz48CcrhGwpxe.VWxu4lqKk
 j0dSDNjQr06IRdVoouYgM2H_7gzsgv1cBO1rd.y322xLTz.ea1eJTB_zBL6j5AjBHYBbXm4zNs.X
 tr590AFYbxb9OJ6krDGvyH3AtlmvgHwoK2xoWwxWwgyzi4tLqYsdOgq1RokOJHafK9lPaPn_Feib
 wDeyZ.EUFQ2MrGOhkIVL4EBA1JE4VI_Kj_OZEV2W6.GrKdf0Mm_FAvyCqaWhL_9wqBll.zl3P81i
 .s9OyZfWphRUBDywAKUMXee8kRk_HEHrMcshNyR_lkRvcklSwOnzuAbnABaPvokqHmqRRnRGlzEp
 xOvG1ex3sUDjV47D7ow4Pcq4V5EOhNUkyOD2_puGBOtm9BE9Q6hj5.LsvM8ayz9HC9z2Pb23UOQG
 bpHmGZPz83S_Zslm9WquGOoET.c9Y0yrBJ35A9b53OBolk41IG00PLzYPRAPPNrBpVIBc69ZSQDD
 0Dhwyqwh236rDJslpCRG5ljFFE_wKC3hsqyMHDHaQZf5UstTH7zi5P.4EnW9iKI_IhIDkXFXwb2n
 7ictLf8ahGIanqXR1wrF41MIo2yvmf5clU1WNXFokD0Ey57ZrqhzSyFp.o68A28GUGbmgPcv2HMz
 atWJtyq9CvukSyvVJOT4llXWYgGo140aVnqzAqhkoVh9CbPedlEOv5LtQhLZXL8CVIljlwtFMzMQ
 ydH5e6c7F7GyWf2Oh6UO.WhyOqNtkIVQLN0y5OOS4KHPc3W4A0H1UqzbnCvxZTwavtTALhO_jnQw
 WUuFWFFAXFdsWp8DlTtf2F5mt8FKKFae3bn7erBDVIdv2rbmAhhBd3_LuEg_sQ8IYQEt5kl1ayTh
 TFBIyqT6sWyzTDenvXqC5g4zQ0u2xaxwty6LoqpHPTJy6Dm8LDesuk3CPjQerLM7keCm5nNRNdXX
 WdEm4qrz8lhUJU39UWW7r.Z_wCS6f1uGgm3kiOjTJYSfbIGKHy6Xip4qOiVK7RXjiwT5.spzjVah
 .dKP8NCJSbrp.Xp1ushv5Ju7UY4QnC_FmSmaYSRLtyAki9L2EVa0Qxz08jzHofBYY4ESaJHEFya1
 1
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:01:56 +0000
Received: by hermes--canary-production-gq1-54945cc758-xkjn5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0e6e0ce8663761707dd7260b164b0053;
          Thu, 09 Jun 2022 23:01:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v36 01/33] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Thu,  9 Jun 2022 16:01:14 -0700
Message-Id: <20220609230146.319210-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new functions are put in security.c because
they use security module registered hooks that we don't
want exported.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h     | 24 ++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7fc4e9f49f54..5260dbe9ef0d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1919,6 +1919,30 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+void ima_filter_rule_free(void *lsmrule);
+
+#else
+
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+					   void **lsmrule)
+{
+	return 0;
+}
+
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					    void *lsmrule)
+{
+	return 0;
+}
+
+static inline void ima_filter_rule_free(void *lsmrule)
+{ }
+
+#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
+
 #ifdef CONFIG_SECURITYFS
 
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..1b5d70ac2dc9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -418,32 +418,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
-/* LSM based policy rules require audit */
-#ifdef CONFIG_IMA_LSM_RULES
-
-#define ima_filter_rule_init security_audit_rule_init
-#define ima_filter_rule_free security_audit_rule_free
-#define ima_filter_rule_match security_audit_rule_match
-
-#else
-
-static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
-{
-	return -EINVAL;
-}
-
-static inline void ima_filter_rule_free(void *lsmrule)
-{
-}
-
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_IMA_LSM_RULES */
-
 #ifdef	CONFIG_IMA_READ_POLICY
 #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
 #else
diff --git a/security/security.c b/security/security.c
index 188b8f782220..8b176769dd86 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2580,6 +2580,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 }
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+/*
+ * The integrity subsystem uses the same hooks as
+ * the audit subsystem.
+ */
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+{
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+}
+
+void ima_filter_rule_free(void *lsmrule)
+{
+	call_void_hook(audit_rule_free, lsmrule);
+}
+
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+{
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+}
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-- 
2.35.1

