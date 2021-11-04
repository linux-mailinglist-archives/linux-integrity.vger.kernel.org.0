Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D48445BB8
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Nov 2021 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhKDVlG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 17:41:06 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34475
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232119AbhKDVlF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1636061907; bh=+xQ2fYIvzaxZTBukhEg8ND24INGgGbCbwpFVfQ9tSwA=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=jyur6xYW4CziwnLs+Yd8Aqtbdo6l1H8R23Llxz94Sz472CybVtpd9Y//cQWAfWMyOB0sISLN2hQ7cdYKpG9gSlUFScS5EFMhmSxLwtam5A13zBAtzFSoWXFFqytmj25jdiudgHeCJDOuWKxyCDcUKIxVpTREU/8q941yKmxEC85ypULGslgIHr6bQUDZ3isUdsrISHXZIdsYVenXrn1pbwQLssj51s3RVgPz1rOhQjkj9ubWmvK2yMdB65lXmCHvM9DSdLbimNZoPvlZJlPj5isRBnL69ljxDwXXLac2C9QwTRd7eG4aODrFgcBBRpNLyXcCOmfw+8xSuE/8bnQOCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1636061907; bh=l5TUuJCVKr+LW+BuI8h3FQDHMH29L6tDvENcyKskqWM=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=M/2pL9j9lBjnlRIC0LiD9lJHOrpQ5kk72TeXwfUtC/OALf2Ud1bV+hLX7+7b7Pzyb9ZWiLCjbOM8MpE0vcG3XqlP9WMEgi/HrKY3QLHY+pWf8ANTJGZ4clFt87QnKh6uTWS2EDdIt16H+BB2DJwH65Z2peVThK2Q0Y8J01xnvnHUoeLgiCkXTEp8Li09Yk7RvLWftKB1baLVLLJ58Xix2rSXEO4K4jolVxWZQ/yOV9bt2zps4Udo6zGwtnjhRicCnlHE8r4HT0HXhlR/hW3FmZYZH9/I8pW8X4WOaIukuxupwz6bucmlo1IqrKqhqCLk8S/leZdVYK1NUg/aAUQFFQ==
X-YMail-OSG: I2GfWAMVM1nmfswTFtU35qznKoLvw7NwMOAn_UEYZH3yGJFAWm8r6mocds6.x50
 zu6k0xw.ngz_ndt9ZpCSElNgUfg2sPNqW2Xk9iyLyUHm8L50lB9h37MdrA5YBoBOInlhK9yv9YyL
 KOIjFueuUDlIG6z188zqwmCqjS8XLN6iPPMOkqj7G9L06LeNPYDcWK13njwqLndUvomLo6g268zB
 bQIk61lcLYSgaAOCV56DDH2lehiSegusA9_w7EMFbUmopjLxpG7xCa4x27sDVC.kixIK0UCWQ66_
 8yTzgoecBeUQ6SF6QbvexEPe0BNnCGad7EoEuxcPz9Uqtp1GqLr24lIUspW_07U6HRq8kHyzxXBp
 Pu4BDqe9FwNrDMVpHSeepWRit8kKn6xURHNwVd3SVI8R5AgB6giwrUoUkSof2XkgPC2D4yJQ01cw
 M1vVkcZPbjsWan7PLGjoIJSyPNnLYXTb1BtcBHTRGcxYE6r5jeVGSMqr9997MBYXT2PKlrRSV224
 1ORDJWLbzvrFzoxit_sghAP8uc6Gb4FgzoGZ8lMX9dNJx7n5seb8NXvK4NueLU0TASTTp5Wo.jdn
 nCaI9SwA7NIb8Lc_wLX40P5ItAmBYf5Krk7GdKyZgktVEOZSLPCwO4h6xq10hUJqpMZVauQ6F_4I
 KljvJoSiDCv3JUld0fzK0JhZJ3kV8ZB4n1AFQt4zsYaMCAwwC._4yWY1fXY02fKyNTs4e_vEMw7M
 woJ4REK0d.8wtGo7h9rUacvcAxjtaqivlVAe4d4nE059uiZ6zRtC1q.ZLkVEvDq4K_SNbLM98dBv
 EpuGMTU8wbMhw_5QncxeHFMDf6qT9.B8xrYgHKa_8YXv6CVRZ04LWAlPvMTnyM8zBAr4ZlONtbeY
 m0jJQr8j1eI3i8f_9y_.QPjNoJGgWf4auU_1mRH9MXV_PLt9ZNBQDsLIjMYNycWekd_9q7BBA_XY
 9XrzAM6B9oAFLlZa2C.y668LPBCZtkGaDgWRaJsUyL1mT4wW8VmrM8wnDY6d5F6qz49nCYUfWBnb
 QddpiOSRxWakqrUc08gjRpVYfPBwcoBXUnFtsy3JtVx.EfrjJoqS2N39K0GNMKJjlZqahMjvcEOK
 0CvGbLnfI1OJ3ERRj89Tzhzrms7a9.iNteTsAoTJyio4KyUa7HRSWEo0LCnq39LeGByC25oUge7Y
 NP._eEs.o_nR8Z4KZtAyGP36C_ADbndKba1uMnKh7BBeGUf7H6BZRHPbnIAdOIvgOlpP5BJ0vNXi
 iLH2vj_b4eWEV78JOyUg62B_B2lHzBiG5QiEWTq2ozWY50.b9_kfY31SB_10RXzx7KtNITzohvCc
 NzbcR7jVrE5XQQpNA..1mMmW2rcIAA9Y45TQx772n1qRYvNAScC2B3ggFdmhIIsUkLpMIRD4PUWS
 Bpf9XPX5vliLl4KerP7AeVNkpcRXsk65N5aDm5N4dmQ9n9gzCGhAnS3JZ6Jl2A1CiTzibE1YHTZW
 ra9zRes3AHMbOgvER_5F1cwM.hnz7LqRn10vpKxlUSKh9.l32vW0T.Q_RsBEnv5ApPfVIYV0xgFl
 hiTloO31pKatvIJ9VvP7Vt1HjMVgJLY3rJTfq3A6zbo28YuUcCzfWE4iCjkuhyRQFyV38DiAhfsT
 hYHcQ.zr0qnPc869Ot0TO0sV3NCEr9TCY8BhZuSx8AP3CJ6HJGHYne.PSBKGCfxqNkH9YtLUObjA
 si9vkgpBHob4dGO1gzjS9Gne2NgkG7QRCGxer6LB5Z7U1TC8xS.JxRAAMo3s3WFF5YhI5X5NEKLe
 aZnsPVnpmqxQHASfj5zvOwRBE3a9OXCwE5MvPd.FLtvgh.uFCy_DRHpibo02AgOeEPR1sVH0iz5_
 vZi98frxV2zR.2mYyq1HuU2co4mO8PvASUitjxzwD7smL5pmSFPSkcXhFLtP0MIP6QbYCZuBQvwY
 FXvH0QMjq_gVIOhrrX6frzOHOkrjLAx0Eg6GqPLmrpvUFGXJsdoLNfGI5ONo6TfLPi6fbyZyNVEZ
 s.9OPz0uZiYPVegOQvMQg.zuzzIAeBi8bMPVsRmAKeJPmD8UxLN9iNqgrm.NASesZ1VoWxCMdJsf
 sc__KaPuaKyPRWhJiyvY9VtJ8MyX17W5_rnB8TbsKGvBTWi1umGv3T94_JViXodB4zH77kKxCUFh
 jmnHd0H1Aw1VgdlDA93fd_5WbBC77sEy7u8vyBebuRRffCtrQU5PC4IX_KY.GDBGq90VFmVTyROv
 qe_J20poq04DzZS2fk9AmC.8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Nov 2021 21:38:27 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ebbc6fdcb188358d04b58ac2f541c3a5;
          Thu, 04 Nov 2021 21:38:24 +0000 (UTC)
Message-ID: <b68c16b7-891c-5f60-7e85-4f4d6c331283@schaufler-ca.com>
Date:   Thu, 4 Nov 2021 14:38:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH RFC] integrity: disassociate ima_filter_rule from
 security_audit_rule
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <b68c16b7-891c-5f60-7e85-4f4d6c331283.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new functions are put in security.c because
they use security module registered hooks that we don't
want exported.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
  include/linux/security.h     | 26 ++++++++++++++++++++++++++
  security/integrity/ima/ima.h | 26 --------------------------
  security/security.c          | 21 +++++++++++++++++++++
  3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7e0ba63b5dde..f98d047b8d0a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1917,6 +1917,32 @@ static inline void security_audit_rule_free(void *lsmrule)
  #endif /* CONFIG_SECURITY */
  #endif /* CONFIG_AUDIT */
  
+#ifdef CONFIG_IMA_LSM_RULES
+#ifdef CONFIG_SECURITY
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
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_IMA_LSM_RULES */
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
index 95e30fadba78..19ffb1bceb3b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2563,6 +2563,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
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

