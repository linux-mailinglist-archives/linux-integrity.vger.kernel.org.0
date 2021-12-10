Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EC470ABE
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbhLJTvg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:51:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25496 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343711AbhLJTv3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIv3DV017087;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4tGjfzkjMGQ2KgjPK3Ll+QStpNIq21ZlivCJTVWdi3M=;
 b=KaEMI0m1mwAz4/jfHQab4px83k3i4MrqteWtp7VzfOD7fLVBOQOi4n+w6aN77YIuTTcC
 TdvYO0t74UtkZUUwHekqcp3rFUK0wcUfrfPjv5ab72hYnBMQcx6wyF21+K1rZIhPKg0W
 mKKdnegG8xBs6/ndYjZSEKUSfPx+sEoG3E5GFIMwdE7KV/z5GiihTGjkovopuv4C3uKW
 ml8oHpeggDpfjiunIegLXKDjwd5FzxGxLbgcn1rCQ5SF30Em/MxJToo/YeZAofPO62Zj
 8MW2OwLTVbvm39KRGyRTrcOKHiQ5jxuW0KEDkGDGc5xoNngVQxa1TEzL82SwXwT6jU8I Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvcmes0sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJecd2001605;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvcmes0sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJcDSu028115;
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyycns5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJldwq26214888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B38D1AE06A;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95BC6AE064;
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
Subject: [PATCH v6 14/17] ima: Tie opened SecurityFS files to the IMA namespace it belongs to
Date:   Fri, 10 Dec 2021 14:47:33 -0500
Message-Id: <20211210194736.1538863-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ezDsSUc3jztVFRcGJyhBUeoeeLtevKQa
X-Proofpoint-GUID: YBBYPq93c9aDIbGvG8mESVRbwn52nRyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tie IMA's files in SecurityFS to the IMA namespace they belong to so that
also file descriptor that were passed or inherited to other user/IMA
namespaces will always access the data of the IMA namespace they originally
belonged to.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c     | 74 ++++++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c |  4 +-
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 0e582ceecc7f..a136d14f29ec 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -35,6 +35,20 @@ static int __init default_canonical_fmt_setup(char *str)
 }
 __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
+static inline struct user_namespace *ima_user_ns_from_file(struct file *filp)
+{
+	return filp->f_path.mnt->mnt_sb->s_user_ns;
+}
+
+static int ima_open(struct inode *inode, struct file *file)
+{
+	struct user_namespace *user_ns = ima_user_ns_from_file(file);
+	struct ima_namespace *ns = user_ns->ima_ns;
+
+	file->private_data = ns;
+	return 0;
+}
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -49,12 +63,13 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = filp->private_data;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.violations);
 }
 
 static const struct file_operations ima_htable_violations_ops = {
+	.open = ima_open,
 	.read = ima_show_htable_violations,
 	.llseek = generic_file_llseek,
 };
@@ -63,12 +78,13 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = filp->private_data;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
+	.open = ima_open,
 	.read = ima_show_measurements_count,
 	.llseek = generic_file_llseek,
 };
@@ -76,7 +92,7 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = m->private;
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -94,7 +110,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = m->private;
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -195,9 +211,26 @@ static const struct seq_operations ima_measurments_seqops = {
 	.show = ima_measurements_show
 };
 
+static int ima_seq_open(struct file *file, const struct seq_operations *seq_ops)
+{
+	struct user_namespace *user_ns = ima_user_ns_from_file(file);
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct seq_file *seq;
+	int err;
+
+	err = seq_open(file, seq_ops);
+	if (err)
+		return err;
+
+	seq = file->private_data;
+	seq->private = ns;
+
+	return 0;
+}
+
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_measurments_seqops);
+	return ima_seq_open(file, &ima_measurments_seqops);
 }
 
 static const struct file_operations ima_measurements_ops = {
@@ -263,7 +296,7 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_ascii_measurements_seqops);
+	return ima_seq_open(file, &ima_ascii_measurements_seqops);
 }
 
 static const struct file_operations ima_ascii_measurements_ops = {
@@ -273,9 +306,8 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 {
-	struct ima_namespace *ns = get_current_ns();
 	void *data = NULL;
 	char *datap;
 	size_t size;
@@ -314,10 +346,23 @@ static ssize_t ima_read_policy(char *path)
 		return pathlen;
 }
 
+static struct ima_namespace *ima_filp_private(struct file *filp)
+{
+	if (!(filp->f_flags & O_WRONLY)) {
+#ifdef CONFIG_IMA_READ_POLICY
+		struct seq_file *seq;
+
+		seq = filp->private_data;
+		return seq->private;
+#endif
+	}
+	return filp->private_data;
+}
+
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = ima_filp_private(file);
 	char *data;
 	ssize_t result;
 
@@ -340,7 +385,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_policy(ns, data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
@@ -386,7 +431,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -396,11 +442,13 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 			return -EACCES;
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		return seq_open(filp, &ima_policy_seqops);
+		return ima_seq_open(filp, &ima_policy_seqops);
 #endif
 	}
 	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
 		return -EBUSY;
+
+	filp->private_data = ns;
 	return 0;
 }
 
@@ -413,7 +461,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = ima_filp_private(file);
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 747dca6131d6..c2acd4cf529d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1908,7 +1908,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = m->private;
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1928,7 +1928,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ima_rule_entry *entry = v;
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns = m->private;
 
 	rcu_read_lock();
 	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
-- 
2.31.1

