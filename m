Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019835ECD5F
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiI0T56 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiI0T5x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 15:57:53 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892C1C99CA
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308669; bh=q1O7nAXq9hNq8lMSIOSddJXrQKGCzeTGXOdZUvFDVUs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Zy49jjrAVJTILeF0oDu8wZp9vlxVK4zNjCAqI4ITN54rWEaxsqxIBFXbOzRjpU9ek5FIEv73zsoejTk350IBaRRQIGFpmg1MWc9BQHG4jb6K6terSCyBq7wWzs+zQcx1Fgfxot+nJcUiNMy/GzQzKzB+PCB08/XtFZ34Jap6BAr2ZMKH+tYUKC539uZHJ06n2bSNFpjorqvm45D+PvBxTsXMkrkx0NtuvknXHyxQmpwB4m+xnVuvVygzH9QLRPj48WEzZfGKk6K0BvOcu28SrszeF1YKg1shsGpeIcl7aLgJfVYoNVQPQyonlNuPz8OE7ez8s2NDUvuaTQsTNwnSOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308669; bh=cO24ohb/F3lhDZtKVLSIktBVCK2dDcaYXqe2AW+Zj2G=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VrTaOFRJqIGO4OsdM9TRs4iFRD0K6hE/E+5ByIaipqxlJYhMG0G2xYPawdnwArXJJLbtBSTZiRqgvfIzqMQvnLRJgU7dqIgX9P0B6hChUhc7VHsz6yf3QGmAKv0SCcIbF1bAlu7x0XfJqseiKlxlFEQsszcnE1K1zMQ1LXf7MM3fbqla43FKSKstveuSBMpZh0EhbKfHuTpZrfzjQLi/XEGm60qPzJ21cSeiF5cJB6LbP48Q1rGFfV5hckl/VEYUhABNFcfRJHJlKJUAolnC7Mb+mogk+yb6lkbtoz8DLO7vjGqMvR+o/VAN6HxvspwdmPGlKHBBg7CEkr5JlmbRKA==
X-YMail-OSG: hGZDFGwVM1kQ5JVyLRphabpMip28IMO1uWKfwsKQEy2zKiCkWlQMdpCX..RgwrU
 2oeRIVpEZfzNklUT1peOV.i4T6kkMvKgT1v7EqY.c5X1YKuTH0t4Y3RvpFI0V_ypM7vZUgGDU0y6
 Bx7VZA9.jMrS3ezMYLfra76J9opub9K4lHOJ7em36bKC9BHrLxwgW7jF9_GSrWfgsoPqT0u8nQ_A
 2dFdBnh_qWiGacc3vu_LDbnCZl5TduXTMYZb2fKb48Klq9uigSPfP1O4E_ZBtETgKchJvB9ixpJQ
 hUCPD_X92JcWKAWm1rlezao0cdRgRD30QpX9f0bsvcRLOGZTpluHMGApXx_8Ld5ZM7U0ZaSPp58s
 e7BVVzIPPZejBi2ewCtimPKCRA9TJZQzdEdT4A2_xxeFTy47tGDvKpuXUtA0nyF0ShPpeQHPNsOR
 SxqjZTuH3.YM357CMudF6i2PZK0y3P776Z3Z3TpTJUgUSVrED.KahcLcoyhEiXpBX9NpR9CYfMBm
 GddNWOkAIAgBANxIlZbHwGOGADnJgJo2u9txJuSgn9rNveGtYnoGSL5_AhKXOb23GLToSB5fE88D
 OicV.awyxJYa_BL5RGuBQSbnyfeolLW7yvGarJ74UlR6ARg6DivBuCtuM9FVLWkKYVAWUL4tsT00
 7X87wi88EqDXF4GgaMXxGaBjRtXA8k3NBFjFMNETdhb.zEOxC3jySbvHKq0Ounr1C38YIJpWpUUy
 5OU1oKWexNhE2lKjK5MEC.aJ6.nh0WdRGOPAeGq1LlqdgBpYIYljFcvgLieI1K2g4vE4VyvfodAG
 QAWupM_d51aJ0ngFuozZ_FhZJoQxmyFUAvJRpYBJG9OfivtOwCTzpRlY6wnUZDySo53f665lpnIy
 brAGlwVwQuaaufaZhIzUPLL53bNUYrlAGeNp8v0VqCL294nTS_NL5RHSEFxA2a8WUsfNPoY3Bp1I
 C72ftJSVkd7H14aG4117LmPpvDhevYvICuVhsKa6S79VUHW57eFGNygD7acL6fDTSf_4btZLVAUO
 cXBMZhfBzYkle8ZKg6AGLsbu4IzXb9jmk4uZxXV.qpklb0b6rk2rFgKgOt3vnPbMu0jWfzqWq8U5
 or5aONZucm..JT_Fnb7r4aZnQNt19tsBMWKTe7F9pdaou9hzMFQPT9jCErNWMl1.QjBDR2ddqRAH
 ..YLLHIg9pL1yW9r2IjMRCtonDjNAVlIb0QRwtOrDV1MMVy053AXXLgXfN4QYEYNzBFtD02ig0I9
 RCEDLLxzlxwZV8wgAM0eA0zYePiLLNXKXJmIPB82LLYogShU9ykJDAxj60va5SRZ4ZkeruHZSSds
 ITY9gpgNI6R6lNu_nBVTiuXiyQIw7j95oISuDgBmnolT635sFyH3ZbWYjDl9JLcCqtfIyNssBNus
 WU0.Q3eeor52ihlCw.7Uzw8ASd2o2sSeo5iC_mfNazoQkSeEjGGT_zU8KPAZyQb2TFvWjBBRwHew
 q_VyziOOyKcv6BcXwa9fHh99KXnlkXia.uibly3qmnTleZil114ZSyuyMxJBlshbmWHWxLNjoHBs
 Kw6DNByJ3ThMRyBpRfyOPTbyLewaSbMF1AZ3jfd1EhMq828kWT475tmIaAZtcWqDg3IsGwlAItd1
 io8Qe1Yi8chvSmiem9OqoWqpWXQyt8rEipAI5b8bEvjuTmeIhIRaBBScMD9CW.cwfjigPC1btEoE
 aIVqyTrHQpbRHAfPV_vj3mp.a6YRTGu6x09hcLvpwZEGoOKVGIJszEQC360earARLh2vp0OEpXgE
 pvUZqkV3WMeFacKN.KgTEHszhPBfSmjsD4aOspHPxR6Jy8pXd0KntS5dLLQDyj5KYihZAKIG1Ask
 MbwSEvlzbk2gnXScIkjaqqP_y6BZ7Qw78tZdwrPI7T9wsHsy0rBYJHec9OWFQtL4JKuE6hOMnJXi
 os.1C6CmDV4WbdOQLo6QBZorAytSN8yJLN.dcMHV7.t3S.sbzTs5jOfurwEZX7LaT_qSZG50B3Zw
 4irGM4hDNVgz6ve8f2kw_9qE7gT5JT6W7WWyIbM8nxhGs7HGz2eji6WUFZxWbOlziT.t5GDEyXZP
 JybyLfxP8jJzSBqV5cMi4cV4zqh4azKjYEbYCe08Vkv36qe.I4clm4GRLmLM3BIb6E0LjWTwsuXZ
 bmDbYd0Kwlqco_U0g1lhYCZnAxflJt570QJdy.tkAYt8e7.TXPm2J6dVY6WKwS.rTJXWPeB.Jghx
 9brVmT6IycFLe1tS1pYWu55Hg5VWdJrrmM3hWrtxLmJLZ1YrqfOYJ0NP9kCBPbHOJElUXWpW3bId
 JiTUvK7ymPg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:57:49 +0000
Received: by hermes--production-gq1-7dfd88c84d-65w2z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29caefd968e6c103fbfc34a90b4ad636;
          Tue, 27 Sep 2022 19:57:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v38 07/39] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Tue, 27 Sep 2022 12:53:49 -0700
Message-Id: <20220927195421.14713-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index c4696f14daac..fe3273a6498f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1944,6 +1944,30 @@ static inline void security_audit_rule_free(void *lsmrule)
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
index af62f4c1cc89..b916469388b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2603,6 +2603,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
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
2.37.3

