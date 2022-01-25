Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB249BEDE
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiAYWre (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbiAYWrZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMfj6t011040;
        Tue, 25 Jan 2022 22:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=369+3T91DjlWnaCaA0PLNFxxrjOgsi4pNFXhE+Rj8uU=;
 b=XPEbDgvF8693UDqgMotxivQXur5f5OfnPMWVtrrws4lSn5orn94UcX1FRgOoOVSeZ48H
 qFgwoTOERwiXId5Sy4n9cKFKt578uZOq5MnoBYT3WbuCl4aJ1TTU0k5S34x6izqyeHoW
 ICy99wIRxqUmsdv+bIb7wlEOgKSp5SiVhXFEZ8r1fvx82yqAK05+UCdyEHn1xwU+3+yP
 /XtbIeRpxXwJbL236zqTZV2y8Nzorku1Qp6IRJS3pHlq+u/4/Pk12D4Un04i7e3RgnfD
 qqQ3QWmkPVoS8J++nFnGesakkq1doLDwjkphGE1wSkxwJ2I7D5uv+k1KHyE6dWXgLTkB Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtt7ng2fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMferT010835;
        Tue, 25 Jan 2022 22:47:02 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtt7ng2fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:02 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhoik010375;
        Tue, 25 Jan 2022 22:47:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3dtbch8rg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkx9P30605638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77738AC05B;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 645CFAC05E;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
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
Subject: [PATCH v9 21/23] ima: Introduce securityfs file to activate an IMA namespace
Date:   Tue, 25 Jan 2022 17:46:43 -0500
Message-Id: <20220125224645.79319-22-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rr1XYM75bxcaDK2EZCPaqJgXjskGiVoH
X-Proofpoint-ORIG-GUID: gNsnAds2jdbJjZM2OSx2yq3NWWkpP0KA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Introduce securityfs file 'active' that allows a user to activate an IMA
namespace by writing a "1" (precisely a '1\0' or '1\n') to it. When
reading from the file, it shows either '0' or '1'.

Also, introduce ns_is_active() to be used in those places where the
ima_namespace pointer may either be NULL or where the active field may not
have been set to '1', yet. An inactive IMA namespace should never be
accessed since it has not been initialized, yet.

Set the init_ima_ns's active field to '1' since it is considered active
right from the beginning.

The rationale for introducing a file to activate an IMA namespace is that
subsequent support for IMA-measurement and IMA-appraisal will add
configuration files for selecting for example the template that an IMA
namespace is supposed to use for logging measurements, which will add
an IMA namespace configuration stage (using securityfs files) before its
activation.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h             |  7 +++
 security/integrity/ima/ima_fs.c          | 59 ++++++++++++++++++++++++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_main.c        |  2 +-
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a52b388b4157..cf2f63bb5bdf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -123,6 +123,8 @@ struct ima_h_table {
 };
 
 struct ima_namespace {
+	atomic_t active;		/* whether namespace is active */
+
 	struct rb_root ns_status_tree;
 	rwlock_t ns_tree_lock;
 	struct kmem_cache *ns_status_cache;
@@ -154,6 +156,11 @@ struct ima_namespace {
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
+static inline bool ns_is_active(struct ima_namespace *ns)
+{
+	return (ns && atomic_read(&ns->active));
+}
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5dd0e759a470..79a786db79db 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -451,6 +451,62 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static ssize_t ima_show_active(struct file *filp,
+			       char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct ima_namespace *ns = &init_ima_ns;
+	char tmpbuf[2];
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, sizeof(tmpbuf),
+			"%d\n", atomic_read(&ns->active));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_write_active(struct file *filp,
+				const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct ima_namespace *ns = &init_ima_ns;
+	unsigned int active;
+	char tmpbuf[3];
+	ssize_t ret;
+
+	if (ns_is_active(ns))
+		return -EBUSY;
+
+	ret = simple_write_to_buffer(tmpbuf, sizeof(tmpbuf) - 1, ppos,
+				     buf, count);
+	if (ret < 0)
+		return ret;
+	tmpbuf[ret] = 0;
+
+	if (!kstrtouint(tmpbuf, 10, &active) && active == 1)
+		atomic_set(&ns->active, 1);
+
+	return count;
+}
+
+static const struct file_operations ima_active_ops = {
+	.read = ima_show_active,
+	.write = ima_write_active,
+};
+
+static int ima_fs_add_ns_files(struct dentry *ima_dir)
+{
+	struct dentry *active;
+
+	active =
+	    securityfs_create_file("active",
+				   S_IRUSR | S_IWUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_active_ops);
+	if (IS_ERR(active))
+		return PTR_ERR(active);
+
+	return 0;
+}
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -516,6 +572,9 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 			goto out;
 	}
 
+	if (ns != &init_ima_ns && ima_fs_add_ns_files(ima_dir))
+		goto out;
+
 	return 0;
 out:
 	securityfs_remove(ns->ima_policy);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index d4ddfd1de60b..39ee0c2477a6 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -58,5 +58,6 @@ struct ima_namespace init_ima_ns = {
 	.ima_lsm_policy_notifier = {
 		.notifier_call = ima_lsm_policy_change,
 	},
+	.active = ATOMIC_INIT(1),
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8018e9aaad32..059917182960 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -441,7 +441,7 @@ static int process_measurement(struct user_namespace *user_ns,
 
 	while (user_ns) {
 		ns = ima_ns_from_user_ns(user_ns);
-		if (ns) {
+		if (ns_is_active(ns)) {
 			int rc;
 
 			rc = __process_measurement(ns, file, cred, secid, buf,
-- 
2.31.1

