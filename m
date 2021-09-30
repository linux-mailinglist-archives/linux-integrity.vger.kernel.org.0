Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D914E41D928
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbhI3L5b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:57:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3896 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbhI3L5a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:57:30 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs7n662Yz686cr;
        Thu, 30 Sep 2021 19:53:09 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:55:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/7] ima: Introduce new policy keyword use_diglim
Date:   Thu, 30 Sep 2021 13:55:28 +0200
Message-ID: <20210930115533.878169-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930115533.878169-1-roberto.sassu@huawei.com>
References: <20210930115533.878169-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce the 'use_diglim' policy keyword to enable the usage of
DIGLIM if the file matches the other criteria of the rule.

If the file or metadata digest is found in the DIGLIM hash table,
'use_diglim':
- skips the creation of a new measurement entry (action=measure)
- allows access to the file (action=appraise)

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy |  4 +++-
 security/integrity/ima/ima_policy.c  | 36 +++++++++++++++++++++++++---
 security/integrity/integrity.h       |  2 ++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index a8a5791db14c..4979fc068b0e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,7 +27,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
-				[appraise_flag=] [appraise_algos=] [keyrings=]
+				[appraise_flag=] [appraise_algos=] [keyrings=] [use_diglim]
 		  base:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
@@ -60,6 +60,8 @@ Description:
 			For example, "sha256,sha512" to only accept to appraise
 			files where the security.ima xattr was hashed with one
 			of these two algorithms.
+			use_diglim: enables usage of DIGLIM for measurement and
+			appraisal
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 084b5d9257da..dfab21aeb7e1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1048,7 +1048,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_use_diglim, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1087,6 +1087,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_use_diglim, "use_diglim"},
 	{Opt_err, NULL}
 };
 
@@ -1181,6 +1182,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	if (entry->action != MEASURE && entry->flags & IMA_PCR)
 		return false;
 
+	/*
+	 * Ensure that measurements made with DIGLIM don't have the standard
+	 * IMA PCR.
+	 */
+	if ((entry->flags & IMA_USE_DIGLIM_MEASURE) &&
+	    (!(entry->flags & IMA_PCR) ||
+	     entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX))
+		return false;
+
 	if (entry->action != APPRAISE &&
 	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
 			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS |
@@ -1215,7 +1225,9 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_META_IMMUTABLE_REQUIRED))
+				     IMA_META_IMMUTABLE_REQUIRED |
+				     IMA_USE_DIGLIM_MEASURE |
+				     IMA_USE_DIGLIM_APPRAISE))
 			return false;
 
 		break;
@@ -1229,7 +1241,9 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS |
-				     IMA_META_IMMUTABLE_REQUIRED))
+				     IMA_META_IMMUTABLE_REQUIRED |
+				     IMA_USE_DIGLIM_MEASURE |
+				     IMA_USE_DIGLIM_APPRAISE))
 			return false;
 
 		break;
@@ -1719,6 +1733,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_use_diglim:
+			ima_log_string(ab, "use_diglim", args[0].from);
+			if (entry->action != IMA_MEASURE &&
+			    entry->action != IMA_APPRAISE) {
+				result = -EINVAL;
+				break;
+			}
+
+			if (entry->action == IMA_MEASURE)
+				entry->flags |= IMA_USE_DIGLIM_MEASURE;
+			else
+				entry->flags |= IMA_USE_DIGLIM_APPRAISE;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -2058,6 +2085,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_type=meta_immutable ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if ((entry->flags & IMA_USE_DIGLIM_MEASURE) ||
+	    (entry->flags & IMA_USE_DIGLIM_APPRAISE))
+		seq_puts(m, "use_diglim ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index cb4a8cd2a213..89ed87a957bc 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -44,6 +44,8 @@
 #define IMA_MODSIG_ALLOWED	0x0000000020000000
 #define IMA_CHECK_BLACKLIST	0x0000000040000000
 #define IMA_META_IMMUTABLE_REQUIRED	0x0000000080000000
+#define IMA_USE_DIGLIM_MEASURE	0x0000000100000000
+#define IMA_USE_DIGLIM_APPRAISE	0x0000000200000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.32.0

