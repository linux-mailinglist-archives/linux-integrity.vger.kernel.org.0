Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F67253319
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHZPMe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 11:12:34 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:41999
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgHZPMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454752; bh=g1FSIQWmgAC6SJgHjAw+GjFg2rk2VUWHVyDhQo3lklA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PHCGT69jnovL3o5jMuLP3DR5Kr9J4qNQMBWLeCCVWplMDsB6qXjjOa1MsYE8oszumClHMQ9NNTLZpyALZcce3zpeGEXG/8gV5cNmliI7kOkS7vGi38qTvWU1qE9RA0inG0zYVwY3VPoXf/oKiPzw+IFhM8GcF93ZtjVrgOkLKyEIYpt/AgdNG5bXbqHCe/hu6pCVIZFpQkRXsvm8HQ8PSFn3FWyHMhDL2oyzarshtqMdOjTbJcOVbQ/OdHP+I7bE5FYmZA/TMKIMlRiQQvmXVvUDN8ReVv9IIhsWHO6cXrcH8V710Cy4Ax87Qmyx7Eetkv9FssxvB8cu1xkonwtOig==
X-YMail-OSG: 7AEefBUVM1nNzFROwBmh534f5WGfZ7VURsNbhAKIhIRPeN1.qYKo_y_ifj09wcv
 6rSVZEVzMfm_b4Uwufas0coqN2vKOwCoTFQ110GToHNrilbtyOku93UEzMu.HAliHyUIZXaLKH7A
 TeLQX8.lfFbgeeekpRr2mzBL_RhW_Hum7y8vgh3mqwxODIi7SsyIi_Bvj1FTFHVmYW2ODOXf1iMH
 kx_W8_M.GWiGL3FvUBqI3WE2QyHwXv3BrC4Gyu16M.uceI0_cQai5PdW.E3SwOm8Ha1saaMZxHC_
 UV8GgHq0rjh5A0rIw2e_RMlaZM9jv5xYcguHOeH07KvBsmBfH3KNGzkmVKnqktgVst.HugUa7EQD
 u07yb6paMQ3HvlNaNsUOlceJViM0E6vMY_QGnf064S1Yn2MO8WiP0zwhw9e2Poc5RJ4jOvMeIyFf
 mqUcGDFEa.S.uBviT8rjC6V1VmLBiI_u3cLBQD9z1NKuWJTk0duShChFXe3WHkg0VYH90HQMf3md
 MYPXcEY6vIv2wUO7ZxUIaYOoAO0TlEh7o6LkudS8YEaY4UbrcE2hGNCCPfQ6Mo9kwyr0sS5wRE8P
 Mx6wFyi9_Of5fNi15rGq1x4RAMrv2j12BPCvWBAoUgD6UQvJiMY8vLCmaZezaifWYqYrReMRwRvz
 gPcJr_jH28j2tm4CK5AxpU4Pl8BRZ.pUtSukV17heQJxBOZNkU__nruspGtpGh2D3.BOrLHtTk_G
 KWQKWjUEXRQZMLqEk0EqcgGkJ4wkvM.nqlsp6ZNmKgZnIhct_nXQqXiUKKH4xT0rOw59lCr4x2qB
 QgWZZHqQZZG6ZhL4x6lSxSZmzUO7IB_olN1FaZGXD1.Nm9319Xt9GY4vGEFphKVNXcu4X0G78Aw8
 cMrEgtskYdLHCoEDiyiEYxxNTm_2mxb2H4fo1XTLQRu6EKWE0udoDZBWeK.bDNZ62eWeBZaKvKoa
 YhdMI7j6ik5eNWdzSPPJHzCmoU7MId79hxZ_5GHjDw1Xs0AZ5NVArCLrDhAIurKbL9fFM7JwtwUZ
 Qm.SCZL43SkzrmfTPwZEuvXvdcK2Pnw2Wz12wzHz3QYZcjQaEgxMLT3NQ0Zl0DerPthfehY9geT3
 31g._viTMRuWAs3vCOp..G0aBUP9nH.YRTpE_OMwQNQWOAcPXsMx5M8AZc1C8Zcbj.JKB8m2LBDL
 PamALnqLqbsaAplqALKL60b_t2AYqBtGZ_SnKN1FdKmS4YRUq8xL11Vsym4PBZYiknpltjDLzYzJ
 JLzEq4yndIkphOf74y5wAV9NszgLSC2h99Hl72ONgv.8EJ71uWaNjiRm1R8VresToGOeDG98nptQ
 446s03Jw6nNJXzqV0VMdmNONhBMI02TRcMs4HrODBHiJzOAf_ctsN3sNnl6l0lSI6oDtRmbmdVNu
 fjxvQqjdEDbnvCeqTBsD2v08kYgLpsL2sA.0FoCZe1FdkjNNMp6I2QgGXBiZFbM1NLiC4KWDhbwE
 xrwpAlxKslLNIj50vbYBiIWKYY03OiaecI585lykPB0yI8YLqsb7wJboDLEdXNjBXOelCZh805XR
 IQVechscVLuushbPzDJZRY7JKiRY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:12:32 +0000
Received: by smtp401.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a682a390c8ee6408bfcba5f880da76f2;
          Wed, 26 Aug 2020 15:12:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v20 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 26 Aug 2020 07:52:34 -0700
Message-Id: <20200826145247.10029-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 56702d17c0c0..63d0c9a6cb42 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,7 +435,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -958,9 +958,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 8916a13406c3..b58b0048702a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1980,13 +1980,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 3b30105113df..a86b35dad4fa 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -499,7 +499,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
@@ -512,8 +511,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&lsmdata, osid);
+			security_inode_getsecid(inode, &lsmdata);
 			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
diff --git a/security/security.c b/security/security.c
index 01c1561901fa..d641c6dc5933 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1442,9 +1442,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.24.1

