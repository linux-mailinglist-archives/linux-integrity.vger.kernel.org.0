Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7253F9EF9
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 01:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKMAJ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 19:09:59 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:37594
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbfKMAJ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 19:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603797; bh=IV/8fV3RewhDG+57mk0yypWNQe7gvXfW8jZ3Ya363tw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ffcaCBgtk6LEqPFLDi6KI7VsE/y7FTHgenROpJzc8o7AC45gwqqFeYYh7ZbHWVfp/qFOFrypKkMkM4QgWTwZQmrF1WVj5A4ubitk9QUD/NxPWIPEeh0twerpbGyIR44/Bqd81DWlxtPk53qfc03IscaPC63Km1Hm64hr601SnjwFQhUVjs2zpWsH64VCuKrbQt7cnwAvRNOM3I6uGpNA3GkPt2QP90Bnfm8rqRUryRob7oRFQGo5LaLxDo9YmnY82MqjvFnbji9MnKCL36HGEFNcXnVpVouoeWzxjJW0YqdveTGs7ug46rjMPO6URvoC4cCpVLWxFqpFmB+v17p9UQ==
X-YMail-OSG: mjrhndcVM1mcUIO_IW57vE4_6UFqmlONISQ3zimXfL3EcLSpZXYBLWB0bujfx0q
 nTEkGbz3.5lxAXNymSQK9mvxY3w9Fgh48qjbdWTX.FbXkXrLej0yWg1m5bsX1S8JCziu0reXx8qR
 NQjvVdMRNimzgbGi_jqqSp2AiFECfw_a9T90SeEaqX1YZufIO9dovIlmceFw8zKzBWRA8lAx9jmt
 wSUnJ710b82s.zVXke0sC00ioYIeqF6xRCbkYjmlBB_ApzutjhH1Wp6_bjbyo95d1J3FGmX1PPPZ
 cBTuRQii.wrk_GX8P3v.N84TXBJB56kzsXc9PIXqhHNOLmMHHJnI1Bnsa0HHxEgOHgsonCNgqQM9
 h3VNyHc1SQWuPM4dlvY2RvdAXZFL_WRybNWO_7P2dxb4ln4mrLCLsosngGfDB0kugoDMBVrKVpbt
 IsHAtei1BatThmZ7kiCQBIVVXoo_ZVABp1njVYENOMeWj8QysiM_rrnZVW1RyS14zUz_Ulv0zCPU
 0ccJFnUIKYOa2EbrEaMnNOh_1ASFqwTrB1XwOjYYMaPhgWdctLKrQIDkrkRl2s_Fl16U_uqpOJNZ
 EB3qLH9zydlsbrc7nKWY02GA.dfW52NRSpZldl4.yEfcupKo2VShh0XNs6zslTjCi0xyPLThgFGp
 Y1Qhf1yowhw46EG1_ExpoY9OTbi6S8enc3BbGCztutUOlEwpAL0BEKln_nMJGuI9IWvmdefnQ7qd
 5DYMzrxGixZGsX6vPHijkXG7x5HnFxvWxu5V_UohD3SJbfbV3E9kpAS7rv3z2xaRWAGzWWHnnf6C
 thkjnEmvwE36U0Rn4JnKEuPn0VE_iLqtEkHaN0Vl6Pcu0dZ3klf2RTjCiXfTi3tClkuOeUh1Cyec
 XsVMe6jiaL3haTZMCAeyQYlAQJXuacT5Pg0C2DdjFqML0Fv0H_41TRyoJ24YqdBPkyyDETRsw6.Y
 DrsfM9fhk.T.SXgCy3.Bz80PyNPZeox7.66FiJW3Mo1ysdCBheM080m89pw3rXAqSNGEE31pNdsL
 uZHtO.fDJlf6C6azlHdYxCmVjwauthvHsTD.zGNk_ply7RKPKzOZrcIcVwl5729c6uys2zcF1fuc
 aax9m4e1d3rWL2ncTrT9v9S2esbi0wjIKxDFuELR9_936KmiWi7usMgRWyxg0vE7j1KD3BJh91Nv
 tplSMxdssIja1yc7UMq5j3ollu6C_Y03PuQ4iQ2ryEt3Y8DoZ8.COtrLRN.cmmM5amGbPMuHXOVx
 ZwSkzFCEFymXUZqBqsmuigBX1VGISX5kvC3jucrqTffmbO3hWhkDK9mSWN9zFL5tFv0CNn.ZZH2W
 7ovpn7h5c_7P5bHfLKwoo1Zt9cjCn9HPZ3e18dVom.bJnUA1GGwjEPMR4gvp4uO4znFlzupeGXFK
 DJjK325VTIeEsTjeXBGx8rGx4QyQWyn23ulHVlw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:09:57 +0000
Received: by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a194c842b715663bc900de4e5d395aa8;
          Wed, 13 Nov 2019 00:09:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 12 Nov 2019 16:08:58 -0800
Message-Id: <20191113000913.5414-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000913.5414-1-casey@schaufler-ca.com>
References: <20191113000913.5414-1-casey@schaufler-ca.com>
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
cc: linux-audit@redhat.com
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

