Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955D417A59
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbhIXSCH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 14:02:07 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:43396
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345464AbhIXSB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506423; bh=grDkRo5RV4L2mHUqLOUmZGqo1SoGcBwapuM/U/xc+PI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NamNUeI5D/GW8yuA97NnDpNmfJ+0AGHD9gCXJSAyBGmhZIJwyUAMrHvXzM7nm8cWWgXy7dx8m7aFf8gPfFAxgPpV7W08MXQfSycuss6vYjcBTmJ0D+1kLa7JbOL13zMb2TJqPwx8tqFi3yqKEltuVFLpLjJQcEiV1GTl9RyQz2x3nueZgZ4oIF48uu0UpwA4bcCuBzfgHF2cgDWPjfeBF4+//5XoQp8byFmG90EXEbErNd+q1X4mFZdVTnOwEFz3pdhgqWWwAZAQfZkn4U/M9ckQC1lOAH7EfP+kS10PRTY2t6ws5H5E6x60UWC5M3kHrUCdIuW5zcB4Uz5iwLMJ/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506423; bh=UWYW5K96JpFM+Rmc11aEzqbKhgYF7JGz12u97oGzlOW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AiBoPVrulgoPlsajkcrrfhikxsi4/np8HwQD+9AXhEGH6tqcZXHICS5NAKZIgQ25yWil8Bg44mZXW9l139rfsiHhwrRB5/wLmm/3VWhe+BNqSWOhgWRFj2MowPCb+Tg2DgzmIvgP7qNV5C6eoH57m8ECYTcIVeLPI4EOYhkoVv27eacwpw5QRbfg0MLgOVe7Sa5vNbPgBjbk0Cb0VEp7twnDdOMsMsRvXyOgfNmNN7ZC01ptXcODTmjwzfRHhIhPkMqsXpGdGlpdLHzvHEtJewaouQyxYidohItKz1/KmWmFT2WFN+o7/hYdO8nCDVlK18VqX+PamJcEkEqVCGOlYg==
X-YMail-OSG: UOxbg4kVM1lnPDnBn_mzKWvloejDdKqfxxIh_ZGdg8iaCjQtkhS.r6dgjBu9zln
 tPSM7y84Oq0D_CqrpaSgDsU3jVlkUZQKVu2tP9Vsm2BUnYE4VQqs1LI4Fr5YC7W5SIlt.TwvejcG
 DfA94TlkVuKgJIVKCh583twYOzMoxvZdQRqZg2Q1CXNSvScMWK.BWBGQOOWPhDg.JIqOd3K7lB6g
 Nd9ngQ5JEm.MxMZ2WyHgiiy3mPGJl96AY96Ki8aDlNPtW_IgDiobJEqOnKPcBqSHjHTAgJBMPQEG
 TOk24JCvE1BgRT97BtAPi_OrCc._0PQnV1hsLuvD9DqWUrBNxzp7VU8HgEc3eUrg44BS_vQdL5MO
 yMH6YxSFp9uUgMxrtBAe0JQxtzcpqu3vq.MM6fBVNrvqAui7ssKk3FUJB7pXDjpmcV75JiMu5J1O
 DylfGGxg3sWU48Ht5HJXMqCUBhlQ.dLk7M2P.ZZzY5FgKszgw_4qsjUkv1bKBwUhxPnfY..q8Vf3
 .pG5WoMNRrnLiDjRjZdW6MOA9JdNO8aqKLCSz6HEX04qHFlIb4vBWHkka8yfiFTFQFIrRVZqqDVg
 .iWq4eidQB6EGUmtoSJ4PXKbnCBaOkHd21iDPydRNHOwE.q__q7pPJJnI.Kez8CuPjAnO2amGoHH
 XS6B39l0GXgQOkYp7Kra9z29Io_oXSsh.KIHg8MpV6pRmw8Fo80exU8pDUuEX4TRta6HnuJw4.tr
 Lt_DSHyOdlUGkj7W_Qb1J6PeJjug0bJ15sgBH_gtTcUJhpvNY5T.gqUgGHqQaGDVut.22crTAw2m
 2.0YPiBM4vFXgQykC_cGHY7ziZhQlooWS1MkYs.SUYIHiAmjNUIAAMOtGii.CGp1Ucqtvz8.CVoZ
 wN8DbsmHWrcpADvVAanlDUy386F9CQpSJhKPbQOhdnpXVfJi_j6N2.uYMb.2kydiU.9yz2MA0.dd
 1Am6eoYqz8bebz.VVS4a5UAVtdNjFRWeElZ9qf7rXTaSipmV0tW4UW1KdYSpBi6TFUgdOGhipxo_
 wKxxrOM9_cOsTq7iXlaZXSx6IIrMArwkT6yW7mmy4vpAfuEFMdhfJafxsaaSbOnl_bM33.5N1SMz
 FTXRVmAU76KFEm6oPFtUJJFRvHmj5_c40EKOZGndYlQu7S7YO6UV.bB_wVoyPhwCZQo941tpDuiy
 gcbsBVj8lPyGUXmn8PlmwkVDFau9FvH8k.zMSoXM_zrd7Tq2AgmvZCCUNxuvIM3.lEV.BE6APFBj
 JuLQ_IT_RUGwZBm7QckhX_SKVz7qAy2tq4UsQdcXsqG8PDCn7E17bxVfPxpKqoOJwClSK_KjS1vd
 YaV4SgYh.VnbEOl6SLJlLLkOGbdIcXw4oU3qd9xqWrUWSXMwzK_NIqqUl74fjM.f0AdgFOOZ46RD
 faX5EJwa3r0RuCaYlY2rug6UZRL1Ry1g3j7HkQ_rQXuwIVJMyfPHaoD28UmLEATWhjUDENN70Qt0
 9UEiW0hVDuMRTY3y7cTWcsjXRBkKVkW4_U1CO0N3JsRkxAUDFQd_YHjsJ_LPlhdqcDS86UfnRCGm
 rD.6FVOWDUyGLnU4Ct3Cd6G2acT7nKK.V64OQ0yKhDcT3c7qd363DM9SoVa9zCG.wTTlDQBkCCix
 VXiyEzpgBzYQRMTHLWaUU1uubW9hCFJ.76grdiRak8H4YfQ46xlED5PIs1mxhABKv.k1g18cdCVW
 HzLZn4sZPFbJCS9JBPX2sCe8wZPu8r2QByZByaJKxqEadr9yh45tVxFMt5c8wn88DyiSDLRhDggG
 nPev__L1_RhcAsHGSXO6rhIx3_AvV9bcJd76Jz3U_UajkcmxqepZWzlNDn8rxyF9hKcXOisxmDtw
 snzs.RYKr3VCS1r8tNk2Pl1C.iZgLo8YGXZk_eBeP4wYUsCIL2bwadxx9GDs2YmAtfJW3AOG9PFT
 sRiekXJL_5OP2i6doHuiMVkWlmJ3gLdsedsB9xtJ.XeSPAg5Mh5GMJcQ27PE5CF3dCrYW6pdHfg7
 0mB7UNWHMId4x9LAcaljNyxiQr7Ez9VkV43yHFoXFgZjg2ZFws.lf3xh4Z1UijwliohcNAgIc9T7
 fs7mC_qmNUe8fvXZfCLlJcgNDgsar3sXkTddbfcwcFKnOiHPU8a9YvwMCzrVpJ0_MDyH3ofc6ixt
 z5jfgvv5CXGIsKiOYiftrBP.FyXFEQ2I1TCRwZDnOA7PXJ1qft5_.SDOPqukt1_lXdqrQxkq7wqO
 yPmYoxfONoXnmdursi4l8yfsIGUfO_a83GIKCG75infkXMLYXwb2gMU5krMmgcJoow1ixYkOtyuW
 o5yqqHU1TdukkjFIkGu_ap.qO4bi0JaTLqPc2omJxrUAt2o1o_ovT8PCYWiiKxurf.KDFpJdcWbI
 BN6vz0nPCODnboYZ6K5OBnzXeEilF0wP2qLml.9k-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:00:23 +0000
Received: by kubenode516.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b67ae9d5c17e62eb36b02eaa4d7c9ad3;
          Fri, 24 Sep 2021 18:00:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v29 05/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Fri, 24 Sep 2021 10:54:18 -0700
Message-Id: <20210924175441.7943-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
index b10b10afd04f..0ebec0fcf313 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1945,7 +1945,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1961,8 +1962,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index be965a8715e4..1f025ff1f011 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -437,8 +437,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
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
index af278e225f9e..3d9f051edd20 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -621,6 +621,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
@@ -633,14 +634,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
index 8ca554e1dbeb..6f080a6cc090 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2672,11 +2672,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2684,7 +2687,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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

