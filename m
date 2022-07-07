Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7749456A5DE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiGGOsd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiGGOs0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABA10CC;
        Thu,  7 Jul 2022 07:48:25 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EkpZV007596;
        Thu, 7 Jul 2022 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6MkXC7AxIl6dyiN1hKRN001xHZoWoEfAYX9KK4yLB6Q=;
 b=Ve/zzeziUwxKhjazoJ7sDsQNvW2rDD3FFhkgRGeqUnJ6Gz0TSr0mRZs5gcuKSVHR6alH
 N8DzghZpsgYOMNNFMfR3EtF8DmGKyYDo+gwnk6J1S8UqATF8badE+E1oI4+m8sg+jDib
 NzR+Vjhf1AQuUY7PP7QXjBJ5GHX5m2lz9NB7+VnGVyGPhP4Up5jDKyXlA0PB8gcIHBsy
 O+JC0H7p6N/2SJfxEeORsgufIwn/H9Bh/QIETA+LaXm/9ymmotLr/2JgIoqr7phnpOlw
 KItIqXWdnIuAv+/S47XKPOntp1DMHoRbU6sJEwWXnQWL8RvUA6XydCTtdA4pAvYSthq3 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61j5r1se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267El0vY008044;
        Thu, 7 Jul 2022 14:48:09 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61j5r1rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:09 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EZmCL021786;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3h4ud7pvtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em7D624903964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93599112061;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77F5411206D;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 24/26] ima: Limit number of policy rules in non-init_ima_ns
Date:   Thu,  7 Jul 2022 10:47:58 -0400
Message-Id: <20220707144800.828288-25-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0KdKAxTr75UZM5DSYeFKhc8n125Lgtjj
X-Proofpoint-ORIG-GUID: mpxIn8yl1EEqoIq3ecQ4KLPh522MtPtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Limit the number of policy rules a user can set in non-init_ima_ns to a
hardcoded 1024 rules. This allows to restrict the amount of kernel memory
used for IMA's policy since now any user can create an IMA namespace and
could try to waste kernel memory.

Ignore added rules if the user attempts to exceed this limit by setting
too many additional rules.

Switch the accounting for the memory allocated for IMA policy rules to
GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting can take
effect. This switch has no effect on the init_ima_ns.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

v11:
  - roll back changes to auditing too-many-rules since not auditing from
    IMA namespaces
---
 security/integrity/ima/ima_policy.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 181340678844..d26765df0dba 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -312,7 +312,8 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		return ERR_PTR(-EINVAL);
 	}
 
-	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
+	opt_list = kzalloc(struct_size(opt_list, items, count),
+			   GFP_KERNEL_ACCOUNT);
 	if (!opt_list) {
 		kfree(src_copy);
 		return ERR_PTR(-ENOMEM);
@@ -386,7 +387,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL_ACCOUNT);
 	if (!nentry)
 		return NULL;
 
@@ -842,7 +843,7 @@ static void add_rules(struct ima_namespace *ns,
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 			if (!entry)
 				continue;
 
@@ -879,7 +880,7 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 	ns->arch_policy_entry = kcalloc(arch_entries + 1,
 					sizeof(*ns->arch_policy_entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ns->arch_policy_entry)
 		return 0;
 
@@ -991,8 +992,20 @@ void __init ima_init_policy(struct ima_namespace *ns)
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
 
@@ -1926,7 +1939,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	if (*p == '#' || *p == '\0')
 		return len;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
-- 
2.36.1

