Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAA2A7435
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 02:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgKEBAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 20:00:05 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:39370
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387968AbgKEBAF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 20:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538003; bh=kp4dWfdwZR3/duFNL35a57sdXSJgVd0rWpqs628JXTI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M57DjVQkaepIMMogIIO5Ipx8xGSulg7nWaBk07oVhEFTC/BXum5c762FDvH+T/ynUGGomYnP2S96uwlrUnbW2yIECDaZCgECLiaEg6fG8bkWi7gKfufW0NkZVE1Z3uoqdLk+oOxYeKVntOGxkl1ToNUy3XrBLj2Xaff533aE1/fZUjx1Gx1QK88bkHMalmjlOgyp80F9zJsOqBll+7uOA5kGMG8+IuP1xB4Z5yythxeRteMrLAZFWVLir53AZ0WSqxgWwc7Y/qam+IPuB/D08pSzHUedOAXM0JwhZ/xlkUH52jEKp2DTskb/wGMDossPmYg1bUF9yPMrMtoQyOZHxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538003; bh=lyPT+J6gpRSd0MW9kH4kw6fZxYeQcAUtgj5DAcScSzM=; h=From:To:Subject:Date; b=M3xsr+qjTsPFkcRjhFbMw1TTM8tzHOLHWIFVrzn3joXpweMXaNPJzrd0BgE/0SRyXLbkQffNNXUdlJfA82Y8opNEaH1EWM/DXh4R3zyGDo+1iWhRLKk57OaBA4YwQ+8ST6AvYq+03UTIP1wUeBbJMPEmXu+Sx6F0klSrepVnAhPgucJWgZb6rtabkwQWghPMU9OwGg4/9IR/WuFWiecFRWH4zwTpCKoyq23ldd3o8HgJ/z+kV0iCiYN1BEoDWcAs8Uhe9TLK+YmZJBOjQlnVQMG+40HU1vMvmaAazfeQ3iZ2BXMkZ5sOd+ldpRfQPpURSxzEEQgnpA8umGijak1YgQ==
X-YMail-OSG: TU3cH58VM1nTl5jx1Q88xtagXxHMH_nm_SC3jiKmiuoC77I16zbsEISA_VB6t7a
 OwT5FpGDcTsxwI21TtcTSEvoli2HlIlhGtWq7l5Q7UK_zJnVwJoNGtUyCH4eDGUjhe_yFXtZCs1o
 xUy1LNUHKQEiy4gG_nlm_hrNqkwUcMYDkFhAfnXvZzWCbdgu1xejmDe.9HxIMvfYOTTf8tdfZarv
 hC_8eHbeUCsLYaEcdJsqJEnJJXiBYQbLd.lMTrWcU9lwJjMOfShYHKj_.laETWTGhy8JqxN6w6yC
 za6zvGkFuux69sRnFbLD5EYZVXxGfaLr2dgjtwx_wYHbD2XvnBmPSyAx5EYYkV70SeWf3OYvWv1_
 oDY9XeZ8E4fqICbMMXIQYNUtSMs.zHPa0.5YVjZSFvk9COndhCcd0LspBMXKuMXt9bOtNVSsOrcp
 oTSPQvB5LdVjGyPs46uH6ujX2ZOnof_wSFyrT4eroAz8XGglCpbLK4efpG_rSY68.W5gk4iVuGhW
 LU26fRLrftvpC0Kp3_fhn0oZ2BwuIqpI.Ez5K4sMsv9qIQ2RKkhFHCQoupiaBNIWwuMHuYe.BFwy
 iUItgxGZdz9VdU0n0eDfsIzOtc7VhP8of4Tm4AtKAZRzCAe7utART2viB6ttA8GSUvoin71F3_QG
 E21yD8thn8Ayi52T23SrxuOzbed6CuppoS4eQoG5zgKbA78lgZ0.9saKBiqtzhhGSVzFA7Foy2Nl
 uACLvy9Kp8jJzNAz1GtIBQg6IbqyRyv6PPVk10vRg2n5SgqeAaHgjQVv3hUZdVQhJeDbSEII3ViF
 WZ6PKySPIKOM4rPE_VjmLrmagYPwCEIy9zHypGSKNDV2fDriXVggGuqvy7JlIXJV3OwYVWNz6Zp8
 QL22_hbi9gaiGaGt6.szxqmgpDNUaWQXBLu34lONa_PdTSUk9WY_qx79AxqxUwUpZJ6bReQt_PwM
 HOELkVZ_7gfFq4kXA.XYY4QrfdUaruk6wPs1xhMMsAUgrtt3XAdFtPbZGxxxVn_9NMW4yQ_AsEl9
 PxJ89bGF8B7dTt8mVv3Alb6n2_f9HFsM1EoE8zXcafoG4o_1GutwdD0JdAt.kFgYuGjK68pT3e_W
 s6oWgfT8jQMxDFiDUkdF24RAE5S7wzhJa6Nwn4T.3R7v.EAKCBJ9G6jXG3lUEnSs_DXLLtZ8.lqR
 ECqfW0lNu6v5twtz44OxsXBwO1WJTAHbbGGWwNbJbK_3Rhfz.SChjm9ylCH6tMiR9ZNuljs74EtL
 _v_aVP6jkkKmiWqbrDVhPPy7cEI19SLQ9tA6Gxwx2k.hlyKNInlTopPkQvCeyNxkCAcs7mLfOddC
 QYB2YzUaWWj9l9U3hEeQlCOb5Ogb4PmAvbE93.6Sg8LPoUjEyEENqOyZlG_D86rbcE5JS2YKLtBt
 I.O7YPvW7ICl3m8QyxV0QbiIINdg3q4VcT0vQKT1Av1kChHJiArioDGq9A4lzaLU2y3_jYxz.n90
 RXt.ra2JtZpQd03.K_Q9u1kc0FxLV9FvanMxibNPlsPVPR9owBAdd7VpBTNZm6UaIWmHQCo5435r
 Chr7l.DcU3AjYIeICqBPYSd8KkiuNEpygh6Vt9q06y.4mR2K.33_ZHEh9te.5dt1EWcnDd3Y8mTI
 o15p7H.h.V1AQ_CpXOrWfTFmLMnLrXaKg5Ak8hAp4nvN7nbpRS83kqq3Se32agU63FxaxrBr93Gs
 tKd8zjSjzd6IhyYi3AOZpI9c.DWEq7LkMAtEf1kC7w29EsWvvVKigpL_t1L_zNOc8AhshzxCa_I9
 FwLlrXFLRRo.tkD7JM7x1L6PKwfupUbJo_SPVOYMx_z.vyxxRsXfjPn4_f2hcglCvwFT4LOJ26bF
 P1sd1JaTHGq.9RiRhGHmLcPtPmYzz2yZUBK860cZAlu9VBtIiSo.jsuWa6WNxzE3MlrEmTNhwvl6
 J7t6VSa5RxJW7mETQmEMrmfcnw5tBCo_9uuyKyNXRaN92SoOUwf9cmsRKJUgKa6pp7EZj_dtaCGh
 c3vtLR5jaG3z35G2r5E2rCTiigvGWBkOSZJgxxkfc7eXNJG0Cc73Na0Ol0xLSGkKlg8.3hBgB3j.
 97sktd3vk4XH4fggKcUmwTow4kDSzCbNO7SEDmCMZld8o..lYu9HA.wnG0OsXpOUbw9t4P6JJNvt
 nHB9UDqbcxfbNgMRmK9czXfbtIJTBKP1hvdsbL76pwq.5BHpyfBVELQDI4Lt1J0WP0FHWce3qaDc
 g3YO.38gyZHUx583zGQvI_iq773N0tXDr2UB4fbaK_9Tpm8OOAy.W9ZMgn4_O0yW1fMOtP2x4neP
 L.6O.A0iD.Skxt4K4hBR8wkVpJKJcUaVOxXMq9QKm1GTZyHhV6xkIs89LM9nZEeXP9U.DkaxaZeE
 sZZmmbLHI3TSA1Sq_PexUdZpeAWQjz78wI9XReUltrh0kunqmzmal0oJgrkz6GhNyN9KWrJUbOmR
 vmT1b9oogNzxmOb551GnsoJm7kr11hlB0eTfWQkQJQK3rtC9ntO8OIq.jX6QGdwRIAZ1jAi3MGAr
 73Sd7hBX41CLKl5a0YCno_vo8nLaWOXhjN1x6WUkfEuSUWTLtSCnsH.pXxwSNESV1JaH2jkcBDz4
 thhljf40fvPtHatFn0I3DFjCkq9IrtqiwW3MJac39zHfZwU7RyaGJugrnsFrtQYgtv1XJzPAZOZh
 WObQy3qUvj6YoIH3MaqaoEu2dv0ES7.SdnY_B_5JS5EJevsFCeUtC5OyDvVNsTL2khaIGSe0Ow3q
 xs0judpwdsNXqF6lrpTdvfFwukHtBc3b6LCNqqR06Ue9Bez_d3lqrZ94L.Cuq1XkexB_ELcY2lcm
 87EtSA1AMULyKpSZPiZ.JdQ3FlLaavo5KseZ8nVrwTXIJPfbnW9zviotQPoLnAxC.B8yt_gF639k
 dNLCchouoNLIFF.zjAPNfO4QDrJUCgtd9w1BX36erG42vChLjBz.QG7XdtCAA2zAX25AEDD1cTOB
 bAPaJsGNs4T4IEvouaY3UnyXlYLRA44sh5DP.UV7OhICqroKG_.BZTnykQR4tZViKgFYHp4Id.GL
 vEe3tA00f5yPD.AwRB1L3HgZY1.TPsxPvCqtz2WBTYU.0SF8KpNvE.2ocSVIUZOjgxhF7g8wgZmL
 aKppON4DUc4ym_s.ugKQGc.rlz8MVR12x6xBfte237t2An5s8fxoeN1nLp8N6a4REqeisTm_wcEr
 AuChv3ZCug0cP4UeuCAi4d5_.72J111hEzIBZ.FAmqV6r8priC3WjAVUx41UWqeuVFQyJyzpL2iw
 sKARHbK1r5vfwj62K8s3SxcVSL340nLH1WdzSuIkYoNCgpP3SVwaX4Em2BqSduHBlFLBmGcxJJna
 xNgj0UogCT2dViZptTgcoypKL4Xu9ONPE1hwX3Gs8RZ65RoeiNYCTu9HRqD5K9QZzniGf3KUQ2Vk
 C
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:00:03 +0000
Received: by smtp415.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 600cc41e751f00dcc1b00da4b488352d;
          Thu, 05 Nov 2020 00:59:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v22 09/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed,  4 Nov 2020 16:49:10 -0800
Message-Id: <20201105004924.11651-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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
Cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6b9e3571960d..a7968dde27c6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -436,7 +436,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -963,9 +963,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 3e47cc9b7400..bbf9fa79740a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -561,7 +561,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
@@ -574,8 +573,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 421ff85015da..f3f6caae392f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1443,9 +1443,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

