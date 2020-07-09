Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E05219515
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGIA2v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 20:28:51 -0400
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:44891 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgGIA2v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 20:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254530; bh=497lsDzuZDCS2lf/A4kSZznXxW5D8v/MqowPRO04QUo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tuLJnhgiSkqVLKHp1sq5023FHMsWwlNUDlx4RQYW/rKXhg68vFD0suzg68y+lXQU/NeqjglM+0K8ogRj89GEQo/m2Mm0J/ADyCUbHWVL3GYEIykEvvs4QrqmhEM3RMgmn8Rr4QI0tk9PtYmLOqm+yGkBK5iHGnXmdk/dKXtVGx+qkW5g9qAixRo18/x+mhVyBBaGG7hHvgy+1ek7aPnBGNrTOhlfKiJ6fQEK3rw0XnT6JNnVesGBbe2CamwjjGMjEeJFHs7Y884LcAW3e5ktqw8oZRraL41A1lDlBD54lj8+PciWYkh8fO5m4JMAiDO+GYiH2TZQR1xcZ7YaidEMdw==
X-YMail-OSG: ojqEwYQVM1mkj7nxgQfFxKauynEgrXKTEmehOCy1es6L6vImwbhjNRaxU6tzsC4
 yWKWW0zFjvZejCXXvuBTMoLjGw2XY033sSPzd9U3WR.v8Fxicpy4e6WGwIc1Suy5xZEzCCxDs6at
 keTznB2TTvV9fwGXP5UaXtO2OEVfngvOR3Yfu9UzyOvi4umQqKzPdQYbhkIFumHtjsOyWPDStOqu
 tldXmIDb0_ilQdGlFaKoPwmUtNevfEuNyBX5H.XBDKxVd91Xd0kAgiQIhfE9PL.1Tt6eWLEisSE6
 H6GifzlqGBmQC98zIuYtMmCFad7mU5bv5iYCvzV9qy0mebX.vLNv67M8dhRriCMDy0pMVe65EMM2
 u.OpSFgDHktSTUHzhaWDxsH6vixopf.hQppL1LIFX3.1DOukTVAouSiO93LEyfcljtoTg9It8oL9
 SRJmgDfLjROr6pPEl_rqbJN2UFEKtc9A68E63RhueCBit5sBzFpaDWzmRStbByZ.GFTjBBxof85u
 OMLpl.biikSiqxJyx5_bD3DxojMfaJeWg9DCdcua3uYWSgM28CIE9jETXgnlFsXikx_IH1NJbynG
 qKvk4Wiev68dHcPrGTmIMn7Hm3SMvr2l0IJt6iJ8cUbeF9rlnMX_j.KYZjX9xi29a3XH7Zyr1M5R
 _o33L2ocGBDs1B0s8N_teOrl8eN.tc6V9G.iqbaQepBW6AFcirnFUzucGI500WhbKhtTGF.NX.Le
 kTGIVqeNYV.0nfmQtmTkTjE.nqXHcdodGbE3iObsjUMdYJg5PCM5A6Z6zlkR24iWzsN.0Jm9LFlI
 3zV7O5Q3D8W1CnfyJgm.vtXXxiOEVpdNLiTu0c04qKAkq.YQMe3xtlMH9zcnyoILCz1ueiQPdkEu
 LRiCwMC.2bvOrLuG1wpqU_l7SztCYEw0DKA6glmYvA6dMlw1BCxG0SOVCfP8yI5hUCj6_BS.VW72
 212NOuwnlWwZGI3YCUw1AtpciWkvvduOP6rLZshCCbNhUfwn1CR0JHQaGothXeskuuyBMd.Pt5IE
 K7lYDUU9Uy7W2fnYxoDlskm6tTIUSKbyO3CG5Z02M9cw3BEmF5xdfYqvaxPldaCm8FIedLVZuh5O
 4Vuxaa4vhRGd794pQ2nxSxoc0Ojxyqgs9KYECt56KzfS07z5zNjt6cKOoMKTIz5I67l2BDwj4W__
 Fe9rpe7bZx5SRIjj5snuvFo_ZfQRCvGrn2OtHivuZl1Y1VzHcr5V5MWm1EYGeLpcIgr9e2WJNUKp
 HemdKFsCFSGPi33ZncPpYrs0PKWwwIQbvhvr9VtI1j9cmVJtsa7ZgDvnQlqhfBugIs7tc0jC1KBm
 3vlS8n1tewpa5FivwmYyhN570HNtXIShwXlIGxi3_pgvTJfeitCx59ClvDcmuhpUgii.UJXyFPoa
 cyFRr4OANa5dTxUPXe.rdbmxHHwK5AJE.K5P7c.9Y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:28:50 +0000
Received: by smtp417.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 506795308ba93e7d63e1eb32e098eb65;
          Thu, 09 Jul 2020 00:28:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-integrity@vger.kernel.org
Subject: [PATCH v18 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed,  8 Jul 2020 17:12:21 -0700
Message-Id: <20200709001234.9719-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index 60a5b38e2708..e6121eac138a 100644
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

