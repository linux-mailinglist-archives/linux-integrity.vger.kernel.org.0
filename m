Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149A5ECDBB
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiI0UFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiI0UFU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 16:05:20 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016B1D88FE
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309060; bh=BLZeCXyChXNLvsEhq+ieZUvZz8UBoB/dSDB8Yp5+zMo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tNSLxoVXeKKEJZNPEt8vk7iIuKP6VPSEks62xJ9lfY2RxIZjXymBEXLt5qNmFV3Cv8jBjft+ASySrE0UD839AfNDz4k0+vwfFe/Cm1Zi3IlHrFOePnCrvTlOnosscVv66pBqBmB9HCEtUT7ID50FHDv9IsY+0JebwLGiKJcS/cIn6IfRPq+iZG1SQro+ercYQuf3KIxar4xHm0pdCSc13G/JpFh1G/c3RiYRJZjJ4BRLQ56Cv7zF/CUCiv1/upqLz3gH2ztwK/igC0s/uMycUl+6ENugurcRYaBQEqHEoYmAC9YjeyGXxrH+HkFQEdUp+HlGs9OGdpbBW0M4Tb6Vlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309060; bh=FBq0vBJ5sabnrCp02ar0BfXeQiQvBgu52esBZAUKP5f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jVFUJT51yEnapg81fleM4C72klwAgxvxf+jrEGBAEJypvtw+gqK44shI86YI4CwLdC8lmFChXNYab3Q+zbSlfLJmri1aAgLK96WPBcNKwZTXH2NuSF11ermOh2JOGYHv7w1RjOpX1KcRDZS0VRBGpM6Yl/nWY8X4uwe8nioohzOJAsBUZq6oi7t+ufMstA6iQHiLoDe8xlis/3vYNH15NhlqfUsOw5rDU3kDXkxBnD2R8UDMY2tvB6If5q+WUMsD6c6pEYmPyJHhTSiZInOD0b3un2Mhb5uVc9nMohwq008Q8iX4hcP59Mk2AVAxGr0GDDLX9+MOTIcRTPNdHEfAQg==
X-YMail-OSG: hoOxSOsVM1mr5DcZRE9vQ3_JDLHQERhsvm.5gCS63qYNDBnOu_MAHh6WKY55pXg
 0BDiKC2OO4coG7cfbmec8TrRMuEEljvrE_wwjt_BjGKzTQ1e5_Y0JBhXAjwpx6mNsmGTSDcEzQ4w
 phlFlYqtCNLfHB7r8rz_AGfdAOBfpKhUQmugFQQkPPuYPVhH4SGtUB1xtPJTewtRyBcA2BPPJMJ8
 ZtXaCYKu7XQi6wzXAS.DRSBd4bow0GJPEEzVzX3x0_CLLo5VhO0RF7Kfq9_qo_eKi0ERb7TJW9zp
 H9Iv1IsEecvuXizbijqOD2mfWp.ZYumBK5WYaLnv06Kf44237QyOjLcLl76k07fD1356nU7_4sBB
 NKK19xnCaI2F5NknnhyuY8.44J5ZMxdWrOXlJKb7r4Vkgrka1R5yOJiPekO3ghDD4fXZxQRIjmnk
 oOx9Ct4y2b8sRk.7rhVEtIeaBOICxXvCWBDK_Eu7f2eeHtCrgXFgGjTlX8HUDSMNZb.5ZLOU1Wym
 Xt7NQ_B8JwKCGX0LV27gMxOIkZlU1vwEuf3I68V77iaVWjGmNC.BTQVtXuWiHfStKpOF9AWxlazH
 sHyulMzJsgRZvtmlAxk9OQViH2f.NWrXNW97RnA3fyHyGchF4so6zOMKkoI0uOKlcUFtu0wPKDRt
 V2uZ7CcbRH1P2XiX5_QAhQ5d2mFtoKPEodzTf0AaxQ5LI.UcI2l_qredI9llHte3HkHaE.nyKdh8
 Z_FwiFq38wPeM7gy_wOCNy8WaLzmAQsaMMQ6v0hiiEN06ufjT5oO3quzZ3w5.uaoPbak80Vpy538
 zYAsS5GOvdOGArPI94Wy1qlTpMvRb2zRH6hHBNSX3yRKb5WvS4Tsy0dDWclcgaDajBq7XBfJJT2w
 aLfD.MX_8p008n_2I70i7UIdR0C4GrPUB4um471hzk.mGunVverguux.5HtllPEyW0DpXTkxusT.
 rUD175PcvVqON0_VXTVNpgH4cpK3EG_wOt2q0ShZLb5464AemGdPa5MVqFUznD5YB2OeHhnSYBmT
 o.gv_lQfWMZac9OIRPYN6cyDlXfjluxwvpNiWB6T.0XjI6lPVcAq5z7RXQHBy.aLbVebsQYWJNqj
 YPJYhHe.u4hWn3mm3De2.6dohfcrTDMDoKFE.SwHqT11XOVWJIVQr3qZ..Np6EbJNRjcYTzS7F3S
 JVo1WyDthkWHBf6mors8XXxnjp._JTX4KimvkX0ri8O9IFh7Wdz1jHV7VG07CUYNPaA1XU4IeAoa
 dzHAi7bg5ijVZMSQRDh9Oqjhxr73yx_rWynlAnPEqSwUtPm_eb2Tk7GUaKFQbziy4taAnKHZUhiO
 3fqA2wlTeWK_wZ_tT55trHW6KzPwxAE9D1GAk5qm8d3wXHZNG_9NBtwMillv38UUL5T3jUvihLhD
 NEGQzGbugXe7d9iMtS6AP.0NpIk0.U2P..JwdesBtsNSWGcPqWnT_B0JQM20lDCqEnenjNPS.JGp
 lmDkCdpkT923q9ypb9HCLUXPlho.NC0MqnwTkkRM0ulNJ9MsZ.wQRQu__GNX93RzgIZLr8AHM5Fg
 p_MJQetGYv1YRltOhxcVf.2kJjQ2KcfYa8RBTG2R1EgVsmA_w93pIDQ2WWAtefGErWbcApQK6mhU
 ok_w0J9WmZ_t1zGPGnWr7WQ8XUgmutbJ6Z5jzVjMLD5lvm2bb4YqpIdtOjP7gZd2oDY_ubjBqxnA
 heof9jBqQXkxjlLK3Hu_4IYCMQ35a26cLUijcU8tjbDIYhVSzA.Wf4grTR6Im0.Ff3XHRRrTMjXy
 wJJaqgllptEnEbaG.HHVlrTJ5ffz3Jra_hfxShf_azhCNhGHkDWy2i52jsSNVHboWJhyl6tZK_Mr
 pwCVbwgHewwohfV6IPkKf74kcXLRu.8iJArazTI3kd.HidoHP6pwUtArMfdCcKJM1.Tzm0gXEnM7
 A3IE5POjJd.EPlLPWbBZLpVx1a3taxznW0faGpXCwFjAyzikvp7Z57SrOzG4NQ_EaamwvbY_ZyKD
 OOPQDr.Jse0sNf43hXy6fWCXKmMX9hdaDTs5yn0itOslp5RX4hLcz_pDDN2VjtwNRcmJx_1I7.U3
 .qo6kn7JbVXPZQg0241.2wg9dcHA9gi5oKoyDrIGgqB2P_J8hQwUQK8TFbqmVlRKjqJsq0Eg0lJX
 c6H1d45VbE_iySEYm5ey4Z4YYN8NtidyeJ6yVVXqbdPbrWHpUlz7BQndIbkzLcen.5gvlTu7S60V
 O.Um56p9L0HHM
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:04:20 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 59c24ac7dff90509b43b845d0fe4485e;
          Tue, 27 Sep 2022 20:04:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v38 18/39] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 27 Sep 2022 12:54:00 -0700
Message-Id: <20220927195421.14713-19-casey@schaufler-ca.com>
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
index 142ecbf4dfc9..ca5dcaee7c23 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -494,7 +494,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1041,9 +1041,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
@@ -2059,8 +2060,8 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
 int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			 int lsmslot);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmslot);
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmslot);
 void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
@@ -2071,7 +2072,7 @@ static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return 0;
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
 					void *lsmrule, int lsmslot)
 {
 	return 0;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b2879bdf45d8..ad5f33af3b50 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2281,13 +2281,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 2e1aadd36482..e8693939447b 100644
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
index 8bfece0911aa..563452000729 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1579,9 +1579,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
@@ -2827,15 +2834,15 @@ void ima_filter_rule_free(void *lsmrule, int lsmslot)
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
2.37.3

