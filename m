Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94D28C257
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Oct 2020 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJLU31 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 16:29:27 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:44721
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbgJLU31 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 16:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534566; bh=lsqAv4wr2ivPICctHHG6NywIyyi3rn9RfeZbqPkoO8g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GeWqNGKk3oN3Xg9qRQFvZF2/K9gStYdsqHE+7frLgiXHXJumHN+HmP+zoCHAYRYNRjLoGuY9u9BPEKgBUSmgKYMC5td1ckg8DsOZd4yGjsWCsrF+zYpdU+caKOj5BE2wOlNXT2cn8q7F+xgqzcc3UBPfpS8DXl6hFTH8w5MTNpzIYMBtvAWY3oODo25HO1XCk6m+N/sppbtmzCvXdRpsQ73eOmbJOkjBEfilygqG15MK/8Okmxa18onBe7afQCZQQBZvpYzg6tWE1K7wy0gC9s/YS7qGc1xNq6BkJ+dp8jQXtm2NOvADljlw2Ib4wEj27XjAbvqEaf1pQJpYmpOGNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534566; bh=ig1gu89+275uG+iaYd6OVifA2jT4jDFeCflq+zfoBbM=; h=From:To:Subject:Date; b=g2Bgb+8KdZLSG41Xb8xjL0PTdrB/HMnzMPGUFUeZExk/l91Rh1D8T3UImIAHvGno91iwIx+EHIzFzlDOlImqCppVkRwbB5W6lUvwpuZOadsXGRBakhjr9uXZWvj7KjapH/dIra/LmzRKjVAdpykepFFqoXI4VhFMcslJcN8sJgBaZVWLdI91aXJXQ6/R9QByVTRJ3j2JKpPZvP7bx/T0wxk3NxCfF7YN9OJmTM1N8NhYBXmZMx4n8/b5PRdrIi2ltykRGHKQgx2r21iaZpeMwm0yN6IZuN/seKJ60FgtV74PknGGWydL8hAYAZRYs18fIK8i/7oIJBTG2wyO03f1Tw==
X-YMail-OSG: vNRNpzkVM1mU92mIpUsLqZbjXEkeMEFMTdXinDgMSS4Tjf2M2Wct6ssMWY7OdMQ
 xDDJkn54z.M4d.cbxizlHnw1XHg7yup2W6DjUpVA0R5chdUXyOhjaQAKIPXA0JKPuWhT3D547ReG
 FNME7lGmFp7aN93sNJERwt0tH1D1Zlr4N.fu7ttTA8cH7.JB9Dcyy9kk5fMsFGMdCGZKAtLzpI8f
 L75_ECMEfqPuxTPfgcSjtAvlFYTL.GKmMUa0y.njk2FPJklpuAIFgXQ1T3BxAVaVonCO0SGBcauY
 3k1iF6L.zlgaBTqMj6Kiq6AJSikkY9tEqlO1j.tp59_X2oiDQZLAuQ_YwPs9Q446ewauzpRszIp.
 PywYx2wxjbWtMF4c9gHH7c8_lJ9NSrmd9zFAiTWwD.3IHqkz1GN8rgpy8uwdd2U.jKRiNB0Jiu0R
 R0Tf1jVbQZvrcRRuoZSofHnlc9D5yED_Sv1QHpgGj5yVqigbUc9iz4hRh97.xFD2JBoOtWJZzH3h
 xBIR8eWgw5ySJEV9fODjUCpDcOJ15I1LRTuScq.KwhH6ghKLpxIrd_Rqrz_syo7FgdkExa7RbDH4
 7IQRYOzglDtq.c1G1lwuRlQtbW4eP5.FS.GcCvQDA9Yat2OhJG2TySIu2YS3hhCYw3NIXgPUpYw4
 yXrvhrw0hJIczntdSbuSGY4qxl32LCTH2YScIw0IAiWHssWpn2FqDxGlpVybW5PLgZm2Hxn0bUWJ
 S7xgIv40f_34slHKwA6sLD3lHznOdea.rkxBz5RkYYTFhA8toCfPDDy_9V3TraLU27BOQJEJaAwU
 ADOYVaj2008lhrVltp94vaUmyT4pzMktOCx0vmau_cOjs9KMPP5HmYmaOOtrY.qcqSlmpZ0P1tV1
 s4z5r22vWiv8vRwvmpxLfWHof_rs8M3z.84Ul8hLvDB5bfoswrzRVSD02Jk7HEQ09M3sV8RoGpbR
 t_bcgn.RCjsyzrqioO_Y1Ei6u_3QN6XP7QdOuxy_PlHcPIUQzBJU.EEjFSjV8jhLP7G4SU70ZpBm
 I0AQP4Guc_6GtxOjBHp3zeYPDcEBCQ4L5oVsIs338WAkYC.yufcU.YPfCQRWMVd1GQuIwFkyaGd1
 gy5MndvZ_0rZfxfFIHnQGmoFLMSQh6IPxNMVXz.gf3jCuFRqm4iGhtR5Z6cApZZ2Fqwap8NtGCSP
 t7avzK_APgHSR5bqEkybqkmUNrTcxCt1gTX.5Vno4OM8iiedbB8Qn2uhi9fDd4hNEet0wgDdkeOI
 9ur5rX.qM81l.P2ENC_dOKzMMWu0bKf5pKbkqh7eFU2rvzWyxqzfVqXbKIUUzW.UV7wfHZdfQmDK
 QimfpsMfKl9dOwQuB9i0W8CT4x.AFl8M43qqYU036AOQ2Kxa8gGTz31dcEPa3gRMv2lqDCL_y5Ay
 2gz21nBklww9.xfyxfv5koN433EV6bvEjo48XWGtuYZ2Imc1PvEn89j9dC8I_Pty8jTisucy9iTp
 61_7x6TvdOJT5ikjzNyqNH.o7mnH6.IjwBy_wT7On5k5nAfxAgmqAPiKYcGc0p1N0pEaY4XRxF_T
 EZpltTabARVMXqs9YctKlByXU7NfimY0gth_D7EWBgg.cHUTNXtk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:29:26 +0000
Received: by smtp401.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e75236e965a16848586e820b52d91cac;
          Mon, 12 Oct 2020 20:29:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v21 09/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 12 Oct 2020 13:19:10 -0700
Message-Id: <20201012201924.71463-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0e58fa8e887b..bcea823774cc 100644
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
index 6b43ac22220c..8218f68e7b96 100644
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
index 6fda656e2021..91e51ae759b9 100644
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

