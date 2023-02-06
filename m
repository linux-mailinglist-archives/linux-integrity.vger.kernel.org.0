Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543568BF49
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBFOEB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBFODw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388B5B83;
        Mon,  6 Feb 2023 06:03:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMKZ023149;
        Mon, 6 Feb 2023 14:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7NpdvJJ+kFIqA/bIpBgYsf8j+v/I3xpk+VSo3mf+jN0=;
 b=mIQCU/iT5LO/z1TY9u+WmXw6OeX1aPpRlpimDk0QMvFfA9ljucyO0t7EB1PmzqO3/itP
 Qsa+Kt7QPemrCYm5rrCIRN7MXgsouPcAzP1XepGnAQY2YsUY6nhiQKUML8NEO6qlHhBG
 rAa4EFvS+ahfgj/ycMKQv5qIngY5JT3aulh9h123fH9ik4Ma7Fvj13K5SABX4YyHyKhP
 T1RHYyvO4LNWo7ve2zzmQVaPlBYH+K/N+zeSEx1nt/aLj/DTOPNyUdz5FAeaxwX6H6jy
 lqArsJEODBjxJY5x8eo972b92segn7Z1jF28LW7gqhKr3utDFoMpSDRczgMjwYYglky0 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkhwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:25 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Dt5hh013269;
        Mon, 6 Feb 2023 14:03:24 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkhvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C5kru000521;
        Mon, 6 Feb 2023 14:03:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nhf072yhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3L9G66126098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CD158058;
        Mon,  6 Feb 2023 14:03:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1E3E5805B;
        Mon,  6 Feb 2023 14:03:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:19 +0000 (GMT)
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
Subject: [PATCH v15 10/26] ima: Switch to lazy lsm policy updates for better performance
Date:   Mon,  6 Feb 2023 09:02:37 -0500
Message-Id: <20230206140253.3755945-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 14naSaAV3-RnokxsI4lXuMMrdnz2_QU6
X-Proofpoint-GUID: orPYh5qEKzUOYPcY1eGBBMj_gleSoDiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index db28d6d222a6..4de8ec776611 100644
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
index 8e71b28855a4..19aca18db323 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -252,6 +252,14 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
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
@@ -498,7 +506,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-	ima_lsm_update_rules(ns);
+
+	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
 
 	return NOTIFY_OK;
 }
@@ -752,6 +761,8 @@ int ima_match_policy(struct ima_namespace *ns,
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
@@ -2016,6 +2027,8 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
 
+	ima_lazy_lsm_update_rules(ns);
+
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
-- 
2.37.3

