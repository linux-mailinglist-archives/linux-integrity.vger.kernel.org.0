Return-Path: <linux-integrity+bounces-3510-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A46974273
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41071F2751C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8781A4F36;
	Tue, 10 Sep 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qy+c/LwY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8A1A4F2E
	for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993894; cv=none; b=R59GDYkbfCle5Irfxzyr/HfD0mhw953n+yFRlwa4313E+1C9k7AkbawrxtdaJIK96nHygrOWcNAzUdema9rHTqXdK1Q6UC3K/UdJSi5o0r2n09UsmCjzgqcEE68Bw2gyMhgAFEj4sWwyPy9U/4Ulk6JBKU/4I2/H8Pzt3nqfv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993894; c=relaxed/simple;
	bh=S46SS+R0nyCLxubgW8sJKqFsdTdpBILZWRQpPxgNBv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNCsITd+fTIFBA0hN+AfU+IWQITyNHL7eHs07s41kUVTLR/s0ar5eOKIPirSec0bBG7cY1briY6x/WB2ajJCsIf84aBwy3JkM4lNt0vHrOOYlZNma+en5OiGDz0IQ5enIWEaaVuvz2F+dMU5a0QY+PHFQtbXU83W6vzZ+jDbTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Qy+c/LwY; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993891; bh=YqNuSh7G2a8CxdUWt/MHjs+OoDWEq+Ghbbp+RwiCg94=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Qy+c/LwY9CIPqKiY7PkOwV/CXbVu+95yCz+QeShHdYBx1E6PhHw1niU782R4mOd0AWtqy3lI3EQZR1lUUlr8WjExYJv9gZE57YyWBCQtBzd5SOqFaeYkyVDBDqzI64tJGo7tmG47M4yeZkKaJFn03JrazIlAd+dryOqIvaAMayS0TQSxUx9a61Ddcj+dYl1UQ2AD9uE3hkT01b5VbUyrZZM+6gtuNHxRyL3ij5SrpS42DPABVZJ6cJkux/1MX5yuOeLTQ/jzFPW38il/XAUEnCIhqAINgkMO7mqLsDq/ojLqDqCYny5ka17WppWJINDGO+I3ADhJzpqHe2dw6qKtPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993891; bh=lklpdxNugB6jvdpRPRkah82wsa+46Km5W3J5Z7T5hUb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZW6oXiMqfM5dXtVJdRMWuI8RJv7pwlbGfb1PP2Zk57PlHWvZmiuuULEghCdcFNKB0UTl/j4gO/Fw9iWTAuZOk5YFYdcg2UkbLQapGDYAet+B5HiFjz+vrLQVQb6yBPJOFDpuMHQ3h4QmHD4aLUR6SP/EB4Ve5GKc5AeRLtbgwBGUtpieo4DFMGvpNmJEUZzCVzEFgPkdN435vHI33Kmi8FTQ1cmE8FFBlF7I3fSCUcUT8hIFbyDJtbtFI68YDQPYUo0xOZCPmfa6sI9fBLJ53/cv98+kkSXeSp0T2llKAa1cxctcPWzYljbEALpt+2XmvkhTbABwbKq3+uvGZo9cnA==
X-YMail-OSG: mrnCfe8VM1ndptQyUo7.dfho88kwHtQwSlRUf2mzaexdVs0xwHr6Gch.2gp8nW1
 QhSmh8TG5uZHEx1Xm3DEw76T..qom2xBy6snqkiRf0jWP_z9b0Lavdd_8X1l.CPwJWivDKAk827j
 EuVaHVIsjJr.bl5Qh.WCpiXGPwbq.7o98zPFsUaUek8i_4UW103XwGuPqDXmQIqDmD_ynepQ3nE.
 ZmCUl.XFOPpmKL6jk_AtO9z5pjbAqche1GjiZgzzKIs74NCIHmO25.KimzVG28RJFB.a4gATKsrc
 FIn4puOjby7j5YUEQrl0XbBb55lKRrlppIRws.bG2qnpLM1vycp91aqIhRHH2Ac9g602p2z5W2xs
 V85W32vaf4pRqzxq0efqs3HtTVH4o5Z10uvm3Yc3qCwSBS7Jd2hoH9CTmLKpxAeB1ZPy2WI57hP4
 Pm3bOdHdk48Wsm2gZx5495CNbzq_kDdYUyWmmADnY2mTWOU7qbBCFAQDa5Sueh8xpgUBSYTBIPFo
 A41CEg5CyqNpaDwcL4XzmQLic7CTedCTWmbmQZ3s4Cwm.LxLxPV27V7Ih3h8rARBH2FIWnvc5032
 6RFjQCLo42ftCVWErkwz0.SMsAjfhS2G_Pj_S5y6X6zalQROtDL0q2.Ri.dUFttie7jX.rwdUe14
 yWNg_1VustoP3hBQPySJbjEypsEqVMZQj7xVM_8iRUliAjQweThgoB2IiQsSR2b_E1bcjcgQ5Ahy
 P9W1xgtx8zOK4Sf6dGU2VumcECGQayRMYnsG2BVRK4XXDnRtPrlu0GPcizqqcBR2fe6Onz9qKlKk
 IFfCUO2mtVAFdHvEYn99mCuGHd9N1aiNCkJ5nr1z_e0w7R4VsmMgy43kcugDalqu8jr7u.F9qz5e
 T0D7Q2R5ApUTDADALnai4AL66.rZ0B_fXCrK2RXnnmyMltiQSPVx1.G3NlvCj8Gb7WM8Ja99TM1E
 S6z6vrxdfxCNj.OjzQki69mNecu0DTaVcHAp1d3pysHlN8CKr6TPXa99grkvSrVu2y.9wjF1PzDJ
 8F2guyQm54.pbAYXKmho_m9jV45O.0xNFAbXLym9Ix8ow8vaEsjSQYdE53373D1iWwL1pKe4zojR
 uXBaQRKAPbTIbdNSU4RsW.AuoatmF7wVI4FRG_ro2isCPpsIh_xZVG3u7okr8O4PY9f8Q15TzyLV
 a4kTIpkVhKrdS9Vg9YyOLTSIKUPlvx1Sw5i3Dh9tActKVMMUzrCmgnyFTWwsuwAslAHpAVNBnKPq
 WI1x1LFj3tAVJy73zNRDiyWCXnYz_d5P7g4b1MrnmTa.ORSxKKO9w5GNo6SlpkHTsDpNZ6Ax78c4
 sThbaA.Q4GCKHQLBOfVKLGcZtpzzZfX22aEiBDe7B.MYhwBU_Ocdj8PbPcyaP_m83wjemWHAW0Y5
 Sx4ZIjaXh7hyF043iEbCZ2ooesf3v9ucQtUvzinukuOgQetFCGKf_EDhOnHGoP47MRJDjG7W33tR
 Nap9OSriOCoLRgT25DYddz1KEIGRm_p4oVWkY9XKm5k0qoJ2hDtYFxa.9MqaB..yRzseqFWzKCgn
 W5QattrtOAK42OyfaSdsiX.MMyvjyiBgQdXZg1togYPhOjQ6g8l1GflGioC1pis81qzNEIGiK_Pl
 r_Unklat8xbVFKz5cSftV64XiwjdKr8oaEYJVe57E_uNWNdZXOcN1hUNZ0AwG2ueEqFBA.rXFe8T
 S9ozp2xXfC2GmsjLE1DocFNmcFLuZFyvaaPv0rNoBYInKbe.91ZotWCR6zEBgtT8fK6tubRWBBad
 3vkzWAmdW6.DBxra6MJ7WAgffH7WVdL4xNPZgWotaXBLM3JaKImJSTj8XlEiIFuuwEeszxPMEp8W
 OPzFep20QSoG7byD3q1voNPe1DhLZyBqX38DluqrQNjyPTucQBhvPmvG.eThp.fFjNht7kTzZx4S
 QVAJoafXwEGtl9TMVz5YOpt..0xaLdfWzOdRs4IHGy5ayPpe8D.C30y4JSOeUhyMoyK9ud_kjvjn
 cigInEJhTxzfXp6_lul1hnDcshPEivtpvzPDI1BlmLw0qkwaFc9cNUHqLv9ZPPaH_rsGyaYX9Jn.
 zDcwUZoCYQMGm8iwyTghlJLOyzJwV6TS.u1fgjraOWp1OgvgD6w1WxswQiJOGNt.iiLA_XQk1VJk
 21b3.CgkU8maoUqmvD_q8JtmfBGt6o18QuMMqcEl_kHk4s_ksiljBwzIjv5x0nqaKDukc3p6VCfl
 blcr0GT2x3hR_Ly6mCwvWs3w8lIDvBbiI9VtYBXkKruDU6KGJepPQ5ghMy8cYagg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a3b68d7a-0e10-4468-9641-d8e70b3343dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:44:51 +0000
Received: by hermes--production-gq1-5d95dc458-s958r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52d00b93a233ef9d46e84b01a7384b7d;
          Tue, 10 Sep 2024 18:44:47 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 08/13] LSM: Use lsm_prop in security_inode_getsecid
Date: Tue, 10 Sep 2024 11:41:20 -0700
Message-ID: <20240910184125.224651-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_inode_getsecid() interface to fill in a
lsm_prop structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit. Change the name to security_inode_getlsmprop().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: selinux@vger.kernel.org
---
 include/linux/lsm_hook_defs.h       |  3 ++-
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  3 +--
 security/security.c                 | 11 +++++------
 security/selinux/hooks.c            | 15 +++++++++------
 security/smack/smack_lsm.c          | 12 +++++++-----
 7 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e53d29c3ca1c..75131153f89e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -175,7 +175,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
-LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
+	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
 	 const char *name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 07c0e635f124..6c50dfd70e81 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -440,7 +440,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1056,9 +1056,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getlsmprop(struct inode *inode,
+					     struct lsm_prop *prop)
 {
-	*secid = 0;
+	lsmprop_init(prop);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b976b88c19c3..8302c8f44cd4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2276,13 +2276,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsm_prop prop;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getlsmprop(inode, &prop);
+	/* scaffolding */
+	name->osid = prop.scaffold.secid;
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a96dc3ff6aa0..dbfd554b4624 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -649,8 +649,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			/* scaffolding */
-			security_inode_getsecid(inode, &prop.scaffold.secid);
+			security_inode_getlsmprop(inode, &prop);
 			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 1e603e055c9f..2365626a3365 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,16 +2622,15 @@ int security_inode_listsecurity(struct inode *inode,
 EXPORT_SYMBOL(security_inode_listsecurity);
 
 /**
- * security_inode_getsecid() - Get an inode's secid
+ * security_inode_getlsmprop() - Get an inode's LSM data
  * @inode: inode
- * @secid: secid to return
+ * @prop: lsm specific information to return
  *
- * Get the secid associated with the node.  In case of failure, @secid will be
- * set to zero.
+ * Get the lsm specific information associated with the node.
  */
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	call_void_hook(inode_getlsmprop, inode, prop);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ebab856c8748..1db4ecfea764 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3505,15 +3505,18 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
+static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+
+	prop->selinux.secid = isec->sid;
+	/* scaffolding */
+	prop->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	u32 sid;
+	struct lsm_prop prop;
 	struct task_security_struct *tsec;
 	struct cred *new_creds = *new;
 
@@ -3525,8 +3528,8 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	selinux_inode_getlsmprop(d_inode(src), &prop);
+	tsec->create_sid = prop.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -7211,7 +7214,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmprop, selinux_inode_getlsmprop),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 	LSM_HOOK_INIT(path_notify, selinux_path_notify),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03d0ac37b210..8c362fe2871c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1649,15 +1649,17 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
 }
 
 /**
- * smack_inode_getsecid - Extract inode's security id
+ * smack_inode_getlsmprop - Extract inode's security id
  * @inode: inode to extract the info from
- * @secid: where result will be saved
+ * @prop: where result will be saved
  */
-static void smack_inode_getsecid(struct inode *inode, u32 *secid)
+static void smack_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*secid = skp->smk_secid;
+	prop->smack.skp = skp;
+	/* scaffolding */
+	prop->scaffold.secid = skp->smk_secid;
 }
 
 /*
@@ -5127,7 +5129,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmprop, smack_inode_getlsmprop),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
-- 
2.46.0


