Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4D22CFAD
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgGXUns (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 16:43:48 -0400
Received: from sonic317-32.consmr.mail.bf2.yahoo.com ([74.6.129.87]:38644 "EHLO
        sonic317-32.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgGXUns (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 16:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623427; bh=234xaKUPRrEJCTjuYBkCOO3TsjX0WFi6pBUT1DN6P6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LzWVcNALyCHBAgo26GDk5cJKEtUORfX767BTumIZX9DnFUtFTbwwoYHgxfaPoc1kMnuA6859Vh0TQIOyzg9UpY66oCAdbh+baCfwXacHxqGB0lJJ4GK4s49Z0WtBoF8Pn2xdII6rBRgwAh3DNHRRyTTDhGnEBqYYh0M0/qfdEtILN86Iu3YXcwYjP0nPvHsJdiOPiI4l6EyRB0oXLQVa694XKvhRgk+b27W8t6EbMnGbTflDy42VqtCT6MeOHJ4XERB2MEwMLCuhiBDzQH7HQGNaPEjt8vU3Y9SjAXPrpwXCbWFwSKfrT5ODPhEfhNMADQ3jXJMhXaVUyIHQa4xDmA==
X-YMail-OSG: W4rpcPgVM1kGbzBzkfqqG5AfvwocczHrL_p1ZRhxDKby60tmB8_g5jyv09Xn.D_
 Cbw67jx32PcH3ooWn.sqI2oSXeAeA4TKpTV17pjfUiCTCpVcNbKBgX9Gc9t4B3mPAamG7XSgZQB4
 9qBn7oPUswCTgnQGPKuzcfHILkvt9guwUmSaDnj6fvwre4vzpog8sDfqsBi7fdqfudrOWE0U0tKk
 fwQwk7UsU_BKU4X8Gmh38qINwSTpy4FKR6B6GQt10L3S3wOwX77P2y5lAhX1EChDOu3kD_DpdNPM
 32QIv13F7C0FiYymUv4g.DxdJKisT8ObCgguOtaqqdMhfdbb08U9ro1A_741ohg_GfBcpH9B1J83
 Mb1echna_7e_y4tBriIrKH7PhiWjWsQttMKESZLjzMdeLxxnKQrOJDDtnqhM8ArNvCl5QxeR1heR
 DY2m4Q4ohJ_jOFFxlrhHqXhvpPhw1q32IwGtn23bRTcYWIcvY_Q5p6IV4QwDxOhmDUXOKB3pcsnl
 RMkwNn2aqLBMdWgrCQg6DtKSaw6H7xsZPHOlUm0L29w27AjNKMZfCsY5qyTb2DeWw0plSDZZ1Sem
 dmQUoktOxdkISEU37is9pQOggTGQ37y5Y56rAcWQYfMwNzXLjW.QlrJt2yyJN8JrMVZj22wCyzYX
 Br.KYewANRXRYNoU09ZwUtBGfXWARs8RQamTsrtdtLGOBdNKYcezR4MlAPl7sZ9TSW4kWSQBA_Ta
 7g9wA9tJ3O9M2jHdAVTKUKURD4hix.n.sF7PYKPYA_Ereh9NkKDdABVJeOcrIlhTEHiPj.INrMCF
 NXXlOrfBmzWNKye5BUUPt0JDhtCwMYs1QDoVMPUVazipGnahxw3X4EqQKNzIdNeT_jfMTGbRv06.
 K7oalhUFDGq8PKhgNOZWci_UUBRPpZD11Iju9vcoaEhsWu22G0ajEcPrsLv8tvCcRZ8GQ2EFZOh1
 6KqYiSORbQ6hl_olupcOHsMBJ8Fl8bpWCghGPWPrPAovZE4uIAc7vJbK0WAaSbuT6PGapXzcJ8mA
 lb3ZlOF_taXpPh0L_ENrzKGJVVfpIz2Dw.w20WOhao.8Bqj8xBO8CaCBvNm3H1VDI47Nnn8rubTR
 GoLNNywKeiI5mYD4KDJuEBwRo_xJLglZViyHsLGhHbPKR77h0NR1cSGsfIqAs9o784iekDHPlI1W
 cMXxe.lk.ra40NYIT6u3mzovUJLkSvvDgeBFOZ7nQEEOhOE5SVgW4bPzv_R.usIZJREey1tOwN7i
 38ntgVV_F7CeiFyAkB39A8Lylt9h2yBPKSTpA7adl8BDK6egRMksgOGsiun.pYN0_4vFefXXnkmp
 JC4Jy7IZIbLyLGwxMwM1QH73LJxY80T5S6o1WUGX7CSfx3Bp4gBRRunWn9TGEwB8a7_KTVZMZE0z
 _F7ianSZ2L06wek.U07POhRC9yH3kXgmKkf5K
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:43:47 +0000
Received: by smtp421.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2a27315c8f93868f4c41ab74491b0352;
          Fri, 24 Jul 2020 20:43:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v19 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 24 Jul 2020 13:32:13 -0700
Message-Id: <20200724203226.16374-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
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
index 4037391a29b8..b804bf896552 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -434,7 +434,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -957,9 +957,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 4928159d1ce2..d3e1bea08da0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1946,13 +1946,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 9a0f462e8891..8f9c66a0a612 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -479,7 +479,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
@@ -492,8 +491,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&lsmdata, osid);
+			security_inode_getsecid(inode, &lsmdata);
 			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
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

