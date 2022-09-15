Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734495BA16C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIOTdw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiIOTdU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFA9D8C3;
        Thu, 15 Sep 2022 12:33:13 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FI29Oh024595;
        Thu, 15 Sep 2022 19:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cuuBvIInmGqctCF301MCXsqeSQIuxaO8z77bU5N+Fx4=;
 b=E7mgcIY/zJtnCIRfjZqX5Ul+tW9Pu91YRYW6KQMBot1IV0ozvcSCU5HBMsjeBPOTfV/d
 qGBehI2ZnzdVPtAsSBSJ6Ale7mW8CfZAyGm8gZJbjM313SF9j/HqsBKxBmf0cBnbmBVE
 KXL4eyFkRif+Ivv5q/x8qaXyugcr/reN5gLpGp0PkXcs9OGLmexY1r86Cd9AZdKSLceB
 e7TPAXWY9D1Rj9mR1nRJG+Aa40jVUGgU8rop18pkLq9RyAHUHR5LxbSQja8rz4yQt9zE
 T+i2p69HjKPAJESJ7Sti45W6i4D5YbPTQVDoEC+VALuRbq8EtQQ+nyaXBVcc6Xu5wRm4 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:39 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJ7fvQ018539;
        Thu, 15 Sep 2022 19:32:38 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:38 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJKKZs010413;
        Thu, 15 Sep 2022 19:32:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3jm91w0d13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWaCc4653624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BBCCAE05C;
        Thu, 15 Sep 2022 19:32:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A5FDAE063;
        Thu, 15 Sep 2022 19:32:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:36 +0000 (GMT)
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
Subject: [PATCH v14 10/26] ima: Switch to lazy lsm policy updates for better performance
Date:   Thu, 15 Sep 2022 15:32:05 -0400
Message-Id: <20220915193221.1728029-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _ltVN5vuRfoIGFRJ5b_JUrJ5xDnB0UeF
X-Proofpoint-GUID: o2sP85HFtOgZwZNa4Q1cPJFu8lGQj97j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of calling ima_lsm_update_rules() for every namespace upon
invocation of the ima_lsm_policy_change() notification function,
only set a flag in a namespace and defer the call to
ima_lsm_update_rules() to before the policy is accessed the next time,
which is either in ima_policy_start(), when displaying the policy via
the policy file in securityfs, or when calling ima_match_policy().

The performance numbers before this change for a test enabling
and disabling an SELinux module was as follows with a given number
of IMA namespaces that each have a policy containing 2 rules with
SELinux labels:

2: ~9s
192: ~11s
1920: ~80s

With this change:

2: ~6.5s
192: ~7s
1920: ~8.3s

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/integrity/ima/ima.h        |  4 ++++
 security/integrity/ima/ima_policy.c | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c68b5117d034..5bf7f080c2be 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -123,6 +123,10 @@ struct ima_h_table {
 };
 
 struct ima_namespace {
+	unsigned long ima_ns_flags;
+/* Bit numbers for above flags; use BIT() to get flag */
+#define IMA_NS_LSM_UPDATE_RULES		0
+
 	/* policy rules */
 	struct list_head ima_default_rules; /* Kconfig, builtin & arch rules */
 	struct list_head ima_policy_rules;  /* arch & custom rules */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5f5cc3ce3b15..18fd19ecb402 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -228,6 +228,14 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
+static void ima_lsm_update_rules(struct ima_namespace *ns);
+
+static inline void ima_lazy_lsm_update_rules(struct ima_namespace *ns)
+{
+	if (test_and_clear_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags))
+		ima_lsm_update_rules(ns);
+}
+
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -478,7 +486,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-	ima_lsm_update_rules(ns);
+
+	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
 
 	return NOTIFY_OK;
 }
@@ -705,6 +714,8 @@ int ima_match_policy(struct ima_namespace *ns,
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
@@ -1969,6 +1980,8 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
-- 
2.36.1

