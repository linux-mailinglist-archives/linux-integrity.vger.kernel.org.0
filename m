Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8368BF3B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBFODp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBFODo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC3835AA;
        Mon,  6 Feb 2023 06:03:43 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqLt6014800;
        Mon, 6 Feb 2023 14:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dhZu17WkPk2gtHfUPvpU8O1UwdHNGl7Q2rxvdB5u20M=;
 b=CpacAugtXkHnPelMWNSETXgF9Nkfa3sBeU4cO2AzSVdnvbb3lsxC2mLPU9c+cAXf9Apg
 lp/xMRY+U7qThDP2ATdFrWALmDKl+qWHPIeKUaQchAVb18hR82HnEgrLISweDioY8Aft
 jmh+wT8rVYD+n1eE6p/a1TVyL0PoBjLryN6usIZvvPE8onECQsnr0hRlYoXBfYGjNibn
 5126t/XTBEDssDami2pOcpSNWduJLt48NOPTRm3Ko4F/98jjZNhIys+lE5WPEVf/Yv3S
 HSaxJx4KU2KZScWFPmZh1HOHUl2bd+03hI1dFLI8M4ZSHHvUDTiilCqjcyeSJP3K2CBG /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk3mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DvItV030157;
        Mon, 6 Feb 2023 14:03:12 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1gkk3kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:12 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CAFJJ001062;
        Mon, 6 Feb 2023 14:03:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nhf072ygn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E39748979114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D6E5805C;
        Mon,  6 Feb 2023 14:03:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7D0D5805B;
        Mon,  6 Feb 2023 14:03:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:07 +0000 (GMT)
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
Subject: [PATCH v15 04/26] ima: Move arch_policy_entry into ima_namespace
Date:   Mon,  6 Feb 2023 09:02:31 -0500
Message-Id: <20230206140253.3755945-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7TOiA8l1auhSpHrAOh_hiDdkp1IVaSKC
X-Proofpoint-GUID: eR6uiqeUQ7McHE54kZ09gukNQbaDZgiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 security/integrity/ima/ima.h             |  3 +++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_policy.c      | 23 +++++++++++------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 61986e271c5c..d82dbeceb913 100644
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
index 671994bd07cb..502b1e8021a6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -252,9 +252,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
-/* An array of architecture specific rules */
-static struct ima_rule_entry *arch_policy_entry __ro_after_init;
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -904,9 +901,10 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
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
@@ -916,13 +914,13 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
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
@@ -970,7 +968,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
-		add_rules(ns, arch_policy_entry, arch_entries,
+		add_rules(ns, ns->arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
@@ -1050,7 +1048,8 @@ void ima_update_policy(struct ima_namespace *ns)
 		 * on boot.  After loading a custom policy, free the
 		 * architecture specific rules stored as an array.
 		 */
-		kfree(arch_policy_entry);
+		kfree(ns->arch_policy_entry);
+		ns->arch_policy_entry = NULL;
 	}
 	ima_update_policy_flags(ns);
 
-- 
2.37.3

