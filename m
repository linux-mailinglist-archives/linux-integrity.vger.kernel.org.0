Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAC68BF7D
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjBFOF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjBFOEv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBE279BA;
        Mon,  6 Feb 2023 06:04:03 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqN6W038582;
        Mon, 6 Feb 2023 14:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jP8KBaC2w1pfrnP6mRMKdLJWyfdX3yly5X0lzocqMKw=;
 b=Q9+58PBAuv7K9sdx1kk32mae/47Us56qKnnOV2KQn4cowbELz7OAYZTdnBIRAKarAw0k
 MBmGdy4a41KmKrbejdPhx6r5MWnyo9lXFFwFWxNKtOYqXewXv/+ttUAHmdxhYtRtHQ52
 RiljvyIM8IWNXJ4Imkb/cEidF2lrptk0jTf/hnIciJhAhhA7x40c+YEoQe5Wflbp/25M
 0TqXs4ZJZikE2d6N3UO6Yn3+NR9oQC/ogMOPv/eSte/jAoCjvTB0AWP7G3eE+xuUwSKQ
 Cwjjnl1hyrjqO0h/aQ+EEVV/N3DzOSwkmrfQ8X75hRHdDwy+Nsye7u3ORUAsnz2NHDoH Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2qagj1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DrXbm006236;
        Mon, 6 Feb 2023 14:03:49 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2qagj0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:49 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CQ4QT003472;
        Mon, 6 Feb 2023 14:03:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07300m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:47 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3kdF10879728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3364758059;
        Mon,  6 Feb 2023 14:03:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62E6858058;
        Mon,  6 Feb 2023 14:03:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:44 +0000 (GMT)
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
Subject: [PATCH v15 22/26] ima: Introduce securityfs file to activate an IMA namespace
Date:   Mon,  6 Feb 2023 09:02:49 -0500
Message-Id: <20230206140253.3755945-23-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dpoIrqpPJo_FEpEfcinJ8zJLzLqE0I1M
X-Proofpoint-ORIG-GUID: ZcM-rIOOyUqBK-iUE5FKpdikw5_lSyaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=822
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce the IMA securityfs file 'active' that users now need to
write a "1" into (precisely a '1\0' or '1\n') to activate an IMA namespace.
When reading from the file, it shows either '0' or '1'.

The rationale for introducing a file to activate an IMA namespace is that
subsequent support for IMA-measurement and IMA-appraisal will add
configuration files for selecting for example the template that an IMA
namespace is supposed to use for logging measurements, which will add
an IMA namespace configuration stage (using securityfs files) before its
activation. Besides that it allows to create a user namespace with
securityfs mounted and an inactive IMA namespace.

Also, introduce ns_is_active() to be used in those places where the
ima_namespace pointer may either be NULL or where the active flag may not
have been set, yet. An inactive IMA namespace should never be accessed
since it has not been initialized, yet.

Set the init_ima_ns's active flag since it is considered active right from
the beginning.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v12:
 - Fixed uninitialized ret if IS_ERR(active) was true

v11:
 - Move code from ima_fs_add_ns_files() into ima_fs_ns_init()
 - Use ima_ns_flags and IMA_NS_ACTIVE instead of 'atomic_t active'

v10:
 - use memdup_user_nul to copy input from user
 - propagating error returned from ima_fs_add_ns_files()
---
 security/integrity/ima/ima.h             |  6 +++
 security/integrity/ima/ima_fs.c          | 64 ++++++++++++++++++++++++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_main.c        |  2 +-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 29f1e9f95869..450e7ec0a9d7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -126,6 +126,7 @@ struct ima_namespace {
 	unsigned long ima_ns_flags;
 /* Bit numbers for above flags; use BIT() to get flag */
 #define IMA_NS_LSM_UPDATE_RULES		0
+#define IMA_NS_ACTIVE			1
 
 	struct rb_root ns_status_tree;
 	rwlock_t ns_tree_lock;
@@ -158,6 +159,11 @@ struct ima_namespace {
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
+static inline bool ns_is_active(struct ima_namespace *ns)
+{
+	return (ns && test_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags));
+}
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 84cd02a9e19b..301c717e029f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -451,6 +451,57 @@ static const struct file_operations ima_measure_policy_ops = {
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
+			"%d\n", !!test_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags));
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
+	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
+
+	return count;
+}
+
+static const struct file_operations ima_active_ops = {
+	.read = ima_show_active,
+	.write = ima_write_active,
+};
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -461,6 +512,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *ascii_runtime_measurements = NULL;
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
+	struct dentry *active = NULL;
 	int ret;
 
 	/* FIXME: update when evm and integrity are namespaced */
@@ -531,8 +583,20 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		}
 	}
 
+	if (ns != &init_ima_ns) {
+		active =
+		    securityfs_create_file("active",
+					   S_IRUSR | S_IWUSR | S_IRGRP, ima_dir,
+					   NULL, &ima_active_ops);
+		if (IS_ERR(active)) {
+			ret = PTR_ERR(active);
+			goto out;
+		}
+	}
+
 	return 0;
 out:
+	securityfs_remove(active);
 	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index e841302cada9..03d326cf82d4 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -62,5 +62,6 @@ struct ima_namespace init_ima_ns = {
 	.ima_lsm_policy_notifier = {
 		.notifier_call = ima_lsm_policy_change,
 	},
+	.ima_ns_flags = BIT(IMA_NS_ACTIVE),
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7908acd57e9f..3bae652142f5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -443,7 +443,7 @@ static int process_measurement(struct user_namespace *user_ns,
 
 	while (user_ns) {
 		ns = ima_ns_from_user_ns(user_ns);
-		if (ns) {
+		if (ns_is_active(ns)) {
 			int rc;
 
 			rc = __process_measurement(ns, file, cred, secid, buf,
-- 
2.37.3

