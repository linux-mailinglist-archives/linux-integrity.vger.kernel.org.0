Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B068BF4D
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBFOED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBFODw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536EA12595;
        Mon,  6 Feb 2023 06:03:46 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqeTY027235;
        Mon, 6 Feb 2023 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4KGX0WqjU4uuch+zY/5pjQzzgfr+j/RW9wEQS9wXGaw=;
 b=tB01VfXr6t5WUTOazuYej7TjmTSY6tha+Jstw1ERt0Fx3zcPSNWvusiYpEqht8l4sRDO
 j4uuEaNxB1vJIPQ2a+F7gBN680wEwJgkEhms5PSe/hwEknn6NKqY64vukeyEPknFVV/Y
 cY+/aQ4s//Ie/Ru4zGb2XiZeVIwZgy++/0ByIX4H0TcAOtbUGo6owgEbbG8mvIpnBg1z
 9e1+XyAoz8pflRc7B4ugWBK/zzNMYaPyMaQSgLgnr1D1BWnkWrDbi4bl/bTOjHsC4HTl
 zWA17KThWW1/pxJpleEKEPrn8kBDb+odSIbkagMXGGJk99Cr8GxS+LrkJ5bNaQ+RG3BW kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tbggm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:35 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Dqmqu031980;
        Mon, 6 Feb 2023 14:03:34 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tbggjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CFt4o017641;
        Mon, 6 Feb 2023 14:03:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dq61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3W3I38601396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF1565805B;
        Mon,  6 Feb 2023 14:03:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A40F58059;
        Mon,  6 Feb 2023 14:03:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:30 +0000 (GMT)
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
Subject: [PATCH v15 15/26] ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
Date:   Mon,  6 Feb 2023 09:02:42 -0500
Message-Id: <20230206140253.3755945-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pp5ZNQ74DfnA9v36CPqo6MU-2aJVVtF8
X-Proofpoint-GUID: vGLATNprnMQ8Ot8ckRH2ORudy62_7f_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement ima_free_policy_rules() to free the current custom IMA policy's
rules. This function will be called when an ima_namespace is freed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>

---
v10:
  - Not calling ima_delete_rules() anymore
  - Move access check from ima_delete_rules into very last patch

 v9:
  - Only reset temp_ima_appraise when using init_ima_ns.
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_policy.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5d647011429b..efe9c82b4396 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -333,6 +333,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
 ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
 void ima_delete_rules(struct ima_namespace *ns);
 int ima_check_policy(struct ima_namespace *ns);
+void ima_free_policy_rules(struct ima_namespace *ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2a2c88f7d135..10b85642188f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2014,6 +2014,20 @@ void ima_delete_rules(struct ima_namespace *ns)
 	}
 }
 
+/**
+ * ima_free_policy_rules - free all policy rules
+ * @ns: IMA namespace that has the policy
+ */
+void ima_free_policy_rules(struct ima_namespace *ns)
+{
+	struct ima_rule_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
+		list_del(&entry->list);
+		ima_free_rule(entry);
+	}
+}
+
 #define __ima_hook_stringify(func, str)	(#func),
 
 const char *const func_tokens[] = {
-- 
2.37.3

