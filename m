Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520C5457F7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiFIXIe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345890AbiFIXIc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 19:08:32 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62371252BB
        for <linux-integrity@vger.kernel.org>; Thu,  9 Jun 2022 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816108; bh=vRXNkEFwPBrhbUfQAAYp3D0X06XE5hkMGmH29DlHBtc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oMvduhrwBYpaMHnmGfbZDUH3zY4Rppej3EyF4db2dqzP+Qcn7ecsVAowu7hBoGm4MqT/HvucGn38XTP5eFpulDE1zBbugklEhMSzx12gsa006/NtGSt/8TbB0vBPpy1Yp/WOZiU7PsgWOJc/o05jRUeLLwZGkfIk3gbW9aqzKiyvt0WA2ZGd/YeP2Zj06hN9JoizEO1PSELMIW8HMVazsYT0aE4DRSEqexQMKW2qA06iJIgjPS+n7hQjkBrWGVYogpKVur8g4HpNCVJCfYiEGkEiX3+T6Ehi5lRnPT1SoEzgKBEbIAnkJfeLS7yN4aEJcNXzSq3e05HHPX/3+h68Aw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816108; bh=MhhB+/2veZse5qPJZFp0D+Nk189VhzBkLyTqrAKukMF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e8Gu8um/z0Nj05gQuxr2F8qCDMYE5x6WcVrYf0xEM7LaqUSBGxjiPAu91URYijUGrAhEnCveR4fLGnO81YG5Gm+z/ggZEZJhcJZHe2J1kreWUPKOLttWb5N20gwUEE3Qib32zpqeQBWLOh1qXVX0AUY3+TmUIXSyNmhhmhMzpaGeBk0eYHq+BIlugYq6UaGB6rR2x/qcW6pxlWwRrZTXrPCwcnoUzGyNqN09DOjcayi9AX5nAvuxnjGP7Hq2BTSz5sQc6Y7OL4rqqJxy/R0wByQtAB9j+izt6Oa//8ggi0/vs8jqmxkoXFwE0gUV1Fx2Ec9eRZf/6qrS/aMJygJHcw==
X-YMail-OSG: Nh_1mzkVM1kej0hSJx08_n5qVIWQ.K9fxDjlru9b7CSA9tdu7hZPacgnu0Uv5Gt
 918r5KG2Lqv.YK5cCas_h8SFYsB.FpleJljxKxwngZTJeoJFrkcXsV0ip1Zmp2f35j7o19Xqt.63
 7_eY_.GSyc1mZu2sCcc2ay1lsxuVhDU_jI6hnmqLSgbYQyxy3ZFFgZMYJW3NpMOW51GPkmHz9PLa
 6kDPoqkwLfRxVxQlnrJYdVxBcbUO9PaN1koGtyvf40.AaD94wlJzQWkGwMVyvWU3D9yK4MO8iB0v
 SFf2cXPDxf98cFkqr91M34_1CFXZ87ydEQlH_S.qEfl_zHAni72_Od3WIJSN4MIvjjrNzz5jOtQS
 j5vJcCYLT7m2XARD_MeMgJ4_RYkJoMXFmXdLgywNheZtoTMHwYgxqpEn0uYeCCF0ls4.CAROGpik
 7EnqMus0gcNR4i_suk8cbpvPNRxUDnnksyW5rLRtDzcq_0WdEreX0E1wDUDO9_dnc5kg3VPayv7e
 85r9e7ZkrIuMisg2OQM0TRx8d17d10g5lBxBT5zhPFbcFh9ee005zfAtWx7RElqS28_gI_9kQNk1
 nyRHIWi5wzdoKq9L1j91k.PL02cFBHTkIefXD6NEtElB3Cw8vQuX5KzCv93SX4.EYqfKSgwZhcY.
 fqT5kFmQ6bgSSXcNAus1IU2oS0wrjlx76G.VwafCQ5t6eWK1UvClB9Uyh3dHakJBtSydgx.mPMkX
 zz0A8Op2siyh8YQZUZHwt3M5shf0WobrKtAR74NwwfdgT2bZbL8B.YvCoZdO9uxoUjWXLn63u_ql
 X291a.JBwjH1iuy3j9S9A3mTht8j7pIxq5LNnjUSxY3jUMVxhsltRlu4hAN34SqIw_AUTJ4RoHNJ
 lDxBpRHBsA0FOVmQ6pXRcqfDsQKNvBDunpCmSDPjIhNW0zlcZyxgqKNnvdtRspx9Fev_E3.UYt6G
 DsglvpMujSKpzI8kVuVU3cfaOhmoRBTfxfI33GED191.rCN3RbdFOD_qY9vCBuhRgyzBZNc_RRpc
 qulx7IqUBRUOo5al0G5_1Hery2ombU2aQRAYOUjdEo.rFE2sNxuB4mRZigGxWlgfkDudT1JvjyY3
 n6orrzCv2eYc6tD6AtceDu_9oU6YJIoTTfEka_LjkqKkBwvdZe.WGhfU6C.B2awAy.bnhj6ZyOIr
 XZQZPGIy31ycfVMKKz57VAMsQe8TS9awe9X0GwcqGbfcN9UN6YSc54y_XkxY_VlZYpxU_cIM09gH
 ftsb3My3frQklgiOksoq6sW3G2wp4wEczr8WyVqkyWc1TIT3bCNecrt6SWqCC6EF0UfkqKR.ysAL
 FJoMBnDC6e39bx.ipVxci7Og.5nfJRVbJqfULIJ7jPSkD71GfaIy6_VYgIYQzS4PKLhOcB.2JKzC
 HiGhkDftXq3z0nv9MZreQrNeFRMZJ1y5UoGKK9s6scuujQGEXvM.He87sB1cTjh1wC0DFac4z9Ue
 heWGTvtiaiwqonEvijRx0dcwSq5rlvEMCMLNJHTCK31ldqNWNORZ6tfxGPFBhVB79KkN.Eb7NkCC
 5QRJxlPe8lA8Jjwhsb3eQ2D8wSYdc4_gkeieH48SjvN.v7ePQrX0gPM9wLKNAZ0m916S5r0ksbO6
 d2ehHW9_OYnt.2h2aLBWxg0s6cVWNncskTXNFraeiCjqrmY8n_uOKSG.SLMg.RixT7fM6VSgsj0D
 4wxYKILAs5Exq1osEH3EomYUMH1aAnqIqaZgtDRL6fguLmoiLobpfeStd_ihoRHlmNT8BimzPEkj
 9Nnfl23qOz.iNi0451wpajUj8nitzno7E8epyQzQMLbX2SZK3P9EAtqTKAbvOJGJQTKV1ugxlVGt
 4MQVpFFAMv.Dk1LfE3XvptzK0UZhkThfJ25vo5uJR4CS5F4W8r9efH2KBnLz_8sKHEaMglKOjE5k
 Ql5CG6c5pZ3X0s3_2MbI.Z3NAopqr_Gf1BZ6SDWSpzn6.uByI75w1KMgfj74d3kwXIzfNC9OgvY9
 uPnYUrB1HF5w28P3jSElgJEUA4XU2iQOv_O6iYXa8PnidhkW3MnfNZtzIva5Wn4QhuXSEr2ek9XX
 mLVP5X4w7GomLa9S7DNjbvzMiqyyAaTOSKSIr87DpTsuL2J9oEhkbgUndjPEavhye9uNUX_FE1.z
 6zORsw9uJTkb8MZSADvZFhRVDIlCuwVcMKjp.QEEVYiroRNJCMdqY5KTK19cQrs4lJozLMHGC_nR
 0TmjYwSybxh6iIqp.yLnFpWjU4LTLVOUMzCIQdLswohpZkEfWjpqdMrZSnscwfKX.jk7pJEGl4cN
 nCMouQa57YDc3tip8QkGW3NqMGXmN0g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:08:28 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 81d1362bb2f9321f75335da17974ee85;
          Thu, 09 Jun 2022 23:08:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v36 12/33] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu,  9 Jun 2022 16:01:25 -0700
Message-Id: <20220609230146.319210-13-casey@schaufler-ca.com>
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

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h            | 13 +++++++------
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  9 +++++----
 security/security.c                 | 19 +++++++++++++------
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ce4a4af362f3..a478faa6124e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -476,7 +476,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1022,9 +1022,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -2034,8 +2035,8 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
 int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			 int lsmslot);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmslot);
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmslot);
 void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
@@ -2046,7 +2047,7 @@ static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return 0;
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
 					void *lsmrule, int lsmslot)
 {
 	return 0;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e56637b5d518..2d1dd5af8a00 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2306,13 +2306,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = lsmblob_first(&blob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5c2bc6782e17..593b0ba51b6e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -636,7 +636,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -648,8 +648,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(&lsmdata,
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->lsm[i].rules_lsm);
@@ -657,7 +658,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(lsmblob_first(blob),
+			rc = ima_filter_rule_match(blob,
 						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
diff --git a/security/security.c b/security/security.c
index 1a4741178944..ad1080e01ba8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1560,9 +1560,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -2804,15 +2811,15 @@ void ima_filter_rule_free(void *lsmrule, int lsmslot)
 	}
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmslot)
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmslot)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
 		if (hp->lsmid->slot == lsmslot)
-			return hp->hook.audit_rule_match(secid, field, op,
-							 lsmrule);
+			return hp->hook.audit_rule_match(blob->secid[lsmslot],
+							 field, op, lsmrule);
 
 	return 0;
 }
-- 
2.35.1

