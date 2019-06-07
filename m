Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E742A3821A
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 02:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfFGAYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 20:24:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43585 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfFGAYF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 20:24:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so93218plb.10;
        Thu, 06 Jun 2019 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shUvO/uALYYYiabiTVXXX7TFdnr0+YAGqwBC2xXOs1I=;
        b=DWA/uWxh1OP3EU4EMjkhhQXhKfoqXmaScZcQjE0WbT8pfwLPJFwEGMfZX+cELGcejD
         9k4OPxmyapjjYXQGFXvZRY4UtDipQ/O0a4+ubsmTQ5I5Z/HlSZf6j/uaXbZ+aVJL5bxm
         Ly5JVAttV4IJbpsUgDCFycySASE6od+fLpId+5SQSYuCxwsqD1gEHy5SlFuuPCLMv0L9
         PC1fgFYDc98YB3KWeNFinmpr+6kRrEx5hMyaa+uyZSUZbS6RKIuJ/e5FQhEHAMIqIhZy
         htVwL/aXQDd49Tpv6eP0MudbTOwW2FiRWiKWBEjrWN9UBrNyzmzPTgGH/PA6C7kBjSif
         +bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shUvO/uALYYYiabiTVXXX7TFdnr0+YAGqwBC2xXOs1I=;
        b=Vtn/0uypzDS/ktb/qSI9rIzHkLSgOjmbPzN/Ah4+7nV/8VxZfFRmOYg9JD/cgstIXc
         5LLQyx5XQ4F2NpiFn3HLHjPmwW+Jnmkp7dPci1sYskSd0v2ud3VGd7NEQVtlzgduUflW
         PHRHm9EGcnvVWA8EIMzo569HcDyEdZBS+nWOyFp+4B2bAqgZIE6UJ2GzZtOu+kjSXDkd
         GyQiMHyBf5PQtz7XcOmWgIrRAW+Arf0YiGi3FmFlqbnqOf6/ZzEoRKZzpgQOpq/7R/Q1
         8ZOgYrEn638gzyma6VseZEZrlb3zZ2FzCNCpmTmBR4yhNztclvoVMM+CAYBL+QUamVGD
         pH8w==
X-Gm-Message-State: APjAAAWtthJNVPLoEmlJmWWQlv4EesHSvBVHlHgm1yAbNMjtSmNElN9T
        xQaBH+Mu34lV2ZmeMMGZycU9IwDV
X-Google-Smtp-Source: APXvYqwjhmKcAaaGHYD0+lgDApcZ4N4LOCeGmxd5C8XRhg/VK9YK2h7VKOwdKXRLi/eyaHfI4jq5lQ==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr52625359plx.173.1559867044506;
        Thu, 06 Jun 2019 17:24:04 -0700 (PDT)
Received: from localhost.localdomain ([167.220.98.69])
        by smtp.gmail.com with ESMTPSA id o13sm324179pfh.23.2019.06.06.17.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 17:24:04 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v7 2/3] add a new ima template field buf
Date:   Thu,  6 Jun 2019 17:23:29 -0700
Message-Id: <20190607002330.2999-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607002330.2999-1-prsriva02@gmail.com>
References: <20190607002330.2999-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A buffer(kexec cmdline args) measured into ima cannot be
appraised without already being aware of the buffer contents.
Since hashes are non-reversible, raw buffer is needed for
validation or regenerating hash for appraisal/attestation.

This patch adds support to ima to allow store/read the
buffer contents in HEX.

- Add two new fields to ima_event_data to hold the buf and
buf_len [Suggested by Roberto]
- Add a new temaplte field 'buf' to be used to store/read
the buffer data.[Suggested by Mimi]
- Updated process_buffer_meaurement to add the buffer to
ima_event_data. process_buffer_measurement added in
"Add a new ima hook ima_kexec_cmdline to measure cmdline args"

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |  4 ++--
 security/integrity/ima/ima.h              |  2 ++
 security/integrity/ima/ima_api.c          |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  2 ++
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 20 ++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++++
 8 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..3e78ce3591db 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,8 +69,8 @@ descriptors by adding their identifier to the format string
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
  - 'n-ng': the name of the event, without size limitations;
- - 'sig': the file signature.
-
+ - 'sig': the file signature;
+ - 'buf': the buffer data that was used to generate the hash without size limitations;
 
 Below, there is the list of defined template descriptors:
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4ad1270bffa..16110180545c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -65,6 +65,8 @@ struct ima_event_data {
 	struct evm_ima_xattr_data *xattr_value;
 	int xattr_len;
 	const char *violation;
+	const void *buf;
+	int buf_len;
 };
 
 /* IMA template field data definition */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index ea7d8cbf712f..83ca99d65e4b 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -140,7 +140,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	struct ima_template_entry *entry;
 	struct inode *inode = file_inode(file);
 	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
-					    cause};
+					    cause, NULL, 0};
 	int violation = 1;
 	int result;
 
@@ -296,7 +296,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	struct inode *inode = file_inode(file);
 	struct ima_template_entry *entry;
 	struct ima_event_data event_data = {iint, file, filename, xattr_value,
-					    xattr_len, NULL};
+					    xattr_len, NULL, NULL, 0};
 	int violation = 0;
 
 	if (iint->measured_pcrs & (0x1 << pcr))
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 993d0f1915ff..c8591406c0e2 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
 	struct ima_template_entry *entry;
 	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
 	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
-					    NULL, 0, NULL};
+					    NULL, 0, NULL, NULL, 0};
 	int result = -ENOMEM;
 	int violation = 0;
 	struct {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e4f301381ffb..9308d664f074 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -641,6 +641,8 @@ static void process_buffer_measurement(const void *buf, int size,
 	memset(&hash, 0, sizeof(hash));
 
 	event_data.filename = eventname;
+	event_data.buf = buf;
+	event_data.buf_len = size;
 
 	iint->ima_hash = &hash.hdr;
 	iint->ima_hash->algo = ima_hash_algo;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e6e892f31cbd..8c40de18a0aa 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -43,6 +43,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "buf", .field_init = ima_eventbuf_init,
+	 .field_show = ima_show_template_buf},
 };
 #define MAX_TEMPLATE_NAME_LEN 15
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..43d1404141c1 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -162,6 +162,12 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
 }
 
+void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
+				struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+}
+
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
@@ -389,3 +395,17 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
 					     DATA_FMT_HEX, field_data);
 }
+
+/*
+ *  ima_eventbuf_init - include the buffer(kexec-cmldine) as part of the
+ *  template data.
+ */
+int ima_eventbuf_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data)
+{
+	if ((!event_data->buf) || (event_data->buf_len == 0))
+		return 0;
+
+	return ima_write_template_field_data(event_data->buf, event_data->buf_len,
+					DATA_FMT_HEX, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..f0178bc60c55 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data);
 void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
+void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
+				struct ima_field_data *field_data);
 int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 		  int maxfields, struct ima_field_data *fields, int *curfields,
 		  unsigned long *len_mask, int enforce_mask, char *bufname);
@@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
+int ima_eventbuf_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.19.1

