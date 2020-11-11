Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58C2AFA1D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Nov 2020 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKKU7y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Nov 2020 15:59:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34346 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKU7y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Nov 2020 15:59:54 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A1AD20C281F;
        Wed, 11 Nov 2020 12:59:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A1AD20C281F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605128393;
        bh=ZwApRPA6yq3CTn0pJNUnmfzfcCUz7gA0vBBGNi8eScU=;
        h=From:To:Cc:Subject:Date:From;
        b=NKEoMctK9f3ZYPF7CJ31moNuev+uvzvmMpUQIM6KhmOfoarb9OEPwoRq/hTlZ0uod
         EO8UaSjk0cnVF8w5MEi2XUvY4unAGgYIcjZoW8XIjyWvj7RQyexjCnlZvsa1NP3g23
         csxTzViIj/0K3TdA9PBgT6ntNZ7I2PCtQZs3ip1Q=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ima: select ima-buf template for buffer measurement
Date:   Wed, 11 Nov 2020 12:59:46 -0800
Message-Id: <20201111205946.503-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default IMA template for measuring buffer should be 'ima-buf' - so
that the measured buffer is correctly included in the IMA measurement
log entry. But the default IMA template used for all policy rules is
the value set for CONFIG_IMA_DEFAULT_TEMPLATE if the policy rule does
not specify a template. IMA does not take into account the template
requirements of different rules when choosing a default template for
a given policy rule. This breaks the buffer measurement if the template
is not provided as part of the rule because the default template could
be different than 'ima-buf'.

For example, the following IMA policy rule enables measuring
the command line arguments passed to the new kernel on kexec system call.

 measure func=KEXEC_CMDLINE

The IMA template selected should be 'ima-buf' to have the measured 
command line arguments included in the IMA measurement log entry.
Instead the default IMA template is selected, which could be different
than 'ima-buf'.

Initialize a global 'ima-buf' template and select that template,
by default, for measuring buffer.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_main.c     | 17 +++++------------
 security/integrity/ima/ima_policy.c   |  2 +-
 security/integrity/ima/ima_template.c | 25 +++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 13 deletions(-)

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
index a962b23e0429..3646ae763ba9 100644
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
+	struct ima_template_desc *template = ima_template_desc_buf();
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -833,16 +833,9 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
 	if (!template) {
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
+		ret = -EINVAL;
+		audit_cause = "ima_template_desc_buf";
+		goto out;
 	}
 
 	iint.ima_hash = &hash.hdr;
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
index 1e89e2d3851f..e53fce2c1610 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -55,6 +55,7 @@ static const struct ima_template_field supported_fields[] = {
 #define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
 
 static struct ima_template_desc *ima_template;
+static struct ima_template_desc *ima_buf_template;
 
 /**
  * ima_template_has_modsig - Check whether template has modsig-related fields.
@@ -252,6 +253,30 @@ struct ima_template_desc *ima_template_desc_current(void)
 	return ima_template;
 }
 
+struct ima_template_desc *ima_template_desc_buf(void)
+{
+	struct ima_template_desc *template = NULL;
+	int ret = 0;
+
+	if (ima_buf_template)
+		return ima_buf_template;
+
+	ima_init_template_list();
+	template = lookup_template_desc("ima-buf");
+	if (!template)
+		return NULL;
+
+	ret = template_desc_init_fields(template->fmt,
+					&(template->fields),
+					&(template->num_fields));
+	if (ret)
+		return NULL;
+
+	ima_buf_template = template;
+
+	return ima_buf_template;
+}
+
 int __init ima_init_template(void)
 {
 	struct ima_template_desc *template = ima_template_desc_current();
-- 
2.29.0

