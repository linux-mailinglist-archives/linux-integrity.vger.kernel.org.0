Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609934769B3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhLPFnv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:43:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231231AbhLPFnu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:43:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4Uiq9024476;
        Thu, 16 Dec 2021 05:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zHWfoApnPpByvUFvCcLazFi8Y5aMJ4I/+PNPrwsk4rE=;
 b=Byd82wjZwgUBHp7GKoPeJZB5kIskslL4q0FxB5tC08mIHDsbzkKQ582451UWvkj5jCEs
 ta5v2hkHQ3GdsoiS+kxV8NGdnOJ5pxidBr8Gh3tLqFVF4PRtXvRH52SNPN9T2YAOe3LK
 pbg1QQT7KJXu7snxchSIr+OWEc0QO1GDgXYp94dPdliYkRXFpkL4i+N/B56vZIDlAvD4
 0NDlNkadYFPYYPd7jfod9YsQH6X8GefEXbAczEoYYFVITpp4DCkSor9ay+1nvyUim8/w
 JVSkUfsizGDgdTOM4ycyDWDdD9G0FUA5Yk/kv3it0q9AuZOCR+XjEqQN6FmtyrTijpDB iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyfv44gns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:39 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5gWEx032262;
        Thu, 16 Dec 2021 05:43:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyfv44gnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5hP73011104;
        Thu, 16 Dec 2021 05:43:38 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cy7712aba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hahP29491570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 642546E05E;
        Thu, 16 Dec 2021 05:43:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5413B6E059;
        Thu, 16 Dec 2021 05:43:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:35 +0000 (GMT)
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
Subject: [PATCH v7 08/14] ima: Implement hierarchical processing of file accesses
Date:   Thu, 16 Dec 2021 00:43:17 -0500
Message-Id: <20211216054323.1707384-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -rHdYuDb6qmXiN70YqIKDo8Jyc4feOch
X-Proofpoint-ORIG-GUID: 4VLjKf1UulFIM3vqNe7QO6wNBFqjGjzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement hierarchical processing of file accesses in IMA namespaces by
walking the list of IMA namespaces towards the init_ima_ns. This way
file accesses can be audited in an IMA namespace and also be evaluated
against the IMA policies of parent IMA namespaces.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h               |  9 +++++++++
 security/integrity/ima/ima_main.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 61461ee5b208..f9e592bb9560 100644
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
index 98be891c2621..4c85a8df3c86 100644
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
@@ -405,6 +405,28 @@ static int process_measurement(struct ima_namespace *ns,
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
+		ret = __process_measurement(ns, file, cred, secid, buf, size,
+					    mask, func);
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

