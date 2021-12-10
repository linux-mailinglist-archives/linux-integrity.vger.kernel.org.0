Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC433470AD3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbhLJTvw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:51:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343784AbhLJTvn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAI873k011051;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9RmU5lKfZ5PEbMv5qG3TyQvw1FSleHbq6OtkG5qdlvU=;
 b=AxUdt87o0TYUFGirU2YFYtt4KB7+dOtGwSu3W7gEGOvfcRQk3Zl6gmoYTXS182GXcI4Z
 jYHzI+zk6i+BKrYENSgOAcNjxAd9jFMh4GI35NXGV2XP8o3hbd5Z6tE6DCFjDpg6/30P
 Sa2/D3PUL3m1dHvvXt5hgAcyNCsFxvsKB+3KvbWZc90I46acPDYHMUnOkoNB0MpowCe4
 cU1s6va7uLBLLA1XE5uPlF0zoRYBkAP0ZQZd5Ba/P+q5U7zuri7l/sUxOdKFjyyRemJH
 90qJ0TJFRHlN2z5JGReMXdlL67O9VLZawXTJmNX4jYHTKMLhsi8GdNorYHyQc4HuHy8L BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvbatjcd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJaEUR017223;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvbatjccq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJlIQd029473;
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyydm09e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJldRD22610394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3136EAE067;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FD78AE071;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
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
Subject: [PATCH v6 10/17] ima: Implement hierarchical processing of file accesses
Date:   Fri, 10 Dec 2021 14:47:29 -0500
Message-Id: <20211210194736.1538863-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8RCH_TY1yDOeMePp04PF3cWZ_lfsPnky
X-Proofpoint-GUID: b0zkdrDhrIjxNPfxpZYdSBciGEoYLHx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement hierarchical processing of file accesses in IMA namespaces by
walking the list of IMA namespaces towards the init_ima_ns. This way
file accesses can be audited in an IMA namespace and also be evaluated
against the IMA policies of parent IMA namespaces.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h               |  9 +++++++++
 security/integrity/ima/ima_main.c | 29 +++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 85903f40acfd..fda371cbde50 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -66,6 +66,15 @@ static inline const char * const *arch_get_ima_policy(void)
 }
 #endif
 
+static inline struct user_namespace *ima_user_ns(struct ima_namespace *ns)
+{
+	struct user_namespace *user_ns;
+
+	user_ns = current_user_ns();
+	WARN_ON(user_ns->ima_ns != ns);
+	return user_ns;
+}
+
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2121a831f38a..6ebc57cd91d3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct ima_namespace *ns,
-			       struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+static int __process_measurement(struct ima_namespace *ns,
+				 struct file *file, const struct cred *cred,
+				 u32 secid, char *buf, loff_t size, int mask,
+				 enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -405,6 +405,27 @@ static int process_measurement(struct ima_namespace *ns,
 	return 0;
 }
 
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	struct user_namespace *user_ns = ima_user_ns(ns);
+	int ret = 0;
+
+	while (user_ns) {
+		ns = user_ns->ima_ns;
+
+		ret = __process_measurement(ns, file, cred, secid, buf, size, mask, func);
+		if (ret)
+			break;
+
+		user_ns = user_ns->parent;
+	};
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
-- 
2.31.1

