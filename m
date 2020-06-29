Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D220D497
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgF2TJ4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 15:09:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50382 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbgF2TJy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 15:09:54 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 328C820B4904;
        Mon, 29 Jun 2020 08:31:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 328C820B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593444672;
        bh=6ZAZLRdiVmhJSotXumflMugZiteYC6hE4wK0N2IMWYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iE6FwL5pkqNJ+D5EKPLuBSJ6t2EamXVQtIgimYH3NTz+/m6iAqvPMKibVX9huKOhS
         bwF9HbBeqw6gTxc45Xiy6vfBhPGmjSnqofkv6Un+Q5APCtuUITSWlzpD5dFSbCvb5s
         51vbIlpPIX5UoiCkEcK7RGLA88jityVKynrVKvbg=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] ima: Rename internal audit rule functions
Date:   Mon, 29 Jun 2020 10:30:37 -0500
Message-Id: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rename IMA's internal audit rule functions from security_filter_rule_*()
to ima_audit_rule_*(). This avoids polluting the security_* namespace,
which is typically reserved for general security subsystem
infrastructure, and better aligns the IMA function names with the names
of the LSM hooks.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
---

Developed on top of next-integrity-testing, commit cd1d8603df60 ("IMA:
Add audit log for failure conditions"), plus this patch series:

 [PATCH v2 00/11] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE rule support
 https://lore.kernel.org/linux-integrity/20200626223900.253615-1-tyhicks@linux.microsoft.com/T/#t

This patch has dependencies on the above patch series.

Tested with and without CONFIG_IMA_LSM_RULES enabled by attempting to
load IMA policy with rules containing the subj_role=foo conditional.
Build logs are clean in both configurations. The IMA policy was first
loaded without and then with a valid AppArmor profile named "foo". The
behavior is the same before and after this patch is applied:

                  | CONFIG_IMA_LSM_RULES=n   | CONFIG_IMA_LSM_RULES=y
-----------------------------------------------------------------------
 Without Profile  |  IMA policy load fails   | IMA policy load fails
 With Profile     |  IMA policy load fails   | IMA policy load succeeds

 security/integrity/ima/ima.h        | 16 +++++++--------
 security/integrity/ima/ima_policy.c | 30 +++++++++++++----------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ff2bf57ff0c7..5d62ee8319f4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -419,24 +419,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
-#define security_filter_rule_init security_audit_rule_init
-#define security_filter_rule_free security_audit_rule_free
-#define security_filter_rule_match security_audit_rule_match
+#define ima_audit_rule_init security_audit_rule_init
+#define ima_audit_rule_free security_audit_rule_free
+#define ima_audit_rule_match security_audit_rule_match
 
 #else
 
-static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
-					    void **lsmrule)
+static inline int ima_audit_rule_init(u32 field, u32 op, char *rulestr,
+				      void **lsmrule)
 {
 	return -EINVAL;
 }
 
-static inline void security_filter_rule_free(void *lsmrule)
+static inline void ima_audit_rule_free(void *lsmrule)
 {
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int ima_audit_rule_match(u32 secid, u32 field, u32 op,
+				       void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 294323b36d06..60894656a4b7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		security_filter_rule_free(entry->lsm[i].rule);
+		ima_audit_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -308,10 +308,9 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		 */
 		entry->lsm[i].args_p = NULL;
 
-		security_filter_rule_init(nentry->lsm[i].type,
-					  Audit_equal,
-					  nentry->lsm[i].args_p,
-					  &nentry->lsm[i].rule);
+		ima_audit_rule_init(nentry->lsm[i].type, Audit_equal,
+				    nentry->lsm[i].args_p,
+				    &nentry->lsm[i].rule);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				entry->lsm[i].args_p);
@@ -495,18 +494,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
-							rule->lsm[i].type,
-							Audit_equal,
-							rule->lsm[i].rule);
+			rc = ima_audit_rule_match(osid, rule->lsm[i].type,
+						  Audit_equal,
+						  rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
-							rule->lsm[i].type,
-							Audit_equal,
-							rule->lsm[i].rule);
+			rc = ima_audit_rule_match(secid, rule->lsm[i].type,
+						  Audit_equal,
+						  rule->lsm[i].rule);
 		default:
 			break;
 		}
@@ -901,10 +898,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		return -ENOMEM;
 
 	entry->lsm[lsm_rule].type = audit_type;
-	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
-					   Audit_equal,
-					   entry->lsm[lsm_rule].args_p,
-					   &entry->lsm[lsm_rule].rule);
+	result = ima_audit_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
+				     entry->lsm[lsm_rule].args_p,
+				     &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
-- 
2.25.1

