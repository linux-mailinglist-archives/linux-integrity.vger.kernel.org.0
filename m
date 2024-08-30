Return-Path: <linux-integrity+bounces-3432-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CA965414
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 02:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A1F1F240CC
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539751D1303;
	Fri, 30 Aug 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CyM0juYX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AD4428
	for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2024 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978256; cv=none; b=X3xiQI+15iRBCqFRaYpzOiVzEoR4V4nO/8f0Srl74CBEXzvfZNPngIidiV1Fh8LeTC/G2DbS+qb/Hh/JpHCzIzkQ9354EG9j2KlxHKnQa3Icm1ebfvIEd+BUv6GyTFX0GpoE/GedqTxN6uy/NWP1LX8G7+LcgTXYYoQ/2ko/r04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978256; c=relaxed/simple;
	bh=97NwEi/HLiTvn4HtJu8laGSoEHnPmQULTM6fH20IBnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2xBzLRfpnWzCcJo/Aj8MpacJ6nzheoJ40M5F9HU5cFp3EVvYQo+2FbBxaQuroUG9Ek6ZPlExYfH4v/JyjnLOlvWP0O8PQ5SauNw1VyRsYKTKeMLHzRAwKbTK+pgmm/PWyMi6fpTO3DGgrwQRqdAriMb3d3bdRMXxr09+ZkSA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CyM0juYX; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978253; bh=/mjQGqO0ODaV6PNm1DLRoitVFkvqws60YMTQzri2i30=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CyM0juYXAtctLGqnxq2wrt0GQoHHckVDNNeX4hPIf3cn7M5cV8JZ5Qore1qnWi6YUFyChVPqOpgOPkwB0NWEsRh8BfN+AOrg9Y/a5vpZew4OqVPSSPQ/zaYnF+krrGj90N/0sx3Pk8K9zMCnjQdXQFFMRe+Ch6cTx02JmvMfuHpfTIyQDWQgl5tlTnURbvn3wzu9CZ3PzY4Cv3t+v1pXYghVX79BdLF7iTDuyzqSclkJnrbnl36eliR10j2gx7VvrOeXa4EG3tdWxlBMnQ0PHWFPW9STNM1iXFLFx/Qu+XT9Do6r11HBkhFn/5G+hNwZ8HJEflKuC4CKGOa+6huB6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978253; bh=jBNw2ic06F5C1Kg9IntO5T1gZOc8fHtGVkbcjeUmikL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lo3XfDK58RQlXh0HKMNcMw+17U4jbRuNV6oYeHBuLbwS84zQqjxx9jTIvLXZvibfVhTv3zKzPEyYkRJOAeNUAUihvA8m3dEu9F49hXGamhX7eSmkR0IU9SkBbrNeBKU8qlnCRj77xc9rpy41n1/wS85qMQ4/QIsdKu5cfkINkcXRhKElu1jErd72sz9UvOFHvCQ5MWk5kgA/YAKhIxssGkP2aAKwI3uBEukQelj6ygR70ZOETaUXJDF5uke+YP6wLnJo7WIRG2L6t/LsTBjIpzPib+F5g4rs4upoiZ3UI9wMr78ZZjMC5l5M0gowmT1A/anomVvHRgTfzbSzE9ZO1Q==
X-YMail-OSG: 9gwFqNAVM1nd2E2A31esWDjNyrjZmYbtVeTlRz5aOeqqMWMyZN1pVDA6.ezRgay
 9h8CMGNCaMTDX8SJGtP99qFtWrMvSU8n_s6wbdebIDPdOMneM0QKlYc36IOuA4MUH1uS347BveCL
 12.tUQuk6Tg2ZLA3lIeTvDWll.zwr2pk3boqXXIcR.7iUzmmdGri8SQE_Gxut8xdI9Ug.H.JyLaW
 CI6sGCtZinrAG0obJjU7qy7tfIBKrQOgzeLNCrVNl8NF2SDtunb0R9eyMfSeSzYIB5pnMED3lQWF
 pN6Dyt88UwnxgjZJKiAru4LH85_FxT7rYb9a7xvAqccJ4YPPtsJHUv1rFsmBw3BUGcNJ_tjOViPd
 9PMpgrl4Fhwo3HvSm9J813UshbKwPOgQp2.rfiICaf1jTidmDSeoRWKpFXkwaipy51sX3DA8yLJN
 DbogqYV510uld0P.aLXLXKOuKfcueOaZYe9MPLAZlHJ1JfaZBOV1vyha92rCX.hmJ8YNncqpWI1K
 WJdU7cvs2aZ_xij8sEh59BpGqH2ghbqzyIfCSqOqmDQ51t.7d3kaTmS76bmG8z2sCkQaeyK7Wp4_
 0d9B9qFYZoQGkx7uH_43Qdxcw_NE6gMQZJu.i1O6CHGJgURJaD1ay64wLhkNS2JlXPfth_5u1wIO
 LvWgsqH5ZJdusq43b82K5FCtKjHMSd_nkvfhIuJzHm2bfP.8bc5o4kPdsiJWFSz26FHn1pUa5l5S
 hVhNCwai6NGAsqmbwlMQdfBb0HCpOfoiUwGO8CezpiW1V3gdfSlK1PHnjCXAEpBNQR9h23P.RcJg
 9bhvMj2HvjZQMYUPbakO0P7VXap8hgPve.IftfTkHvrp.sCgg_vK0wWijIUjljFrX8dIT8X4xMzW
 jtDvs416ZGmAVUeieWhktuF1FEpgpDrPQJEx3zxFnmJYXEF2Rjwc1aGrsrVrhE54ss7Q6ak8eAdt
 4ImFTjTuL63SWnmf6KtfZpjPoxFVUmk7OHgcAswyawCY2MJkkx9eT1dym1EsZCW0cMqLdxLsrI25
 6ZLN4i6oWMLbOnvJ.qofSutLMhVbqZg_lPNNIbW0et6j6wj.qplNc8jKT7hO3yepywM.zuqCM435
 vT0DnWeGN7fjmbjQUkLd2VrDmnU704g559lf6XS.f6.5JNNAYqRc1cw5l51uVBNbv9sEcXlMdZxT
 .NRi66TlnSVWalU95oyI7BazZKmU.BUKlA1LKVd10w6asC8Ec8lpM65P.EpEKl4kku09xfmclbF_
 8Og9y.st4Ala2656uc6F_OviishCJBD2jNjs8i3Ff9Glnn002u3RR4Wqe54w16UOT44vMLwQ_.3g
 p6dnDkU1LNXiMOC.Aqu73CWN7GiGIx2qTT7hHQTvRQqBrqmQYiw4XNfesAaVq44oedanGCB5Ip2g
 D8yGJs1b8RQ2T4dqCrqqRijOaJ2jMcc_4xkmMGLLi16_MFNdFEWkbAIKIYFuIk_XiRKJPDvAJpDS
 amPqh.NpALm4gj4ed0LL.jvpJMlppnloe0c5nm6RPi2sAgV.PO5fRFB7O78eItUZfvYpqzY1GVZ_
 EWz1fmh5uIXnXfpnw6sy3GVzeYIUuznweC40vqXq7TZBCpLqw5zNwtkj5SD4L0E_VvdxS0.e6O0Q
 apvT5g3nRsftfr_seMozHl7QZjxQ4earJ7ICHYDvlm7rx3mnC.LV5IN7O8ytEA1VTR3dZ1Nk1hsR
 igt_qvMrnyxIjUMhrXZrId..9Sb_NxiUS3jz9yqP3_d9Qy.t_K0FsLcz1kNu9YwUK2fAJNvZbpnN
 ofDVMR35hqL1xs8duNaQiG4ioUb.1K0zIdfw5mBIhMVsH9byXy9rRyF5rDM5PJ5TJ62qUfzNm7j3
 bDZ3kEtb_TNWR4V4aUc7TeMQOhq9dQ_B.Zo4SzLmqUz1fZ_wlFG001bHFEzmX9VN0QzV7s9HlfAM
 7NxZ2jQrnitZzmwsxxw89i6Xc7umg6T4EyMv4.WUaEG1frrGP3PV7h21UCM_RLCfFoyg6SOLrLhV
 .mHSXppGiTQSOb2mk6KguT33oA1mxRDQ_9YiwvthMrGl6FbKcwtR7QP048thaTAAbnI0clSuIM8c
 0ijKF_yXVEsw65tWwZE2_EGFnDDIuz1IUbWA87dNPd5kTdPP2Z8Z21T.cEM34hqQ47aWHda5qA0b
 Mr7X.E4BjF8XWP_Es_8UcUfOhtLHr3D6WUQgWswU1gEo_J5BkUZNdkTDShfcbvH9nEJphwzUnjZz
 2B2BfRiD7TI6Im.Yahe5S.7XJy_lSSFKifdVO9376GTf7Ybka4UyhbqBDYxQgj4KxxWO4OvsGLqX
 nL33qydMv1PO8C1Dg91nYIG1hl8oHsqv9rQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 47e835f7-f3de-48a1-9acf-0c4e25ad667a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:37:33 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4d7fb0b22ad2b46e66df0183031cfdb;
          Fri, 30 Aug 2024 00:37:30 +0000 (UTC)
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
Subject: [PATCH v2 08/13] LSM: Use lsmblob in security_inode_getsecid
Date: Thu, 29 Aug 2024 17:34:06 -0700
Message-ID: <20240830003411.16818-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
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
index fcacc59faf33..88e7ac15ca62 100644
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
2.46.0


