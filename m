Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF98810BEA7
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfK0Vhz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:55 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34424
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729613AbfK0Vhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890673; bh=EAE8T2HhHKZcRczNsSfw6utq+gFJoX2QCxwtRDSTStQ=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=k6GOwc44/h4VnkebfEY6o07WKoBOOM+JyRFgwRFVmNzbH/H3q8d912Jc8swZRV4v2ZnKBiZlFdJHMQKfLEsYJA4ZFoytRxyfmMLOEa77l3XP+9xRmh0UGoWGwUlupvHwFKZoYiP/sH/yqVdd9eBjTH5w23Pk/BLdNpw63pPqkg6eI11kNyPcFU9th5U3N7vdGp3hosSMh4pyDun7qAzSqP5ByDtlUvUhG8TjE5uI7GnPQ+1hBFOMPMOeb9e0TwG0DXKSaaCr78/O1M1/Ep/Sb7XMWtl3fC7G8eKesXl4wXHd22BeGE/+c/L3VxNi1CtlJ6t2AqQM0u2wf0M1g+Pc7A==
X-YMail-OSG: 0UxP2a0VM1l_GQPsRAFQbg26ggC2CldD1ZXKe0UCsQ.Tf1o3.3sswUS7g.vGqok
 0YiRXmhFMjCx4lmSFKk2s.pJ6.Alie5gNngCzo02Dpv2ehNFoyXKPqQR25mCcuazViBI_SIYVQmD
 9yGlAyvnN9h_MrSJbVmKATtTkLPiieIUMf1feslntX401wuWAVwl586WOYcu_GXlUnyQJ6rU3dIh
 dBajDmF5OR7YcFs8BsXfmuLkrjZIRVnyAGNYbs4Tn.X5Le0R3REDJwvtuyl8bER_0GZHdBFOJiWb
 i9NaaD43zu81bMvCgyyRJ9MhHwfI8cV..Q6IPxvrHtf0GamZWqlx.1xJwlCbyIlSJopeGJS4Lz1d
 ibq7NdE0MNi27.rJBbQEZlDJnt_6A.HTj2NJf9wQYx0aYk4z96iCzivWQbWjByxv6e.CU3CH3305
 c79qNFUaNuesw75qh4xaugp7cdOxahq.aXjUJmYKXEQiMi8XqBYhhyBvqcWQRJbrvyLRLjpyQDk8
 2bYfYQlKw9Xhq6GMtxivOxh6YN0JOfx2C.4s6ge9pL_GzkjCdgHiftCike9hFuulNV3tcGlvyGCe
 S07lnZXTTKOuN6IMJ7n7ny3bJv.70K6fTdWAr_9nfVhjE6HBTLVD7_3tAlKlw8kwY.CPoR1_MlRD
 A02QoYQfWk4T_M8Him.FBrY0TNPRmivhxsyH.ohKo5BpNf09oxLg4vx1mhqHWej7P3byO8.03QKb
 OgQ6kAn1jFZmmf8zrYa41uohN9L8WtpStD8eh2rxDzIQqNz0pFei4NYLN9kIuYKSqJZRiM.LP1RM
 Fl.Tpz0mbcRwmdN_PY59T9DpqTxxhMlYNWHTe5H4Gv6eVqUFlLUt9fSuScIujMuvkT9bXESlDd6S
 xO.P8kmY6HG9mhd_qJd1ZMGIYz2AP47ryWdm9Mo5PxO9Gf5_k4ynaKShzitfmfo4Gtby06YIfm6y
 5mTx471ToGBTnrRm1fyX_K7yHHimnyjrbI5hWUsq2s1OzOK8sfFp0Ytxfcw7VYgb_IzBeQu0sgjk
 k06WWy6IYfKKVSnd1StqbCPlXGGBs7Ho6VMMQNaj6o3eM42czkfYd0WvI3MH.VVaefZQfG5hRZMQ
 ediITjAad0D10VGKNxMFKq1JfkiPSYh4ZYVtUq71hvm6xXXYcb53No1r8kQO6CYktMHHOQJs8pAz
 Rn4eLQCV2dAp8eyHMcAcu_.WUbrMxUI.oNJ4w5T4Wyszv6ittpqYDvoP8CcWPLqJhoz0FtE7rP9A
 0E84ajlJIcetygQhaAsaXG0U.iLoQ6TemXvmEkScIZVWlxWO1TjgZMH6QgApHTY8RlxqnQfbsOJM
 cwZrvuXiv9sMfiwWGzucxTjM6Zh07DyVnt6umaqfRlJZ_VhCfVtyyx.7q3VCOjqg1L56at4w5pRS
 vjhmKdp7E9Z9wr.gD22noNBsY9dVC7YdfyGHgwCETcLP7njyJWcwO8AumjEcs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:53 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1a96ac238072416f313a07a6914fee4a;
          Wed, 27 Nov 2019 21:37:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 27 Nov 2019 13:37:03 -0800
Message-Id: <20191127213718.18267-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
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
index f9c12b05eb2d..7255eaf728ed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -406,7 +406,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -921,9 +921,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 193ddd55420b..c7d2ea47a326 100644
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

