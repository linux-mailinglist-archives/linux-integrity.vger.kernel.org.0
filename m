Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE749BF63
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 00:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiAYWrl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234224AbiAYWr3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PM68Hl002480;
        Tue, 25 Jan 2022 22:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KijHy903UMH2XLgL8VnGJFey6CestvpIRiHVW5YG8YA=;
 b=jCffWbfJ5xltTsQRui3vkfViDb8fILuCHyMvTdi/Y1alF/Yd003q2wg93nism29wrr21
 bbMjG0EebtNfcRqBJag9qqY8xbjbqA6bU0NNYb/O8v1U63UfGDiJ8AUqsJ8cTNb/f/wP
 1OaHmpQrRiLV9XivDy51wtm6CwNayCq2r6FosmXwsFhmW/eUQfTvcOYpf+838qcyoXI3
 KPT09GVwAAoVCux/SNh5kjnGpuD8JQ7DAJv0PsPJRHj/JBLjb92O5omPNuj9FIVMtTEe
 dWWu3sC6PtKAnB59+2/swPOzaPZ7SWFusCgmkXJBIqKF8L0iZXqd7QxkB2ZXssHONzFY hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryw1cba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:00 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMZYxa001673;
        Tue, 25 Jan 2022 22:46:59 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryw1cb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:46:59 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhnr1010313;
        Tue, 25 Jan 2022 22:46:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3dtbch8rfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:46:58 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkvc123986554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:57 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4575CAC062;
        Tue, 25 Jan 2022 22:46:57 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB28AC067;
        Tue, 25 Jan 2022 22:46:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:57 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
Subject: [PATCH v9 06/23] ima: Move arch_policy_entry into ima_namespace
Date:   Tue, 25 Jan 2022 17:46:28 -0500
Message-Id: <20220125224645.79319-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1fEdqweKj6hy-Kniz9FVWXEPsbDzGOlW
X-Proofpoint-ORIG-GUID: gLa-yLtgaLCeu3VtdAzZA9TQEkJYGqGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Move the arch_policy_entry pointer into ima_namespace.

When freeing the memory set the pointer to NULL.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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

