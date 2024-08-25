Return-Path: <linux-integrity+bounces-3378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB695E4D0
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67637B21241
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E41714A9;
	Sun, 25 Aug 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bayzxP58"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E516F288
	for <linux-integrity@vger.kernel.org>; Sun, 25 Aug 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612659; cv=none; b=lPEmGGOJGNuZsfuMKjDhVUzp+Doo+g//tYPyCOEW7gFIiAMY/3sY5A1sdUOtHDPRf0Hy0oZHKQ/FmJwxVHCueFF5JCfI+kTzruCHlAcenHFcxq+0AP/OO5O1wAWrU2y6FmyMJO0lBEnGG15tL0jDcSzxGGo/WJNCwiqPwSFzxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612659; c=relaxed/simple;
	bh=wnMZ2uXte2hSLvEuyMBox5FYzBbs6pDZLwXgaeXtRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp9iquEC5Ut/VVsda5D1gQRjfejqamCs/ZKWnAqlICSgvsv+R8zDcCn4CPM+n/5mJEjaEgGTAPswjarlybNXv7t161ki7Nmsg2VjgmJtOs/nJlCChmFjB4aInzRTar71EHyRZxPU7rISxUesxsGSPSApHGB5b/mL1JcullmG3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bayzxP58; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612656; bh=2USlz2FWG0U2xJWlqZrVgsxa/b1xvrzPhqgbJ/XMA78=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bayzxP58N3lpGvSpAWbwuK62HbY4zjUcTFUJ9V1blzDv1+C4PAc3hXrMpEXunNvIL/j7fLnfG2/O7/h7KV9c2U9iqcULLBeBd4CHy/Y0NoA5fGeB83W8IaEoT27gNFZmNRr48+f9KuGm3U2V4fxaQ7V6czSDIE4S+8LY/9U4JPnrd8ZZ8ary7C12jjCNNfdzPV/V9yZv+c2LEz/PUeufMY/4JIdImi7m4CIw/wtbPuNzOKX3WMBMLHybHSOiAIxb7dmh/j57G30EAZiZQjfRD5jNiLew4kpjDA12iaq84oGMU8QkeJyzwd13Sx72hEL8ePA4nVZQkyf1wOADE8ACLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612656; bh=baB1Dbk+Ak3giwjt3iETu00RPUxmr8UxwUD8JXk3YNg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f1BHyx/CXASES6kIR/kCkq1MyNMzwUFVKPdXLNEtVh68L43shVOkus/7+Zhk+Xkd5N/j+E3pwj1It6VdeKg8X/FN87k+Ub1tDU+32fHm0CKBEsMpHioT29P2r30+d80yGrNa3hOkdiwsXOe/NtTi12BKMaNUbOsToldoFO+p1dq85qqw4WeqT3cpq3s7J1VzX+a8ifOwmtftXNIea555Ke91Zn2mLJ5owL+zQNg7tEEPZH4/AFPudR9ik/WUWYoVqnAgoe1fjEKTJIf8Il8SAGwiNp3+4uyIYhGW6M9ScZ0WMe49a0pcP+poinGRh/DAf1uZd2eI4V1hW9Dc30qIfQ==
X-YMail-OSG: 1VsDCjYVM1kBhZ0hUJvKOKULwSXvHcbvh3g.GxTHcfMdKcfIsgl.SgELEHQBMeA
 0qIlo3OkN6viVdyw9i9LogFirUp5bofuI_kYjdZ3QEz8hBbSjX425WMhZU.ZzAU2VuzfuGM5b7OL
 xHwiJ9OC899uxzcj49ZQF7xXfRDQiiv9Z7z1ar9GYGM1ETpIei7b0jqx457TIK9McYDdjYYqxezz
 xPeAa.6y0VORBJHq7fGRjeqSA6sNWWo8tdMYaHbJDYE5D406.ugfgh6Njxt6gq6Zh2B7CaZXHMK4
 VU_iHMa04GEBs4Pobt6OzZNqVCBMMD7F.SXTziZE31Ad60V68NPmpY4lPpCHkvpbM57chkBwD7E8
 3B08eq8dW.FNJjGKt8zQMUbhMgWFsRX2KoSC9izwzOG3N44n6aSW397EE13qG8a4iudYXIp6cOWM
 Z2jJRLOyqOlLbLJrJL98HPRFsSmlY9mtZKQs7Kd0VAPkWcJs6RYSFDce6V4UiAm4H2aY08qEptLv
 6exyoselGuoOmHKJefs7MYkRw.zNYGKutq66w1Tc7hitq6N9AdmhmvEw26dA8_EzyTNMUhB8cKpk
 lkT2iC9JNq44acNUCBqKDma7Q3zr_ZYx7DFE9t.owsVCJfgJuJOaQrBJR8pJwLTfd2CpEvC_6k1R
 piLY94Bb6V2m3x.CmknFb7H9L.sYRRbdOg0gXBykH2VEfmZQG2JNQkZcpAQHmV_I1zp8rpNqtvq9
 pP87u9HJiXyqWytnRJQvBHKz0n4kG9IcqLUTsKj7JbtOiKX0atdux3v5jKyG7mrU1hrOSNIVyULu
 NKq5U8lLJNO8M9C6lYqCMXqzWS6wa6JN5cPWiy43eKiNgVMaolZ19L7jZHbcE1_khw6o6TgtBQsm
 9vxvZzeu6q0RkYDkWW2t4OgMmYZdyObJLoGTQgqhC.br3dsDDLeo1wPR8PZG_pDjuKrSl4f6Xymh
 vxkiBnmcxo5q2rBI2VZJt2Oq6IUE1xaKo3pJytoc5ozPO0meI8Bd02xMSur5qiLdO31rF0qtmq.m
 TJcQCfKROWiKbORpg1Bqh9wEkAs5CuBUACcTkd2rqWoWd8dk9xsph.G4diUINmL7OXuiYrVvkKDb
 35osn3mngp.wiSVnOPirnXqi7B6a_sCRV2g7Xdet._6ZwtTD6MXe2rRZk.cj1R0HqceqwqMke30R
 4rTz_P4.0yBHYBE_yR6qeELNhwa7Vt_Q3sapz56ZSNXfwq.IVz7a0a6bBLw377gUQv1xnl_iYkcL
 MrZu_UUcxc24kxHObvYqNSMRJn7nbsab5g.NtYKn0XEjO7NGZkCYS40S71L2qaGuQ9rqVGSh0g_V
 jhTyio5ZwLpfRI.sW1C.d7HgSrq4Z7s6zIqHAbKd5pEB09P08ykOGpg8yu9bwTzVCEi7TLWeBQOE
 rII.ORyynxR0MceX.DTi3uUm3xLVT6k6HKckwg3fRT4.TXe6UWQnugPtQf62b6jb9U2mz1NVujv2
 ADUVTYXqqXnxMvCXhD2KR3iibivDwVTtR1sAUnprht6HMo6s7v1NX6Ig96iTLEYiDbrYL0lNJEfr
 I_hdIrHmcM0rSt3kUMiwUwOGfLck2Ka_wxXmsSCfgGxQGEQ_MLiFZqXJflzYJRr3GcRsA_9H3tyL
 PgQZO1i8QM9EGAcwCZ6Y7c66mE8_2FFre.hPy1a3H87DgmsS8L19sv.ZULUu8_E14e1jEB0T2lnj
 eNGlqBmS0Jxa68UaFy3e35zLChfukls2EZEB82JP8rZd0iCjgRH1WZlCZSETao1zsYatz7J_bzio
 ybhfx0EztAkX7DEG9etGsNKT.bQcSClc8HYO1lo37uQ8c.0wtewmSs53b9vC7uUlnNBJjEcvDpXc
 gjo_Wp7VEVlPV5svWJ8yC.12A4EF1DVqve.KNEyLNFWsNZhEjw_GqZWdWYB1WMz3_IAI3hGU962X
 d7dYPK_XG9CJfA5V69kO10YePmXs.Bq87voZOMNVVcHrmKFgI.kqhjarymjnWypDm9AkPTZ5TC3f
 JMS9twOJ5.baeHsTxIaGCGo1R27UEK0q9eMrLcFopIdXl6NzGgdzvDRA4H5hg6v6J.JkA.1R0qR_
 MMHopdlKjjoitRxJOybiJGksP9TOAgSNDE_j_Tn31b5HxdwJOZg01TQtVqSk810Oe3d78d.8YEo7
 nfExyB639CgbtXmSw53N8Ic7.tmPLpVcl.aS_.9i_qHsGVtCcs6fIhZ2livp4Dkjj4kT_5q_puVN
 vBh3wJa9bzM17IjtkmmaVjJf_B8C9YOuniIRalOo6dfHYjk.Q2x7zmeMMka0CSVtQ4jGIANMVTzi
 PJjqmrGUGAydND0240yolV.x8rusBq0UwFg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 134254bf-3544-40b7-ad49-d0715c3dd6d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:04:16 +0000
Received: by hermes--production-gq1-5d95dc458-dxlpk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID acda3a00d6062e816b69b20719962769;
          Sun, 25 Aug 2024 19:04:11 +0000 (UTC)
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
	mic@digikod.net,
	linux-integrity@vger.kernel.org
Subject: [PATCH 08/13] LSM: Use lsmblob in security_inode_getsecid
Date: Sun, 25 Aug 2024 12:00:43 -0700
Message-ID: <20240825190048.13289-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825190048.13289-1-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit. Change the name to security_inode_getlsmblob().

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
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
index 06c60f1aefa7..4fd508841a6e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -175,7 +175,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
-LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, inode_getlsmblob, struct inode *inode,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
 	 const char *name)
diff --git a/include/linux/security.h b/include/linux/security.h
index b28f2f7fe4ef..4fe6f64cc3b4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -440,7 +440,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getlsmblob(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1046,9 +1046,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getlsmblob(struct inode *inode,
+					     struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1f05445978f9..eb1c64a2af31 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2276,13 +2276,17 @@ static void audit_copy_inode(struct audit_names *name,
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
+	security_inode_getlsmblob(inode, &blob);
+	/* scaffolding */
+	name->osid = blob.scaffold.secid;
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 33bdbd031673..35a8d3435507 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -649,8 +649,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			/* scaffolding */
-			security_inode_getsecid(inode, &blob.scaffold.secid);
+			security_inode_getlsmblob(inode, &blob);
 			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index b6e28e20ac51..c2be9798c012 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,16 +2622,15 @@ int security_inode_listsecurity(struct inode *inode,
 EXPORT_SYMBOL(security_inode_listsecurity);
 
 /**
- * security_inode_getsecid() - Get an inode's secid
+ * security_inode_getlsmblob() - Get an inode's LSM data
  * @inode: inode
- * @secid: secid to return
+ * @blob: lsm specific information to return
  *
- * Get the secid associated with the node.  In case of failure, @secid will be
- * set to zero.
+ * Get the lsm specific information associated with the node.
  */
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	call_void_hook(inode_getlsmblob, inode, blob);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index af48b8f868b7..f5d09beeef0f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3505,15 +3505,18 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
+static void selinux_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+
+	blob->selinux.secid = isec->sid;
+	/* scaffolding */
+	blob->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	u32 sid;
+	struct lsmblob blob;
 	struct task_security_struct *tsec;
 	struct cred *new_creds = *new;
 
@@ -3525,8 +3528,8 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	selinux_inode_getlsmblob(d_inode(src), &blob);
+	tsec->create_sid = blob.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -7211,7 +7214,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmblob, selinux_inode_getlsmblob),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 	LSM_HOOK_INIT(path_notify, selinux_path_notify),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 86a370ec54f9..8cda7dcf30e1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1649,15 +1649,17 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
 }
 
 /**
- * smack_inode_getsecid - Extract inode's security id
+ * smack_inode_getlsmblob - Extract inode's security id
  * @inode: inode to extract the info from
- * @secid: where result will be saved
+ * @blob: where result will be saved
  */
-static void smack_inode_getsecid(struct inode *inode, u32 *secid)
+static void smack_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /*
@@ -5128,7 +5130,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmblob, smack_inode_getlsmblob),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
-- 
2.41.0


