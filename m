Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3D102E7A
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 22:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSVqS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Nov 2019 16:46:18 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44691
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727140AbfKSVqR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Nov 2019 16:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574199976; bh=fVLWr87l6j0R/gnScLqNrHSBH1hKgEnFzkqP1Bp6da8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iEW6y3wjZL7O9PK90+CqJBsk1f6RYUz7F+jCOhel/OXjT7APuMT0Y/NBHB42TQERkfEvkCk2g7vkicF3oJjOd9Z/L9g2v9fHccCX0emidjfveIgcVFEtuN2gKQUNT9Z00eksUog98Fv9TbbiApw0cAiXc+f2W7Es3oq+03d7B9uPKEbvplKUe8VE5d27E1GAIWiu/PpMTv2dOexivC64vTmR4hqMdv2EGrCiylhzeru6/M2r1f/f+tfuh5oda9iHYAeO7EJldY0hA5rKDcDiq20xAXPHFAiHJz5p0y7RPhiW/88aY/GOw4ziQzeL/J7QNBjWKZq9c0Z3HgsRfksbIQ==
X-YMail-OSG: bS.2J0YVM1loSwDzZ4_wOZ7cI1Go6Iy89IGnAvBb8MFeWT5GH9NUj0co.1PVmIW
 WarMB0NxOWyl6wPW_R6mrsSNz9Xc9HYU0__KGXVaQVgcsMQfQouX5_IbvHxlfcb5Jo1uFDbS6Plt
 4yOtDq5sijDFYB7fZXpH1I5RkVyMBXJSznJ_OZcEiF_.Z7NFZcE6_..FZSIjxJLEZeyTUlNouH37
 2Gn2OcIC6Sr.cwy9Suszipq_dRh04i48Thz4TXbtdFl1OVtXp.GHcpJRoMCYA.F_N.e1GRxH1oN5
 c3rTBHaWAASRnAthFVVDO0sR8pR2LfmEtaTsc9ZMbvalA8fgOfbs2.g6JQvqTiBvuPZHTpAnlNAz
 A2AIBaN7er8RFY47AZ1FM89sqHZ7WeyGhAvBoadlMmpNxBpcF25Mp2c5nUhNkG6wLEVdHHahCNBh
 WQgDLTkUaWLdf0wWYhegiiSFv5bfzk4KwW7cd9yNCLh3dm.g0uvEAUKRFkMeOonEXrzOawEnUe83
 _iVzxHU7aFiUfF_neqfscnIlgbV.BZqW0vPFHtU2jqJ8uYy8tyqvVFeq2TG.UO91TONYtHTI6MuE
 ix7qquBnzvZins8LYmzNVdQ9ojwwtbdr6mYpuH6Z12vnnpFg0pFZDIWWRP0dMHVD_rzFEBRqTHlG
 m829e1gh4l9blq6q1Ysj8q_UMTbyvEKCN02kZZSUARtvrSxR05ZcJgSnJ8a1Ax.zDDRlYqEedKs4
 uS.S3lWxJUvkqaJ5VZ8DkE12ZuHeRnvaDMVFrEGwz1lbx5yTAuzDw_OCYWzlE.H0xmToUW6Zewhs
 mKx9KUL9Jio7D9AYOl4mLEjco1dhiR64_qQoNCfWi86e1X75DFgqG7y3Sp768VxJXlyWcyt_a9LX
 UoCrcvlA70pg6uQULfhrZq_CZFTf1wq1E8bTNAEMEQuuXc4hjnBKuBhLnm8XCVXBRTlx8jBrxPBy
 GATfLXocYyyYpnoVx.eOe0LzARrjXXQYqkXPuGIXu5TCmuwxRK0IHi_bQ.VTahhMRqiiUyU3U41j
 JuA9kB147rK5tZG7n9s.I3cxBZBtp0SxDWEkLjmkMqV2rmqLr8AhjI1PrVPhx5YCx3NjmvShL5Hn
 7vpvdZQYLiNinnYqmPpBiag1160Y1s_ik5NVXclBZf0d_fUWpxDDPBU64K7Dc7Z_ZMTZaFbNV2Ac
 txXigenEpeJoqAgzLLYviprKd0nJWlX0f3j3YOlQJLgeJxFBk137tl9VRHt_nWf.WdTEceli1S.7
 aE9efCeV_WIX01JGa3eC6Q_9iHivd4Lclbo5Jriff9.oIcRtKVbSG0.YWreqp_cmetoXEjPXemRx
 GOPD8C8COtMVIT42BULq6pVEJ3NPrw96CTdXxqULK1NDDeYInIN9dAsp8DDdQBjdDnToo00ok65l
 FGB02mieCgy6OIIjCRt.xXpJhDeEZ.FMJSL3C8VWT6ETYGI400EY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2019 21:46:16 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ee2e3e844c72ed99628860647e58ca83;
          Tue, 19 Nov 2019 21:46:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH v11 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 19 Nov 2019 13:45:58 -0800
Message-Id: <20191119214601.13238-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119214601.13238-1-casey@schaufler-ca.com>
References: <20191119214601.13238-1-casey@schaufler-ca.com>
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
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 67f95a335b5d..a845254fc415 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -407,7 +407,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -922,9 +922,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index cccb681ad081..5752e51883d5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 7711cc6a3fe3..c5417045e165 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
@@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&blob, osid);
+			security_inode_getsecid(inode, &blob);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index e1f216d453bf..bd279a24adfc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.20.1

