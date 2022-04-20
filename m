Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF337508A0E
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379326AbiDTOKR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379353AbiDTOKK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE943ED8;
        Wed, 20 Apr 2022 07:07:14 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KClnXW028819;
        Wed, 20 Apr 2022 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hDODQfHxncKmdT1CPelnP7t68PNJDhfJLxmV0MuTmNU=;
 b=EbcFdvFl+SKqAt7aBaNieLTJQH+JIYjSBrk1DvMvYa51kg/sSFrKlCRT/2n1l0iRyhVR
 HArq9tLQuhy6dlCywgMeVZdSWcWniG4SSKeLW/S666Y3rJxVS3fckN9X58Ohu6zkP11h
 zE1N/vtxumFvg3NrpDDbK/nsN94tDUPSplmPz28xH2fwVz3dqskIVcpo7nnJM2FPylJu
 ZasNHOzHxCX0HJKLx4pYQNcyUJ9BQQB4q1layqOtFI8fBuZr2KtsNYa5o+HkZ3TOMZbV
 wjhWW2Pj6iXXEzYsToSEJ80UGncbndzSH6OogMXFk7FsfGSpHKCCyU+TEEKMvFupOjSP 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjdn3r60e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KBvrac008463;
        Wed, 20 Apr 2022 14:06:46 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjdn3r5yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:46 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE34HY030562;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3ffnea3y4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6i2B24641862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 569F4AE066;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A8FBAE062;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
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
Subject: [PATCH v12 24/26] ima: Limit number of policy rules in non-init_ima_ns
Date:   Wed, 20 Apr 2022 10:06:31 -0400
Message-Id: <20220420140633.753772-25-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TKh4iT64ggF7UilfGPzTNnWL_VmLaDdl
X-Proofpoint-GUID: j3Vd6hIQ6bu3FJGtST6TNGSkpfesxuxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 4f8c50ddb777..a0bd8ffca88e 100644
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
 
@@ -1864,7 +1877,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	if (*p == '#' || *p == '\0')
 		return len;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
-- 
2.34.1

