Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB1417A87
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbhIXSIk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 14:08:40 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:39364
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345715AbhIXSIj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 14:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506826; bh=NSFipKtBBIm45/MDEef6cClsYrf6QTE77Xh6yL0FpFE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fNknNLA3lYmvdhxrqDKdQ8a7wO8Fob0lhCAnyCbKy9hvdT9UoXbQwoLRC70BoVC1pWxFZzx9mPLssi9kEn+oirXgwE+LH3UfrIjtl1Mt1+oTrwY7ISlll6GdTkjchyJnD7cWgzOufd93NIOhWd+Cp8rMXpuSa1cEfQQWrpP1Fzlg+6EmkwVjlbb2iT30h7G4I45J/l1Nt+0d+4TqI3spkG5ipmlCSFt+DllEcvrXRZ10vCldQ2uWlJxxpD4GGlj+c75Ksi1qRUFG+gTOWGlffGgTxzogQI0/UDy1sPolaOcQodfaKQrWOgG6dyzzboH/Qh47SfxbuH50km9YmWRUJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506826; bh=4msa18yrZDHcDr/ysBzWkUKn3IVXkXJ7gsCnm4heKIi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cWilWyRLSyoXeLsGI7PWptmQyVjO5Cwp9pnsuJiPG56sr06Z9qjQkrN0fVYBSAo3xa2R36Ru/DykxvZ4o9Rggn8Ise9YNKxOnxUGq/KlhxfLqOWDCblHPGXJZPIovPbSodep6Te+Dvx8WwVa32DUZv5WgOFLaUigxHY8Msm8V/zIeHxbzTwaYrzOwchMCKcbIGtWZK0Voq/+91ESSEF7+zlE+SGDnExZ0kEA4i6YLbEBs3aYAwHvX7XTvDqJzo2TfFl++QAZBBMBcOULd5hcLFIkh/jKsQci/vsF+Ofge4mpBAfefziUugAuLgd+OWSL4hK3t1t5ZxDMtiqjZk13Zg==
X-YMail-OSG: S4r3spoVM1nia.7i3N9a0pMdtqHJYFsvhlN8i7XfNsveKkChgEGcecLCLJDu0x0
 Sd6bHKFLrd5G1B7_XlS_jvZdygAR8HAKllBvs_e1FduCcdNzqdzYXnKUvNWmFOuvBGoAOp6r5grv
 y.3Rntsz2789Sfub24lSoI7XrYNJv5ShQOWDiGEBOuJbI6MlNFzU3siTqCO6GcIhKOpux0_1KPGi
 O9rtxXLTNGr6gUihZnSalqjm1jIwISfLrtNI.KlHoGip5WDuTyX9pLoJ1mcv94zeoekXuWks0NIE
 vA1.Acyk8fbWWFkhcQjoEVTNnjAwU9G7LZQjAkSTsNbJlzrU5oB0jQ_4Q0w3UyNNidaqHmgoT4GU
 MJC4Cm70obEO1AAjH7HZZ5czLv4w_CjapVYV7dSP6bytMS0y9BKnfdIxMDNV3r1A_VxlTeogapuw
 QEQHeu1.t8vncxTnmWnt.X9rHebklKhwsg6USy5HxbEPzCPOIJ8osk5NWK.orulrzYaC0l9kPkJh
 wx56ShyST4VGBAPA5Mq5lAlM3VtLX0M9d2tG.pt3Mul4FYX9f_d6bqouLn4tXH4VYlG_3zD6_NdT
 PBnTmU8f0eNY1LU45zkk1jAtBzwUWaVoN7E68PlLKnc6dAmy1b3AMnWToE7vU9jLPOMiL674I1XE
 Xu.GjKSjzGOX0HGcsCv35aPyNTjo_E98J9ZzXw9G_PdApXJ5gGgzrW9VQeB5n9JZjjH8Ape3c.hI
 t2Q9B4xohrybloml23Zhaby47_PGWUULeuUywQey3MronKV8ynBAIkf.xmIFGBsQ_y6wtKYcTrcs
 tkQGDkIFN.DlrJJfe.V5TVSfFrPknjP6xRqfez8k1am4.pHEZWR5j9KyWNT8pTOgrL2MKDT8LBCu
 mJYL.obbpSeZ6nrqCMJIFiCxFG8xPlWXCXJ4KCHBqo_7Uw4T.OWFLs8pelHU9A35GE4tyEBDhn1n
 yszpcc03ztovhr8Jxju98NVO1GntIA3IDkpgjjJwbCjOCUL7YAaFXaH4tLi0Cqwzd_igDVGJJxqY
 Wcyo9dS9iDA7576RF8YdFTJ7yQaGa8PcZQxG0dhJPkzMTp0iSd7HXrOGECm1SU9OlN_t10NucZKa
 RmEJjU8GNxJfp.OlpmkdQyWnbmTTcy02HMM3qA6zYPNAYO.XoEbSWGHy1fx9Nk1BxSGgpvLCzRnb
 IgRhebwxIEoJUek35qnInrzKhqkbreSf8Wk4BdcY5mjtNaEVKBACgE7Q_zvgB6AxCEE9h.xFFxCq
 zDkTjpq41IaFDhuxtJzEFdYq2j8oJhvJyaG4talNmSPSg.mdNRx7ZjyUf3qGf9TAGarGmiUzNfCh
 arIzDjsHg4IZvMzYdVQoMgGizaxedEuFWrR6FrF5tedQFYppdMKCQy58cu5Fx2bkoewVkphsQLRc
 iD5_fgg2j6OGUsKGDonzmEaaR2FRvyxGqN755lfJZyI_gSIN_SFs22gV33BybwOqREt4b36Uq_LH
 1nRoyrkbsiBxZJIcKuCCyNy4kOmSUd6T_t58EkM1jB38tbm2.i7huXX4w1Zli3mb2gNB6H4SVal4
 7PPw.LMZ09STH3mOXjDOnBgZ3DWJWuPapVwR7HnAA25QrTv2L8NWDwEhsj42NUlW2p_EYyuooHXZ
 EsXruqYIeGOkjjW3ltOp4eP8.mumRcb9yPusb_JB0dDSuSG5X0U1Z_aSEj1bKBjFOBxzfbloOZFn
 mZjcqaTiCgmzfquUUU6GXZO5thpXLVzRqVnkpbVepTXFK.FosunC_ADE0i7tpm73HZx7OWGXJCzO
 vpZ_X4norddkOIMEjTFJVmN8c8zXeuL4frgO8pD8lSAHMZULtXMP8k4ushoZpJ_0ZUlRNnTm60WM
 WVRDBb4Sek4xtYTUMYgxBZJqhk.bLW_YNFxQQgj5o1l8WcV9XD4uZduU2LeCyCg8AbT.b4ncAXpS
 scgSJiTJxuQq6v0tv2es8XywkXxrgrm1uS2drwVnlhs8C1q2QPknbI.qjVvNf1X1Ipk.EGW3UNb5
 LOS7KEEQIwKj5e_zHFaRKVplR5Uc6A2Y4lMim1RXf6qXsB63tmFKT7XWH_Aq9f6qWmgVTy5UzwUV
 WUYs.CSJ9xdoYQrfK1V5.ik4ezNeFS8P.2muYI..r14Pcp.UB.TadrMubkkwryfGjctz_BLRaO1P
 MD0M.AkUTPRzznCP.PqDrWi4skXLe_y_D_k61rb8wCs93X5mJCkm5LG4eLM_Zzr_tvNG2V44w8zy
 YELP9WbW.FQ1ms17WujNV0MkfwkghROoBHSg2Z.lU.lsZCd3rCPNZgXsFFZOrsZyMq6xjSkmJZgr
 LCawIHnSfE_zKLECGksNdu9jaIPzPJyytJBTQnwBBAxZPZTGoLsxy
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:07:06 +0000
Received: by kubenode586.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6a336e70ce257ef3e6f73420e83310a5;
          Fri, 24 Sep 2021 18:07:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v29 11/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 24 Sep 2021 10:54:24 -0700
Message-Id: <20210924175441.7943-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index de70742c30d6..5a336fa10818 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -455,7 +455,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1006,9 +1006,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 50e3f2f4cb49..dcd1b988a2d3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1975,13 +1975,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 3d9f051edd20..67c7762b2533 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -620,7 +620,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
@@ -633,8 +632,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&lsmdata, osid);
+			security_inode_getsecid(inode, &lsmdata);
 			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 74a7fb981904..5fbcccbdbccd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1549,9 +1549,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.31.1

