Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0652B12FCBF
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgACSyI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 13:54:08 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:42094
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbgACSyH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 13:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578077643; bh=pL+d9OKQE1ZHAGCzy1pmqa6oN7KW60Eqi/6jwTiGtjA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ouqGc+c0Hr2GfPWxhbfHARupHvLSULSZgzY9Z82xUJicUYJuoZINHpR0KK79qDfHUYu6Mb91ohWXQ3j6BWezXFRym5f5G58Ru69txHZfLwJ1jM3aKQH0qkOesr5EH7nCfmb6Rtf3vO1HEm58Vflg6OscFFpgMbUPPR2BDVI1C1lGkEAmsK2Jk9FGA6SRssgsoLV4K0NbhH42VMIOmBFvX3xjTYsiimmd4D3hQ1PISYHo18u6LNx4YZUUnWAPNaByv5Dierqol+ezG1Wg+Vqw87SQ51MhKO0vVj8VKWCaibK1j0h1FeKRPOm8lsxcQQNwZdaScMhwa7M++6M2KUAj1A==
X-YMail-OSG: DV4CoJMVM1lFVw77HFsU84aXjBxXiEHtGmR.ngHWPtiVCHlmU0obVuN7zoP78Ih
 t9WZp5hKuofJIFEcEystu1DdcDsDMc.p_QFrnv3XR3q5BrH8vx91Oo6Eoft3mm0riNhDKIROGli0
 4S5oDI1_WcrxqH0c5Pe.Re87qWTdQ82KInMzDyG63YtFfkFlVYtdXGHH_Vzvyyxn99JTSFduwd8p
 mM3GOLzaP50sWzIUp58d.Zmr0TpQoYnrvWVMoBECL.HBIP6rBP0UqdaruFf0Z2azTfHLs6kMkQ6U
 0HAmAlGYB_lRvIu_a4jHmZquarJsDwzoxlBjiFgmyXe9M3RzqYYUvl84zhs_4SKsBtwSyU5BUHpn
 byy2NJQM8W9s8dyj.57qtipgri9RvHuLYJyJmlGMU5TnnZ1w9N_VnnD6QjYdfTt9RhmbmKcbvIes
 3m5Uk2Dmok7aLzdFeSgeiOHNQwTWUp62jFKmU8sL3K9HFcDC6RwrUO_.Jykx_B5SO1YD0wqZlT_1
 VNHZsWui1Ik2q4fbpuJm4tRWbmgnn1x7z85dqj8iLLzU4fOh9FjwApqE4N.QEyNaSZLjQHFf0vxA
 dccA5KreBKd5dg7mDBrKyGecNpByadAxob1Rb683FcasgFp7S8UvwG9JPHOZoEmjtilrylxGgmhT
 pDjKpo_CfyMNT7c4yvLMLbm.PUtmZJpNpV64nxOxyMjONWuW.nBa7nMx4Mr8wHRi18XXeye.NOVA
 vzCLJdpByyrZ8avBIyVjT1G6TBeSiYDDXSCk83plaOW4.wVsox__lGO7s3UU0Cpk3jYhNWdAO_tQ
 nt04RprF93IK3bJDOj9E3yqdaxExgiE5WEIySbqmuyo44A4kjICq1dWnBe6fLYVgLtFnPtyF9fcu
 PA_r58e2LhrRsNYgoqYK9B9d09YAg8upcuw_w1sWheeFINhn6DXozW_EM2PIyhqMG83E2d8fQJCF
 7qbJmP5fYZC5ig3cNJ7MMcCIj7YK1m.0iJWScg1ckwsXd1iKo988iTmWa6GC1ElnQnrHAshtDyB2
 epuhQBOpd.5F26CmsggsVpVYN8sH5fYhPy3o0x27k1dpbPeSoDU__e25pOMpM8gxPMKVpPAimm98
 TRtpEIRVyPCwYF14RENYPH354kf7wDXeLXoveaPSoOK18h2y3ZntToWWWhrCeO7Ww7_mhgMcqA4O
 d0mY7IQtLIBSPbD80urYQpE4qUY5lJ..VTfEC0VvpDD_t7ojhtKdaAR_QY267NyfQnaow1lW_ylv
 Amvm08PQPHRvpA.LZre_jkWn_DM_2CuwQ0jFoPMfZ.Klo0gNss69k9THKzEdABNoTa5uu7_gp6aY
 tO5Zqt9Cp1_DgI_CRczJ0bTwf1BpCop1z9JSVrvXkVkaH.278bXeETvSIYwhj.BkxaRXKxBC7xS7
 8AjNmOtQS2G2Q8oFLiqWxuUgplJw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Jan 2020 18:54:03 +0000
Received: by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b80d17ba84e1fd59eb23cefb977dbbbf;
          Fri, 03 Jan 2020 18:53:58 +0000 (UTC)
Subject: [PATCH v13 26/25] Audit: Multiple LSM support in audit rules
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
References: <20191224235939.7483-1-casey.ref@schaufler-ca.com>
 <20191224235939.7483-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ee5e4cea-b6c1-fa12-30de-8fc9007d69e9@schaufler-ca.com>
Date:   Fri, 3 Jan 2020 10:53:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With multiple possible security modules supporting audit rule
it is necessary to keep separate data for each module in the
audit rules. This affects IMA as well, as it re-uses the audit
rule list mechanisms.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/audit.h               |  4 +++-
 include/linux/security.h            |  8 +++----
 kernel/auditfilter.c                | 26 +++++++++++----------
 kernel/auditsc.c                    | 12 +++++-----
 security/integrity/ima/ima_policy.c | 36 +++++++++++++++++++----------
 security/security.c                 | 34 +++++++++++++++++++++++----
 6 files changed, 80 insertions(+), 40 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 2ce0e8da3922..d4213c471801 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <uapi/linux/audit.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
@@ -64,8 +65,9 @@ struct audit_field {
 		kuid_t			uid;
 		kgid_t			gid;
 		struct {
+			bool		lsm_isset;
 			char		*lsm_str;
-			void		*lsm_rule;
+			void		*lsm_rules[LSMBLOB_ENTRIES];
 		};
 	};
 	u32				op;
diff --git a/include/linux/security.h b/include/linux/security.h
index 26967055a002..0bf71dd74a9c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1887,8 +1887,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
 int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
-			      void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+			      void **lsmrule);
+void security_audit_rule_free(void **lsmrule);
 
 #else
 
@@ -1904,12 +1904,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
-					    u32 op, void *lsmrule)
+					    u32 op, void **lsmrule)
 {
 	return 0;
 }
 
-static inline void security_audit_rule_free(void *lsmrule)
+static inline void security_audit_rule_free(void **lsmrule)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bf28bb599b6d..0f351d1f6ef9 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -74,7 +74,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		kfree(f->lsm_str);
-		security_audit_rule_free(f->lsm_rule);
+		security_audit_rule_free(f->lsm_rules);
 	}
 }
 
@@ -517,7 +517,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.buflen += f->val;
 
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       f->lsm_rules);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -528,8 +528,10 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			if (err) {
 				kfree(str);
 				goto exit_free;
-			} else
+			} else {
+				f->lsm_isset = true;
 				f->lsm_str = str;
+			}
 			break;
 		case AUDIT_WATCH:
 			str = audit_unpack_string(&bufp, &remain, f->val);
@@ -767,7 +769,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 	return 0;
 }
 
-/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
+/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
@@ -781,9 +783,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 		return -ENOMEM;
 	df->lsm_str = lsm_str;
 
-	/* our own (refreshed) copy of lsm_rule */
+	/* our own (refreshed) copy of lsm_rules */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       df->lsm_rules);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -835,7 +837,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 	new->tree = old->tree;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
-	/* deep copy this information, updating the lsm_rule fields, because
+	/* deep copy this information, updating the lsm_rules fields, because
 	 * the originals will all be freed when the old rule is freed. */
 	for (i = 0; i < fcount; i++) {
 		switch (new->fields[i].type) {
@@ -1354,11 +1356,11 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_isset) {
 					security_task_getsecid(current, &blob);
 					result = security_audit_rule_match(
 							&blob, f->type,
-							f->op, f->lsm_rule);
+							f->op, f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1385,7 +1387,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1417,7 +1419,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1432,7 +1434,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 28fea2e73040..b9f81ef64c39 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -638,7 +638,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				if (need_sid) {
 					security_task_getsecid(tsk, &blob);
 					need_sid = 0;
@@ -646,7 +646,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
-								   f->lsm_rule);
+								   f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -656,21 +656,21 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_OBJ_LEV_HIGH:
 			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
 			   also applies here */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
 								&name->oblob,
 								f->type,
 								f->op,
-								f->lsm_rule);
+								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
 								&n->oblob,
 								f->type,
 								f->op,
-								f->lsm_rule)) {
+								f->lsm_rules)) {
 							++result;
 							break;
 						}
@@ -681,7 +681,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1c617ae74558..227993b8422d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -74,7 +74,7 @@ struct ima_rule_entry {
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
 	struct {
-		void *rule;	/* LSM file metadata specific */
+		void *rules[LSMBLOB_ENTRIES];
 		void *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -82,6 +82,16 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
 
+static inline bool ima_lsm_isset(void *rules[])
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (rules[i])
+			return true;
+	return false;
+}
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -252,9 +262,11 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
 static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 {
 	int i;
+	int r;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		kfree(entry->lsm[i].rule);
+		for (r = 0; r < LSMBLOB_ENTRIES; r++)
+			kfree(entry->lsm[i].rules[r]);
 		kfree(entry->lsm[i].args_p);
 	}
 	kfree(entry);
@@ -277,7 +289,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (!entry->lsm[i].rule)
+		if (!ima_lsm_isset(entry->lsm[i].rules))
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
@@ -289,7 +301,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		result = security_filter_rule_init(nentry->lsm[i].type,
 						   Audit_equal,
 						   nentry->lsm[i].args_p,
-						   &nentry->lsm[i].rule);
+						   nentry->lsm[i].rules);
 		if (result == -EINVAL)
 			pr_warn("ima: rule for LSM \'%d\' is undefined\n",
 				entry->lsm[i].type);
@@ -329,7 +341,7 @@ static void ima_lsm_update_rules(void)
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
 		needs_update = 0;
 		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].rule) {
+			if (ima_lsm_isset(entry->lsm[i].rules)) {
 				needs_update = 1;
 				break;
 			}
@@ -415,7 +427,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		struct lsmblob blob;
 
-		if (!rule->lsm[i].rule)
+		if (!ima_lsm_isset(rule->lsm[i].rules))
 			continue;
 
 		switch (i) {
@@ -426,7 +438,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule);
+							rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
@@ -434,7 +446,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule);
+							rule->lsm[i].rules);
 		default:
 			break;
 		}
@@ -811,7 +823,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (entry->lsm[lsm_rule].rule)
+	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -822,8 +834,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
 					   Audit_equal,
 					   entry->lsm[lsm_rule].args_p,
-					   &entry->lsm[lsm_rule].rule);
-	if (!entry->lsm[lsm_rule].rule) {
+					   entry->lsm[lsm_rule].rules);
+	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
 		kfree(entry->lsm[lsm_rule].args_p);
 		return -EINVAL;
 	}
@@ -1470,7 +1482,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (entry->lsm[i].rule) {
+		if (ima_lsm_isset(entry->lsm[i].rules)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
diff --git a/security/security.c b/security/security.c
index e94de64e114c..4be490512ed2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2831,7 +2831,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+	bool one_is_good = false;
+	int rc = 0;
+	int trc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		trc = hp->hook.audit_rule_init(field, op, rulestr,
+					       &lsmrule[hp->lsmid->slot]);
+		if (trc == 0)
+			one_is_good = true;
+		else
+			rc = trc;
+	}
+	if (one_is_good)
+		return 0;
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
@@ -2839,13 +2856,19 @@ int security_audit_rule_known(struct audit_krule *krule)
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
-void security_audit_rule_free(void *lsmrule)
+void security_audit_rule_free(void **lsmrule)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
+	}
 }
 
 int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
-			      void *lsmrule)
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2854,7 +2877,8 @@ int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
 		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
-					       field, op, lsmrule);
+					       field, op,
+					       &lsmrule[hp->lsmid->slot]);
 		if (rc != 0)
 			return rc;
 	}
-- 
2.20.1


