Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D48466FDF
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378191AbhLCCf2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378179AbhLCCfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B32MTM8000767;
        Fri, 3 Dec 2021 02:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ORsOqvHhu0hXyxnTJElDo6KuCG4EgLSfJ6yy5k2gfw0=;
 b=XiF0+LXXnFHbm9TFHYXla5RV9/5XA1A0ujVI6QZT+P/C9pSMAlGuHhEbuefOiIIJ7m1Y
 v5LQ9ccXtPk526xBFLwQa7anJexkkpGgkdWDuWXCgUREDAKPjiqJ2kwz677Qrhuu+lZ/
 OPB9Xv3gIesJu4bAi62r/fMMSWcxRoPRhvch4T0iGrkdlAosNBn38eTsD/QZRBlATCbW
 DXaaotqdHA2daNx+SSitSAs2L/tFzTjRYlf0IvF0iPc/GbsVxylbTXmmwn9Sp6hIomBB
 /O8JOXNJ9aR2qFXykvlZro6Z9w4SXSRZ9NWVTvDS6bXZ0ZLUcG9YuVPk6IxFs4WArtyu YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqad8842j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:42 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32VgCC003902;
        Fri, 3 Dec 2021 02:31:42 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqad88420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:42 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RTk4004550;
        Fri, 3 Dec 2021 02:31:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3muap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32Vc6s60883232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 538D46E05E;
        Fri,  3 Dec 2021 02:31:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CDC76E085;
        Fri,  3 Dec 2021 02:31:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:37 +0000 (GMT)
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
Subject: [RFC v2 10/19] ima: Implement hierarchical processing of file accesses
Date:   Thu,  2 Dec 2021 21:31:09 -0500
Message-Id: <20211203023118.1447229-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HYFlsu5TcgcgNEPA9uI25h9T-J0jyruN
X-Proofpoint-GUID: eStA51FjgdGk4nuDsi_n503Bib46DGOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement hierarchical processing of file accesses in IMA namespaces by
walking the list of IMA namespaces towards the init_ima_ns. This way
file accesses can be audited in an IMA namespace and also be evaluated
against the IMA policies of parent IMA namespaces.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d692c9d53a98..42cbcaf2dc1e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -199,10 +199,10 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct ima_namespace *ns,
-			       struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+static int _process_measurement(struct ima_namespace *ns,
+				struct file *file, const struct cred *cred,
+				u32 secid, char *buf, loff_t size, int mask,
+				enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -404,6 +404,27 @@ static int process_measurement(struct ima_namespace *ns,
 	return 0;
 }
 
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	int ret = 0;
+	struct user_namespace *user_ns;
+
+	do {
+		ret = _process_measurement(ns, file, cred, secid, buf, size, mask, func);
+		if (ret)
+			break;
+		user_ns = ns->user_ns->parent;
+		if (!user_ns)
+			break;
+		ns = user_ns->ima_ns;
+	} while (1);
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
-- 
2.31.1

