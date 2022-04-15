Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273245030A9
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Apr 2022 01:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355030AbiDOV3J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Apr 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355061AbiDOV2q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Apr 2022 17:28:46 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1F35249
        for <linux-integrity@vger.kernel.org>; Fri, 15 Apr 2022 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057891; bh=qJztjeL44md9j5GzMPacWbImHBE13gd9xogSfDlUpZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bJLC7z5my/XomlDO1EH00UKa8s2smr73PgRTM4fU/lS1/WMKIxMZXd28dtQfrC6THe6Kz6ixMvcF50brmmBcSNxfFxdhPOrFUFBnNvSp6DLZIPvMyStM/NO/VLiC6HP58kJWD4txCQF3hfysp+IzF5TJwe8hQlaoGKXscyGjG2CzvhFsGg15IgNIeuL9Pe8VTEY2RHsG2v2PYiS2SUohCw/tQq6hY2YL/ykiUCnkB0keJyBOlf4FF3Ss764t1Pp5hbo1T7awjF+nUNTEvvriVF6c987+L/Q1zJUOT70c41B5UZ6F4jTyDXCxYeNAKxa+oWkhBTcsvut/4AlRbLAGSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057891; bh=K+teIgNdsg2N1IdnZSBg07aM2/gEfaeAO0pabpxeI9+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=j/ghvkhJMtknHR8slHcIKZSwUCfct+Vsat0G6lxLAF0ySB9xlrOvtpZ82vzXNKEcDsO8GSpjiYqJ2JA8X72jCTAOVWBR1HKiEJb7Pwzqd63ui39VGY152+FcVLZxkVpxjiiWFZT9uR3+OAxIhVkjy9gEFC4BtmNL4xWQh+gMAfp2F2bqOdTeaaMMkUikcSNpBiIBmqPVpXVUHEjcCocXtlYmeH/y94kJ6sGvNsoT1pbO02vkBE7xtRoDeBumCXJNyR1NXGN36wQBbmnr6IaBnTjdism4/v78XFY5UvA/9r3kRV/ZtCOjsVRYKiNEguM3PM9r64Iez6aaCQvmhLiP0Q==
X-YMail-OSG: SzZdLI0VM1lq1fJDS7.tyXt3kRbdtH4nRuWkweelcUdjOjb6n5gQvsGL98d6Ri7
 vM47RAJVdsyotwwJvg0PumKrcMaGfDU4ZIkOEKSE7ts3r4NHr63Hjc7goGaFHm3JCd8BTvqxhoA0
 Y2GtpMfBRbYFaugMwF5zUwTwh.hOUcxPtoQdKCssSm1dGqGObburWn_bgFATJdjmUS236z7jG.k7
 L3RISW1fWXdxWZPgvSc80ldc7N5T8dbc50651hfafZhGWWFb6WV6w6eNOw01ryR5Q78B0lfUVOQU
 vjuTzWFKIPZgYD3thwT0D3CVIi9BNtRLffftt8K_ZC8mryE5ULqFsnci4sT_VMVXNXoT2c9pAPKl
 hol69VBfrE0pPSWbVtDI8OjGCF4UR7GWXImH3nM3e_yHnDn8zVPze09WuvB34SsPomS1X2lcONBZ
 cVPs5WsMD7arB1at4rZZnUNAOHEsLQ_kh8W9uGiHWvn6BM_6smZcawUIAhMR8ayCazA5mqrncW8n
 qpUvjbjPa0v42zSLjWq2PyoOH8GTQpn7.QdMIeIE5W05YIBDY3oHTFI27DEyFUU_LbMtJflS0zMd
 oKcevc744cQawvgWU5FveFJEB5q_lqbIiVvBxbZPxYmeCg_5fm3Guxr1ASSECUzHYXxTGtrMNA_a
 fuuLEjR4dyiANlowgT6A5Ohs6CFWXkZA7zUhDhx6HjpiTKhmK9CG8fXLziuab2nsL_6QT019irRz
 z6JgHs2a_STUASz4Cdzwi1Y7aZ5u6xTvG1yd5PhYQes4lhVT6lL7pM90CH7qt5n1hiC8KOUSvjEe
 hSWArAa3u09SZXVpwRyb0KZuIZAFJ1r6wKLz9PoKpLuCV.4hL0XDrB9RFIvrPyf3kDCZX7PLzG4m
 WAQG6w1dA4qoHQuOIZfNxnf11AjMLMcyjAfwZhpFKyjzvMTqGPbSoJHSu9S5L80wZciNAF26z8ms
 OeyyLLTtPTa6Ho5hpFqoqHxQmD38A_iA3szM8FmWrhSXWnRAv9FqtOXCB7bQwx4cgBK.nXLUwJnD
 ozewsVkd_5AvMxqsVgKmjAzUcfEVkg9ErOoSyP5DkYRpOF10tAcwkYEkmRZNLlyN_3RMfVgQcY_V
 yUI9mXVQ_wCtbG8nycLL1SS_py6vo4TklwJeogrNGqW4WqTFYX6xNlxQ3D2jXc1jmAl4ZEWF2hJe
 p45uiOPy6F1XR8H9VExIsNpTzR50qET61zruSw8rPmHbuv8hu1sPgpUZwnHnESNEKQp5pVKWWgtg
 mOdxSM3Q6GPHefj14kFlnmCIkjr9X5HJvSqHWw8H3zYYFthrz6V4KLqHyt8iE8Vdunhcz8qnDVZL
 nu_re7d_yQjDoau9Gzhm_yF86j6lMNT6F.OsQPW6Dz7piqZqqbnQxW27_9cUJav6IhuLjEd39PV0
 N2dWO5C2PgrRDVCJo7s447ISAFvlIhosd93_.uBzMt.3GlMlfhsKCcuNEoVd4OpQe8zQTllAHbyp
 bfVKyKOvn1Q3yi2lU1s9id2D5KrrllHAYqbkiAdBo90kbm7TMdIBxD24XuD9.1VrFo.KkDIfe5te
 UMX7C4dgPEJafJGE7ZqS7hzYPnDIHE0mHKMvkVF8QezZvf8_Hcwmw3J_E7nuVOLK8s64Zw8ox.XF
 eUlSRhe0ZnHeGLhBnQMvs7rBoDrMW0.q0zhgYkh1Zngrk99hbSbxNAOpKcELAAgMYztIflCdIyUi
 r2rPWKngXPWZTt6QNdk2LdUvDeL6ifx1UuGVw1I6USCRpCob.ePQhwEeYiJT5PrMR2808wE81sHV
 .aCinIYyedZTKW4Arz5CzzGAnVuW7XqBuE2rAFSbpFnVmoqwuCEyj0LNVk1ipkTZOTN.BckVGRjp
 EsCa3ct3PmNBMlfCJMk03AxvyPhzyQk_a4rh0CbP_dOaIkxQSzmmUrlh1i1gig2IOinInR4OXbmP
 wOtWp6njGiK3595fr9yq5gCkSQZJbMJFuUU1l6xkSeBdHhtgcmMxM._hHwVRN7GMGmGQK8HR3696
 ApOEeqGY6QvKKzwZXW_OfcTSFeQvV1Szrz.2m6RlNP5TlHZyonpUDi7FlSPsyS_sVEIxOE4hzduY
 sS0uEolk34XXap8gyvv.Q2knOCRP_eaZRxv.s9BiZYLuEPpufBF5qNGt49pMG6Oii5ehpWwfYZGc
 C.CSUtFFhnYp3CI0pHXy2OM.1Mq3T5TGjgDFwWwVGVUPRfQxW.KNNO.3LrGRVrK7dB6mJxtjuAJt
 KoOVlOxJnQ015ee7Lc2UaiPFR5UD0dU85lS957ncLTeq9xx.DJ9q7SLw8JO2avTkbkkhiW3C6RAw
 Tqer7II7fbS2Pfo_vn5kSenDuOJ8OXOmdGNuIrV0oLt21uLhntWJxigeM7_wXi5F8Xfe6DjTOk2u
 OnqWi
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:24:51 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-vddpd (VZM Hermes SMTP Server) with ESMTPA ID 7e2b2946fba71fdc86673e46e490ef4f;
          Fri, 15 Apr 2022 21:24:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v34 12/29] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 15 Apr 2022 14:17:44 -0700
Message-Id: <20220415211801.12667-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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

