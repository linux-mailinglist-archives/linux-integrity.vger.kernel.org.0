Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2928955DEBD
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiF1A7E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 20:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbiF1A7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 20:59:02 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1E4220ED
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jun 2022 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656377940; bh=tYqWAwtnK7psUEEe4XhJcu7l6wVw6vdttfwUfuyaySc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SAgeBo1sjcMgWnDBC1xlcCce6xsk6wRmUqxJjNppwLOLQ2J/vQXOTqLS82D7XqD3LrJsxebgfmwlO4LDYo3XSRxi9wgjKN1P1+y63ter/kpIB7HgTSKwbIcEX8OIS22xJC+hu3WESRNeiUyd4GWG7sARE9mPFG1MIlD5thlBH6ws2z8vBbnAsMag91EBMjuMMfHck4Hew53YbHDRwgZYRwesuinkSqmAv/z/m21TD2xXzX+0O4SFo6q+yZAvQH0V7HSvdS4gL1nv0vla9dOUrp015yPAz2ncW/RvM/HtVrfLXkT6oROnjPEX1H395fhgRHL8/MVHHmi/xn8sWz5Ttw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656377940; bh=QA6E2JR13S6k3NYK/bvjQvHkizLcH4RD3DodTeatUSw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DpPt8VtPI6yn3xopzfTt6WUjlXLfI7T/CHdZvf5qbOWAjGFTDqQ7hRshnapkiHsqyPVABe+YvRaZ4OERft4nrPb84FMxgIc8bq6bnGUTIjBmbZYZNOeCWP9aez+dAN2XPs4b7ZQJhWt5eshdB6wuBrPPJyjftNFrnBRgg5twzI2IClkR7IzzV4asx84MK7KF1CEkjuWPx8X8w3muR2xNjr1egB9F/P5Kn5J3og/uC44bQn+xm2gDDS/pt3Nz103IicM1U1xTqb8KIASqN+9Mf3aL5T4JrSpOigrsfo+W59cc2XOXKP7tCmQt60t1ibPZ8eYoDWrwFD7unp4OBlTsTw==
X-YMail-OSG: v_79ysYVM1mRV20MgroC_3Ki095aENCZjUwOnNSxBwMbuMVeSkPKR8.me5nCUUw
 rKkM7jh7yayJczS_d484nIYpMRNprBPtpvhvRqaHmsNirz38z6774jX9MbSLafq.YNht0EnJWSMW
 o4Vu4i5t7tmpxeCGHLIRD8fYo2Qn6wWQUaLD_i2Qjb5iLWbOUCx9QgkJbq8x_7UMbNXhrrnMvJ0K
 dLMo6aYbfrcQwi2ku0Hc6cZG5qh3pd4Rt_sh.OZQbF0UEDd.CiJ_GrB1jGTX7svv2xSUU901AXhA
 OudH.yPjzL03PCN9QkEwSe7OCFqWoyspgWd39J1cyBANCfxDmILNqgthFYJjQ6vI_UfTdrnCJqyo
 dWobjiv7iQ2aC.2cn3SYqaLzwhsdWMjK0NfoMRlMDXZR3RzgALENj3MbEjpXH6jWtNoXeNpjIugt
 iMdyx4W8MBDEjKt34jMsx5t.9o2ZhDGUufXmU57Nr8mx54bL7n4Ma.bAbJBG.0uEYn.J1MMOQezL
 _cffaROKffBwtqKpp.wFPc5JQG1O2tBAOjP6K615Wig4KQ_F6_DlmtQBQWNgQljAoM_Rzpn5bzz.
 .jfnpHn5OkzMsC8_qNUdLZifNb6vG_3bkbxVA2MXuWKLySDguPzJo7ExAlzfLBmo6OWmgd1Aa4Fn
 Zw5Te8dIFhvB31QilJiQqbUJSoad9D.LPtrYQula8aReOXFnOSVp9XwrKxYV0QhftH3HkA8W9Pwf
 p6ZwHTiUn1g0cZeN_xgQQeYc76iObr030nXf3mzApcaBHqUEtsYrAA5SlUtI2nUyXz7giQ1kXB.T
 PlpsPuyT51p4wPYspBIdobUuwpurU.Rc8LzCoT9VhDsUE75j5a4VYyum87cA5EMSx7qhqqSUAmqa
 uoq6HaGWnPge__NuI4gjw5Xb4422O8KGZep36Nz63_kfRELlmBpEeq0MPpAcmb3rXoz0sxrlzBBJ
 UecuRQ60ZXN1mYNEYb0L8B2smNo33Pa0Bk5fOcolvOQReiUO2Y4EFg6zUQ09egDIuNUU8C6WySbi
 TMrEYLRlugSQ0GJnR76iVZNQw09o1oB_YRZ.6RsonVfA0cohWhdk1PbBMbD0GaCcowVVCFf5JrBm
 W.Fe6SjQni4c6pxWPyinaY6KXog1_9QbJ_X6LazABPoPK5me8v7clYRWkA1NYBvpqXw5sl8F8KEy
 GzhgmVBWSI3Rc3D.iRMOYtP2Q1KPduNqx4f7aC6HesvNfZQ3yxvF7cYy2r_lHrvGeLupXATo7dvv
 7bp8FYaiNdcl.jQIv1llBuV4axTU8wU5Ywpq0WKYEa.DWvYBNUp1JNK4ZWNNNNT34yLLOCsN53rr
 noQ.jK1Mq8EbCD.jR7VjyiE0PySDvBRH0OWqlsg6FvsVl.Gp2rZPY_.wU0PNdQpbNlyUh4Cq2DWW
 kqTvWgcKvwoIm5V2c6M3YAsXAKje_TlFfw.KmoMgPrSA5TtjvJ1Ob5HFLi0mdSEhDzguw7aCG3AY
 Y5frcV8wxGYRPnYAGydVBaEgKPuP1dej5tsk9JcOOrC3gCTyeu7kwmzctfTARDaj7W29cRHE3Qa9
 mAvv8Xv668pCJOKiMkDbOfd7K9.aqt7pqjaw3mEnllmUoyi6ON1B5Xd.tjKoxG9uuHbisof_9ZuS
 I8ahx878N8m8lpof1YO9p_xgsRt9._LICiVqph7xY0ahZVWq4c48cVPs6e3XNe9UxaUU9Xz9SOTB
 H9j2z4ZtVU7Wou.EW0LwMKU5GWcbf8BOm0mi8XOEingxfbwOK9zAYvdZpzHo4SjnwBy53G012vt6
 mn8ednd_y3Tl9tsaGQMn8eIYD_s5Krgn1SYXL7nD7MXrDGKBBRM47UhhQ6C1st7g12T9GcUDjD0D
 1yEyc5WGnMrA368nmr_bCmDf3Ri2TbFEBCgg4GMk5Bu0Kq3eZsrsZq3k6cwUE7P8iM7DG5pXBJT.
 jZcxIw.ZMC4MoobQJXb_DcpEgBCeXpNkiT3bhjO6XTMUCVi9axyzdzyKA2GPmRhT6R9lUpjoAdh5
 G1FWojv93dQqdYlOwoH8swV43YssKxN8yLXXlQ8XItIy13NnPSHjaWAQQkSaCn5K991.Q84udzei
 2DQTYypCa6npXxc8BI24PotBOrzvlJ3lXsW3yxAdu0u89djiLdOMyQJyUJrCr5Q_GCJzYAhpjjYm
 hq_wBeHAWhAkAo5K44G2v.NFfKfSqMaIqcGwC3MF4KdKOSPELKnd.40j_nADyLwAOf3a2yXvDlD_
 eHwYqVt8.cn.uvV3_UEi2H3OMlPog2i3u4BD.2QZhxJ_vyFnazc3_LYg81FMYAQg1HhBO.e6abbz
 hX4RJE0ZELTtU.51VQQHcuEx8oWAOiKAwgnDXqgAm3dbDS0ChRneAw_0yHg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 00:59:00 +0000
Received: by hermes--production-bf1-7f5f59bd5b-b6lnk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0a6274eef1e7322c21c22475730a9ae;
          Tue, 28 Jun 2022 00:58:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v37 01/33] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Mon, 27 Jun 2022 17:55:39 -0700
Message-Id: <20220628005611.13106-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
2.36.1

