Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C86505B7B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Apr 2022 17:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiDRPnQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Apr 2022 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbiDRPl4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Apr 2022 11:41:56 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B448386
        for <linux-integrity@vger.kernel.org>; Mon, 18 Apr 2022 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294386; bh=gZinOR0rjH0VEq8KIPKeJFg5VYryd3doxauf+XrBdSU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gv4ejR7CGnxp1ZhTl7TFL922Ll+dWp4kBAwiMy3HN0PwORVz8GsaFI/SODB4xrSH+iCY/u3MBw85fo1doqcnPM612/7+P8/g0frcZt7gyVvN+tF4kT+T2mlWUlJ80cqXZutKEbQhdCgwfnOdiaCmQM1GyGuH/GVY8nsuOJNAhbTEYNDjndIhIKMFXSQYI7pIexZKCTunZ6AElu6XIyCXQeTMKGgKZVJyKYyCXGW2/i5eZ6BnWnlBFacQNoW4a++jBh8hNEmLC+D2JiTnc0AYfPg0tuHpEYrpnf10xPGVf4NnFZ5Zj7z500xIbxT9XBnB+BuKUY0v5H5DaCCw4WUCSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294386; bh=t47N1Bpp+t1WV/QGXAsIPOVFA+mLJN5ccVVfK8cIium=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SsdfAJUYzGCWPKkuDAKeFfZmIfalm1qfZBEpV1rwZyB4HDe1z1vHyEmYXcgFGq4XiieTxN76oY2hPCLtiPs8XDrnef1BmrHqYyGuXtJZYOkUx3lWVtuDMB4d4aUBP84Mt3aOSnSRpOeO1TEJZAZnLiHSi9ajjennd+0NbDzYBfmYKOskS2P8WyGTVXS8W+IVl/gXUGCRcj4V6E7TArhTiLQhJTYyFDQIwICxjUN/5tBgsEdudptHJNbzp92PTcuX/M+89xlwaO+wy98LRftasMOKnY62GRMKE8QhCpb4IlsccKY0v+EprZtjXyv6JVDCmPuU1z3JfM7sooAJPtvtgw==
X-YMail-OSG: 6thIsl4VM1nBpODMipQA6p1UMxqdTjaU5SBCYnMSLGCK.OgG6iQNqi8v7I9wWo_
 Bjv__f43tPPytrJ2.._rp_S5obm7RYwC4zKS0kfarIdjon.pgY.l4fLiI0M_agN0OavyTQC4RvlU
 cHTadaw0pP63NEYUFZhaW5uNLxV4TG6vclnTt0xAxT9kQ0llAkaEExsBw26bixktjSyUO6rg5_dT
 GvUUnx.CQiAut50SDyW8MzcNaS0jIvsXzZzEzkxHF86zxUUyOEXVeE7CB9qyr_aLuWVL.54f.Tj9
 EFatT4znne98ZXTcRwCYQhboMamPhLepj._chjdmMhxqmOTbxJJ_Enb3zpONpOvPCkorbWf6G0ZO
 qZpNA9vTHFL1j_H5ZARYDKO2FYPuUE2HWO6MWGDSjm52baF4MhYxzOqw_tbiAr5z6madVBILO70_
 ILz0pSmPlgdxbGyV18SY1YEpgsk6YsQKUKmo55KYAT635gCbwltB.f3x3qLGQTDxbz9WrXqwKvFM
 sZBl37flzvuyrGYrGeL60yUP4_Z1IFz9XN.p_otoOy.i2XAJst2lCZew6KXwbxknDQ9Co6c.4ibx
 DgZZsL2Bbojr7AmI7YsYtsQec6QliG2t6HZDeR10Z8MpjpV97oS_07XHvtDh1SB0um.5yUKxQmLO
 Z6h4Dmgl4aArFP8vYc4kCFaoL._NS5s.rTpht77pN9n.pnR249NdRs.p9OiU6VXpFnYyliElsm8G
 W8SCWXTjFlzONF5AQ7hyo3yjXkowwTBEXE76vAk_l43yymTqoiDF2sKqvYsIhzIHJQKskWFEmiV9
 ePnciJjFEsABM9RiKB.X7vHWKokZOCLCNIkcsd.5SBHJ30W0JGjaevfsEOhNWp6U..G0Ky7hCHHu
 Os45Lyk0XPQSAzJi7Lj6wwIbrPzBUkff3nauGoLO4jnGL6sz813aryFXpAGj0E6J3eiQuoKQiW8L
 xapQ2VxqIC9z46ktadhKpCfqHJwL7djQGEoPmRL8jqlmlAa.nSHinhzsmEqTPcNQC6mDHUCEh2eM
 RD0GyVdz737Tpn3bkG6K1IMP4X2AjmDz69JlWNsChY_2wF2WKtglP_hGGvnbmisIcxaBtBoCVtH_
 EMSnMKUahhgSVKemtgGJuvNgpK2zIxbYes63H9OgbcV1KrEx.8JKBSim8nviVVHLkcVqLXXUm9.f
 JAYEHYwPgewuvCpN7.sYaMZL_FnpqBdbitiNT2Zbiyn4JKG26WAypLpAsYJ8PCj2URH_ZDUsWkLY
 XT9BhwrBvSVcHjypYqyltntamePkbUTkpIeI.FHkvilYi0U1nif.H4t9oUFz.lLpsqluAtj7vfSf
 mxpPGK3bmfdbnLWX9_Utl_T0Mad53FAFHTFw_gbTdbKTAI5jX3yboD346Uo7fP6bsFISQP8AUEAu
 BjjNBkipB9fbY6HSohbwgI0tsVBm66cjfatddf7PokXXUz187Kq.Ly7tewSu3tsFjjd9JVnQYkaV
 MQRyKgAZ3vxp6CqcEb9m1lVebm5PeTElUWItXmlxNG7KlvWtQjs.EBS6zkqzF4DbQ_2bPnS.XZxH
 pNuCCM65sGC8DC9oi7mIeM.ZByKYd7uPanduJgC0ZaOptyhNdsdB47IQ5Kn6vmMHwt79voOS0IRF
 xvWxxDNAVWjFrs3bIbESNmqPmkCM1wVZPiQU.4eAcfn1CHqRTSy1XCXsiVSz2kEI7SB3u06adRoE
 DyKiJvZDy2K.6wcBXU4EpFdvHMyov_ypAO4TlIlbMon30QvJYOVwAJ3RPIICm6JXVProRdpcO8VD
 HY3okKf6yVNj5VI1yWhtSzyLr3FFYbHxwk7aPR9El_LAqKfuTArGQRw3CeBSQo871fy.SkGULq5N
 xQSZnAcWIJWEEfS3EjLU0FPez4AaZptCXTmvLe91QJvA9x6jiT0CDdLukU4tpp14_J4BD2K7.BvF
 9Xy1Ja74MUbTETMq4PwCUkr7KEHCS2spW907br7mgR0V.nkTEUkVIRToa7FaeBe7kT6WgwT5qlqO
 aIfXje4ENFcbvYHAnvKXJr0E8HlTF9Flv9OMWx6OAeE1mos5Vns62lD0k_372IAIRgkZGszJcuvU
 XKmoQpwghIyrFuGsQfMex7oXXMlKcvn4.Z0AwpUDewZvWl.4mlayv8Re.78JTHH5PyXOhp.DHeWD
 _pqCHpGWZAA19fXb12mHhzCvrHywrb5aenj2GH4y3E48Z5vFUhscHsUcIiUH3H_kqA4y3k6vkFYE
 lU1UW9wmUgIGbromTEqCXprGTScsCQt7Z5TiNEn0IcD4.AwWlQnXWSuOQSFIdsP3V9IKacz0MZki
 taxqvVFRn4ERAuZRsQqfUDm6RR4QGK8O7yHdIDQxwzLK5QtKwVonR.eckw797zsmRFVPS5JnKuGt
 FnHloLgA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:06:26 +0000
Received: by hermes--canary-production-gq1-665697845d-srvxf (VZM Hermes SMTP Server) with ESMTPA ID facb0f2176037c185ff3b4e507d76c59;
          Mon, 18 Apr 2022 15:06:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v35 12/29] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 18 Apr 2022 07:59:28 -0700
Message-Id: <20220418145945.38797-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
index d11dfa33c1c7..781b1a2374c0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -474,7 +474,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1020,9 +1020,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index b7bfc934436d..fb8c4c61189d 100644
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
+	name->osid = lsmblob_first(&blob);
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

