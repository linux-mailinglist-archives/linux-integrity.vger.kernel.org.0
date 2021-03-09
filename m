Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D604E332903
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCIOsu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Mar 2021 09:48:50 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:44186
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhCIOs3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Mar 2021 09:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301309; bh=0bnIIhWktDavWp0cr9LiTL2mGyMjywR5f5WzpYYVImc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=onmUi+EIEqV7DLj4mtok90RHftER8zkvYdAKGeluK+4ToPG2PbUg+ETJN9jxcnBWaWIiP8QOf3N2hUpDcb+D3l7d7CRrixZv5NJ2IowxYfI7Re6MnN9FXEdcWrECEcZ0NwaL4gGxxKKpOJ3VY0q8jX5eZlso7evgbgfZvBx78TSDR+C1PsCIAVqbOQeX0+PyoRaTX6vToHFXI39xgA+lT+VCClOTN0h0Q80C3J2WAqMQCXhjCVTpGZxfpg3pX1B6T+zX91F1dfbM+hV60nyKpsQqnADWzp5CTpYT4A3cZSw0Eco7m8e2JFZKs/sM3mNVGg1ly2qtJ86wiZtyfgzddA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301309; bh=vYzN/ad3YKDHjByVxdzH065uuF4q485N3uun9s22nYK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jDoJmKfKdJ0Wmyj1uUlBUlGWXvmY3kYnnTt9NQgGNAtvas0Gj58JFFTRTm2YOBUei3m0gkWGe6nBhvSBxmyjNkQc0Kvjj4WZcBmU0G+4yPv1vUZVL4dgzjWIEwj4hlsA7b3MEPPZKQVIowCXn7rjUz2vBTaF/Z4kycMpD4tZROat7jnaSwI3b1a7gIJT5gfLohHrjJ5aNCRj2GIJ9Mh8PU6yUzfdkAN048kAYEgxwpmUONHkoi5rb5LEfiLOtxid5EgFuF+UU3AGAgu0UNdG+gM4VMZoxqGhpT+XYjPk2B+hbQGXyM/gEc2eE0y9RGysuEueuU4bctQi1+PHkNe3+Q==
X-YMail-OSG: DmUnHPEVM1klsOiDEdco.1XB5hvxgfw4DdWsehZgQYPmb1X5bXmhdnwnWn.Mj6V
 BwTYR.1_yNIEDAFQkSfTSvUwDwMduqD.LGeJCv72oqmz2CaZCea6teEyqLeH4Bq8vjCIcXNCm7D7
 l2XZlEs98X73hl7rWEKfx6limKZBQZ0qUEOwo61.Lq4zPwqcI7daAPouot7LytX0mSWnMxeBAjcQ
 lFxgkXNt_5HLWIteNq9UMN50swH6dfXkEXRBLHIgxdxTNZBG50psK506WrX5jCareBZO.Sui9ryd
 Jn_Irzoi1ZvSfHHXCbwDG_7oSGJC8e8o8N6JTKVMBiROw.p7xSgzOevIHs56vc5.woQfXkvs4NA.
 3ce4XadUWwUaPOXYHhtTNdCAb0T5MhHKvO4r1IQ9ouq1MfLvUHy3Ir77q9_pTji5WujSIQ98Ny_Y
 tcqydx6fvPzFqqPkUBvIhWiW_OYomf4KXt_nOS2TUZRYQKnOLaxvzddOFizqdQ62kS6ABxV7aVVf
 h6BXQ45oz0nqcT0eu_Ncp0I91gSXzkvF3j6iIQAVtEGTCnUy0BdH9k92YKuYnLuQ6WUU_yKhMO0_
 1ZM5Z.R7O7APcmuukkkchmzlVUmZW0Ya5bpbBOgDB0qCWrrdz7vEgbd7_b4kzYmAxOhtxucj304N
 MewwJkmyH7OkaMYzMWSvbuzUi_yPIJDzM6rNaRYK0a2ELi78SHfv618OYAekbsJc34bDJJHb03hr
 IZNRjCIU9UAxKC9Q7X8k9MBzSJxP8K3V1XAfNusXjIkjgwh0UdtnouBBly62KBduYejeg_k.iHSF
 b78YSkRdHuIJlJteMjEdwAkfLTlPpAnuZR2QqYK7CAYIBfjwALAaB_sG1k7TKWb5csgGnJG3c2Co
 ZyYLIy15HRkywG38Fxn2B2bvgyin1tSiRCtT0tgKAlv_LBpYR84j.Xs.Nv3qpAttTi.S0pbkZt3M
 a6L8naTLK8HfzBDT8xBF_zhrBYa00.jW0kaJI6YNf.UFggXUCq.CzhrPVegx_RRrtMBgVH6pxxYd
 c03WicKX1l_noI2dELIJIxKDHn6RICBpquO6vwQgRQzKfunsi8GBQpQE7ei6Y.zn9n0Cfbmbtj9E
 zLHuZ7v6LMGspvlyzy9rXv6au9EVhtlflWfrd5MbvLBuY4e8RjRl288z5It5c_Z8sjwdjImg1Nyg
 VfF8sYAcobU6tFU2XRG8kZ1Bj7vUkB4FymOY3KHebMT8lrfBoV69P4KIJDjhdQqzN9p5pH42S..2
 chLTdpuUZoYFYKtFmYo9jwZIZ8Z9EwTI0msBDk8s8YRu5TJ86lB5RzjlVFunz9RuvTQHSCgoPK5c
 5PdkHpavTfDdnY4pXSexwgkB9k0abZSaymbr4sIVchLaSpzd4wpDoGUnxJt5WKQLYTSrv.ZGLmgm
 KlnHYtHPwqcrf2a.5thhu4hkLIi2L51fm5tK6RKjqnO5_A38XV2OHz_vonDYxtGc.oeOD2J1eB9W
 pCGCkxELJNkeT52b1GAq5Vl0.70igbFNZBWHn_4DlXtFmIKVKbGxT0_DE91W2ZvcrFN8BfzisyJg
 OBiuxm5.lng.wmmDlPUUvv841sTbdi7W_bjNYh0PJKrrfygdLnjrONPCuKd1t7DZPG8aPdcxNrJR
 i6vbgnSFn3Zry0q_FAFvBOzGKV.ONVBCb.7yuEbERhO2AiE0A1_tes_g09_OaZbsuLAMHuP_ehGv
 vsvbS8O4iejtHSiViBfzQuGZtB8E3vJX4rkIpw2mhXx0AE8dE9xpyPkfs0ihqbvbI3Oec2wdk3jt
 FYTthDrrn8KG7bYXnp3i0LvOqFCo52Zhtz9tJg1yEqW4qp4vzP6fysD0O5Er8CgTnkpqOukyTgec
 vl_eE9qdzYaxXyPpe.ARM7a_IJXSKElrsBThWDYKe6RlWLr3YfRTCSoEgf.k8xqNlPNKfDriy5YX
 6CQ9Jf7I2a6Df4whGjapt35oN_0GYDIMvUVjRUvz2yaNiVCjybDKbKXLUkxYhuXd5yvfEctNWoOz
 3Qkhykl6QayeIT4OJADEbDGvloqdAk_g6lq1jJrgMaP82y4ob0ZRswblpOIc11i32dP7WjyX8guH
 O.hg4WKzj1S.Ni9vrcqnZztYNgK.gMn9_tnUETSBGgKv3VPX3VUpBhnD7Z0j2LAgJsSLs4Vr8mar
 zmwdjBg3CB5VZ2jvWPC.n6DBEJ8WYEha4PFc8McPa4WsSHmufCee8fm1ppQHeXqdiXdVHdmBYtef
 znQlZf6tFmqNoNlkLK0BK38xXIH9C2UeQsHDW2TzuLef9.jfiwdp9WnF1tZ8fFXOUkN0yeaI.5rE
 VsilaMLUMAE3Pf1XXvb3vA_I4qaax.eGgX2zfR7hsKCMA..sVfWdxMBf0jAV9p5liZJSo4FdEHlx
 f6SfCB.1YvOAt6JGmyCYUynBuVPna1Nd.dt8icJ.kfz3SvdSksZeV.OoxBomYrEy39ebl7SJ0Fnh
 0G4x4.n46czCBousbWWNoDQwsLF0GviCY6lxvUgExq_YICczvHOyD.TE7yEiPnba79gkNk4diYwI
 ZvkI15yrcg1btJsmguVj9ZNwygEvxH8VnNOOg7kU9d1C.nRfDR4oOJq1F2p7kidr3.1cTkmze_41
 711n.CIzNU2rlmVNMd7COviMCMvxR2ZLIW9YVS5i_CpwipSp5uWPyqrA758zh4UrqrN_npTNcrJM
 Z5iJvTys_K4nfKrGmRcMYUGxVsZC_IuxkIRyaYLWUfwGqwy.cm3KnzuDeeRwbIwtcKTm7.exLbkZ
 txMG0VdE_v8qBZDsl4xl4jabOJ4HxHY5noCT_Uqkxqhw1MJJTvMVBcxWG_TlsYm1RnVE3mqXiG6M
 Qi2gAoa7scs6q8YM2VZq_D.4p70AM6hF5czf_tdZJpX7gMkOcbarQkg_FNbn6zhgM92ZZlMegG7C
 NcWol0_cLG9mk0lIBehO8CsqNAlAzQYDF5zx_rxTjm0kY2.VLgU4iCMTLq6tcYtk001Mq74r_kBT
 fI0r6AGX4tHjIo0mryfhNvs9QuB_1uDTqRH.Pqymyg1jgYvgz4NgRFDGEpv1fBLXyOrlc3gOXSax
 pIDLKhgePfEC7FBBALNVbQfb_YX7XXv5b6VRPSuRlaUDXkRYn0OwZcLC1R477gZf0Hra.qMC9rQJ
 PDB5GDXNPFxhZoL9VT5u.UUIQ0WxJSYWf62lJwLwHYbP8DFL8_tgDoleS1vgyDMVUggEEE1teZWh
 X
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:48:29 +0000
Received: by smtp420.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 253fc13a7a5299d33a87efaa9bbb70dc;
          Tue, 09 Mar 2021 14:48:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v25 05/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue,  9 Mar 2021 06:42:23 -0800
Message-Id: <20210309144243.12519-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 10 ++++++++--
 6 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 38059fedb693..911e74840593 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1926,7 +1926,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1942,8 +1943,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 45da229f9f1f..e27424216159 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1361,8 +1362,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 385f7769ae5b..829005d3228d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -472,6 +472,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -670,7 +671,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rules);
 			}
@@ -685,15 +688,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -705,7 +710,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 8e8b5251550e..475f5622a903 100644
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
index 42a11f2c1068..81d45b471a62 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -607,6 +607,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
@@ -619,14 +620,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
 		default:
diff --git a/security/security.c b/security/security.c
index 4d4b0a21bea2..67e9345741b8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2618,11 +2618,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2630,7 +2633,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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
2.29.2

