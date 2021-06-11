Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D13A384E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 02:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFKAMW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 20:12:22 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:37584
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbhFKAMR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 20:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370220; bh=q97VNdgJJold01jpe83mBVgZBuOdQTi6Fd/jqBjN4kc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eUpQuNrdS9+ayPKM0lZDyYsXRv2C5PqN+0nogHgnFpAdRObjSqrvcs3FaWVdrxkjkNOMrBlM35+x96dt8hfUPzdxeNdx/OHXgm2gVyuta1iSDz20dm+N2Uv4d4ViMeVMUJy8BjyxdHmv2GEH6/X+lffh5zEadqVCnhCcGm9XSRzQul244ZD+23LAG81BtQoHEQ+y4EcOcSW/Hg3HrTdFtXbiLdJvZv3ZWRjboaY+uOkVF8sDVyE7+/UGL6zC+5BU9SNYVNqBn8puyktHgtH980yOKMJzDlFEwuV2vf789QqAjeZ7Vg3cRuQ2Z/w5STlFMZRFDD8ov3BQdbIqC34lfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370220; bh=C/3gsPf0xYOwXqFJ+exFYLhW+CP4H3iI2d1aUarfN9w=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Wzk4hE0OwUlxRR6yqAA4VH4AGtf/LeKidkAh/lGitb+3qRAlgY4WStPnev0wyZn+OQ70FVpo8qC+cFVPmZ84RzEwnc8taShpQOTtvuPKdnfPJN3dzEzn4l9xmFLn3uvefRS9r+TuCvipex85wGw4tMWs5Xzq7h/2Yj5Wj9OscVKjmr/NccaeGhWkxpm45c9Xag7jBrPHCs6KL1G6Yv584/L6aTzl6kjPABHWgAEYUzIefXxa96iyufhIeng/dXne8n3OOCT/8lCgXhTdMtJRQLGCrauHKTxk/2Iqhutvn88twfEG4u51WJ41hWH7KniSYclEc2x480q+FtJ1OlOgag==
X-YMail-OSG: bqmdEDIVM1mkFbYywXWYtEOC_mgVGZft1Hs95.AhPxajYETqGoLOHfakwcTdk4_
 L2WS6I8Spwz1EpBIUPY0zdioIwbKR1ClPpi1.6RckAA6Hl6p66jDrdvxHBzJ5UoHRqJT9cOw0Fk6
 EVDX1aPHKbuAn__zfwHbtAguzIhdlNclyH_vL8ws10_j4PbbrsI0d31VC91MBGZGoNBrclAzVNei
 B75Pk0xr2.AL28f9fr2otMqPEEuZGOFS6O488oGjcaRvQvU0aSjpALERUiCwS0Ey14epyy8BXgzZ
 9FUSbwJ5IBNRH4nv2cHTN.WztmM86L4NA9FckZwUbe9gT0dfcbC8xE3CGBQBqAT9TJVnDLhKJ6ma
 3YCiCm4ttgrAW3y3K9YRjOXDREfSjj_qDa5ERsHDKlc5AKwE8WkoNKXyr3a4nDEHDTHrpe5Q.bco
 BKZKyvJ1yltByUZYAixfZfQ1F7_W69vhFfTkPKNY.p8TOYTi8_RiYz8Y5XGPAARX1g50vAyFQIZt
 NaYUadtHWbIEfAaBd1W2L6HKMt1abghozzwEVNIYiYjyYMdZ52OEBdP326L9cHdhK.2IJq7Natyc
 lHd9sGByVUEOq6i_y374XQdCtUtamk_1BD0X.Fvbo4p0TmTdzDFh9qtPiYNGKKirpsmcReBIT8rH
 bxSkThm1SUaD8iMt_.VeQrrIm0BkUrhULSLmGKZkBK_Ygx1rEFDMytqsGHA9LlRl11gIAhV.RRl2
 GIWmpl7FvLY_nXirpJ.SFnqGSd92b7E4xDBcI2Nb1.MZ_FO4uHUKwpOuM7n2pcZNG1WR0390fmxL
 eQZsohdlpSRqvDFQ2j2HrW0Phd0SJej2jIN0lQ0W4U.enKY.KecE50lTKQjRQjdw0k5UXg1Q9gZY
 CEPHV3HfeeRxlb492OGwMwroGPP_oK1ZcPlF.gb82eq7mZlTtj0ybQq.3082_UxTTYIWn_laaPOb
 9LUS2hXzpjB_e88K06WdEIDmP1cRNL1DMSnpJAEuLD2y0WOKOQ9N8.CUZ7G8GKvou9zd6.2v_Hju
 xEjITwtLesMWGc2IuzRJCYnvVr_c9rrDviemEtXOVPf_jk6KRAWvxlIOcAFa_bgy29WXlFREHT.m
 O4ZI3ryGkAnConbdHCdfGLmICgCI_bA.gXEkvfZlpyaPXdW1G2XZ15MiipDWfqLOfjsyxNDCgV81
 EupcMEX3GLtLhvhNXr22eQx4q7Thd4SsZYLprEZAMF0c63b1Jf1mHMBoIx1JzUlUbhk9gLZdnuLg
 qJSBCHIeIBtQ0EEZAR1qSV0z6WD.BaT7DjlJvOGZX8tt5mBKbALi8mrzC5.Y1nkwsc5doD36qaQ2
 5tuxwMY.4HniKe5WKGTzpjKRJ3vogCu5teIZj6q9SWCcEx87SMVt7_hIyEBl3GzYlEwMjSIz30sb
 d0iQRjgo.kV3QKicsGEN.._d0_WJ3KT7WfZAb4jmx9CcoJhp9oQcRXqXnkBOu93zxsIWeTwsmIkr
 wOFc5DS9s5sOrMZowWeaJflS3rtiiuyvns_TGKNhdlBeQlWVWDlIvXgwQZyC21dJPqhyr40aDTEa
 shJoWH5f8ziuE_tvtaO0HIEqJK31vNINrRzyDettrVke_X989x_oM_fVBxSB.hHEpkYaTp.vhXe0
 _BvtG8ytmGYK6efoJYeGKdZw1W5fTDNDmznZfcLLvDWJjRARid3Gsx844JJ5mms4xSBGrkTwOXI0
 0XiYrgNuY0zhKtRjJclsvw1OSPuiSzkzYLayATkxOzOdzPaHNCwCjQQcHH3BONXAU2z3PB2ueIEc
 wC9CIQ.RbUb9ZLl8Q1D.RDIAeoMLERhM4I_SnAP_27RD_6SZoDnoNdQMZdF74M7cbZoa8IIGf4qT
 M0P3HNbkLlUze8DV47FrCTTFcJjaFPAWDC33Gpr_Di8JWWKIE5dbtK5vN4.2JqhFc_kdkLQZYr.h
 fTBI.oD1x4Mqnf0gKAIL9NifMem3ah4JAH4ApXOxOpQsZJa.rI6BNrQQ0tYcCYTNjsWMyp7GLt4r
 N.EDjuCXl0Xfa0lf86CoRIGD.wx2rd6TU6tGGxvUSob5BX9gHycI0Ihz8BncbY9wWCLSkGNtkbZv
 J2JEUSAr8da3jgaIrqXIxg6a0uT.jioCIJkC5L5HjUx1vw4AymZBy5NJ9ksuTRG6.DiZIrsK50Jc
 bKKw5ZnoHhAscE.R0rvotz5XoAgi0pnMT7pqSinzDhbBCJwpIBjTGgbomuHpO1qYO5OMC9lMssTZ
 iK7K6MZJiv3856mMlDqSAPXRvZTJHGyA2NPvfVZpINT0aY3AvRUee0p8TZpV0e6pVsK4.gewmSaQ
 VMiX4k.uRRHMtlRLs7XBqc77JlWZlt3Zw_j1md.NfDMMe3ljBsTMzTUkMjkb2VK_azjvH0.GGD4W
 2XaKrFBrNS5jNutFZ5IiHexmq_FADuN_FS5OUcAFzTpXbgUvOGo8ihl9ONtjvrJkSVgIMjZH6ina
 YQr5WQyDAcATV3_e3Q.odGoRiZRMja5ibcIWgmb4D2zdSAAFnNgZgjMtPWFYPeqatf2upNPb2G.8
 0HcTkftUpYxgDpRO4e0aP1gJyvC6qwxh6VP7aEVr9taopevV0vabdG.OSx3I2E08HDrIYgDfRliU
 R21aCWRoTq7MbdoeutJjnqgeiOP.ZxP82n4b76vnTsE9Flrn.ZNfCA.My_njEy8jW_1inP.BdElc
 sqZT_VUSb8UXnuF9zgl.ELqZ4xG1C4v6dU6pUPevUUOAhJuitTxucpGsD9_sswHGWrbklq5X2Krt
 mDt4YN6qwahT7A.Lfrh3Dno5MaAb1elsU53YyugCm8D0dL44N3hzSp5gkttzmP5a4D_pyCSV01Rp
 y587NMxCjKWN5HMLRNYMcrWdCtjgjQBaxz_8sFlceJu2.SHuGlCFzeTH_C3MXVr5YSh42V1o8vJE
 I_NTtRpMXAFFO1rF2v3hnhkJovl0UWZMoW6IhPpD7IW366DruigAo3BEuqXT7Vby3JwS5AbvQa8_
 5b7BKNSZx4O.gaRxlvP7DLhY_5GMVD4fe8jy1gxXqS3cFvnACtIkrsEiy3lLx8Qxd57boxmkDUus
 XE8ylafKST28M9WKxVIXiEi8NlGMLaE4v1p5LFhFuwsMp59WfL7I2HkJnsZ2MucGPtnX9ZHmqYmf
 D93ZBIXNfpLT2vJwvihzYLg0BmVe7gpp0XOi5nZ6ZSllhaNewSv3DW0ycj4KhftdYv9aM
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:10:20 +0000
Received: by kubenode562.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5a52879a1461170ad8caad907adee61b;
          Fri, 11 Jun 2021 00:10:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v27 05/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 10 Jun 2021 17:04:15 -0700
Message-Id: <20210611000435.36398-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index ca9485105f00..916a0f606035 100644
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
index 392afe3e2fd6..71d894dcdc01 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -472,6 +472,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -670,8 +671,10 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -684,15 +687,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -704,7 +709,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index d804b9a0dd95..a05841e1012b 100644
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
 			break;
diff --git a/security/security.c b/security/security.c
index 6387107e4014..d467231342da 100644
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
2.29.2

