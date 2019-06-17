Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39648C21
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfFQShy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 14:37:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41581 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQShx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 14:37:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so861257pls.8;
        Mon, 17 Jun 2019 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5eKh/DRVd1FpfihYitd7cyh/Xzcloht+qnfxwzs2rgY=;
        b=ifWQveQvE6MZpR4TeW/jRhoEtW6sfdjdhQQofR+gii3IM/XpvvHTUG29nnh8Vv9uOK
         4n1bVYFjGCzvQMK90O2nYw3mftj13JailvRjozxr0oKkN3Abvjqqrnu5qwXDWMQm6bM1
         S/W6E86kW2eJRDRsh+Kiw9+QCe4GHEtOngeChCtNtjSeI6T2m3k3BiZ7eKVgVFTbJLmf
         14we4paq7eaS4hJaI8LshF43WhPU4VFcxrjJfqB+3ZlaFSehdc57oQ47FOXUBqHVn2jK
         IBnH9YeI1tGxQjqYEbdhrQz/FLct7beIZEp8bAMW2SAg00sdVZP51o9fa+/7RFnbYWuY
         EUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eKh/DRVd1FpfihYitd7cyh/Xzcloht+qnfxwzs2rgY=;
        b=b4+i3Q1VpsfyL936FP7VpEhEFee023xokKZsxdUQBpZK3S61pf8exIDCcZ1iUpcLgG
         NB2s73s7/xIBKqntTwL/jvCWo5IN61Jr94e1OLNOQWXzYUdZwZbR7Plb6QBHkt/FiNnF
         kvNqAumf7XirM6OtdBhjyFvHQLsMfyMfWaQAifJAB0rcONfmxRsZ42aAXgyWrPeiByYh
         9DW8evESgBElzD9gubMldyVEkqcQxiIkRJylYE0moMgTa5Be95rqwah1SLQN+OG4+d7z
         hbOAvWjyJbinW30QgAU9KEdEPIwi/JZ6eRdDrEEBQGR7V9nO7ACwvwZiilbPHJxZ/2gO
         /ZDA==
X-Gm-Message-State: APjAAAUOXvfwI14W/1LtD0wAon/w4gN832JHo2nVCKNz8dqr8XbRuxZv
        V5XjItF6mO7rjyS9GalTkCxscbks
X-Google-Smtp-Source: APXvYqxlsjyFEPxLGML3pWz5dQPKBGDA6K/ju4NjoqOnZklEWmDd4J822z60E5eTspzNNS1Zx3dIvA==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr10587840plp.226.1560796672623;
        Mon, 17 Jun 2019 11:37:52 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f17sm13104817pgv.16.2019.06.17.11.37.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:37:52 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V9 2/3] IMA:Define a new template field buf
Date:   Mon, 17 Jun 2019 11:37:37 -0700
Message-Id: <20190617183738.14484-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617183738.14484-1-prsriva02@gmail.com>
References: <20190617183738.14484-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A buffer(kexec boot command line arguments) measured into IMA
measuremnt list cannot be appraised, without already being
aware of the buffer contents. Since hashes are non-reversible,
raw buffer is needed for validation or regenerating hash for
appraisal/attestation.

Add support to store/read the buffer contents in HEX.
The kexec cmdline hash is stored in the "d-ng" field of the
template data,it can be verified using
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
  grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

- Add two new fields to ima_event_data to hold the buf and
buf_len [Suggested by Roberto]
- Add a new temaplte field 'buf' to be used to store/read
the buffer data.[Suggested by Mimi]
- Updated process_buffer_meaurement to add the buffer to
ima_event_data. process_buffer_measurement added in
"Define a new IMA hook to measure the boot command line
 arguments"
- Add a new template policy name ima-buf to represent
'd-ng|n-ng|buf'

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---
 Documentation/security/IMA-templates.rst  |  7 ++++---
 security/integrity/ima/ima.h              |  2 ++
 security/integrity/ima/ima_api.c          |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  2 ++
 security/integrity/ima/ima_template.c     |  3 +++
 security/integrity/ima/ima_template_lib.c | 21 +++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++++
 8 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..fccdbbc984f5 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,14 +69,15 @@ descriptors by adding their identifier to the format string
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
  - 'n-ng': the name of the event, without size limitations;
- - 'sig': the file signature.
-
+ - 'sig': the file signature;
+ - 'buf': the buffer data that was used to generate the hash without size limitations;
 
 Below, there is the list of defined template descriptors:
 
  - "ima": its format is ``d|n``;
  - "ima-ng" (default): its format is ``d-ng|n-ng``;
- - "ima-sig": its format is ``d-ng|n-ng|sig``.
+ - "ima-sig": its format is ``d-ng|n-ng|sig``;
+ - "ima-buf": its format is ``d-ng|n-ng|buf``;
 
 
 
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
index 1e233417a7af..84b321ac1ad3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -638,6 +638,8 @@ static void process_buffer_measurement(const void *buf, int size,
 		goto out;
 
 	event_data.filename = eventname;
+	event_data.buf = buf;
+	event_data.buf_len = size;
 
 	iint.ima_hash = &hash.hdr;
 	iint.ima_hash->algo = ima_hash_algo;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e6e892f31cbd..632f314c0e5a 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
+	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -43,6 +44,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "buf", .field_init = ima_eventbuf_init,
+	 .field_show = ima_show_template_buf},
 };
 #define MAX_TEMPLATE_NAME_LEN 15
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..baf4de45c5aa 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -162,6 +162,12 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
 }
 
+void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
+			   struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+}
+
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
@@ -389,3 +395,18 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
 					     DATA_FMT_HEX, field_data);
 }
+
+/*
+ *  ima_eventbuf_init - include the buffer(kexec-cmldine) as part of the
+ *  template data.
+ */
+int ima_eventbuf_init(struct ima_event_data *event_data,
+		      struct ima_field_data *field_data)
+{
+	if ((!event_data->buf) || (event_data->buf_len == 0))
+		return 0;
+
+	return ima_write_template_field_data(event_data->buf,
+					     event_data->buf_len, DATA_FMT_HEX,
+					     field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..12f1a8578b31 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data);
 void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
+void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
+			   struct ima_field_data *field_data);
 int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 		  int maxfields, struct ima_field_data *fields, int *curfields,
 		  unsigned long *len_mask, int enforce_mask, char *bufname);
@@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
+int ima_eventbuf_init(struct ima_event_data *event_data,
+		      struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.19.1

