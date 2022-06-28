Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF555DCC2
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiF1BFm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 21:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiF1BFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 21:05:42 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E122B3A
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jun 2022 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378339; bh=nN/Pq+0ZyHWT1ZKsDlXxwMua1jP9bHIcug8QyvfySHs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cNxxjY3EQAIO3qGNJK0puQbK6lot3NOJeUGnfXHye0L5zQqND8EPpvI7NAj5kjYJ/49nlNJdgSlN2I7MRuR+eZVVCVnGYNMcmCah/EwRHzezn0fou++5LtEUeX474wRDtKLhvafaY7XP+1VsZVazZVZyfvEWhikRI4icvXFqRMMgZQSc2yIFyeNgvoti98CTJMm7NRfjxq1tIvi8Uo59AZBZJqQH9sj+bIV6MEbikebvnmjGfmF2sLaJP9JfLPT1fhwbckxqhP6bURHGEYc/0KcjqXucCOye1gp9QoGy551+PrM/jrlA72jaRaLJE2F3R085ZSrZRFUYDE9pu6mqIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378339; bh=gidIIPgp1Fe6CKn226mRD56pZU6uUmKTzsaEXBlSWIh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SulYHKS0+qmWPYbRaQAB3B+fJaDH7N004Ys46Pw25CUD+xdYGTpcpgTewPMUYYs9JP0PlwKOLa40LjHynobHqgFk2wv7CH+giI6MCI+khA0mZ8L+y9Kyn/lZagD7MzUYvIq1OjunFMPFd0AuTDiuaFVMBmfC0BdzF7CEZVJglX+BbRZDzccB3ga4Y0atWawMQ4iFmGri4wd02MYEmJJCVwdH0I177hNnRYig7+ZIHitIdqC1L1pSuj2cHo1yC6XOSe0t69+ZRorG+25vfROG6V57D695pzMJpvl7WRC7PDZCRleXJ2VB62PAFfPMbmlkjqJHdOaI0MZLOBCKBrFVTg==
X-YMail-OSG: PUwWTWwVM1mHy8geZNNMtWmHqX1nswfjouj0FI_N3_0YcQ1s33gn0nhbJWfaPJJ
 NGgazlGqyf1ZyqxTnO8yGsgPX3Dsm1Pmugh1Y1.U.gTUOFeDFEbbiyKX3YlNmO0hdnwDlZUg7lu_
 w2uYy.kDKYIY84VhlVUpFMRuAdrJxv71qOfFqaz9G5OCVuXp971GNwHIPdWKVHGRM7gdDkxicti4
 3P7256YLIAD3LnKnqIn_dckp41S5Ud6vTinPkl2.g6QLuVQQT_vdOn.6lm2PqC36u514HClWjvO9
 5g6g4Nxq.BkTDfFPw3zS4XjDOImTin573NqKTP4fk9j9Ju2ZPqbAgiNnBk6uzESwbSQ0vuCNFQcP
 FmoXRYeEbzsbfcgx.SwnnLp05Q1rfoqQSVkreRpGGtsDUgcr5lUknYfVWDsyv.jHtfLzv1qd.YI2
 jIQ5pTc_PT4E9y4.yK6ziU555N09kyktVMMj5o6yX_GlDSt5LqFmsGTeeXjeQOvTShEQx5QKsTP0
 hn33OYsr32ByTqVuw6hiefGJV5ov9gDREaDbX17_42CD.m1KnE2Ruh9zFJeAy6FvB3U3LYoO.2m7
 B99D1oEfsqRw_LKzaQJiXpoBkyqXgecmlYb0HnPUkEhgnIvtm.KR8Vf96sdb9Gzemyh65RUfVNCE
 nsj4MQGYdMjXDxTqIT1U9F6ALPZCPm2QGhvGbGtSZaPLuzNadzbRlTjabVgDYhDee4kRSgac9L4v
 WRuJnJrujHGaMZH7c8GANvqihW2Ya5Ba8c.jL9cH1k1yKrwWe.tBG6JPNW_yXejxXYB3ZbA7PmnI
 RKec8JhWhtnznBU5yqpESGIKPiEjoxRx3TAYmT7iARBYXLT7OigrOt236uXj4_MqFHCp6_f7Qnap
 HfmcppkYwEZGVGkdtKoPLdKlE3kF8r51qdr5s9qx1vsLZH8AMrZKyZTF7bJRD0c36JFt8Y1Vj775
 40N1nGix4Lq3tj0lOW7ijiN.IGviO1Xsepaz7zo8qSNb3BaVCuP87nR5KBcDaXbax8i.qVdJZV_A
 jSvzoGWBP6DXMkXQo3qwB00ycWBDIpgxdrT3qOf_lRGlULvFt8RcDZdnLWFfLGELs9kXLA.wkmMT
 nJp3lZdsj68B_ZgCo0g8rMqWCyvXrIOv5JU4PcjjcZMA4lDT51vbqsaCnatYcGkBFqf6mt2ltiuu
 EhLyrFui99KoEuB6AIEkohzkFVahpAEmxl13EczCifWDVHqhTnDnpSwgf4n2hM9RUtRLRDDWV3mp
 H1L4sjsk935wEtR9Xh6CxUXXePPStQFvcT681DgUFjZMLJcvnKInNcobGZrxjO8DjHcChJHCpsBZ
 PAbpM_snUdYa8Y0oxBdbdYwu_WFmZRS14sT92BMErf8KMABOEL_iRbwzbqAF8jRnB9GkxDhIgK3Y
 .gM2th1cZs_BlQJZ8TyNDNkTqqQtBKKU8csMQekPCUb20Uft5pUstd.rUpxkSvHsayxCUyL70ii3
 c7FmbtXtuuGG_IkELs3vqvF3XgXO0VemVimWF4aiDLwrmhgPfHqT.dP8bUzP3fvrSGSTpZc6Tk2R
 DeAGkhRUIsEMziUvV3wvDflQ0pufGuIwNP8c281HRnQ2Cp4bDAfen0l7mKm8wz4MKpCN.0VGUF72
 8Q0BE9dkRGLTcyGuKCu8LxXZhXYobGTcCf7HiFbH1K49Tz_iNr50ju5N86cTR.YhyFPXft5hss2u
 Lt3i6kjCahF1kVWjitUwLhoFPtRaQLK4ijL3uAhbcLH8n5JH0dZDVvKh6PE4Z5PGCwDWtEslhmiv
 9W2jpljpzlsjG.T7Z1ZIADW.C79WP7VveW1b6mK7U.uLrlN7wSr1aCHH.vr.54tytIKYmIzWNZp_
 AFNPMyOK7WPgp1snK0nlRCcUZYDGNAi7YBSFPd03iQBCKPYI2e2NDvL59IDmMJ794ap2NZJf5L0Y
 bfVEQiZVcei85t9LwwLetEBV53z6X5jh0LNEQ5OSnA6n3iXoJslrPm0N33WSO97Agr1td_HTrNh4
 ocpgFGpEdrtAOQgZEegkicWMRMlXVjH3uyiSN0CJeMT7wFeAS8A3CzuavLutNTo3rRF_lwS4_e5o
 n6Zp6ZM1.LAf0RVBCedmLTfO1ni8rq2_LsX2XegxBsKeWmIV0Pg_siwIre1A64zL5L8JziTYmVs7
 5u_TIKmAGSq3Byhk4xdWVXZsU9rg371dovlbxX25RptiUI0pt0Wro8wJuRtZ8QTilHHGd07_ZogR
 Yq6521dtg5Ws6ZQ3rz5Hk.7GsexSmYjc5xhJvV4400SYQGubEdi04V9qQXjvtVOmwLLhvK3wsmrH
 oHnIeFnydOQU0X3fI85uYTAMCq_1YruJ74jvLmDcbIapFapqtAu97_qL4XL98OaEvndIlhA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:05:39 +0000
Received: by hermes--canary-production-gq1-677bd878b7-pqb8m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e262426b02cfbecf0124eb7a5c5aa81b;
          Tue, 28 Jun 2022 01:05:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v37 12/33] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 27 Jun 2022 17:55:50 -0700
Message-Id: <20220628005611.13106-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
 include/linux/security.h            | 13 +++++++------
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  9 +++++----
 security/security.c                 | 19 +++++++++++++------
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ce4a4af362f3..a478faa6124e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -476,7 +476,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1022,9 +1022,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
@@ -2034,8 +2035,8 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
 int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			 int lsmslot);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmslot);
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmslot);
 void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
@@ -2046,7 +2047,7 @@ static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return 0;
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
 					void *lsmrule, int lsmslot)
 {
 	return 0;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e5530bbfc83b..1d223176285b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2306,13 +2306,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 5c2bc6782e17..593b0ba51b6e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -636,7 +636,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -648,8 +648,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(&lsmdata,
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->lsm[i].rules_lsm);
@@ -657,7 +658,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(lsmblob_first(blob),
+			rc = ima_filter_rule_match(blob,
 						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
diff --git a/security/security.c b/security/security.c
index 1a4741178944..ad1080e01ba8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1560,9 +1560,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
@@ -2804,15 +2811,15 @@ void ima_filter_rule_free(void *lsmrule, int lsmslot)
 	}
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			  int lsmslot)
+int ima_filter_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			  void *lsmrule, int lsmslot)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
 		if (hp->lsmid->slot == lsmslot)
-			return hp->hook.audit_rule_match(secid, field, op,
-							 lsmrule);
+			return hp->hook.audit_rule_match(blob->secid[lsmslot],
+							 field, op, lsmrule);
 
 	return 0;
 }
-- 
2.36.1

