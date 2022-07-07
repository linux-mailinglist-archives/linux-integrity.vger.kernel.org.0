Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016BC56A607
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiGGOtp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiGGOso (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC832057;
        Thu,  7 Jul 2022 07:48:37 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EgV46009075;
        Thu, 7 Jul 2022 14:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m80vBDr7/oR+QxW+sGrA6iJToDoShUSRJ/+RGfH444Q=;
 b=nFTt2D6lv0D4W05pYogOAlpD00AbPofuP8tf8sM9vHszVpN5+KX6yhwneE+hFrvWvkED
 tBz2EWMUHUkk0coZs5Eo+TEqXB1oo/KwSozX4gJcgpgxdQTwARFiCqkktaKqP6j/hYOz
 Cj2twmorgzOxsYSKyrReUQvqia7gWfwWE+vmDxPMkRJWfgpMsCJRSQBmLSm/clDAzOc5
 31FfslYqUOJfKKtDEoxAQ1MTKGS3njOhwDzq40mdngm5T/8lC8zsZZjArs9dsEtrc9nO
 LhqjC9pn66FApz+uA7CSlPx8CZwd6lx2Gryo/WrW9CZxp5s4HphN/o0kNDPPFuYtov0w Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61fy86wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EiZ0Z019598;
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61fy86vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:06 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267Eir4Z015639;
        Thu, 7 Jul 2022 14:48:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3h4uqy6sff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:05 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em4Gn65012148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95AED112069;
        Thu,  7 Jul 2022 14:48:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7930F112063;
        Thu,  7 Jul 2022 14:48:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:04 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v13 04/26] ima: Move arch_policy_entry into ima_namespace
Date:   Thu,  7 Jul 2022 10:47:38 -0400
Message-Id: <20220707144800.828288-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FgT2AdDbR8sDHLQzkhsxbHuXfL4dk7nx
X-Proofpoint-GUID: 2vVBsDGyNdzRug-rNYGCxQsmfIx983og
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
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
index 0e7e306fb75a..fe1096fd2703 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -228,9 +228,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
-/* An array of architecture specific rules */
-static struct ima_rule_entry *arch_policy_entry __ro_after_init;
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -859,9 +856,10 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
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
@@ -871,13 +869,13 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
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
@@ -925,7 +923,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
-		add_rules(ns, arch_policy_entry, arch_entries,
+		add_rules(ns, ns->arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
@@ -1005,7 +1003,8 @@ void ima_update_policy(struct ima_namespace *ns)
 		 * on boot.  After loading a custom policy, free the
 		 * architecture specific rules stored as an array.
 		 */
-		kfree(arch_policy_entry);
+		kfree(ns->arch_policy_entry);
+		ns->arch_policy_entry = NULL;
 	}
 	ima_update_policy_flags(ns);
 
-- 
2.36.1

