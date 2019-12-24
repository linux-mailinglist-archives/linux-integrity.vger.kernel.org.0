Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAD12A467
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLXXP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 18:15:26 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:34844
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbfLXXP0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 18:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229324; bh=uQ2URDlGHwivvTFxlkJ4ZmBWhh8fhZMuYTKrwyBZ/Yc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ffEuPDEC7enMSaUiQvT81OfCUQ+u1I5Pke+o63/Z54Dm4sk0Sm9tFDetule9E4C/aJLAL0WkIb21JWsLPPzG6q+hRCGAhcCFchdgKgVKkEdbotGy1MDd2KnFYaVEYddEb1wmOlQ8mY40z7OCjNeoHpuB8mjXHoO82k2ouldNwFVmBa0AlcW0Qu3NNQvy7+82QV0E3Ak5xxUyegIJOCaGSmTMxQtW5A6vO4SIiaiOcEWlPI0t95GJC9phryToeBLUZXNbegspk8jLDevj22/Q423nEneKOXWb12wSQ7t0t7CGyBPPq8WA1cpBLHLDAR1ZA3i71yffrNl+uKHBtIa4eg==
X-YMail-OSG: CiGebu8VM1msC0WvIytKE99oWwKHs5NjgsrOAkELd2_EslDFHXtQHzn6GTYiT6e
 XI_kCr_rWTYibuo.7KK7E8.oAWR0EzJrVEzpVzDeEdOWm.8gjOHLfBqHAG7C1QdX7GHvNTB2_YAS
 GFD0O0XUEhdcwy8QHWdevUeUaHKrPtNHKQM1SMcPix9.q6ulyDCLlefHqRORQ.rV8jJbDvlAtclh
 f5U9CMuF7nFc.eb83qaS4GMy3MSwllrkxdBQ7ZsUPe7wBmgCFo4L1Aba9.BVvClkRFgGCDLYVTE7
 o7qAfUx4cxaAqbve35j_fgWYpWIEcBlJ_ieiZQ50D2vtIbzEmONssmpm.uNox8wuad2wZzexOEhg
 AejMY38dUQE1z589OoA_of83QIX0hujGgPynF.zP8D96mM92AaVguVrHPm6yDgCDXnRhtY5eOp64
 lIuPIp96qV3GVK69IkDyzLwrXs_3n3aEo6tNC8gzmsnE54G0NcVdRsygZe.OBWrEFYGfr9E9Aq66
 ZFW.hfADsfpMDNrMimEBaoMIxN_6QGxBlHwia7iuza2p7hUN9jl5LTgK_r3L6Pky_uZaliofZkqV
 6wAoH0A7E6ntbyT1j_9ittx.Wd7b8xh9qCmp7DAMq5qxe2bommup0lJFyoqMaoTB5ylzT.IavPiG
 NNpGZQPwQ864L.OmuMWUUfinC5iTKfcHhuuwXYVIK5jnnW1t7_ptzvPT5JEAhTVw_feRClAgJu6w
 fVddd1FCxG3GT8vZjEU6.Eq42_tpMqRy1.6S5mmdft1je8H1JIr4gbVDM8BCoBWLNQgbGTNulVl8
 oTY78xloowGsgPY5bvQWYSCAJvKJRv5bYksDc5Q9V2ge2MVkGYdC2gSsoEKqF4_oFWPTpipnH6Mp
 uMJgm5vAMLAwN33.C4rcYdXrZW8XYAWKrkuIAZMAT7viWUVbDXoFaigKXW2mNw8ezPjfdj_uj8PK
 16mKcTATsEB3Q65CfBwj7N_nrTpDijFP19zuJmKwqeYs9a162pAgFoSvfFJ9OuuDzuEe_Ax7Dljo
 iQ_8bARdPPiUCQpkgJWnN15tHA9tKWA0oZ2qmKE4vCa.Q7Rhma7g49gCAnZFwh8uIZiLc.xlaUvV
 jplf4n.bq9fKOP1n9FaBPkxblSUMRllzWUsvh0Qq8k4cqxWH43ukuwbC8VCl4AjCgg3DgUpIHUxq
 uL15PCqgrZ9uPS1OgC2.SX3MqCTsTvc3u5bbn.GCfaCH8X0mCYpLWMzDoMWK2fr9A50Otb.UKFiQ
 JtrK0G99C8dLeT4q._5Mteeqc6MVuPrh9Xdplfh7ym2G1Yb_pUO8UdbyKamsfYZzzmc9d_QDS8fC
 zXOI._X6YX5K41umOIV35uRzkX7LAgn0BmVPAYTKetalIqU59OdMDVIqD3UoE6VAVxOQ_o5OUmlX
 D7dz39jAEyJDrFg.6uFG9INGj07yYYUq9QUb3zCEPVCzZ1bynQxtBsfF7Rw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:15:24 +0000
Received: by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef9dc86edb1f682083b985c02a0ab796;
          Tue, 24 Dec 2019 23:15:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com
Cc:     casey@schaufler-ca.com, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 24 Dec 2019 15:13:24 -0800
Message-Id: <20191224231339.7130-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231339.7130-1-casey@schaufler-ca.com>
References: <20191224231339.7130-1-casey@schaufler-ca.com>
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
index b6d5475f8196..e0acc09a79fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,7 +409,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -924,9 +924,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index c42573958630..66322a2a2beb 100644
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

