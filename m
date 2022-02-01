Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C474A65D0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiBAUiJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233037AbiBAUiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IP7Yf002366;
        Tue, 1 Feb 2022 20:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qRyvCHQdl8zcSmTSo84/LqeeAww6VKoV8Z/ytaA+dz4=;
 b=R85sYntcGhNZdG/+9LjUqdvvFG1ganJZtHdI4CGN2xy7HqtbfDASG96qwHoQDDPzXEYE
 2CeHb0eUZJ9/RJ/Sp/Qr5WT9ePP4Wp6s+jRrvOWOtyaiaHAnwynzQfIh6mktrk5USdnA
 nJx3unoPguVgGGEMUx/wiEWltarjOM1yuRBB5decPv+NNDZwx7QObYsQn0tloQMVMC8G
 zgwHY0SgfceDdJgt8k1RXiERzFyV5hiKnSsBlYiEZo3PzwOTjHoX6CPjUQnRTsnWqqwL
 1sarYqMZVMFwmnX6XJWyJf6nW8bVtHQJDvqigDQb2wmkRn9gbWJZmxWw62n0Mx4DbixA NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dya47a7xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KTlY6009582;
        Tue, 1 Feb 2022 20:37:55 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dya47a7wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KXDl2009596;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3dvw7as59h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KbqZI34079130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AE2B206B;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6263B2065;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 26/27] ima: Limit number of policy rules in non-init_ima_ns
Date:   Tue,  1 Feb 2022 15:37:34 -0500
Message-Id: <20220201203735.164593-27-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: th8dZIhDsC9eA80rW6QR4Rdhory28EAS
X-Proofpoint-ORIG-GUID: Gn5qGOmHE_rKJW8_NWM5C4oPxIWDDcVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Limit the number of policy rules one can set in non-init_ima_ns to a
hardcoded 1024 rules. If the user attempts to exceed this limit by
setting too many additional rules, emit an audit message with the cause
'too-many-rules' and simply ignore the newly added rules.

Switch the accounting for the memory allocated for IMA policy rules to
GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c     | 20 ++++++++++++++------
 security/integrity/ima/ima_policy.c | 23 ++++++++++++++++++-----
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 58d80884880f..cd102bbd4677 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -410,24 +410,32 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	struct ima_namespace *ns = &init_ima_ns;
 	const char *cause = ns->valid_policy ? "completed" : "failed";
+	int err = 0;
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (ns->valid_policy && ima_check_policy(ns) < 0) {
-		cause = "failed";
-		ns->valid_policy = 0;
+	if (ns->valid_policy) {
+		err = ima_check_policy(ns);
+		if (err < 0) {
+			if (err == -ENOSPC)
+				cause = "too-many-rules";
+			else
+				cause = "failed";
+			ns->valid_policy = 0;
+		}
 	}
 
 	pr_info("policy update %s\n", cause);
-	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !ns->valid_policy, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				"policy_update", cause, !ns->valid_policy, 0,
+				-err);
 
 	if (!ns->valid_policy) {
 		ima_delete_rules(ns);
 		ns->valid_policy = 1;
 		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
-		return 0;
+		return err;
 	}
 
 	ima_update_policy(ns);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index acb4c36e539f..3f84d04f101d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -305,7 +305,8 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		return ERR_PTR(-EINVAL);
 	}
 
-	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
+	opt_list = kzalloc(struct_size(opt_list, items, count),
+			   GFP_KERNEL_ACCOUNT);
 	if (!opt_list) {
 		kfree(src_copy);
 		return ERR_PTR(-ENOMEM);
@@ -379,7 +380,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL_ACCOUNT);
 	if (!nentry)
 		return NULL;
 
@@ -826,7 +827,7 @@ static void add_rules(struct ima_namespace *ns,
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 			if (!entry)
 				continue;
 
@@ -863,7 +864,7 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 	ns->arch_policy_entry = kcalloc(arch_entries + 1,
 					sizeof(*ns->arch_policy_entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ns->arch_policy_entry)
 		return 0;
 
@@ -975,8 +976,20 @@ void __init ima_init_policy(struct ima_namespace *ns)
 /* Make sure we have a valid policy, at least containing some rules. */
 int ima_check_policy(struct ima_namespace *ns)
 {
+	struct ima_rule_entry *entry;
+	size_t len1 = 0;
+	size_t len2 = 0;
+
 	if (list_empty(&ns->ima_temp_rules))
 		return -EINVAL;
+	if (ns != &init_ima_ns) {
+		list_for_each_entry(entry, &ns->ima_temp_rules, list)
+			len1++;
+		list_for_each_entry(entry, &ns->ima_policy_rules, list)
+			len2++;
+		if (len1 + len2 > 1024)
+			return -ENOSPC;
+	}
 	return 0;
 }
 
@@ -1848,7 +1861,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	if (*p == '#' || *p == '\0')
 		return len;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
-- 
2.31.1

