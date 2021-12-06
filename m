Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9596B46A2EB
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhLFRa6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:30:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240150AbhLFR34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HI46n004515;
        Mon, 6 Dec 2021 17:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hUFcvaWByJjpmi9wzWxytILgPSMVKkio1o87qlBWiwg=;
 b=Bu7cEvO7WdVoyQlozJMlO3QC2gr1Wzffpabixo0Qs0K58MGPMgzIM/0HkJicHcRsAh7t
 5sIXskvKZvblT5Ns/WbXvL43vWevz94pZJonuLmrDdKPlb42Fi+rJaEGq4ZzqIXw2+lO
 oLg2GqMJ05o6O+sulCFhvNlO7Gi/EqXg0BcTa9UZBFFjk0oqZH0s/8GxfWJmGvbXxe05
 i6/Q8Ow83C0Da0opy+XDdA0JXPZzTj9A5XB0W3C9sWAVKd7F+xOrKg68FKM95ZmYyKC6
 6CzwRqQ2M1yHH6+s38rfMGF7bgfTcAXyRYGq6arSBhW9zc9HDHvSL8+mSg0jiIwN5GXN Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspsur4ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6HJiUX011398;
        Mon, 6 Dec 2021 17:26:12 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspsur4a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HDjU0029433;
        Mon, 6 Dec 2021 17:26:11 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyya2myr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ9xB33161498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E4572805C;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5059E28066;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3 16/16] ima: Setup securityfs for IMA namespace
Date:   Mon,  6 Dec 2021 12:26:00 -0500
Message-Id: <20211206172600.1495968-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WQF4-a-BpyO5hdFJWtBH_ByznmN1DGmL
X-Proofpoint-ORIG-GUID: wtya9TdK3wZsbyxMBJAdCeIJuB3CQkEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Setup securityfs with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

The securityfs file and directory ownerships cannot be set when the
IMA namespace is initialized. Therefore, delay the setup of the file
system to a later point when securityfs initializes the fs_context.
Use securityfs_register_ns_notifier() to register a notifier for
populating the filsystem late.

This filesystem can now be mounted as follows:

mount -t securityfs /sys/kernel/security/ /sys/kernel/security/

The following directories, symlinks, and files are then available.

$ ls -l sys/kernel/security/
total 0
lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity

$ ls -l sys/kernel/security/ima/
total 0
-r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
-r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
-rw-------. 1 root root 0 Dec  2 00:18 policy
-r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
-r--r-----. 1 root root 0 Dec  2 00:18 violations

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/ima.h             |  3 ++-
 security/integrity/ima/ima_fs.c | 46 ++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index bfb978a7f8d5..cab5fc6caeb3 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -221,7 +221,8 @@ struct ima_h_table {
 };
 
 enum {
-	IMAFS_DENTRY_DIR = 0,
+	IMAFS_DENTRY_INTEGRITY_DIR = 0,
+	IMAFS_DENTRY_DIR,
 	IMAFS_DENTRY_SYMLINK,
 	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
 	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c2a886c00ac2..c17a6b7eeb95 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -456,12 +456,25 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 	memset(ns->dentry, 0, sizeof(ns->dentry));
 }
 
-static int __init ima_fs_ns_init(struct user_namespace *user_ns)
+static int ima_fs_ns_init(struct user_namespace *user_ns)
 {
 	struct ima_namespace *ns = user_ns->ima_ns;
 	struct dentry *ima_dir;
 
-	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
+	/* already initialized? */
+	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
+		return 0;
+
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns)
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
+			securityfs_create_dir("integrity", NULL);
+	else
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = integrity_dir;
+
+	ns->dentry[IMAFS_DENTRY_DIR] =
+	    securityfs_create_dir("ima",
+				  ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR]);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
 		return -1;
 	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
@@ -511,7 +524,34 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 	return -1;
 }
 
-int __init ima_fs_init(void)
+static int ima_ns_notify(struct notifier_block *this, unsigned long msg,
+			    void *data)
 {
+	int rc = 0;
+	struct user_namespace *user_ns = data;
+
+	switch (msg) {
+	case SECURITYFS_NS_ADD:
+		rc = ima_fs_ns_init(user_ns);
+		break;
+	case SECURITYFS_NS_REMOVE:
+		ima_fs_ns_free_dentries(user_ns->ima_ns);
+		break;
+	}
+	return rc;
+}
+
+static struct notifier_block ima_ns_notifier = {
+	.notifier_call = ima_ns_notify,
+};
+
+int ima_fs_init()
+{
+	int rc;
+
+	rc = securityfs_register_ns_notifier(&ima_ns_notifier);
+	if (rc)
+		return rc;
+
 	return ima_fs_ns_init(&init_user_ns);
 }
-- 
2.31.1

