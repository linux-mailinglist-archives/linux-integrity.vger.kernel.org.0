Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71F32B0F1B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 21:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgKLUkG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 15:40:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44960 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLUkF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 15:40:05 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A76B020C2849;
        Thu, 12 Nov 2020 12:40:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A76B020C2849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605213604;
        bh=WfkOkUEoewOxDtqcDMjv9jmhFphtNKv7xopkuVMSR3s=;
        h=From:To:Cc:Subject:Date:From;
        b=BOzUqB4ay60ZS1GmYtHoIIhL6YKRblvXMxq/n+TH/ASlwEZYuoogBCr9z5GzWLc1R
         D220ifDGMeZjmEZqo3yiFG+WvptBNXvzFue5hLgZR7eYYEPyGaPOOzEyD+Kb45oW8n
         +UHnZxYB7T23y4sEPM3oOLwQvCDNNkH8iNxM/VnQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ima: select ima-buf template for buffer measurement
Date:   Thu, 12 Nov 2020 12:39:59 -0800
Message-Id: <20201112203959.3657-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default IMA template used for all policy rules is the value set
for CONFIG_IMA_DEFAULT_TEMPLATE if the policy rule does not specify
a template. The default IMA template for buffer measurements should be
'ima-buf' - so that the measured buffer is correctly included in the IMA
measurement log entry.

With the default template format, buffer measurements are added to
the measurement list, but do not include the buffer data, making it
difficult, if not impossible, to validate. Including 'ima-buf'
template records in the measurement list by default, should not impact
existing attestation servers without 'ima-buf' template support.

Initialize a global 'ima-buf' template and select that template,
by default, for buffer measurements.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_main.c     | 24 +++++++++---------------
 security/integrity/ima/ima_policy.c   |  2 +-
 security/integrity/ima/ima_template.c | 26 ++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..8e8b1e3cb847 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -156,6 +156,7 @@ int template_desc_init_fields(const char *template_fmt,
 			      const struct ima_template_field ***fields,
 			      int *num_fields);
 struct ima_template_desc *ima_template_desc_current(void);
+struct ima_template_desc *ima_template_desc_buf(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a962b23e0429..68956e884403 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -413,7 +413,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-	struct ima_template_desc *template;
+	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
 	char *pathbuf = NULL;
@@ -802,7 +802,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 					    .filename = eventname,
 					    .buf = buf,
 					    .buf_len = size};
-	struct ima_template_desc *template = NULL;
+	struct ima_template_desc *template;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -814,6 +814,13 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (!ima_policy_flag)
 		return;
 
+	template = ima_template_desc_buf();
+	if (!template) {
+		ret = -EINVAL;
+		audit_cause = "ima_template_desc_buf";
+		goto out;
+	}
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
@@ -832,19 +839,6 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
-	if (!template) {
-		template = lookup_template_desc("ima-buf");
-		ret = template_desc_init_fields(template->fmt,
-						&(template->fields),
-						&(template->num_fields));
-		if (ret < 0) {
-			pr_err("template %s init failed, result: %d\n",
-			       (strlen(template->name) ?
-				template->name : template->fmt), ret);
-			return;
-		}
-	}
-
 	iint.ima_hash = &hash.hdr;
 	iint.ima_hash->algo = ima_hash_algo;
 	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b5adeaa47fc..823a0c1379cb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -628,7 +628,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
 
-	if (template_desc)
+	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 1e89e2d3851f..e22e510ae92d 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -55,6 +55,7 @@ static const struct ima_template_field supported_fields[] = {
 #define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
 
 static struct ima_template_desc *ima_template;
+static struct ima_template_desc *ima_buf_template;
 
 /**
  * ima_template_has_modsig - Check whether template has modsig-related fields.
@@ -252,11 +253,36 @@ struct ima_template_desc *ima_template_desc_current(void)
 	return ima_template;
 }
 
+struct ima_template_desc *ima_template_desc_buf(void)
+{
+	if (!ima_buf_template) {
+		ima_init_template_list();
+		ima_buf_template = lookup_template_desc("ima-buf");
+	}
+	return ima_buf_template;
+}
+
 int __init ima_init_template(void)
 {
 	struct ima_template_desc *template = ima_template_desc_current();
 	int result;
 
+	result = template_desc_init_fields(template->fmt,
+					   &(template->fields),
+					   &(template->num_fields));
+	if (result < 0) {
+		pr_err("template %s init failed, result: %d\n",
+		       (strlen(template->name) ?
+		       template->name : template->fmt), result);
+		return result;
+	}
+
+	template = ima_template_desc_buf();
+	if (!template) {
+		pr_err("Failed to get ima-buf template\n");
+		return -EINVAL;
+	}
+
 	result = template_desc_init_fields(template->fmt,
 					   &(template->fields),
 					   &(template->num_fields));
-- 
2.29.2

