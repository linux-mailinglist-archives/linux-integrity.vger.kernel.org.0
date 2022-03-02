Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23C4CA653
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiCBNvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiCBNvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02CE71CB8;
        Wed,  2 Mar 2022 05:50:21 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222CO2jS010887;
        Wed, 2 Mar 2022 13:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eV/UgQ+DVsHgQLhAkLOr3hnnTsrXYh7q1dymSsrIyDo=;
 b=ME+0EYAldbb8Bxb1OBojYdSLuBWocrrqh8q0ZTv+K/+XTMyNt7JlEodHoJirZWNXFU17
 GLdorscsDSfWTEZL2H0XullwZKVGkWiUVDGvPygK6KJHE8VK0oymqUnDOAnsKwXqoxAR
 SOqZ3oKmUGnrln7/lUp0UasfE868WORAtEfAsEtj8vxztxKw4vm9dXFFt5HWdXe9/JWo
 6b5krzyKVlKLlf3HVpGP6wnN+hphnvtWauuceghpQLoEg2XmLfhyUuBWSbSTqQbO8trW
 jA7EErXGlEZDweL6U6g3vBEizpyFLIKXbJBCQebcjA7rfigzG1GyN2sN/2VfMfQNrfAB 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej8hxsr0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:08 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DR8Pj029372;
        Wed, 2 Mar 2022 13:50:08 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej8hxsqyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dn8aD008502;
        Wed, 2 Mar 2022 13:50:06 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3eftrrpprn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Do0c120316438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D166112073;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61426112070;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
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
Subject: [PATCH v11 25/27] ima: Limit number of policy rules in non-init_ima_ns
Date:   Wed,  2 Mar 2022 08:47:00 -0500
Message-Id: <20220302134703.1273041-26-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hN68DmZ0X-qSPGgfuKctj1dSKJfTGexu
X-Proofpoint-GUID: _PdSoOgSqEvqEciFLWnWjE8KyiQJ9tj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0f697a475882..5ea1549bf601 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -313,7 +313,8 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		return ERR_PTR(-EINVAL);
 	}
 
-	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
+	opt_list = kzalloc(struct_size(opt_list, items, count),
+			   GFP_KERNEL_ACCOUNT);
 	if (!opt_list) {
 		kfree(src_copy);
 		return ERR_PTR(-ENOMEM);
@@ -387,7 +388,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL_ACCOUNT);
 	if (!nentry)
 		return NULL;
 
@@ -843,7 +844,7 @@ static void add_rules(struct ima_namespace *ns,
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 			if (!entry)
 				continue;
 
@@ -880,7 +881,7 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 	ns->arch_policy_entry = kcalloc(arch_entries + 1,
 					sizeof(*ns->arch_policy_entry),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ns->arch_policy_entry)
 		return 0;
 
@@ -992,8 +993,20 @@ void __init ima_init_policy(struct ima_namespace *ns)
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
 
@@ -1865,7 +1878,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	if (*p == '#' || *p == '\0')
 		return len;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
-- 
2.31.1

