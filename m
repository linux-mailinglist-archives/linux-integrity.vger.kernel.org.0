Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C875846C476
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 21:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhLGU0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 15:26:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241362AbhLGU0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jbfb1027243;
        Tue, 7 Dec 2021 20:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hYKHz5oZpOmk7Idtf1PxJ6wdu1EqA3jpsLn6Cy1vXwE=;
 b=m84dOexQi+/+w9PIJpo5CrGjX+N0MX001crIVw2wSa3Y2hvfcX3mreh17gEEv8X7R004
 MLGhysVHp+sSSPRUQ9/tqmfj0QSZJxTmsd+6gNYxO/EU4MGCfOiV2smOWkk/WIZcafgZ
 8rWQK76cTAY1HTtQQ/dQTauZ7xBM8mmKX/RyRx7xr7pdy9HnX2SBidE6sG7yRG0MzzTd
 BVnigGFu4Et/Jz11NmBqeswKx1EQdJkXCZjjeb8dLuAeozWQavMLQx/l7bnUlbfVEgrA
 tbTH2/jh2NLGeZNQgp4pV06qo3kf8dbGZY0Y+/o4pZu9YT8pOxgcvjn2A+1DSg7Oz/lv Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j03g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:24 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7KG3cp012377;
        Tue, 7 Dec 2021 20:22:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j032-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7K798v028332;
        Tue, 7 Dec 2021 20:22:22 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyyb2dkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:22 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7KMJT834079080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 20:22:19 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9FF3136059;
        Tue,  7 Dec 2021 20:22:19 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59209136055;
        Tue,  7 Dec 2021 20:22:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 20:22:17 +0000 (GMT)
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
Subject: [PATCH v4 10/16] ima: Implement hierarchical processing of file accesses
Date:   Tue,  7 Dec 2021 15:21:21 -0500
Message-Id: <20211207202127.1508689-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207202127.1508689-1-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rcHN96RtNsMhRNJCvOkW9Qi3kQYC3Dyf
X-Proofpoint-GUID: kp7i70HAco2owlAxpxf2c-wKZvrdRWWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112070122
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
index 2121a831f38a..e9fa46eedd27 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
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
@@ -405,6 +405,27 @@ static int process_measurement(struct ima_namespace *ns,
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

