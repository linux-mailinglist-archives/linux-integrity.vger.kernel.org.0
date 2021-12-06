Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287B946A2BE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbhLFR3y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:29:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239305AbhLFR3x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:53 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6FmaNu027745;
        Mon, 6 Dec 2021 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ElT1R68eFHoxWm54sqUuqKvMeDAzTrpTAfv6wJD2+Kg=;
 b=KkiNQ2pbpvIVZ5Ibb/qPZ/ai2r3fdcgo41Kpbtz3CNYjLn5ZYsdQt0lccrHs0lmzbnO0
 DLgWoYEJONfDIiTxKlXBDKfybmnYP9oZ0XHnVnKUYXTenGvY8kZUhNhGttBm15eWr8Hd
 OKrgI8+QAthaDs/mtnT8F0Qi/3B6kEQJefzLm17lQaw6Xu2x3lwYzpIUNicHeBg8pXnN
 fZ7U/KyTbBGE52xLlCkWgTCtc9qWJFsVJtSYWFwyuLRWn/9VvztoyqZcbC/hyvmpz8CB
 j2c8NCySznTpWE4hymfzw/vGTa8/nEIznye7SMDdfpE/hGbUf8DBBQXz8Rd1GBdO6DGK yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csn61jdas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6Fo7FC032444;
        Mon, 6 Dec 2021 17:26:11 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csn61jda9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HEJZs000482;
        Mon, 6 Dec 2021 17:26:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy72d0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ8q519726946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7690128064;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61B5928060;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
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
Subject: [PATCH v3 08/16] ima: Move measurement list related variables into ima_namespace
Date:   Mon,  6 Dec 2021 12:25:52 -0500
Message-Id: <20211206172600.1495968-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OE1zxsxDUOuWBZe52t-oYJUaMCyHCkOi
X-Proofpoint-ORIG-GUID: Tbw3qoo8w5VL-PWRC94fcDPon6YlYVnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move measurement list related variables into the ima_namespace. This way a
front-end like SecurityFS can show the measurement list inside an IMA
namespace.

Implement ima_free_measurements() to free a list of measurements
and call it when an IMA namespace is deleted.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      |  2 ++
 security/integrity/ima/ima.h             |  4 +--
 security/integrity/ima/ima_fs.c          |  6 +++--
 security/integrity/ima/ima_init_ima_ns.c |  5 ++++
 security/integrity/ima/ima_ns.c          |  1 +
 security/integrity/ima/ima_queue.c       | 33 ++++++++++++++----------
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 929bf87b1bbf..53f944469de7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -259,6 +259,8 @@ struct ima_namespace {
 	int ima_policy_flag;
 
 	struct ima_h_table ima_htable;
+	struct list_head ima_measurements;
+	unsigned long binary_runtime_size;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a7e6c8fb152a..bb9763cd5fb1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -104,7 +104,6 @@ struct ima_queue_entry {
 	struct list_head later;		/* place in ima_measurements list */
 	struct ima_template_entry *entry;
 };
-extern struct list_head ima_measurements;	/* list of all measurements */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -168,8 +167,9 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
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
index 9df8648ad64d..c35e15fb313f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -80,12 +80,13 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = get_current_ns();
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
+	struct ima_namespace *ns = get_current_ns();
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
index e13adc3287ed..57e46a10c001 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -43,6 +43,11 @@ int ima_init_namespace(struct ima_namespace *ns)
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
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index efbf7087a8ee..debe863364fd 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -69,6 +69,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
 	ima_free_policy_rules(ns);
 	free_ns_status_cache(ns);
+	ima_free_measurements(ns);
 	kmem_cache_free(imans_cachep, ns);
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 373154039b91..f15f776918ec 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -25,13 +25,6 @@
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
@@ -116,12 +109,12 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	} else
 		INIT_HLIST_NODE(&qe->hnext);
 
-	if (binary_runtime_size != ULONG_MAX) {
+	if (ns->binary_runtime_size != ULONG_MAX) {
 		int size;
 
 		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-		     binary_runtime_size + size : ULONG_MAX;
+		ns->binary_runtime_size = (ns->binary_runtime_size < ULONG_MAX - size) ?
+		     ns->binary_runtime_size + size : ULONG_MAX;
 	}
 	return 0;
 }
@@ -131,12 +124,12 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure.
  */
-unsigned long ima_get_binary_runtime_size(void)
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	if (ns->binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
 		return ULONG_MAX;
 	else
-		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
@@ -217,6 +210,18 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
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

