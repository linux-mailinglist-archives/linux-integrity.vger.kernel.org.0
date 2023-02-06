Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586668BF85
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBFOGj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjBFOEz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954B29419;
        Mon,  6 Feb 2023 06:04:14 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMKL012260;
        Mon, 6 Feb 2023 14:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AEABRwx+I+PGYn3gce040DvtOfNQ+z6YS1HaFc2FTBQ=;
 b=UmAvWTT2Yf/eD8pqNcFfhvxGGXRqTlNphjQdt0kKm6FF0tpgh+9y5dsM0EVg0K+SUPgV
 O3W56yFj9MM7UsGTMvnpI1unMYaOhApRlWmfNFLGFrIklE34Qo7dJZtlqwCe+0sE9n7v
 jde6MO1m+d/+3OwodBhUGwk3nS3vprPNINzfpnTDAdI/YxPgKfmtpcaGP+ocs8WtsVAi
 HGcBn0Qw0ivl4yaqqb7O1ZCOZ0JHgoDS7dbu393dLMzF39g/h2JHYHwHAvQ10gbi1SdH
 8KbPZUO3hTn0Yfr/+kE+eGAjP4UsIIu5KTcwDqvBXHoRxomiuo+nMzTQ5wQ5GrrLdsf9 rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2pg0jxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:53 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DtL8I002957;
        Mon, 6 Feb 2023 14:03:52 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2pg0jxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:52 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C5AIo027767;
        Mon, 6 Feb 2023 14:03:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07k180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3oj75112438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 262085805B;
        Mon,  6 Feb 2023 14:03:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DD458058;
        Mon,  6 Feb 2023 14:03:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:48 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 24/26] ima: Limit number of policy rules in non-init_ima_ns
Date:   Mon,  6 Feb 2023 09:02:51 -0500
Message-Id: <20230206140253.3755945-25-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: buXzFecdpuE6i6YZWp-rU7iZVGOvezKD
X-Proofpoint-ORIG-GUID: K2qII9EyMYZKWkpDSPJ5mvkEJmJcVB8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index bcd3227630bb..cdcc2a1506ab 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -336,7 +336,8 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		return ERR_PTR(-EINVAL);
 	}
 
-	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
+	opt_list = kzalloc(struct_size(opt_list, items, count),
+			   GFP_KERNEL_ACCOUNT);
 	if (!opt_list) {
 		kfree(src_copy);
 		return ERR_PTR(-ENOMEM);
@@ -410,7 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL_ACCOUNT);
 	if (!nentry)
 		return NULL;
 
@@ -889,7 +890,7 @@ static void add_rules(struct ima_namespace *ns,
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 			if (!entry)
 				continue;
 
@@ -926,7 +927,7 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 	ns->arch_policy_entry = kcalloc(arch_entries + 1,
 					sizeof(*ns->arch_policy_entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ns->arch_policy_entry)
 		return 0;
 
@@ -1038,8 +1039,20 @@ void __init ima_init_policy(struct ima_namespace *ns)
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
 
@@ -1973,7 +1986,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	if (*p == '#' || *p == '\0')
 		return len;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
-- 
2.37.3

