Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7124F8A0C
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiDGVbY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiDGVbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 17:31:22 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D11A5920
        for <linux-integrity@vger.kernel.org>; Thu,  7 Apr 2022 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366959; bh=qJztjeL44md9j5GzMPacWbImHBE13gd9xogSfDlUpZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XxAfh7/8Ma3sU8CBI5sfic7mHbj1lmBJkGwksyyQAhNkUWPybaZmf+GYab3jplhmOyoe/GGmBG2ZI8rOFcJvWcqsqPkBXN3soKDHE3Yya0lfGbmH7kUo3CEkAr/XXhyGcfbhPMkWcX6iaPyOVVcWpjgBZ2rVtRyAnfl04EYSjMTkNGlXkCR6IuuPm1IQy/m51QkgI2kadKFyMKUs/FXGYeqkUlnzbyX4IS1i55WF4aoL4cFnfullAB1Vrtse2e9cYtT+AXFWR7FzNjO/ttnqehM4erUBfpP5ipwgEcdtxfV31DcRMzA3YCjYELGrUpmrrYLFsswTcvlb8E3+GvSf8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366959; bh=m1sCbxIkYNwGma454/FiCmReWg+hNzD740GflxNjBzg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qz9/OnmGyOTEPIV4B92ahOjE56P4Zv6N2c55cp4vwcTCCaaQRuoo8lkb7ef92ue1Uh+bnEKK8Yi2TjFhFN/qWq6JssZ8BZNDhZp4NVco7fU8a2zDdkdeCPUpmoY9zhHsMEQTfs0ZRTy139ibJda782YDb+7XjcX2s8yZAuodOUeYqlQC8TF4us066OELE1cmnBmMfKg10WzVyHDtHqms2FtKv4YfS0whlxqUa5GyxgJV/XYrfVtfhKsU5fcI4KBj4/BmjsCpBODiHtTj7He86w7eGUvaOx4JzvUSjYUyQERO23+33fVPt4WURnwOeWu5L6YUUU5fyZszf3eKNuqffg==
X-YMail-OSG: SiMXOhsVM1mAHRqzN9TOZxiHFqhLSHoRLS.E4VNoNW08UEPSbDfJ23vzyGdv6.i
 m87_DePl6fzaGLJwOnhv88S1xcB8HeD4nIs6glrOKEooEhNQ2CF83uSk9rpsfRamF7BAxcoI93DR
 Kqvwn1w3f89M4Yxfzz.TtPgdGAd8zgX6r8Qr5ZdPluzZ0Ms0OsS_aMIDGtrk8iNjpdvgmcs8nAq_
 nkLTzipdZ865cnBVPYW0H3xxAItx11GKm5yA0VHGRxVCD9vaMF19c9MtMs.EjRv5XPvQtjIwMUef
 fQ_vXpjhLoIz__c_TKOwZLNJeaj1lwbRN2T1_dyQsjET18c0dqxqW6_VNhdT1SST_Shk4wx6wvRB
 t_wHjU5.3CdBj.YvG0aRARP0iz1HN9xQ1h3vTKnT5ypaH264DhxPNr_K0QvIpYsTQzqaVv8NNnQc
 RY3uNAADxXicWNn7k98wUlSzFKMxZVNnV5SDsjc6GCB0WDNU.j2kRubY7yM7gC2FbDz4OhlZHYl0
 7Llraw_qAPszgX9kVio6GMjS.Rg_KI2zUaHSgd3r0NaWPHpRbdsp3ZXA5JplCK4Md1EWJeFTqj7v
 6P06YT56hRwyuYq0eoo7PYZVoAPqmqEXabcyWXeI1Cu0fE_U7EU3dBnJj5jWfPlJNFgPzv2NxtnL
 tbB.55AGVhcxQ2eVmzeejmc86CDzKtJt.BACB1Dszu2rT3K1lMORu5vp9vnw4IZwA.VOK3KzUnZ8
 DRjzOlt.pfkWxhV5e4QiJyorW2IbNkJ8tm9pyH8lXMTA.IZX2etSWqYVUJP0K7cCpmC_8IRkNkJH
 nZ24DJPXDw7IQd70UD7etwgJRNYYyFXYNEdMdoDa12iq3dPPEvIJG04dJ.PNbCYmywBLvvF_3OdZ
 T397P6Nb3MnFPd.83x.1bgXqi78dCbqcUNGSds4k2fYxLwU9F0BZPKRrU9kzOlyca.52VWONoOIa
 ev38RdzxQMlP.VoOs6u1xojKOgTKEHvmT1C.trxLsycVbtU3FtVQhVpzHjlNlvsZniwvbQc1awys
 qyYczrBHUUV3js3PGs4OW6eOG7s_ndiUgzSUKU69GMURjkTpgJekLA92OPq5BFoo5ZfaCLox6KG6
 oY_Yb8HB3ob5fSLZgyBKBnfZgES7VLQx5d4pKYd07RKEoz5Bkok0DbTMPQfkolcRD9xVMPr6P1uL
 EOpIbW3EhHi1kAsi6gPZIb1NZDgU22jhsYMMqi_IGb04zAvCHMXIson9h0cVY9xVPXcel97Q0Vl5
 hlVL.nAG0F0UoK_uHhAkPDhUGeiu1WWs8TuhqBYCLxVCkvwi7erTU5qL0aZTsDe_YAo901cct46Q
 gbVu6BeeZd8knlLbT5pGqTHXUXnwVBAv3rvmFgL8t3iC29wKGyB879uBj_qB4bT43mNCAkdChYgw
 fxF9g9m7tarAq1q6N5VnIgjPfcoZuW1ZWjZIBC1VGlXNyfrmk4ZJmHbEGgwhY09LdDPb7gTt8PEf
 SicZYVZi5xr4U5vMrX.uIgoOjBW1trUwE25h7_STRXfOxpgfTp1vi58La3bxqKOhUHduV_2u7M47
 9yzQWU1.toYDD4QED8Q9xNCfzrqHZ9l7RfSAtK7zbJXSvjGMm2apmfmX7Yjo3WW2L_l7kBPL3tCF
 GNSWy_11zDd9VPN_FcEdAujZB60OscEEprF5Ix6376ieKXmm9zLmAFQPam9SJ5SPBkCUKaDZF42C
 b_DEs5uj8iVDVjmPjtZbOxJa21fSKi9aE56m18KDj.sZsypt3JCeNcl66cadoIqbTVTbwqRSIw.M
 rOjDj6iFffIrBWvsyRzC42doA8RXwOCt7kpESE8Itjm4F.PTkRxOXyvQ180636betOM.Bz1OabCL
 ve1Ev4_EccATOLZPvDpdZ6DlPQqlKwKeFM7rbr6rS.7ci47leEIGb5477E79ffTXd9cIyzuVmJl2
 1dQ6N43Ct99PdgibYcDgqAHibhxgAonSrouyE6QWNgNSTTO0GjUNrrWOHZmGEg1p0GKDgQbJBjsb
 Ca22svJzw8a5qphJkySQnWxvZU.9UDifvpoUiHymjP7xik0Mrq5GPWxBrNWME3mukEgILgdjGk.y
 GrTcOVd2Cgw0OZb1kq3CaX9N0MHS9kDCG3Qwx_NVoR1XfJPdDnH2Qy98O7Rq6c8uuhRA17K.0VUH
 mEKooXrkO4iNPYe0ODGTh9MfuzMZXx8Lvy.0OetO4ine40WjQ.6a05O36xyBIGDau7Tor7m9WMrY
 L_XRKRcMnPmVvQa9PapUpZPmv0axSUKbTcfMHLM9apHJzLrMgcA.aSe50pOvG0aL2nFsSnJre5VE
 DDjM8qX1vLsHaGdoCJRQ6vudxgQMmFc7qJd.qeT9BugQkg1nH1gVkEzfy
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:29:19 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5dcb49a390aaddbe04fc320d63f58082;
          Thu, 07 Apr 2022 21:29:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v34 12/29] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu,  7 Apr 2022 14:22:13 -0700
Message-Id: <20220407212230.12893-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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
index 10ff7db2232e..44c92e1aedf2 100644
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
index 5ad606cc4814..fbc0895a1a93 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2300,13 +2300,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 97470354c8ae..3deedfb2775f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -624,7 +624,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -636,8 +636,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
index eae5b7f3a0db..297a6be2e23a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1566,9 +1566,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.35.1

