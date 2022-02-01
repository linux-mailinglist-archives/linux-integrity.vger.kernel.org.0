Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740FB4A65FB
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiBAUix (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240382AbiBAUiR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:17 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Js1PV027971;
        Tue, 1 Feb 2022 20:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VNAee6VM45tuopzYYtIVE2klfsHx+qC38Q9rFGUGHE8=;
 b=Nu+3HnDsrI3+F14gWGV6VvNHdQxl6F2F+jzjGb9xnQ1TVnXvcvL9qmmw4J33lJItX/V2
 +ITIF1Ek2hP7PiwRdsOUQcwR7HU+tWz/Q4VeAIADoGWBrdYoSj37DEZNy6vHuEbOd4gc
 B94z9a8oQEyVfPSUERAw4cUBUideZO1JOj8lILezTKiwh6xwT4LWie5tlT7fCiJKaTbU
 TDMwdTKIQ/JS9tSoDBpa5KUfJmjh92qxxVVc8WpnDaKQ6On5IqtgMMdMsaUYO0debF5d
 cLwfq909VLvFX9pxrccRHTNlSocvlzAX15h44JD/jCeAQgqB6NYPnyT5EWvhe7tSZEDF FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58pww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Jwurc015248;
        Tue, 1 Feb 2022 20:37:54 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58pwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KX760024283;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7as4cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Kbqth38732078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F2BBB2071;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C285B205F;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
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
Subject: [PATCH v10 24/27] ima: Introduce securityfs file to activate an IMA namespace
Date:   Tue,  1 Feb 2022 15:37:32 -0500
Message-Id: <20220201203735.164593-25-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BXbc2XOQfKQy4jJgUGsKHWLZahmuhor2
X-Proofpoint-ORIG-GUID: z0jhVAtsfGwZc_Es6uwDV6tLMVsd0cXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
 v10:
 - use memdup_user_nul to copy input from user
 - propagating error returned from ima_fs_add_ns_files()
---
 security/integrity/ima/ima.h             |  7 +++
 security/integrity/ima/ima_fs.c          | 71 ++++++++++++++++++++++++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_main.c        |  2 +-
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1e3f9dda218d..05e2de7697da 100644
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
index 84cd02a9e19b..58d80884880f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -451,6 +451,71 @@ static const struct file_operations ima_measure_policy_ops = {
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
+	char *kbuf;
+	int err;
+
+	if (ns_is_active(ns))
+		return -EBUSY;
+
+	/* accepting '1\n' and '1\0' and no partial writes */
+	if (count >= 3 || *ppos != 0)
+		return -EINVAL;
+
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	err = kstrtouint(kbuf, 10, &active);
+	kfree(kbuf);
+	if (err)
+		return err;
+
+	if (active != 1)
+		return -EINVAL;
+
+	atomic_set(&ns->active, 1);
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
@@ -531,6 +596,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		}
 	}
 
+	if (ns != &init_ima_ns) {
+		ret = ima_fs_add_ns_files(ima_dir);
+		if (ret)
+			goto out;
+	}
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
index 1dee8cb5afa2..9ca9223bbcf6 100644
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

