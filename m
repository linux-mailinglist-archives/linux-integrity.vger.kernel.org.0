Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429013D1B12
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 03:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhGVATq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 20:19:46 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:41783
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229975AbhGVATq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 20:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915621; bh=88hEcSw0zf3tXzqlcfljipl307HiQH32cYtAYnCYsn0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cN0Qa7mzIXweUXMmKAqXBsF1/4cJ8stnR+Eqy+BgCKxz5SggIvLEnduUIKcvsXNXMPoemK5xEiuwwB89VEnD7Jpu0o1q+zCZw4kUBO29V35AQ0of4/VNfug5S7Rbta4gPDvF9t0vsAfttMqTScPUUs/gl1cMRnc5cxGaQRzXvUXSU0512GbPnbL8BFGl0x3fFcJ0kGUeU0FicoCKHHatAok4Bcln2Fo8n1BuloZuMi3NyLlwSE50/pQ7zMSk7DbHWFX6AuCRVB1+BEpKCPwefIknxsezquIwudXpWKP29igyrHNHDvqK50S6Gdtt2oOwfC9LFSzj4qiH3Ntba0DnFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915621; bh=G42p36VJKtGITi4Op10/0IS+txiN/t1eb3RNsfIW0nA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DelmIf26oETyEPHBkFQRaQxemfWx79HFSaW7OWo5sXcJVPXyN3urrFq+LlH/ekXXKLt9wSAGJhiKMOcZyVUsnYGKyPDr8OjREhNASd4c1mrs8PVdR5szYhQAv8rS1u/TlDEkvq8hj1kpblPqX5QpS0j/BB1Pf32FLGWk5DjKGVkY5JmzVNUFw62esm+lvs7z20enFvjFhqwBL92DonP+NFUz/7hIk8OplGWBtAD4+nKfRdzzHWe18mnX8UXMYIlxlJ4bDykssBioGz638snPwgt0tjUB387bfVtRZfXiZwwJ17sLxl8xLA8DqSbOCLHJ2UxpJBV/wSeyPGyxKGYKog==
X-YMail-OSG: m5UZ0fwVM1kgR4pN76wC._VUEt1RzvX1y97iJ.0ke2WD3n2tXeGqKqQOjEWOcXQ
 Ox8Ho7VoT5EisYr0zub4F9kGPCfI9EyHJQ5qzN2c5e2Lc5KIqqjeZmL1uKOoH4uDvmZUCMO1q0dO
 XM4E9yEfvVgU8_9lfFHlMMQ5MkCFTmaEBckEHVFxlbcwB7ieJA71ilTV4SKqzaRzvEs.UphHG6K9
 lj7PFhf8WLXLcnIl7KdVB5VrVX_iKGwvo0Kpal0Xp02lUVXk64yL5LLPL1lwAFyV5.WYPknEudGQ
 eJp8DTywwUijfgVwWgb0qgixXxywLji60eba8XABDBL2CsR.xjNnXkaj8Gde2F9VcZVhRboo82KJ
 jns_0rRouCz_yxQYthe3TGAORohPAOTuekMO42yqH6087LG2ghUVBO6X39JV23ofn_Dvx6VGzJiO
 YK.BmGSv182jZuhrKxHjIa0U2jd0W3qNlgQSnqJiajGkAWnDFpzPaoQNDCnlyNnXZx6pcQyKWrP7
 GL2KxiFAYC.NzNK6_a_vo8J4Eta122RptEBz96vekeUuXSL.Zcq1lbtiTeT0m4k9IfuWsci61hzN
 WC5nleA.2fTNuBg9KsMI1tolQ.8lB6TwL4TyUc6.NVDNwzhhJ3NE4o53pjQe8f8U41EzYxPXM7vp
 ssDnoijvBBmhItkTM07PPHdylhpUUe0gO5F_rxywbiIfmMrHLbWcvlPtAD0ulMHry5DEd_Wwwpis
 VxdGzMziXI7mqNRxPW3aUHSBnE7Rb6s42nRl1jY5Lz9GLS4Sag7hUeawUDfOj2KKgabXN4bxfo6s
 WA6GmF8nID7tbhtfOEerLqpCxaLsQmGljOwiyEiM6ndOteZ.G8.RNA8ya64XtG46W8Yjmt.25oo5
 DA.NWnlyZ1qjwQs8W4R6hAqm5UPK5wt9nUPZNGy_WENC1EiOsnJf9AxsN2FwAyUXx4P7AnYnxiUE
 .uvYGlTyCPpNlGVh2ik9ZaIumKMMPqKKIkKMQv1bq15iMDtP55zWaZUDACohwVtxhKZOqImO4V4o
 hGdPN1Sib6U_QEoQFHSPHGma0STk41RY6fKgDURdi4cjTeCk6Hj.RjvrNjtqxQVVnTGxauI.fKzX
 cBZxM7GD28ol21zzG1zsq546F2o.dXo4UlDrkZdMNQBwVXi6cSpqgqmN5kZhRIeKxePe2AsY_rcH
 YgVBKn04pb.28BwD_O.rn8mE5E0DxWzLfaOzudm84widaIp6OBZ6heP.r0GQDZVXBCjU5L9K923n
 .RRrOJTGgRwodaIpbItHaHAkryAOOpQE4NBcg6fpofGHOw_Y2MqnUUqhDPH0t8A4IwOnMhQbqQ3m
 Z2HiYlgR7lFmYelZNqafDptrdEvZRCoAGLHiYbSP4KxnyyWiuigxXR0Z3yFZ29aWUjsxpaISnQUk
 8lC98pkOfkOq6wzxtlHpQ9ZIvy3pKmsKt1xgZf9HgcSCSLJUazYRY_R26l.GseO0ec3MmqSC7IUO
 P_ZUEKBswCZdoBliu_lwGB3KAcVIsewsVkePV2t1PNRBg1z9RqZUst8tY11u7081.mU9S7s7BCH5
 WE_DyQL6KIVK1q_LYWZzX_9wDHU9.w5.lUomOku_iDMUYcG.FiDtRSxVOZNh.QfjCyHiQwWyXAzH
 JalPYeNShRQIL3vOXCla288H8NE2Dq5jjlI0owcC.XvteVmMZkyE6Ag4DIDDgNYRWMWEbbvoBafk
 7JlMXH1J5zHDSHtYkd5.HEkpxR8rq6t6RS.l134gt9YsX6nqbcHOZZYSY8nWffZDoIviEvnoeuc1
 iPgWyeAMN60_OXuE8OmCuAWLNYNZauQRygsICjo3y4tbhdhxOzJCahFO5SV_VyI8MPVrkeVxgD1C
 UdFezK7OY6EgEHuIH8L13VnaKaWhatNZdwLXCJDUpknvfLwLaV2_XQAzu8.90ywuKkxjdNP5aEE2
 TDXTxaIQc6dkLYkzfrT2KH0RXDt0YYM7mWLeV1B2SBVM5LgnWkeoLvkOIuIlquNZCxWdlj7ZI_yy
 0VV85B4X8OAOFFIuayVcNHkARGJpH3dQHqS3uEap_0BY66tynfVn617dkB6SlFTXJJKBN3fGeVjj
 Ic.awTe79vIcePbHd6c6izjxRLVYjQdOnUdxlTzPoy4xJOiwK8jrW2NtNpIY0sx1y6D28Hc7Hl1p
 nMBpsLFgrLFJHYMaw9KI_xovuV5IkkOG62U5CGi.52AZiJgGlcHR2ijPMf0X3qgTes_C8i0me0cf
 cLO2Xe0SaEwxQck4ZmECiRPV2TXAGhLLEBQ9dJFhCbNRgRQaMvfy_nVFXsQP3sx5TykhIZceh_.T
 Bg3LA3LQ6iWiQZpcbQ70lf_WkQJaVsOTfKYMRpR.xAe_GAUzfrgl2hyrpgZF0VxB9Yn.d3Ys_a3c
 cjAp4AjIbShNmOGTO35oMWVZc4N9pN1S4hUFopwNNNUoiiR9UDtNOSWdjhgA3KuwI7k0RDDRdZ0M
 66GT8cVFM8vE9Y0D93PXLkqy3QKbc3VB5Lmc.cMlN0I31mTWKY3esVN96EdfAS3DG8nFIVN9tn6o
 sY29PmmUQvexoC6MR22nk3uCWlDT82ZTOYVyST_JS.9i4v2cGzRT_jvj3jTLG76If93_IL8gXWR_
 PrYJD4FY9dg7h8XBE4.sHyUMdQfO54Y7B6KQEpb35u368K0Mr5Jer5Jux5WGzT9ROBo3FPIbV.DH
 wBfAPjT9LOC0zQokLR1ETEgVCav93Dsf0BJG79KDmpLfLNW1t1oiL_9okvOLBrxe0nO_GVs9LyUf
 Oqy_Xp14fUMfUahZK9xfWCdanBT6PhrEnsqsQAJFo81r1OHTGygwquLL4HhQ_zoyqvKKLxrumWBS
 9zPhdErxZjM2RDnDoqfvS1wViZLdQMOSW10tJEogvHxBPu7i.tpjOgE8vPBqaU4e2lO3baqFB9X3
 xkVXNO.a1bFQIqKKPAuIiOPVB0RMXVszfPkypke8y9gJs0eVRN0be6u2HVjI3Zf8ayHsQHaYsgV_
 gTUw.MKy.Gqz3H_PVqI6jiG4panjgouUAl1mL4dk34b8LPPYaqu_jhqZSbrrHnZrJgFFl_0UMETh
 Ep6rrnZYxSnW0OlohWHKIdwj_BfWYBpaWqpYgXOSszbL9CwINgms2MaBUXVRfHbYNzLf8GTxTWgJ
 2ZjxNmT4KaNm1TUMU8lSYyx.438WIZRgPXm2Y5wTp0qDoknwOTS96XRoTRbsYWQ1.boWpqyxnInb
 0vfz4u_SnVvL5DD36MJhHCQZ.1yzcv9kvKD6iZsAP
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:00:21 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 018191927b598ade9ea45efd47ffb4fa;
          Thu, 22 Jul 2021 01:00:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v28 11/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 21 Jul 2021 17:47:44 -0700
Message-Id: <20210722004758.12371-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index 4070cef152f7..aa19fa4a553f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -454,7 +454,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1005,9 +1005,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index af612a42eebe..6d112ec89c1b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -608,7 +608,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
@@ -621,8 +620,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
index 458fded340ab..da85932a4d53 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1548,9 +1548,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

