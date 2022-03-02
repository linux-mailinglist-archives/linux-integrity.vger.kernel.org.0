Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1A4CA655
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbiCBNvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbiCBNvG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C56F4A2;
        Wed,  2 Mar 2022 05:50:23 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222CmsWC032302;
        Wed, 2 Mar 2022 13:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=B5h+yk1eDqBaRQMCV7KsLpOyCJCHJJ8oRwm7Xksl3Do=;
 b=OYIru8f1kteZArcaKgBNenhEUJzwpiEbjfecrYzD+qBI9aBqabt6G2wUlDPBo+Wj/FSI
 rtL70ygyVfOG//UBL1s+yEDXhmumOkeVWS0lCwTrbklkdhA8bA+PlT5XD8+cwdW1TBqE
 GE40e2DaHqJkySF5qiUNBdYvBzG4D5lK0/bPT57Hef2H6SsvR5w4M7/WPa5i04iSXKpc
 kjOOvBw1mn0MBT6ln+Luyx7jKG9PzxEjm+x+AMv8U58hFFuTFtYWcLRLxj8JQYFQfJ1r
 wXoFYCcGWHdCEtMQpv5wlByGS6HgOpPZ96zP5bVfc4/6Ix89HeWfGLnmzMQVwSbnyp6d UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej8wt9933-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DftSa012454;
        Wed, 2 Mar 2022 13:50:01 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej8wt992h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dm7QH019600;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3efbua5y4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Dnw7540042814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBB3112070;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B29E11206B;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
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
Subject: [PATCH v11 11/27] ima: Switch to lazy lsm policy updates for better performance
Date:   Wed,  2 Mar 2022 08:46:46 -0500
Message-Id: <20220302134703.1273041-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S3b5uWcQgAGHarhGdapis5ghoXGCJR0C
X-Proofpoint-ORIG-GUID: zpxKoZsu_n6XvAJXOAP_vRA0TiKN3PEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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

Instead of calling ima_lsm_update_rules() for every namespace upon
invocation of the ima_lsm_policy_change() notification function,
only set a flag in a namespace and defer the call to
ima_lsm_update_rules() to before the policy is accessed the next time,
which is either in ima_policy_start(), when displaying the policy via
the policy file in securityfs, or when calling ima_match_policy().

The performance numbers before this change for a test enabling
and disabling an SELinux module was as follows with a given number
of IMA namespaces that each a have a policy containing 2 rules
with SELinux labels:

2: ~9s
192: ~11s
1920: ~80s

With this change:

2: ~6.5s
192: ~7s
1920: ~8.3s

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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
index 94a41572527a..060d45cf35a7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -229,6 +229,14 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
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
@@ -479,7 +487,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-	ima_lsm_update_rules(ns);
+
+	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
 
 	return NOTIFY_OK;
 }
@@ -706,6 +715,8 @@ int ima_match_policy(struct ima_namespace *ns,
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
@@ -1908,6 +1919,8 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
-- 
2.31.1

