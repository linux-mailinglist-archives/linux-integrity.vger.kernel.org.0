Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F954D55EE
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 00:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbiCJXyI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 18:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbiCJXyH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 18:54:07 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194914FBD4
        for <linux-integrity@vger.kernel.org>; Thu, 10 Mar 2022 15:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956385; bh=tmh83u7osd4pu4GiZfbJMQrqUIl/l7Z9iBCkVV4+kWQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s1lmXJs7rvJDfkCZsOLglwFpIZZ3TMkRfYFcep3I+j48y9wwLRKHdEpaLauKKR/lUm9LBkvf4fs1NX+MqI5rvzl1DLyMxB0VEUllkvFh5a8Ur3jmpZSccJmoFHezEcB+lwp3NbCVZvcqpa43AtQNuVMfgoGx6dVZ/fIo9WWnknWVOJEmqV77/Nfkwtt3usk0Uv97FdJTJJma5d1yBCp5ldAsgf6jXZc17Udx1k4LWRt3n7WemxxDjcuLs4Vtfxa8AhJWIPSUscoUpVkLxW9yNCPy9irgpm4+VpzBDrXTjstYrLhFjpWCD3nh2moe/naQLVtZ4KidDrsSGv3P7nGfUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956385; bh=CilM74VtaqTeJCDFFadjb0pK+9MovmYk4HID0FF99Nx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sDKFM6gVVXvHaEp7FSzVQe3XA5fnGXhuCiXqGkXLsR+6ZHImpfO9dX5naVpodqg082K3HqmpeNc/NFZBFzk/1ezlsYWJOtfc6HCixFGpbCeswidp/AUmHcfDJ2FtEnXcOkbwNyCm/caNtVCDs5u/DxkQ67BuFx/0VB3JA9AYnaHVAd4n1qEMizihAmOaruwepOIla4Uv8Yg1XIkyFzzG0LBC5vbNCUaEeUT86aGF/ya3tk8V3iIhK0h94u5NNUal/tRKd9aHD4QPHmEr3hgGDER9SZEB/vBOUzUVFL6mW5QlvmxBe6Ir+r759hdQ/XOHwZP4wtbCIOukjHeJHvKFaQ==
X-YMail-OSG: vH_L3ecVM1lcB5cHAeb_CHZU5UecIaTjkVZAsD0gUCgEaGcom5C4qeIxF6mbEJE
 D_pXruOPgylVdjpdpo3QbRw_.SOMLHg6gtf49GoC2DYRYxNM5rdR3dbrdyUo31OrSpPDireOGhEw
 IOuRDqSQQjx2uXN.E1nYQ.lbO7Jt55eZMOCsFEB.v0Ce6RkSlmqFDCaBg5FYpVF1SHZDhc.xG2L0
 Ds.vuZI1qHMEvfLfcWoFB75ERPy1nLrPZp7ZaF2biKS9PVzIDqs.OXhYy.Twq2FDXsbEIBaArssz
 f5EMdaHGYUtIbX0hSGsHUHoKKdWeUvu7CUZ66FcooJ6jwmQPSLeYZ_.s.rGQfycvQNWxcWih9zav
 3fuIWKiGtzYciJwS5NJXnUjg8mBIEfaMwdZwHH9CgnYw3W1iu9m0oapJS4LovqcaJ41_6M2DvlyQ
 W6ItnerNRGnkByifipgbL7S.XNYp_2I_AkLz9mDVbA7XkQSKym.fEFYiPk5Zt36zhYHtNaA7r_xo
 lVwj.9p3Ce_iTuRE6l9qHtmcQY2z_cZL6I_Yxg0R_vRDxzbt52N6_vU5Umyc6EVW.hhNcbuk0WrJ
 _K6NhMfTO47ygyYBKc3nsCalNruNB01nKkbUSUb4eB5EkAYwyYKBYgLisRBf.U.E7l25MXLOXgKA
 ctfbi_I4XDBC4PQXanUxpnqoxmNuKEiJ0BfXmE2xzaJZpmPPc2o3RPRtH2zf2.E2YKUIrPSen._V
 domV6YzDR3HsTn2h9Vu3T_A7QP.O1KbbJfWXe89X_V8zPU2xJY7rKm8oRdmPTiySE65EKyduoOV7
 AWMH02dhi.X6ChuKqK9VOpnVI6hDAw8DtMAeCUxgSQZOpU4nf_75X7l58MQ1lSgSllBb.50MVn1K
 VPsiIA_MYwMpIvzvI5WngfGcXqAQphlfNlDjD5IU..WUMDXN2O2P_9gLFbJ5D7sVCosnjv__Eygw
 K0eecMtkF7EV6Lo_7PLGX6mR2enusEnpJFXjbR6C8eWqBbnA.5zAlSWIvTxHy4hLYq1Ios8ZEnVz
 F4B5cBTxHltAcouh2RHV.FjsjTD7Aqn0B1Ddx25pdzT9htTCRxR0jGbXuMAaR4R0RB_qW8t_DCNQ
 cAn.AnmNWwEQW1Y8_JEEqySmJ9mn9zHjfqr_KmMdG60TukEcyiK9Vr9h7Mlf6qEl0OjjHOJMuW85
 uuJ1rDfqRE4AWvPS0duiR6nb941HOTDS_UPMuwLj8G2R4nrlZ.FltNEaUAUn0EPow66VCYzhh0_7
 AK8WuI0q2mtJEelxkDjgUNBM0tEzP8uBfcIUW5wMtCUsC5pyJqxaCKAwTkJeeyUDYnnRJiQ6G4b0
 9wzN7IZg.wRNKEWPKJim_qhLvQkj3L1KkZLUISEHdxqjkV65xlXVsfNFjLCTFs.6i6EBbrqGmGED
 fxsraLkCCyQVo2PSzbxGPeiFWIqbhG1OBCmcywrt7BMkY.IjUT0zdCsRXewjNmqDq9Db2I.OGMEf
 179cW6s3wYl0OEbYgL2LIQZXQ.v_ViAutmNwgTvfjRRcMe6WYo.L7FZFZrpX.koHLJwlIJ8NMD9a
 G65TZDT90YRt7XLrwjFvFFgXUl_y1E5N_spQRScCYmO1RKVMpNTNXAFg1jxdunFm35s3xDoz.1V2
 TkPEmzO2YVsCeyfwK105zK.PxJXtprhCkelWZsNsXglHrSuilP97o4L1IqROlgmU4UXXrcp83zhj
 KrJkce9bjZxCTWmzLeqspK9GvfIancm.qP7awfG.8yIbOqOrAwItYIg1vspSmle5JYyDLAIMx7By
 TpK_PABFtVI9Cw4BR87VWbtOyh.rbtGjGXFwPv8lSN90DNNyUQulbEJAOcySQxG7kzFDQXs6rudm
 tREAf5s97kpZ9HbfhmQwwC8D1t6h76hGnTJncPodHdFe5ZsiU8ZwLc5NVYCxIynB9hP5nKO6j0xM
 5xiO_WXHzvsX1f0DaVfRmQxXEh4VCR.q2AOHHsb2y5X_mDVlcIH9nDI1RtTsoAnjM3wzwC_XwqFx
 itpV7M3XSgblZlp27Qpf8oWJFAET85gHUjCirz3pSwP_lCbLYDpizKoKB87WNgB4_U_PCburq1vX
 84JRNspzxaJiJdWhe4AQx2zgIz0RVh9iF_MbbgT2YjC6c9caHIfhZkvQduckbWiyvLnxD9C.ZfEU
 ekqCwApWa0gmEr_HZFEkfCCGK90VYsOv4BZzGI2uCzOv4DB80qpBSXvBYxaTqq8G_agW1vIbyLGP
 _..4ena0rj0f1WuArghOy3ChpWLjDUhPAMwBOucL2hb4KJ5lILPzoyQnGA9iISiiDKsAF07hyqy2
 P6qWvy2ho40QM7pZDdRVNR7EQrJLGd7SQ4rxNzmdLuTDoVdOV_FoL2WQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:53:05 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5fda70cf8d38a19ec9bc1b4fcf47812c;
          Thu, 10 Mar 2022 23:53:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v33 12/29] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 10 Mar 2022 15:46:15 -0800
Message-Id: <20220310234632.16194-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 security/integrity/ima/ima_policy.c |  7 ++++---
 security/security.c                 | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5f20c0c68f67..6fc573d2c253 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -456,7 +456,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1002,9 +1002,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 2570bf5979e0..6cd15abb99c7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2248,13 +2248,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 22952efcc0b0..34ecdd7b01f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -625,7 +625,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -637,8 +637,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(lsmdata.secid[rule->which],
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->which);
diff --git a/security/security.c b/security/security.c
index e33fa677181d..0253c925a272 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1553,9 +1553,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

