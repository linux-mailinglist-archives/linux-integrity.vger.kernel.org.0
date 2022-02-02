Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF984A7C53
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 01:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiBCAHf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 19:07:35 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:41778
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234086AbiBCAHe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 19:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846854; bh=Ofx+zfV9kAlt56YC11tGt2YOtlNVLhFarLMraLNfSiA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LeaN/Mwf3Fu/46HOknNArm6a2N1vgKXPyhZfO8tIHzTwJnlaIq/7DRWHBWL42hmCfAkvTZvO4iCBpBBKSYgW5+IcdBbAi7lEmvy0VnpG+qe6UCj48/KhB5shN6Ika2lxREDlWGODQX3aOP5e2JSI13yFOXybR8THsPrKAJY9QuXM5FMlrWFil9nW7VFVKv/z9u2leWUw7ja5apI/CYM65XxtifRkWatjUr4DjOfXZa1rPOLEB7bRKHZ9Pd6ktRQqVwk0BmZsJEFRZs6syuOAo7niPW/xjXK9qhIeFFDoEOX8TlXSF2Y+M5f03XWat+QuSC9nxHpHi5bn3jBcxkuXXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846854; bh=USgY/omKIT6FHftzOwuaWl0W1FAmmueUGibLpKVLU3I=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AfQnVo+duFRtB/eIAFUuaOfhgkT+1cIuJ9ZVfABuRQWm9jhT/VWMMr6lWWSd4TCzHmIeijM59OMr+pAPcwpDF15HiRV74bHPiqsGbdyM6/UBziD4KaTHLKc3pBJM4IMrC1V923cjTQJZuV4zmlsHGCsWCFxVTSidP2PgLBk1VNbCy2/uXp6i21aFkw6b6B4pGygg3ZE3o3NepxPn7FuuM55VWfGdUo0bUc0S95EmzTryuCtfdFlcQZz+c+FGpmWzpAWGVtFRMGlgYmnY+1mJuRimFJX21iwPDkNp3pNOpANDCI0sMT/fNpSNq4jGReaDYvFmRJgpJRGfw6E8k8COCg==
X-YMail-OSG: hyXz7kcVM1kvixrw9v7j9Ra.xOXS4WdN3hT49me5c2dUs5Ojkb9lCBK2feBLNyk
 Fi6iFwTpJRa6b5.I9HtFnfoQNKjRZmPzPtNXGYEqojGdtCf8WgpeEFSVjP7f2PaHMrvc4tmK3Vxo
 0VqLYBTFpl2INboB4eeoRK9cHF_ZH34z0wauLWIOGUcCIN16HCdd3w7LEQ4RrNz8m4VDB9yoYNFI
 .Ljkskt1cDsHHZZPvBmrEHqxZ13xBRW67P0.pAxoeDw_eZTdubP3J8UwMDmMyd0Rlh.vWj8YMQuB
 poXc51JN_6Ui_85VudbtcnS2uruM8ua6vVcKxJiJWXruOT8fqcGn7eQ3q1PgC.WMTH1xKa.e.a9d
 IS0AvoTOxPN_CVv2WwJ8uCl3L_pg1XFcUggLlO_ouLAdK2yt08Hp02nPTkDqdBaLln7EpFspxnoG
 Q7WUk9DnHdIQpeH71bHjLKdmCB_bzi2OrOFjT17uHlXdiY31892xGNv9psbopb5CoQrzcBYDvzDG
 IXLTobLmH2GL1wkaYEOEjwLKvzpIzzlLocIV.804a0YhhNMPR97OdLE0eEqA2JkKyXSVmNp_yelt
 D2o9UQFcZw1tL3P5ZlNBh3htxiJ1vCJB1lNDXuNUQrbvdy.rd_D37wHv8YkbVWCurmwEgU.HQgKS
 wKKsEVwqU2iY90mlEUgn0GRs7c4LLPGsPjCEXcns2NcfOsHZEIpb984uJoDvFrle8Q8n9DnImdh8
 wKrKzHLaQVeIB6qn4v9anzeegez4gzyldbPuoWcGW3oigRY4EO1eusiElg3QP9pxJFqKFoVRWBx5
 SPPclUbH7faiQqEIhEHzVzuq1T7HCmhlaKv8EWE3pn6QHUR9OxSBd_w26_Ee7.kQyxx2PRuk0DKO
 eCWTqrS6e.SHKJkgW.OUwB.VCzUByUBZ8zX8r36IpCFFW2j6aAxk5yPYrGrHQuwiD..FsO320dc7
 NT4_gkwXOiq7KACOyiGWyYZd7AXkwLAD91b9elEtsqjGKEXgmUwP6udv5uqNurz96H.xJh94T7EV
 ipDYLIulRxrfQGvJnUOstek0T4Ka8Y08Y.a4Vfx4GF9TSfhk.OJ24Uhh2jQ9O.VRB.5nROWyNViD
 mqJg8T39RaelwA7ZCa8qtf9NgSd_ui9nmxLbj_QJwlc1cGQBYDT5atjen.neBS5eoRjZPPy3QcQ8
 9IZAKOA6zog1f.alUEQLLDmsrMKmNyAUQ5epc3qiDGoAEYPH.qy8cAzIyv3pkSGCvJdPMqebRm5J
 SF.cCEr10qtGW.frP97d.iP2Bh.fQacXlT0MbX_HHktahimmefLgYNsHOBmXcfkIg94c00SZzHxs
 L4rqKJ5nRQV6qFg6EwmzkCGNYAITQvZuO_T.jPTT2NbFkBze35TN06k0O_JI1vfJCdLepmwJCyOH
 YCt.VvLA9EpGv2etaKM1hoys1S2FXw1itk.W0DavBD8KB61FYbLJq_nrP.JcQ52T7eUpx3qiCuR2
 BQRdWs4pg.MZYEycOBHbrJgRqHW1DDkSJQ_tXnbdSuGsGXviVxTVJaUY7AtuIR6sukylWImcQw06
 6jStfKHQ9bdWU8R_25JPM6Tx49.6n0vInagHq4BjfyCDDxKFxuuWXL0XP3VTsmXMzmyb2xFzPGF7
 YdRAWFcg.cIv6dO3liloQcqTtqfUQZBZnHufw.jZBUfSikRJvlcUz2IwPtwsU4XYnrh_oel0YymZ
 xiZNwPB8D.qyO5WBrXVSDwRRZ7GIuYURdGmRLIQiyCovNFbt89liKCTajVmRL3f2Mx8pK1fybUeg
 Ik0bI9yKR4IctrpXk_VkuDL8.UvVRWX9zsL4rHej1Up9x_CDNJc1XGCHLnir.0Yq94WTga7hXa0U
 DgXB6VF3XGFLEC5EyA6YbZrObwqF0XZsC3r8mQuGlJ4A2JoN0lPo9ErgV2qgbmFZ.pQnx9YLxGu8
 y5t_xqhP8ICZcyXoCdcW6A0WQzkRz.frA3ti9A1la4klIveo5CunmM_2cXfpuL5W2ELc0_lE_VbL
 CoNluaXXCj6JKMtTVaju.jCBDAHuTpAg43X2U1khE3.qYYJf64oQQZwtgNYDBIsVH0bbTU5ywXcS
 ImQbNb4qgoHmv9LvZ9f6Mxo9IjB68fDhy5Y3IGGIjvaFQnXIbZfUaBJ1lqDjStgVn50sS0bQRvoq
 NQbJdmIBuRK9NSqt51ze6LF1JREh0WQYZ7NlAr8p5yyKYGvoJebuCMrzEajocZukmpHHmmeNDPrz
 2.0RDR8XUSxdS7t1G8_rqoEg6HTXDk0jH7CIXLM.Kt5jVDeNvyg3KUANPCXdghqcpAkMPG4iVqrB
 PQw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:07:34 +0000
Received: by kubenode529.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7f82dc84f3bd924cb223e5ab9ecb7cf0;
          Thu, 03 Feb 2022 00:07:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v32 12/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed,  2 Feb 2022 15:53:07 -0800
Message-Id: <20220202235323.23929-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  7 ++++---
 security/security.c                 | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index d7781bda147f..b0d1abd082a8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -455,7 +455,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1001,9 +1001,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2570bf5979e0..6cd15abb99c7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2248,13 +2248,17 @@ static void audit_copy_inode(struct audit_names *name,
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
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 22952efcc0b0..34ecdd7b01f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -625,7 +625,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -637,8 +637,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(lsmdata.secid[rule->which],
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->which);
diff --git a/security/security.c b/security/security.c
index e33fa677181d..0253c925a272 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1553,9 +1553,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
-- 
2.31.1

