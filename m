Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D44A65DE
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiBAUiQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239761AbiBAUiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JwDDN023237;
        Tue, 1 Feb 2022 20:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CibhXBTqOtQ1o6CPXdlQcPRn1cs+zEcAYgN+4FA+/AU=;
 b=UhIWs5BAVRNDqCEsB1nakkH3QAbVW7Qznjbnv2eimF7roJytvTANozdG2uaoJjGNQxRn
 lK3+dKjEDwD93/W3H8A8WZL6MIUXkragzq6hINeFbtxZkV9Moxy0L6DITfnO4NrNqnXE
 Hod/E9IUcSXFOyyKYO+z0SclBzWZp7HCATfn8gQMuPF9BG61BwWMa2nfuCVyX78XcfeY
 QgpmVuJKv0IzP+xAWpIeZCl0QX31zxq8VLPxJ+fLwH7UHpLdxP6AwB7vBvKgNs7Dz9Ks
 RzGsqmDNSu/BIHgB9i0yjF8xOq+uZL6adDIGNgjQwoBE3rwtPlsnMPT2NzzybqWaIFuT uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkkaru4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211JGe68004301;
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkkartu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWPlW004997;
        Tue, 1 Feb 2022 20:37:51 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3dvw7b14gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KboAa29425936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED118B2066;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9A28B206B;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v10 06/27] ima: Move arch_policy_entry into ima_namespace
Date:   Tue,  1 Feb 2022 15:37:14 -0500
Message-Id: <20220201203735.164593-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s00x0SvGF_gwAKmuTERuAaij5sX8Npph
X-Proofpoint-ORIG-GUID: EJn3kw8XH4jf9yHY7kXIQqwZr-KPkV2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the arch_policy_entry pointer into ima_namespace.

When freeing the memory set the pointer to NULL.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h             |  3 +++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_policy.c      | 23 +++++++++++------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5b44fa6f27c4..a4669b55c2e0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -125,6 +125,9 @@ struct ima_namespace {
 
 	struct list_head __rcu *ima_rules;	/* current policy */
 	int ima_policy_flag;
+
+	/* An array of architecture specific rules */
+	struct ima_rule_entry *arch_policy_entry;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index c919a456b525..ae33621c3955 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -15,6 +15,7 @@ static int ima_init_namespace(struct ima_namespace *ns)
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
 	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
 	ns->ima_policy_flag = 0;
+	ns->arch_policy_entry = NULL;
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b0e1c16b7f37..05b2bc06ab0c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -229,9 +229,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
-/* An array of architecture specific rules */
-static struct ima_rule_entry *arch_policy_entry __ro_after_init;
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -860,9 +857,10 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 	for (rules = arch_rules; *rules != NULL; rules++)
 		arch_entries++;
 
-	arch_policy_entry = kcalloc(arch_entries + 1,
-				    sizeof(*arch_policy_entry), GFP_KERNEL);
-	if (!arch_policy_entry)
+	ns->arch_policy_entry = kcalloc(arch_entries + 1,
+					sizeof(*ns->arch_policy_entry),
+					GFP_KERNEL);
+	if (!ns->arch_policy_entry)
 		return 0;
 
 	/* Convert each policy string rules to struct ima_rule_entry format */
@@ -872,13 +870,13 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 		result = strscpy(rule, *rules, sizeof(rule));
 
-		INIT_LIST_HEAD(&arch_policy_entry[i].list);
-		result = ima_parse_rule(ns, rule, &arch_policy_entry[i]);
+		INIT_LIST_HEAD(&ns->arch_policy_entry[i].list);
+		result = ima_parse_rule(ns, rule, &ns->arch_policy_entry[i]);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
-			memset(&arch_policy_entry[i], 0,
-			       sizeof(*arch_policy_entry));
+			memset(&ns->arch_policy_entry[i], 0,
+			       sizeof(ns->arch_policy_entry[i]));
 			continue;
 		}
 		i++;
@@ -926,7 +924,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
-		add_rules(ns, arch_policy_entry, arch_entries,
+		add_rules(ns, ns->arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
@@ -1006,7 +1004,8 @@ void ima_update_policy(struct ima_namespace *ns)
 		 * on boot.  After loading a custom policy, free the
 		 * architecture specific rules stored as an array.
 		 */
-		kfree(arch_policy_entry);
+		kfree(ns->arch_policy_entry);
+		ns->arch_policy_entry = NULL;
 	}
 	ima_update_policy_flags(ns);
 
-- 
2.31.1

