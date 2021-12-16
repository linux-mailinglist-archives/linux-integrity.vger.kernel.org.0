Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D574769C1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhLPFoC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:44:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233786AbhLPFn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:43:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4Ufak001490;
        Thu, 16 Dec 2021 05:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HMtKZi043Ihl9dEGvseWmupgcIpRkzUbGMUnXrasTtQ=;
 b=YKl6L0COsZYr2oNTCcSiFVlwnJy8ECOT7dOPlPsLrr6biZ441yRh+VW5QegYRVhkMKYt
 gq9oiv/xqa/j5VRyqlzVAejVCk4T4a5bfPKLpQQ8F1Ki1HOg7ktQKFgtKC4nTAHCtRsV
 fEIjwSIYF+u3wJu3/ipsnwk42g3bMXFtA06TQU5iW+kLTYgUEIEPapmVbl0trNElASdc
 IHh7FCzKDWVvGaDroeVK9buV8ecRgbCGaljQizDdwnvw3XHGXGF8OPoxQI/N6IFdqoYt
 QUbddPTaIzdZQ/xGUHoPihx6yevw+3f5de5Hufb6XPpOFQ+aI3Uk41O+u/Wur27PXVti vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cys70xmra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:37 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5NGPr017715;
        Thu, 16 Dec 2021 05:43:36 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cys70xmqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:36 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5hLNP023391;
        Thu, 16 Dec 2021 05:43:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3cy797k4t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:35 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hYqk31260958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:34 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5C86E062;
        Thu, 16 Dec 2021 05:43:33 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9E7B6E050;
        Thu, 16 Dec 2021 05:43:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:32 +0000 (GMT)
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
Subject: [PATCH v7 06/14] ima: Move measurement list related variables into ima_namespace
Date:   Thu, 16 Dec 2021 00:43:15 -0500
Message-Id: <20211216054323.1707384-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jvv-axyW4sZ1cOYU7xtJxg163lVr9rSi
X-Proofpoint-GUID: PFzpf0-d-UR-opl31Iq1DojUp6lzKlRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Move measurement list related variables into the ima_namespace. This way a
front-end like SecurityFS can show the measurement list inside an IMA
namespace.

Implement ima_free_measurements() to free a list of measurements
and call it when an IMA namespace is deleted.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h             |  6 ++--
 security/integrity/ima/ima_fs.c          |  6 ++--
 security/integrity/ima/ima_init_ima_ns.c |  5 ++++
 security/integrity/ima/ima_kexec.c       | 12 ++++----
 security/integrity/ima/ima_ns.c          |  1 +
 security/integrity/ima/ima_queue.c       | 36 +++++++++++++++---------
 6 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 83f53e33d6bc..25d58269adeb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -103,7 +103,6 @@ struct ima_queue_entry {
 	struct list_head later;		/* place in ima_measurements list */
 	struct ima_template_entry *entry;
 };
-extern struct list_head ima_measurements;	/* list of all measurements */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -140,6 +139,8 @@ struct ima_namespace {
 	int ima_policy_flag;
 
 	struct ima_h_table ima_htable;
+	struct list_head ima_measurements;
+	unsigned long binary_runtime_size;
 } __randomize_layout;
 
 extern const int read_idmap[];
@@ -195,8 +196,9 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
 				  struct ima_template_entry *entry);
 int ima_restore_measurement_list(struct ima_namespace *ns,
 				 loff_t bufsize, void *buf);
+void ima_free_measurements(struct ima_namespace *ns);
 int ima_measurements_show(struct seq_file *m, void *v);
-unsigned long ima_get_binary_runtime_size(void);
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 97517830ed62..55b6a4ebef3a 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -80,12 +80,13 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
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
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
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
index 23c14a684d90..10a7a0606de8 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -30,6 +30,11 @@ int ima_init_namespace(struct ima_namespace *ns)
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
index f3ef8a0df992..c07149228013 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(struct ima_namespace *ns,
+				    unsigned long *buffer_size, void **buffer,
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
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 4b7f179ea8b9..d192a80c927f 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -46,6 +46,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
 	ima_free_policy_rules(ns);
 	free_ns_status_cache(ns);
+	ima_free_measurements(ns);
 	kmem_cache_free(imans_cachep, ns);
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1e1edaeb3ebd..ca225d76357f 100644
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
@@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	qe->entry = entry;
 
 	INIT_LIST_HEAD(&qe->later);
-	list_add_tail_rcu(&qe->later, &ima_measurements);
+	list_add_tail_rcu(&qe->later, &ns->ima_measurements);
 
 	atomic_long_inc(&ns->ima_htable.len);
 	if (update_htable) {
@@ -116,12 +109,14 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	} else
 		INIT_HLIST_NODE(&qe->hnext);
 
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
@@ -131,12 +126,13 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure.
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
@@ -217,6 +213,18 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
 	return result;
 }
 
+void ima_free_measurements(struct ima_namespace *ns)
+{
+	struct ima_queue_entry *qe, *tmp;
+
+	list_for_each_entry_safe(qe, tmp, &ns->ima_measurements, later) {
+		list_del(&qe->later);
+		if (!hlist_unhashed(&qe->hnext))
+			hlist_del(&qe->hnext);
+		kfree(qe);
+	}
+}
+
 int __init ima_init_digests(void)
 {
 	u16 digest_size;
-- 
2.31.1

