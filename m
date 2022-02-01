Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73C4A6600
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiBAUi6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240341AbiBAUiQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JNwRi015388;
        Tue, 1 Feb 2022 20:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KTWrpHKCce+2LttByh855lKBACfNPZrVBe8p9TEujyk=;
 b=AuLf8YmxuleMCjtLrGO8/b9psXmkpIY4V7w/c+KN+qEUem6hhYoM6u3qnuq8MLInflpJ
 GML5QWzekbVmx4NjHmFg8R2uY2RepPjlX0hG+aDHOHvQKtCr/8eEzj1LfKuZt8YILvhA
 VwsOnr/ohu4iFj7kDtm+2xQJo2x0e3RLmXKg/JN9AKtZm/cglExWJsu0Lpkk/ZIggyVp
 ClTrqmsM/TIPro6DGvTtHIGbKSOsDG9gRwlfpUq/nHHj2VGPUg/yjKFf9uAaZpuugrEE
 4ge6cbznVLCaHLdv0YOwf0PYG4FgX2enkcYMVIK2lGGjY4syNrrV5rxsSq78KWNTxVln EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyb01s75t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211JmnxK026377;
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyb01s75g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWO2I014840;
        Tue, 1 Feb 2022 20:37:51 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3dvw7b151y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KboiH31588830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D1BB205F;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337D8B206B;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
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
Subject: [PATCH v10 08/27] ima: Move measurement list related variables into ima_namespace
Date:   Tue,  1 Feb 2022 15:37:16 -0500
Message-Id: <20220201203735.164593-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sw9ZE1WtJBsXeRSyR3PJDoVEDE6quMuv
X-Proofpoint-ORIG-GUID: GvtjzKqYMIjaodGxVGybZEov1QFbkgB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move measurement list related variables into the ima_namespace. This way
a front-end like securityfs can show the measurement list inside an IMA
namespace.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h             |  5 +++--
 security/integrity/ima/ima_fs.c          |  6 ++++--
 security/integrity/ima/ima_init_ima_ns.c |  5 +++++
 security/integrity/ima/ima_kexec.c       | 12 ++++++-----
 security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
 5 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 340a59174670..45706836a77b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -106,7 +106,6 @@ struct ima_queue_entry {
 	struct list_head later;		/* place in ima_measurements list */
 	struct ima_template_entry *entry;
 };
-extern struct list_head ima_measurements;	/* list of all measurements */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -136,6 +135,8 @@ struct ima_namespace {
 	struct ima_rule_entry *arch_policy_entry;
 
 	struct ima_h_table ima_htable;
+	struct list_head ima_measurements;	/* list of all measurements */
+	unsigned long binary_runtime_size;	/* used by init_ima_ns */
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
@@ -186,7 +187,7 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
 int ima_restore_measurement_list(struct ima_namespace *ns,
 				 loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
-unsigned long ima_get_binary_runtime_size(void);
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index dca7fe32d65e..5ef0e2b2cf64 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -80,12 +80,13 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
 	/* we need a lock since pos could point beyond last element */
 	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
 		if (!l--) {
 			rcu_read_unlock();
 			return qe;
@@ -97,6 +98,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -107,7 +109,7 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&qe->later == &ima_measurements) ? NULL : qe;
+	return (&qe->later == &ns->ima_measurements) ? NULL : qe;
 }
 
 static void ima_measurements_stop(struct seq_file *m, void *v)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 1945fa8cfc4d..a7477072c587 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -20,6 +20,11 @@ static int ima_init_namespace(struct ima_namespace *ns)
 	atomic_long_set(&ns->ima_htable.len, 0);
 	atomic_long_set(&ns->ima_htable.violations, 0);
 	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
+	INIT_LIST_HEAD(&ns->ima_measurements);
+	if (IS_ENABLED(CONFIG_IMA_KEXEC) && ns == &init_ima_ns)
+		ns->binary_runtime_size = 0;
+	else
+		ns->binary_runtime_size = ULONG_MAX;
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f3ef8a0df992..e83b18492f46 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(struct ima_namespace *ns,
+				     unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
@@ -36,7 +37,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
 		if (file.count < file.size) {
 			khdr.count++;
 			ima_measurements_show(&file, qe);
@@ -84,6 +85,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
+	struct ima_namespace *ns = &init_ima_ns;
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
@@ -96,11 +98,11 @@ void ima_add_kexec_buffer(struct kimage *image)
 	 * Reserve an extra half page of memory for additional measurements
 	 * added during the kexec load.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	binary_runtime_size = ima_get_binary_runtime_size(ns);
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
+		kexec_segment_size = ALIGN(ima_get_binary_runtime_size(ns) +
 					   PAGE_SIZE / 2, PAGE_SIZE);
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
@@ -108,7 +110,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+	ima_dump_measurement_list(ns, &kexec_buffer_size, &kexec_buffer,
 				  kexec_segment_size);
 	if (!kexec_buffer) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 43961d5cd2ef..0355c2b0932c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -24,13 +24,6 @@
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
-LIST_HEAD(ima_measurements);	/* list of all measurements */
-#ifdef CONFIG_IMA_KEXEC
-static unsigned long binary_runtime_size;
-#else
-static unsigned long binary_runtime_size = ULONG_MAX;
-#endif
-
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
@@ -100,7 +93,7 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	qe->entry = entry;
 
 	INIT_LIST_HEAD(&qe->later);
-	list_add_tail_rcu(&qe->later, &ima_measurements);
+	list_add_tail_rcu(&qe->later, &ns->ima_measurements);
 
 	atomic_long_inc(&ns->ima_htable.len);
 	if (update_htable) {
@@ -110,12 +103,14 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 		INIT_HLIST_NODE(&qe->hnext);
 	}
 
-	if (binary_runtime_size != ULONG_MAX) {
+	if (ns->binary_runtime_size != ULONG_MAX) {
 		int size;
 
 		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-		     binary_runtime_size + size : ULONG_MAX;
+		ns->binary_runtime_size =
+			(ns->binary_runtime_size < ULONG_MAX - size)
+			? ns->binary_runtime_size + size
+			: ULONG_MAX;
 	}
 	return 0;
 }
@@ -123,14 +118,16 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 /*
  * Return the amount of memory required for serializing the
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
- * structure.
+ * structure. Carrying the measurement list across kexec is limited
+ * to init_ima_ns.
  */
-unsigned long ima_get_binary_runtime_size(void)
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	if (ns->binary_runtime_size >=
+				(ULONG_MAX - sizeof(struct ima_kexec_hdr)))
 		return ULONG_MAX;
 	else
-		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
-- 
2.31.1

