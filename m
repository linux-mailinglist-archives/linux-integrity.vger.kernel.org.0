Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809132BB672
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 21:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgKTUSi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 15:18:38 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:43278
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730450AbgKTUSi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 15:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605903515; bh=9MAi/LYB0speU+LRF2qgGstFEyg/96KvotQ1I5WfdEI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bej5qH8V4UgAtouV/CS2tLmgep/ruE5EAehoLRTNXWLbYVyMsIjL3FtmsbZp+O3ELg9DkEUpw/xALnJWCv0TQdw/wXTjggk4VcwPSpT7l41QxGab8vQParsjj6JqiW0M+7vn0uAMfE11sjcP1q14CPZDeGCcxJZ2DKysoatyd7QO2lLfslz6RsDSARl861Im5S0jUaJ3RcuYCwIGpi4lMXPkCQ0kq2hL3urnW6U0aHnt7d8OyddVoSzaT7fqVCMcXwBCOGJGLQGjAKZ+w+B+6nIW1TJZJ9gUQjrLl6lKKrGOOady9l4iujNEQ9rywPQT/NygqAaMsiwd0L0iaBwtOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605903515; bh=Y+lYtThC/ExlOTD+qnOBk0yHzxOLu1peAaLXotSet6m=; h=From:To:Subject:Date:From:Subject; b=VatUHeKkgKiBL755P4aYxOxWiJZIPo76RXi2BAR40uJxNOMxeI7Zw6y+HCG+/T7hEOgvW0w+H0giUHQpB3qLZlgmdcVQP+w7nJhU4N+YgXQJrAgPDNzHgCQJMZdt1tCNeBki9rPhVaR3CqfF2USvOlBUmYZ5qdDiE5Acmqb5/GM9kfcA44rKIb7PN86p4Vq8LvYJlnpPadVqZngFeQK1nvxEMtYDAZIP+NK9BZn+N/D0HOaS4GCpu04xNDefjIHPczEB/D+Y1oXBJOxRUiRop56zcjgoxJw8qiA4CSQEzvQW38jB3Fqwvn9h25qlIuqr+f+7R9r/USt+YC/5xN8yuA==
X-YMail-OSG: 4qBx6DQVM1lyqmxeej7TQbyLc0TUsrN2ma5B3KO_769QV29_NOtVjhT3IgbNi03
 osstjdU7iLHxPIoxq2yYl5TmNVVbbHrn5XZc3nclXxNCg6cpsbAC8JXUUyS15F2TjUW0JFiBNeso
 yUF45QoL4Gelsa_ZqXhJ7ByJwkPsNe8XqbjdO1b7NuR7YQ7KxR.MbLpisF0siZk9r2IOthAmMYJ.
 djBdHUPx2hDOykVkEXmVIJ52NtaYbrWaV3bRleLBHaxmjzD9g.cDWPD_9lvT204MpZo6RDH7M68c
 B108btKU0z.uEppdUsT8Q3ClCGLeTy_TMskHNNYhzIXFoYUwPjNSkShRHRnWmF.7YAxi1vA_PksQ
 w2WgyNjjTA41BOT5uzbv1ZYwczmrQ2wNvqVRw.1yQ0MJgd5h_19nQrQqc5WVe21nnPc5kg8YOdsp
 7l9.vSTWt7oNDXiYeU5sz5InNqFsxAgeVrVay1Th6m2u.hHvDc3aGW8qS4dviIcs2tOsqurQc7Xo
 cxYeG9MuW81RNtGYkqwCEXufeehxsJNvfywYZa7AiUGkmoyX8ynoE4WjGyexmZfKddA_PYPybwC8
 gYwOicW9PP.tb0gWu5jvUPMIJA216qxJC2c0d2lblg4JNZtDDZ7kuiINhv74JVbL2DmcHM3s3Zw9
 cRLT_RfhDQ9x8vYykjqlHPSmIF9TmjzOzIUU_tjpMk_suJZFMySb6wBsN8kK.GA23SPqvkWpa4nr
 5tgOXHAYXiBIxRZdorTlpyq.1PNuVF5O2FQN5XkqhAm2pmSNrR5pDDao7BaatqeIKJhYHEOBy_cy
 4TGqHwnX6XS8Dp3OBDSkzwtgzBaVNIsiayGV0iLGJMshg3D5JF1J2RjJZDu5ZqE.kGb2b4xgRNnr
 5tESrnAYclVcwvUqWbX65Ph7Q7DCNLX3NP57phmvTLoYY4WV20FzIxZrkLAEgz2PjtXfUcjFj318
 BqHR5QT6hZ962tBHbBch0nUav7ANp5AvMiTkfh35iu32PaSZ6lZJDsx9YRo9NcG22a4abXOS9csM
 F.6wsW5SFTBFUc4D_Gr3AdDQ1q6u4vNvZYe.DemJXcV2HIDqnOmriM1ov50QKHXEtjaMm6aTvxxJ
 qwdAKnvJRGIac8p6LLFzIGzI7bz02QKYLED.9x1DIIhYT8FNSVgiA8cRZBXv8TIK4eRILw_NdA9X
 unJsmY10.jWTOBIztGXYEiyXms2VRajr0OXU0r2pWjJNxYM7dcj6ewl1Z40E2SXGAphKgr1r09z6
 IeQRaghSzC1lOo.tuJBb4xg9Y1OYJE9EVBuRESiGRRRr.yzqLhIW4iK85q8ZJCaJS64geYlHTiZu
 mVjHG.wro16vK.FROG.YZBCJx9QUBOmHvdNdiQhseWcs95l_SQtMjKMSaIBYCaq7TMfM5wxFrljt
 a8hSJ1Bv4nRdvCWU4Gz74JArVaaYlTbUECGClRRzXvX43K0WUWIRUXmKWAFahbPp.y7OxNvk6zkv
 2l.MDEYJCFDPxd.Qi6BHD2jCYZutZvpJL6LL2Ln9C3ZJPQsbvtbkCEsIVWcEQ0v9dN_benzS4dWR
 UEWV7MBxyEkjmLpGl3gK_eqXJTFbqRGM.6V7bRZFv9Hb2hX10_n__XgVbpM1WJ6zlvwREPOGEER2
 39vuAwkRpCByie3paDni2xdQkfVGO16mlqSJoqJcZebc_DGMBM31OJiAVaknPpjEmKch5Oq8GP.9
 Z3CAyq9NTvMMAI8.YjWDOw6EmqulJiJjdeExS3yE41Ezxe.HC3UtklP2BKPpd1GJovvmoOQzw7G4
 ppN412uwUI.kdHi_75mv8MkKJl5qyaaqSG74STfLYF90RfYbT41uaSzvSD33srQpxXXbQdfs9OCI
 LOSxKMJGzcC7xv9ah46w8yEIQq7TufMARFbmroG2Gq5c2KI9r4ERGD2OPLuDPUZcKEK8lSFL9dRa
 gZDkCFMwBox1wn56pLAR7T2mNy7pBitwNYyMK2WMxGuwoc0zyTErEh2QfYSycHHRpEopIksUM4CR
 SpsTu3OHSW6rPDstGlQbK4lH0r2ErjTLjcyB3qwLm0z7d8vm96Iu63BIggXoL3BcCt6DrWiP1X.j
 XBRFRsSbYsBIcWLgwinxe0HbrywcaHimVkZM_pDW6HXp8EiUNZPnwJx8URp.cUFps0VCwK11rnl.
 zYAstC_MHfomHnkAihCL1gqmoArJva1vs9BiqS_VuwXpgIpiehRHfkD34Fiqm7yxB.7MhhSB_tNt
 RtLnSuzCBSCKSbRjYty7pqj9hd.TU5bBMAME2RjjwAtzIEhXsJQML1bcSPewSS.X9T4J7KWNzElU
 MW.VNWbJw5NOSvIOwHgIT.JLdywKsU5ld_t.KyoPpRxr3qw03wzLsZTyLPI4ug7i7TIfzNIeNthd
 yYJzIslIQi40tlSeceKTCZu1blfrWtq0wRJLjyz_lv03PWSQI8ACj5DXeoFzJ_3wqQCt208am9u0
 PS7l9WI_hXtHvcLGpZqPKiVacG90.5iMvlmzwOP57Z1Ptoc6R9eCGbt9c_Wr6oU60_K3jqaINVVK
 J6n9p6rPx3W43p4VIjHanH1UvLP.eCyXCmTvKUmWTmbpB0xV4wsVzfK677XkF7dlVc3BI.vQBe28
 4JpG3YGrLfi1Ai.OOhPWV343gfLuqBXgXU0u4MS2uKLx1ccjLg9h25uEWLk1EhDn.0LwN3N0g5S2
 4KbhV12rObaGz6tDyEDiHw2HeYFLzcKJdUBkZzrujvaFw8YxX2b.httTPXOuO.pUefq2XutnbEMZ
 gsI9u.aMuCbjkQ6Uogkkfyx4hAtOjvf2yAc4KCaiiL7uMTd0SvkiKjA.ZxYWmwAfCRPRmg_xj_vv
 Kl4ENe9RL4jNOz363LH6mCzhjTtbkUfPJP4BTjrE9nGlqe.LkvRCCCJdongDC6KqCF3zS_D4P7Mh
 40qDxobdfmVPVbdj_u6Ejg9r7Xxp3iBRzxetwuCdDe7RVh7zS7y4lSR_4B7hPt8O8NF0Be70UnCj
 AuQdoQEufRgSED47bfuKUXVytlMDMfFK6CMsNwftms0ZwjcjTgNKuu.Y3MctJ0ZinOjAVHfp5h4A
 j8idDHmKAW2UL6fxCkXciFy45kpGA3AXB_lprFuSq.XX3AvTZsIpJpBS4UPq_bKUZWibYdDWEmvj
 zZifM5uDKhDj_oy4487qyIQqPn_tAtbllF_osvgDAo7Ut.XlAuOdb3tWB3lI7u.J1ocK4LnMh9ri
 D7GbTdnCkVVnkFnFBSUJYxe.FnxWTgb5Dk.12cGpDRStAPN5aezS6YCupQC6H0xCos1Xa2GMbgmB
 f8mzkxpCQt26uZeVXr1JC89iUNUxHkFV9IzfZSnMK6Gic.40pTR3D8EnP8KiwX.4vGYRBhRv0_v_
 QMkKQsfZxZvlJgMYIvKZ_qzGQgPENWEGlDm9QQoPfhUDQudgJMISD.Y8aBl3yFCbGrWEItPu6G0z
 t2mbe4hLap0Ica9W.bLM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:18:35 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 928f9f0a3ea665543955f7060f39dc12;
          Fri, 20 Nov 2020 20:18:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v23 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Fri, 20 Nov 2020 12:14:47 -0800
Message-Id: <20201120201507.11993-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
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
To: Mimi Zohar <zohar@linux.ibm.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 10 ++++++++--
 6 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fdb6e95c98e8..89c538aa283e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1892,7 +1892,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1908,8 +1909,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 16e3430f7d07..7dd6b815a9eb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -474,6 +474,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -672,7 +673,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -687,15 +690,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -707,7 +712,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 6ebefec616e4..6bae2ee9b251 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -429,8 +429,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
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
index cd393aaa17d5..3e47cc9b7400 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -562,6 +562,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -574,14 +575,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
diff --git a/security/security.c b/security/security.c
index d01363cb0082..4ecbef074809 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2558,11 +2558,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2570,7 +2573,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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
2.24.1

