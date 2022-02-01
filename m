Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABBD4A6605
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiBAUi7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9302 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240497AbiBAUiS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211K3hXb007348;
        Tue, 1 Feb 2022 20:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Pp8zr7U+Qv68R4BaTeGzK3g9O0EtUn6iejRm1xKjM0E=;
 b=QfLNb6dYA/3rlMjIj2CElo75ErGc5z/gvzExmhH1V4Ei/nX080XUAkEjz5vIkHOjPCOZ
 kmQfkTMzbx5mKmvFcDitLPY7Znm1hRGm6bftkFdKxiO/Iojl55f0/w5gnu50E82tD+PB
 7Txr7sxkVwYv+Sos+JcJ/RgzEbEP8aZXU8sKo3OxPc+NJiRRCleEq8CZU+OCYShBSP7r
 1WIUdphyDxRfKYEy5gkkUWTprBrt+GzH3SJLekBEYptj+q+MzzK8pxFZ6bQzeQUQTv4y
 hg72FkkDHX31mAjqVIgaYM+vMVtO7RaLVdStOsyR2MBKwWvAzoxolIR4JTgHSBqnEbP9 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dy8u5byhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KaWvt038758;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dy8u5byh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KYwqw002170;
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3dvw7ay3tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KbpAN32375158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5697DB2070;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3888AB206E;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
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
Subject: [PATCH v10 16/27] ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
Date:   Tue,  1 Feb 2022 15:37:24 -0500
Message-Id: <20220201203735.164593-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xll3_P7zsVCa3448F-Q_2oXXt3IfeCgZ
X-Proofpoint-ORIG-GUID: VlBK7K_6_5Okkvi22qhG-LyjtftPjo_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement ima_free_policy_rules() that is needed when an ima_namespace
is freed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

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
index aea8fb8d2854..8c757223d549 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -329,6 +329,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
 ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
 void ima_delete_rules(struct ima_namespace *ns);
 int ima_check_policy(struct ima_namespace *ns);
+void ima_free_policy_rules(struct ima_namespace *ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dcc5a8c585a..fe3dce8fb939 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1889,6 +1889,20 @@ void ima_delete_rules(struct ima_namespace *ns)
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
2.31.1

