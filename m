Return-Path: <linux-integrity+bounces-3774-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDB99732C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 19:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA961F23F52
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAC15C15E;
	Wed,  9 Oct 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nb/lfLL5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6271A2846
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495350; cv=none; b=t3IbVy+OjXgtfjimBWRsIOEaVtcUNh1Hz3RYv7qs4VJJjokEel2YAl2dJq7NEaMeG2cuUOorOS4ugb9xv8zykpkoADgb8ktsF0SPxpCx6kDujfGq807v3r7966LF+N1IGDlNguAJP97wlcvgnTQyvq/8bYfOWDxV4dwwioUFID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495350; c=relaxed/simple;
	bh=5x0nxYzIRH1ATHb1j7OJCfXq7lDDWl3xwqmB9yuEuRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3Jr5uAfgafju5A2kfc26mq6XvSJ4cD+KCwUZG6t0qYGyI7ZcUJMcKhAeh3vjUBLhBFMzH83+lMClDDnmqPIllNS4plB7vDWaQLngzQNTh+T3hzvrcDWOBRvflWwHCknxr2Yq1FMKR+14sVJR2HMK2V9vKFjyLp1SBAH71e1TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nb/lfLL5; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495347; bh=xGS32vK4zqUy1jW80fWK8+QQou1Alo2nnw9Z4ZdIf2o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nb/lfLL53uOEKlNgUrPsMnCcYgUUWboHK5LJvJLGVycaqKd78XcZ+MhJuUQo6S8GydLNTyLYmoh8b7WYfpxge4LiXh+eZeYrcRZEpQOJUPGuPHGQr/n2KAhzrdwi3g/QrD7RjJ1xSLTszSHdkvRtAPmnn3KrpQ8TBbOQxtE6MxbowfU/34wo2wRS/PK9tRE0j0EbFtda3Smvnu2MxAprOPJG5M3j6bTF/BHQM4topjqN+dDrpyGmegOafJEi6HX0AnFK3pVQ64MB4kN3eibXW33IiW7ZWkQwwrLoa6P6/6vIGLXa5ifjJDMh+XSdoDxBqg5CAxLEhp3hZOFByIud4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495347; bh=Wut4H/2YR7QIM0pLGdCpucXgdG4wRM9S3tdRQHWZm5m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fl3lUyeil6Cydtys8LSD5+DIK9gUZqov4wxC3zyFl1HifkdSdbGpO70cD9A1g0h48Vg/Aj9s7x4aFJYRHlBIv1Mi75CKt7krJ5gWQMZ3i8Uj5LEC/5ubSxs9YHKhAU8gBYszw10i6r+6bZfQbjjwrUfgPvTVZ0v98znhlh+R02VjxZGqZoYd5uzW90taIkufLvRbNZlym0fZ8K5wbv9lmR4t00mReIVJzUhPp9L3DiE2BCZcywrrjV58X7bUPzUU3/imsOR+8QUizeiiHB1v4kDJq0gsNjNzK3ltBznApjrK3fO31IbTid8Glk0QyEB9mmgtyVxgXQeif80Nr471LQ==
X-YMail-OSG: GM1vGecVM1muzW9EsI8QAql8.AZAh1E1nlAX8WIgcvWavaOKIndWGq2Zva9Zz4Y
 ULZLDZ9pjzD_UwCqlgkrPcLTE3sKP2kmGCWzLciDBmEUEUZ4Xp4h1jRH1vMhUJf7DLlxsoaTeOwP
 cw9pARcOABFFtvh_4tffg9HyWLG0ZU9Oc8DMLQLo086QugrKjDehH75JphB1tUQ8GFAX4pX3lp5C
 l5.DGzmAnML1Zps3rQLGxkMFN7h4YNxhGChMwnyI41bieScxJow26d5YrhLqjO9Rd32uVVi2sgi1
 EQ3F9yJ1aDTy7vxBxC_x..Vzqpb0ao9JfJ.TGho7dDArd5nzAUwA9UJ6P6nJnMBQ4HLzhv9l0nd_
 Kt8MRUBxaf3UbXRz26FHkTH4HMgK556heMFgOUmFeJAMHx_EEHvIKAPph0kj6c4m0WybzOp4DGBI
 yOJ4vhCK0nmfaXvv0M9QGM3CoOWPD3Sg5xfjYty_.efi5UV7pXZ8Vd4vgw4a3lFOsbfijCLbmKso
 WP477rQ5CULM.MnZc04o37frZN3c3mxfuXRFmgTY_bKBvKlpIF7FajRj4ll.lMNeZ8w7Wxqm5yVn
 2Pm75iIIGQvz01cHcxRXbPbJ7JelrMiolI8qeS7RDE7wIbX2mCCLNfijK2zVhNNIA6COXy3CQ5A8
 dr3U8bRNguAWAuE7Pg2V.cDY9.t0cX9RG8X5GZ2tZiq2s1JPyLlOIFXW2w.wQb4fVsYdpKwQUi0C
 e9HMGFKFgSFasOSWln2BxZhylwd7rgO3y4QIFu604WDgt64Y4a3UR3Alm4sUFl72r8V70Xj0k_eg
 AJmfPwLrbKVp3WwXT9BCsgWopxKHvdiTsTA02D9GakDYjZCozcllx7RxFKVmfQLpb8DKLn03xdH0
 DIMjVap0jnaVmovRWtzIK8Ddf_MN1DLYgMKdMIU63_AuprgXVbkd5aQyC8XJxonMRBi_tuaSvIHm
 6BXW3upoAHqJ617.g6iIOTMO2ptlDZS8Fc2V4mpxCb_nk5USf5vjVPfZ4U3BUuSGgb3lfFvsV0nY
 jxF7ajL3..aQnD1QVPEaEKIe3N5kkripJ.7v4iSqr9M7UF2v2t4zgAYCP3QEI2W87y00glnt_6Ul
 V6MLRkkP9Nw1.zVLL8Ga57Tq9tuwv2ZtZr2bF8WkqLkKBVsPKFiT6eajfR573Hwq2WPEwmBOeVey
 2lgrO4RGM_PVu.n.f0j1bmZFDLz6Bc3vcEKsoda8j2DDMjp2ZjpnaGKxwGN4bN1DvUi5VhGGAUcg
 xTC9co6spsPjD0vNcKJ9F.SZfzE2mN6PjP.CYALoJCghLXjMMv9WkuHNmw7kaTBJtMShv_m294W0
 l7uNH3NUHSmZVCnH6cMtoQHTIXP8UDWXvgMdyRQtnuY.qs17He.8spSChpIPu_LH3JIrFhi8rLFt
 x7YGm19jpwrk5M9pGazhrOeeLfg8qv33M.B0J4moIcTzbgh_fAOCQG204IXrUqBil8Updv9U.oSL
 iLNJ3zOkesPMbD7AUJNcPyDoYcSXQKa2cSdKtsHG.NhKiEM0zlaXAsjxYyG4307HLh6TYw5vKkAs
 s83qY_hdkh6E.bFSwttabjZwTHYEHOPEMriP9IwBvWXFW9Xp_pjmTaCJKXIoMZvWVEl3YfX1UV51
 6FQ0aPEv1EsluMrL83aPqJDPUWevks0qmtLqrpEbqXe_dOsaaIjQx1rqfSBOwuyTA_24fxHBl4wk
 W4c7ujLR2XDY5_EGTB5nhdrVWhsLFGFJIy.eOyQ3K_9INOc5lSlDpycsxCySaMaocf0BNuzyz_lP
 56k012LMtaUG9npaYbJKJp8f2X76KcHAKC7zKGvpWJfT0EGpPb7FVxn5VG7rcOcYQ1ykebpD3NjV
 hJ0qyUeuPQSX6BG74k9OFqB7ljnnHGXtmAgX_E9ENl3S9IRwMDge_vnPTvS9YHHPPaHT3pvFOrrk
 UzTPI9yl2rI4i0zUo1jzJiKSCBlRfNoMQGeJ6NFUNP8nPOboGQWsaNodWtLg7VCiiyTMvwAbbmZC
 X2IL89a53y40or8CeWs_klzVm6ZFMhJ0zuzLqBTz64WaoTluJXv3_6W1DPaIB_80ZPHCGVsmhz6U
 H8kRwcblGvAeLhb4Ih9ySPnFGofoKrEDfPmT3s0GrQ1rJ6CMYn3vQ4P62eTyfF211Ly802qaSfhn
 TDaLoA1tFPG6x5HXXIG0UXLkQSqfH0IC05j7N6K0V8SvvggikLP1Y3qRlorgSPfyGDldkxkZPGwX
 k4iV3TR3xlNFh87E.IIWDcm9U0I.MqyBWngMuNz4Zi6FliMLYpxzMbfHVwYYe4svHhHwfdqH0qSk
 YVuEqYrNCqZDNm0CY0x5lpp1wsLB6j57_IhQEFuvZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f9cdb05e-6123-4694-bd50-d937e37bbcec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:35:47 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 502c2859a32e83ed73c2b19ff921ebf0;
          Wed, 09 Oct 2024 17:35:42 +0000 (UTC)
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
Subject: [PATCH v4 08/13] LSM: Use lsm_prop in security_inode_getsecid
Date: Wed,  9 Oct 2024 10:32:16 -0700
Message-ID: <20241009173222.12219-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
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
index 8a90fd9ff3c8..23ad7e4f8c67 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -176,7 +176,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
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
index 9bc8153f4e8b..2b19ef5d799c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -452,7 +452,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
 int security_inode_setintegrity(const struct inode *inode,
@@ -1076,9 +1076,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 6b2b2a8d5647..372302f0528b 100644
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
index 5cdb5b171ff2..5e76e35dda09 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2724,16 +2724,15 @@ int security_inode_listsecurity(struct inode *inode,
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
index 7d6ffd3483a8..a9f8d10062b5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3503,15 +3503,18 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
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
 
@@ -3523,8 +3526,8 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	selinux_inode_getlsmprop(d_inode(src), &prop);
+	tsec->create_sid = prop.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -7174,7 +7177,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmprop, selinux_inode_getlsmprop),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 	LSM_HOOK_INIT(path_notify, selinux_path_notify),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e74e22c4232f..5c3cb2837105 100644
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
@@ -5110,7 +5112,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
+	LSM_HOOK_INIT(inode_getlsmprop, smack_inode_getlsmprop),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
-- 
2.46.0


