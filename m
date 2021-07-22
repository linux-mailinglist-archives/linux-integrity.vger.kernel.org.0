Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B73D1AEC
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 02:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGVANB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 20:13:01 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:46181
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhGVANA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 20:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915216; bh=hDC9m3+/bDdSFD5OWPdwTetGf+O7t4ZTveDKcehK4qQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iMY8G64zxJ3cJaqNxYrRpSkl0Xd6b4ZuVSFWAd29pF6enB+rrUCU2i9MkLGE0rSa9F9hhAgz43rYQ/Z1insw53v7m+OhDG3nnjgvlRjmGAlIfV77ai9Virq/U8jNUO6E4eWDvMtFLfhvSTQm9TasJxcl/oLBgJ+4nsw4ST87d6W96RrLC/rtcsJzqcBXD71pXT0h4jcpmp7wYYuTXgvQc1EdmjI5RvoXOkmRFlKEygQKnOKU7sTy2wXwrlDPjs3895Uz2DZfgeVTPvuUyEZVEOg3r6oe9q9o10ZX14XNxbqbr3gU+YNY1pfSQ+zpQOOYmbcGWkoBNyBHGe3dcbkvDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915216; bh=pryNqsAvW+3CpkEpycFXY/oNVeys5llqtEDlxiNJ4Cg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NaJ5l5lVUn+C7PRzyB4QKUL2fRXGCduSQSHt91jhXs5c/tGo+vtJ6gyW7SkFBW8UeBbmzXYWcneFNr+jWCsuRBf+bkjqVX7WrKw/b39B7WLZppUBGrSoUjRE35jlgd2aAjJX/T+3YVpvW22l+u0+iru2KmJdTNM1quIX6gEfyND6/xeo5/gm6xFFIXxVTtZZMVONkHLM1EQxDtEOGx9+2X1mkuIVuAcco92v8XVSYXNql9fvEvTTyP3KKoKjLzeFxAxj9H5lb8nX0bcyLg+FVUX9rcRyusUq/66ei05huSrc0JxsnGMemhwUyK7Hp5FC0FBizwNeRLNxKnhmaT5GbQ==
X-YMail-OSG: UCsr1fwVM1kJSEPk.NiKp8r9Jqw_zaPmtqYhAlj0.GszLkoKEry0aEBb6DVaqQ5
 4AqDe_QP4b7S74vuc4JgJMXsXIvPXYHQ_JVF8UXkNo3GuqBdght35UxGzQjEERMtxaRItHNASpKK
 IR4GJJoB6b4pC0GG6VrDqGnol9N6XepulsC9MxkrIYF1QUHA32Mk9DnHAHglvmcI.qRuNvL1czsK
 3SGwMeeG3etUTv0I1B.FyVtLUxQqGeo.HM2UrmkndyaCv50H2_roHvXt2O2TlawR8CZ45jB5SI_r
 YZs.SreZZkUO.BEuxQ5fPNiNlLGx3kbNRg2EwFcb0Yv1k0jAuj8CVlw9kPFpH7eTf9.8QKV7jb6y
 lLvIJSrnxn.fCEyMJGVZ1L3PRmpcYaB0ZabNL7IhJKRARKxUnJQSiAkPavc6Mj3Bpzr7neDHPCPC
 UApg1_kcJ2B5QQSwGnFLzncSzASIcgJKb8.ZBEYkPU_c_sCCDpWQiJT5ggt9wgW0JV6AxANUCBWn
 .S0kuU.Tp1eQXJCqnQGzPHz9B98pEFSTZozEAP8jgR6Gpjz81DR5.RmB2ysvSadnxFnGkS7k3Wx7
 ze1BYC3wZmGmMBveKfOcrkFwVxV9qtdAfpODiVZwKbftUC7UQh8xA9776SF3_cKFXGuJPWMsZfCR
 7YSecooI5r6LA7sVtoKf9tJzvDUfBWsp1v6Zq6CnhNuhZ7YmyqxTd8NKn_7sbEbvtOipdyVopgG9
 DAFtqgOZctbnQlYNUh2Z2T.o6Oqa0LDgHO__fOo4RFhT4c5zqkw6ixLyu29JLnXN5lgc5GhsIj0C
 UqLFESRmYSJ88RNe3ylYWVtiWIWn_hwWNrfdiVjbDLBN_HJVDNnjCuExdhHruOLykwsCeiiGIm1u
 aHYK_w7DiI.B1hkw3uiU_sY_5bgmlktAc1bZoKPwM..1a0kObhAhLI0pgs8XjOo0fGisx_zpgQjz
 fvTEkk.EcJrd0dPe01YogP4j1B40kMoDfve8OOljr3j9ULhTtgPLZx1oIxgdnSMEANFViHfs5501
 0sD0cyi8gIbY56MlwSRG7uso2DpTK6bn6OI8exnwUZU2BYwvpCtzBh7zUtyd3LhohZbXytqfdHVr
 BL7ns5UX8LdT7xGClPeYxOSEzfMjrdoFgE3p_xYdnCHpk1LWMBUvtQBF0zgrhhYWBUEXj.dADlcw
 RrXscVZ9DVv_soaH9NE8UkOah5GVm7VR09ivS0ipxyKzKaS_uwIEtO7OeGAJjuo_B0MwJX6Yi.NB
 K4qoBQ4x9t9jT7gOmWiVArpGYybwVwyef2X40W_q3EBaKQiQDWlr4EA6Uabp2.8FSK2rC4QUSTqN
 IITtfVyv7b0V8e0xI_DxalNa7SYMBeqfPBuA.MFsze9nE2bygKqOVAH5VMfMGUqOc3Qh8HCoKqor
 U_7xzDNvmkskdDVA5BsDgtNmjCvwCp0h4t1lJp_XPuZlO4sjJ8HupQ8FWuY2rHcpnnYWtIu7aEpR
 vvxH0tpWPJX86hXVU2_ADP864SS2H77eh69K52vO9EY5YQr1RQ_jTF1QxuIN5Z2OLT2hmW8s6ikt
 3L0ATq7Kt8_hF0TTcVkG_Fs1wlwNrjWQDcQvjZJaeQqJ99Km.5iuPNrGp.72pXDjAjlHdnUoZKg3
 U.Jbb11rjyqEW3o_QWhstIMqoI_qGU8xzSusS2td1ygX9F13lRAZrGYAopO7Qd3RHF_6q0FbF_JN
 IOBTqeDsGj6Tza1YBLWC39Q0Oc8Btyq0lQY8GEtHgyhMncem8fHCv02LB9I5k.V0B9fKEcxeJQh_
 V2pjvfcZQumrea6JYE651jQJem74Jjz9V7f2cBOfNkFh687Qv6drCFc8WB.2wrDRFp1fzwu3bHCG
 tVqW3zUCYkWo0jH4b_23d1cnMj9i.w4ItrEkRkIJc4d3TS1FBZMVbrMijOVFwNVyiJ81pxyNs3dI
 lr2i3Sy2yMHiZxoyi3aWry7i_2MEKBuD8CAjidxOjz_q0Ow2akf2SQxafyGGEje.pJ7GkmtwyQGY
 Lzze8KUZQN5NbgtemUbFPWf6MIIhj.knZLzcdb7zFEal867O_m0kEwgPiOSwxCYGrb1z.3dJgNcx
 uaK_kR7gGntCqHSXAZfbuFwK4ix3nWJp32DS96JcYTsiSzgPAr5nubfgT3Foq5LSyKzYnM4r2uSD
 .atWD0UwvdV6GO7SSIZ5GKAtRkWHItfNj2QnfXu6bwji5zxf8p941PPXHjkDLDHiunCLavc5IPaf
 trr0H8sUSLHtulUZBRiehpj.tkEe.zSmkvk4mPOexOb6qqaXQ9xzXk_5CE2buAJIbiRSWE7C1Yit
 g6nxmnw3CAdnnGDkv05FwgTShJLSqtmaoT_vEgto568HZQWZalY80IkAs49n92gGyMAZnlwofI22
 YGOWE54awkW6hlc42RPi2Rzxl1WXftJ3Bp9ywxvtLLZKMp3WL7z4sWN3Erfd7as5ABMAZj1rH1LI
 qI4RxEatfFwnzWx3RCbaitfh2juMoxea3CbtUPLXLrmI6kCUYrvUwvHA9enPaddmZft86OoYqIWU
 ZlA2XW7NBO.s4JC1Ujmo9hiVNy.yQbWDk7plBdzlgzJkuPJ1M9v0PQYahVA0RmBIStUGQpytqfPL
 vBszgeRJCLq0utUsS.HL_QZEkm54f09wBRhX6cww3ZmwoLHS9xey_samFcwHwpvrg9lZAqpns3fZ
 CLvLV0X3Ce5J.dg.3sepLW5_TVAWCnfcdHlEss_2irKzO_HatICWX2uZAcQEuASiD32jgdcAZ5D2
 Rs.d0qHnRI9A9N.V6yJN9UpZ0AQmu.kGyTtpUnmg8chGZ0jeHAROfk3XzOmffOdvwQD.NMp1ah_z
 KPt1.livkAoQs3ggzMZ2wBQ6DtdSMdDq1XHQqxkncF6SHw31fLPmtRpMhO2cv3.alNUQN9mFPme6
 4M9zDLqMWS29Io1uAAD38SXHQVIL5v98HT5Ck2St37SLZVevgsiMzMF5vo.ckpH93FkvRLsy72Y3
 Ou9ZaLoTuqRLpFZ1Pw1ejfENaOa6Ijr47XZ8Pq7doegroc9y2lc9PFqHG_XCdfAcgKvvHEw6O9wx
 mwzt74lOz_sBYOz4T6wigU9eDaOy7PQG03vsUy1pgaJyTtDmTvMXFDRixiQWWU9BXsSAF2CTb9nM
 VXuNzM2S6WlZ7xqVJNklTywVuUWvsV9hzoyteg8qhSkCCbulnwpzD2ql8Ku9DWngL7mfevA1bMg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 00:53:36 +0000
Received: by kubenode510.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 536d6598ee7cb958c41c6a3a8259eabe;
          Thu, 22 Jul 2021 00:53:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v28 05/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed, 21 Jul 2021 17:47:38 -0700
Message-Id: <20210722004758.12371-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
Cc: linux-integrity@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 16 +++++++++++-----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 10 ++++++++--
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b641b5b96860..8290f6263b6d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1944,7 +1944,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1960,8 +1961,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void **lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void **lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index a2340e81cfa7..6a04d762d272 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1362,8 +1363,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->lsm_isset) {
 					security_task_getsecid_subj(current,
 								    &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index acbd896f54a5..447614b7a50b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -478,6 +478,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -676,8 +677,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -690,15 +693,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
@@ -710,7 +715,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..55f3bd4f0b01 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -433,8 +433,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field,
+					u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 008a043335d4..af612a42eebe 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -609,6 +609,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
@@ -621,14 +622,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
diff --git a/security/security.c b/security/security.c
index 3da6cb8f9d76..3c035faa2c37 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2671,11 +2671,14 @@ void security_audit_rule_free(void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
 		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2683,7 +2686,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.31.1

