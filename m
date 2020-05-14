Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764D41D40D3
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgENWWu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 18:22:50 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:42040
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728227AbgENWWu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 18:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589494968; bh=00fD1grsIhFF5LtjD9egNqVHjvscUXK4If42VxnI6kA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=c7AUw5beTKEd2JuBURf0PsrO1oS8fJku0o4RJOkHgwR7+nwpTyfPSChYJwS7+V7ib+oV0l6NYADgH35omMDRjV1cgEglWN0oT73uRD1hnORLMaMS/e5h4SLCwuwrYvfwHFbDKImmDt54ePHemZ5X+tFm8xzZ340lAH1mNy17uSFOyc3UUwmberrNErWOUSKM+KivIvyMJWXEPagjyoCCtms4FyIo/AlC5+5NbVWxT46S8KruEofZN5SMmf0uUAGonXg9tM8gqKMchX0DMk+XL7rkTNbGA/QVzsjMw6TQghZmKMMB3tfe/t5Og9baoG3X6FsETyCA6L74da6raR0ipg==
X-YMail-OSG: sf2ys8oVM1mc1HDzilccL8MmySbLrH8dwVO.6WzKUgdZ_rWYY4CWH5tJ0d0ND1z
 ayZPDRpqtg3YxrqxYFHaT5P9Pft8Jv3dq9IFYBIri4K5zvSwizqQ5MQm8j2o8IhdpwTDkCOyqDAZ
 W5iPWUKvJQfwxfjU3.3nhnAuDIpDHGfXET.vVaGwAxB_afPHpVmmgGarVObBdkOFZ3_F6M7k2QFy
 AoH3RKNrHTQ3EmOzHpFcwRi2367CA3wobpJi7MU3BnVObuh9ZHVdyjVW_CJjhEvM7PIeaVVR3MRj
 wDqtkqgrun8yz1eHMkZtWF8MfDKfxQYpLNw.VxqsuUnVXrLMzVCQGs31Y_ON1.QpQ0imvECiKN8X
 Wv3gtlSQBaw6GEjCwYJ48Rg4AIEpPb2lphCo.Bft2njP0mDs9FlHDTST8KJUZuzK7p7be1uGSgkT
 oYoG2gMzIuxwCl9xu6rZBF_vau1BtZOCNko1eIlrpuIgmo.KRMeHrcpFRVyWoqN8.eHHHgCGleV7
 rZIurPtiE2579ThfCp0LvTkioGB9xf8LkL7LlVslzND4p38msdE.WCOK.6HKucn7Wh__mU0kTDjP
 8HOP_gTVt5lMzSfWBmIvxALcgGUUSbv0kq8PllyumLDBjCgsFUVLZkQhgn_gzM_uqUNIzbgyZJZ7
 F1nw9HvAM7ck0I2UBGm26f7.DrWLiVs5yka90BzXGhbGz4TOeJxzejXnxjHVvQoXNLL.h9tdaXOC
 qiKuzXCaEFfJ3uFD5uFhATTjbWbIVgm3TN3.UGUN8HF2Q_RwFuCGXM6T71RjP8iojo1gv1SsKEW8
 v8ZitGInfVXy5Ot8Vii.zGxn4t8yovAunTkri_kr2q9ycRolQZuBa9mmwsRTwJ9N671C4LvFwXRJ
 BD3uX37RfpWGoTuYp2Ew4nAd.AYzurWpl4NoZfkwuxNFsIFnnJG.yAgNIPfpe5h5.5Lfj40rZBLG
 l1ZhTpUy8v3mRSPPF.XJKXDMBaFyCP1my4vGyLiUFOCpegYJhue6Mnvk.d8WwJJvfR.7xrNuo8FU
 XC2W7YNyz5RzBxJinHFkTQIXCgo_POVau74Kr9aJ6hekZsnL1LrrTmjEKDbA48U0RpBWs3Sjokkv
 5mzjIRmPmnd2ZidIUCTONzQplqfwGfF9ExT1NHlzSuodr38lIMiAU_NJ1BdI.LhEw_MgMtMesPIu
 ZWgOvxKkj7fuIon44T.ZqUDIcr_Os0nS_8vtEQrCNEy7dpa06E2aVUQsvo4CuLiZVBSTfa8Oa4Rq
 WLZIXczP7F6Jya__4f4_mE6fLo3S0oomZC5l3ApSg5jembgE.JAoiT3EKiph3ll.3otKn9RzvdN_
 vSzuxq7QKfOKhzcRN11DDeeLBDUCkt999GysfZlLTcSMPpZpkH8X4RvnrIV4YJEVX6EXm4PLvCxr
 mMHlDruVw8cghQaxbDVkpH58P0hFRq_v2in6TZ5iJgiBc20C6dfLP5ExyDuSC.Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:22:48 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c7b3420ad493daad796606174d9ee147;
          Thu, 14 May 2020 22:22:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH v17 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 14 May 2020 15:11:29 -0700
Message-Id: <20200514221142.11857-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
index abb88a7727c4..c46da9c03162 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -431,7 +431,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -946,9 +946,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index f4c45ec8f59f..3201f0997a5d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1935,13 +1935,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 2c1a92cc1bf8..2f084a388142 100644
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
index 60b3d42b2e3b..1e8456a6fe3c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1437,9 +1437,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

