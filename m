Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781C6244E6
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2019 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEUAGz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 20:06:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43003 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEUAGy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 20:06:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id 145so7554339pgg.9;
        Mon, 20 May 2019 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxIaeN4SD4CFbhbqaNpRlsoW5dHafJRRD8QpnczeAmQ=;
        b=cd4yskvtJ+KUGfjpl4WQ6FSqDhTfq7P08JFzEoT98G6r2q/jxYhAoGe2/ANamf+b2m
         bqYRtwf1bHWJYmKDHrDKfaozXQqDeyw78Q/TUVYIYYh639MOFdxXj/+l4wgIRXh1gAg1
         I0w3o9EVCs2Vx2Z+99NgjB5u3OVeBb9FMpSkVtB00pMRJdpd6pgrKaWYOp55z0TPVAj5
         uImyfWbltCwY602rzFzGL/6RRdxV6GvQN+F8/DeUGOmfKQgDPXzPSXXDQlZmDXyc9YOm
         YAXWiRyb8TOgJq2p1D+u0EedmgKTUy8FPRe+os11O3skdxZIagAam+LuhMBiCEk4KQXT
         Cz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JxIaeN4SD4CFbhbqaNpRlsoW5dHafJRRD8QpnczeAmQ=;
        b=OiN6rKDcAnCnp+xQfblyJVHwnffrlqYTeMVd4G7tCARnBndJzn9jLwqzWyl6IuggGb
         azb/7SGKl7jVnP62CF0wrUFC5WwOYSPQJmYqZLBHy8PJIP7pXOYXXC4OnfMPc4HLyFVF
         gwX2xNzzl/UdBL6CHLVpDIIzJF0ka2Il7PeRaOKKN5H2AQieODlbMIRRa+iXBZjKuOZ2
         6UhQHA947kPyvyRQ/b82uZa6Mf+/QPf87IhgrnkezUxs7KEkPQCeq3rbyC+1C1jO7/Ke
         Z99h74LG7qcVDplM2GE/wqyVISeAszTrN4e7s8qwGchq/EjV8uQkLWqCrKVVS2u1rYHY
         rN7g==
X-Gm-Message-State: APjAAAWZF9gMr4mZrSwjyxlq5C/iMkIIYcSwiNjXiesoOd/tqWY+q7gi
        E77zY3GSH0I9qOVpzVPtOZwLPbydwmjXyg==
X-Google-Smtp-Source: APXvYqymWVKYvHzfToNoW6hRcyCmFIj+AwqwvbnQLIRLaSQglL1AclWoZC40y5bdREA0+k3LCxG8Xw==
X-Received: by 2002:a62:e00e:: with SMTP id f14mr83173348pfh.257.1558397213403;
        Mon, 20 May 2019 17:06:53 -0700 (PDT)
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com ([2001:4898:80e8:1:e5e3:4312:180a:c25e])
        by smtp.gmail.com with ESMTPSA id i16sm5939149pfd.100.2019.05.20.17.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 17:06:52 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v6 2/3] add a new ima template field buf
Date:   Mon, 20 May 2019 17:06:44 -0700
Message-Id: <20190521000645.16227-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521000645.16227-1-prsriva02@gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A buffer(cmdline args) measured into ima cannot be appraised
without already being aware of the buffer contents.Since we
don't know what cmdline args will be passed (or need to validate
what was passed) it is not possible to appraise it. 

Since hashs are non reversible the raw buffer is needed to 
recompute the hash.
To regenrate the hash of the buffer and appraise the same
the contents of the buffer need to be available.

A new template field buf is added to the existing ima template
fields, which can be used to store/read the buffer itself.
Two new fields are added to the ima_event_data to carry the
buf and buf_len whenever necessary.

Updated the process_buffer_measurement call to add the buf
to the ima_event_data.
process_buffer_measurement added in "Add a new ima hook 
ima_kexec_cmdline to measure cmdline args"

- Add a new template field 'buf' to be used to store/read
the buffer data.
- Added two new fields to ima_event_data to hold the buf and
buf_len [Suggested by Roberto]
-Updated process_buffer_meaurement to add the buffer to
ima_event_data

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/security/IMA-templates.rst  |  2 +-
 security/integrity/ima/ima.h              |  2 ++
 security/integrity/ima/ima_api.c          |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  4 +++-
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 20 ++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++++
 8 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..9cddb66727ee 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -70,7 +70,7 @@ descriptors by adding their identifier to the format string
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature.
-
+ - 'buf': the buffer data that was used to generate the hash without size limitations.
 
 Below, there is the list of defined template descriptors:
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 226a26d8de09..4a82541dc3b6 100644
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
index 800d965232e5..c12f1cd38f8f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -134,7 +134,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	struct ima_template_entry *entry;
 	struct inode *inode = file_inode(file);
 	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
-					    cause};
+					    cause, NULL, 0};
 	int violation = 1;
 	int result;
 
@@ -286,7 +286,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	struct inode *inode = file_inode(file);
 	struct ima_template_entry *entry;
 	struct ima_event_data event_data = {iint, file, filename, xattr_value,
-					    xattr_len, NULL};
+					    xattr_len, NULL, NULL, 0};
 	int violation = 0;
 
 	if (iint->measured_pcrs & (0x1 << pcr))
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6c9295449751..0c34d3100b5b 100644
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
index a88c28918a63..6c5691b65b84 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -594,7 +594,7 @@ static void process_buffer_measurement(const void *buf, int size,
 	struct ima_template_entry *entry = NULL;
 	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
 	struct ima_event_data event_data = {iint, NULL, NULL,
-						NULL, 0, NULL};
+						NULL, 0, NULL, NULL, 0};
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -611,6 +611,8 @@ static void process_buffer_measurement(const void *buf, int size,
 	memset(&hash, 0, sizeof(hash));
 
 	event_data.filename = eventname;
+	event_data.buf = buf;
+	event_data.buf_len = size;
 
 	iint->ima_hash = &hash.hdr;
 	iint->ima_hash->algo = ima_hash_algo;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..a76d1c04162a 100644
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
2.17.1

