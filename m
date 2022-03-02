Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8ED4CA682
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiCBNvl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCBNv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E1C5D89;
        Wed,  2 Mar 2022 05:50:29 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222DJ7g6003535;
        Wed, 2 Mar 2022 13:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4UXUDAETnUah9fRVnj8wSJGeIBkvnEwOPlI6Ze7yjPg=;
 b=Q6T+hX9HFpi6G2oXTrZDw+DGoKVJQysEILLHJ4AlCyZbcEQD2lg1/c57LQAYVdXwjCKz
 Qsr/vmQE42mgX+ihKXT38BtssYL+sQgybzNFAvadF+6VegotbVswiwq6u6U151sbRVWx
 jHxlbnGGw1jpM/+VqxTIpLm25h5zbeSdc+IGZe1/MfK7rNO3ikyRzUm9eqWVhfkORxZt
 03V/197J/oNPyBdaDHR/DBNQqNmxTxvCkHCheaLChoxY55FWKru089kIIuKwC7Kd7EZe
 XDpIKtrBihGs/MPrU3OcCGWyIWlBEKdVtBoioSf51rr1IQbXunRBKbncZ6oUHCHlPxZz Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9bsgjr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DKHkP005283;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9bsgjqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dm7si019606;
        Wed, 2 Mar 2022 13:49:59 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3efbua5y46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:59 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222DnvN534210074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A618811206B;
        Wed,  2 Mar 2022 13:49:57 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8804311206F;
        Wed,  2 Mar 2022 13:49:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:57 +0000 (GMT)
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
Subject: [PATCH v11 05/27] ima: Move arch_policy_entry into ima_namespace
Date:   Wed,  2 Mar 2022 08:46:40 -0500
Message-Id: <20220302134703.1273041-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1_cZ8RAnd0Rmgu-nptZ1YLOpBtp8izE3
X-Proofpoint-GUID: ZSS7fOxGNW6U2lGOuatPw78dfmnck80p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The architecture-specific policy rules, currently defined for EFI and
powerpc, require the kexec kernel image and kernel modules to be
validly signed and measured, based on the system's secure boot and/or
trusted boot mode and the IMA_ARCH_POLICY Kconfig option being enabled.

To avoid special-casing init_ima_ns as much as possible, move the
arch_policy_entry into the ima_namespace.

When freeing the arch_policy_entry set the pointer to NULL.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h             |  3 +++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_policy.c      | 23 +++++++++++------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9bcde1a24e74..2305bf223a98 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -125,6 +125,9 @@ struct ima_namespace {
 
 	struct list_head __rcu *ima_rules;  /* Pointer to the current policy */
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

