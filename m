Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F97248A40
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRPoZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:44:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgHRPoZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:44:25 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EA1DB868795C484C0F5B;
        Tue, 18 Aug 2020 16:44:22 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:44:21 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:44:23 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 10/30] ima: Add ima namespace ID to the ima ML related structures
Date:   Tue, 18 Aug 2020 17:42:10 +0200
Message-ID: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add ima namespace ID to the ima_event_data and ima_template_entry. This
is done so that the ima namespace ID can be tracked per entry and
included in the hash. The following patch will add a new template that
will utilize it.

IMA namespace ID is simply an inode number allocated to the namespace
when it's created and therefore it can be re-used once the namespace is
destroyed.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h          | 19 ++++++++++++++++++-
 security/integrity/ima/ima_api.c      |  9 ++++++++-
 security/integrity/ima/ima_fs.c       | 17 +++++++++++------
 security/integrity/ima/ima_init.c     |  2 ++
 security/integrity/ima/ima_kexec.c    |  4 +++-
 security/integrity/ima/ima_main.c     |  5 +++--
 security/integrity/ima/ima_template.c | 10 +++++++---
 7 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 33b4a8295c41..7b7252d35d5a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -75,6 +75,7 @@ struct ima_event_data {
 	const char *violation;
 	const void *buf;
 	int buf_len;
+	unsigned int ns_id;
 };
 
 /* IMA template field data definition */
@@ -103,6 +104,7 @@ struct ima_template_desc {
 
 struct ima_template_entry {
 	int pcr;
+	unsigned int ns_id;
 	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
@@ -129,8 +131,17 @@ extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
+extern const u16 kexec_header_version;
+static inline u16 get_kexec_header_version(void)
+{
+	return kexec_header_version;
+}
 #else
 static inline void ima_load_kexec_buffer(void) {}
+static inline u16 get_kexec_header_version(void)
+{
+	return 1;
+}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
 
 /*
@@ -153,7 +164,8 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 int ima_calc_boot_aggregate(struct ima_digest_data *hash);
 void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
-		       const char *op, const char *cause);
+		       const char *op, const char *cause,
+		       struct ima_namespace *ima_ns);
 int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
@@ -415,6 +427,11 @@ extern struct ima_policy_setup_data init_policy_setup_data;
 extern struct list_head ima_ns_list;
 extern struct rw_semaphore ima_ns_list_lock;
 
+static inline unsigned int get_ns_id(const struct ima_namespace *ima_ns)
+{
+	return ima_ns->ns.inum;
+}
+
 #ifdef CONFIG_IMA_NS
 int __init ima_init_namespace(void);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 8d7b0d4635fc..1f4411fffa45 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -76,6 +76,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 		(*entry)->template_data_len += sizeof(len);
 		(*entry)->template_data_len += len;
 	}
+
+	(*entry)->ns_id = event_data->ns_id;
 	return 0;
 out:
 	ima_free_template_entry(*entry);
@@ -132,7 +134,8 @@ int ima_store_template(struct ima_template_entry *entry,
  */
 void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
-		       const char *op, const char *cause)
+		       const char *op, const char *cause,
+		       struct ima_namespace *ima_ns)
 {
 	struct ima_template_entry *entry;
 	struct inode *inode = file_inode(file);
@@ -143,6 +146,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	int violation = 1;
 	int result;
 
+	event_data.ns_id = get_ns_id(ima_ns);
+
 	/* can overflow, only indicator */
 	atomic_long_inc(&ima_htable.violations);
 
@@ -313,7 +318,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 					     .xattr_len = xattr_len,
 					     .modsig = modsig };
 	int violation = 0;
+	struct ima_namespace *ima_ns = get_current_ns();
 
+	event_data.ns_id = get_ns_id(ima_ns);
 	/*
 	 * We still need to store the measurement in the case of MODSIG because
 	 * we only have its contents to put in the list at the time of
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3839b9eaecab..4758e14c4a7b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -117,6 +117,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 
 /* print format:
  *       32bit-le=pcr#
+ *       32bit-le=namespace id
  *       char[20]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
@@ -129,7 +130,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	u32 pcr, namelen, template_data_len; /* temporary fields */
+	u32 pcr, ns_id, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
 	int i;
 
@@ -149,18 +150,22 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	pcr = !ima_canonical_fmt ? e->pcr : cpu_to_le32(e->pcr);
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
-	/* 2nd: template digest */
+	/* 2nd: ima namespace id */
+	ns_id = !ima_canonical_fmt ? e->ns_id : cpu_to_le32(e->ns_id);
+	ima_putc(m, &ns_id, sizeof(e->ns_id));
+
+	/* 3rd: template digest */
 	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
 
-	/* 3rd: template name size */
+	/* 4th: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
 		cpu_to_le32(strlen(template_name));
 	ima_putc(m, &namelen, sizeof(namelen));
 
-	/* 4th:  template name */
+	/* 5th:  template name */
 	ima_putc(m, template_name, strlen(template_name));
 
-	/* 5th:  template length (except for 'ima' template) */
+	/* 6th:  template length (except for 'ima' template) */
 	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
 		is_ima_template = true;
 
@@ -170,7 +175,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
 	}
 
-	/* 6th:  template specific data */
+	/* 7th:  template specific data */
 	for (i = 0; i < e->template_desc->num_fields; i++) {
 		enum ima_show_type show = IMA_SHOW_BINARY;
 		const struct ima_template_field *field =
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d042b08cc4d7..d63ecb02b032 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -68,6 +68,8 @@ static int __init ima_add_boot_aggregate(void)
 		char digest[TPM_MAX_DIGEST_SIZE];
 	} hash;
 
+	event_data.ns_id = get_ns_id(&init_ima_ns);
+
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 	iint->ima_hash = &hash.hdr;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..1fefa59cf9b1 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -13,6 +13,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+const u16 kexec_header_version = 2;
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -33,7 +35,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	file.count = sizeof(khdr);	/* reserved space */
 
 	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
+	khdr.version = kexec_header_version;
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
 		if (file.count < file.size) {
 			khdr.count++;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 80b1737a3369..fa63780ae76e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -134,10 +134,10 @@ static void ima_rdwr_violation_check(struct file *file,
 
 	if (send_tomtou)
 		ima_add_violation(file, *pathname, iint,
-				  "invalid_pcr", "ToMToU");
+				  "invalid_pcr", "ToMToU", ima_ns);
 	if (send_writers)
 		ima_add_violation(file, *pathname, iint,
-				  "invalid_pcr", "open_writers");
+				  "invalid_pcr", "open_writers", ima_ns);
 }
 
 static void ima_check_active_ns(struct ima_namespace *current_ima_ns,
@@ -923,6 +923,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		goto out;
 	}
 
+	event_data.ns_id = get_ns_id(ima_ns);
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 5a2def40a733..945e70fafd2e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -13,7 +13,7 @@
 #include "ima.h"
 #include "ima_template_lib.h"
 
-enum header_fields { HDR_PCR, HDR_DIGEST, HDR_TEMPLATE_NAME,
+enum header_fields { HDR_PCR, HDR_NS_ID, HDR_DIGEST, HDR_TEMPLATE_NAME,
 		     HDR_TEMPLATE_DATA, HDR__LAST };
 
 static struct ima_template_desc builtin_templates[] = {
@@ -362,6 +362,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	struct ima_kexec_hdr *khdr = buf;
 	struct ima_field_data hdr[HDR__LAST] = {
 		[HDR_PCR] = {.len = sizeof(u32)},
+		[HDR_NS_ID] = {.len = sizeof(u32)},
 		[HDR_DIGEST] = {.len = TPM_DIGEST_SIZE},
 	};
 
@@ -382,7 +383,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		khdr->buffer_size = le64_to_cpu(khdr->buffer_size);
 	}
 
-	if (khdr->version != 1) {
+	if (khdr->version != get_kexec_header_version()) {
 		pr_err("attempting to restore a incompatible measurement list");
 		return -EINVAL;
 	}
@@ -394,11 +395,12 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 	bitmap_zero(hdr_mask, HDR__LAST);
 	bitmap_set(hdr_mask, HDR_PCR, 1);
+	bitmap_set(hdr_mask, HDR_NS_ID, 1);
 	bitmap_set(hdr_mask, HDR_DIGEST, 1);
 
 	/*
 	 * ima kexec buffer prefix: version, buffer size, count
-	 * v1 format: pcr, digest, template-name-len, template-name,
+	 * v2 format: pcr, ns_id, digest, template-name-len, template-name,
 	 *	      template-data-size, template-data
 	 */
 	bufendp = buf + khdr->buffer_size;
@@ -470,6 +472,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(hdr[HDR_PCR].data));
+		entry->ns_id = !ima_canonical_fmt ? *(hdr[HDR_NS_ID].data) :
+			     le32_to_cpu(*(hdr[HDR_NS_ID].data));
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
-- 
2.20.1

