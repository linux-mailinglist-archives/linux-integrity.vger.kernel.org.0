Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825205023A
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfFXGYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 02:24:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41740 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfFXGYw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id y72so6528658pgd.8;
        Sun, 23 Jun 2019 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7KgeCWoIYvzHqbQO0gbh/ggWINu6e3+yzWokAE8U54=;
        b=u4de4LAPDzX8oPmZCuOTIZu5+4Dh3Bf7J5IdjgtWSkJTrAMioa4m4tQgZ7XG1jV+GY
         tt/hxdUxgVz2bwOr+VJ3MJ3LjcE4d9/Ke6OWRdqjwiUM63aM+kT/hplK/8JXbwu9nBO1
         Pd/j5un4jp7ijBrliB5Xs86Ejp+994Cx84IVcnhCmBEzNeak1b1jfGeYaOcQMfZNr5jJ
         kOnYlW8PNbQdTvkXQDyRibVOaAKBp3JvsZeVOzKmE0vsyNg49IDVwuKMtXmrj2ZmiatJ
         kDua3OklzFbk5lFWQPGLZt99LTq48E87OvVHeDyKv/VAXB9F1BtLSpbyKHQ+gQju6YoQ
         7kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7KgeCWoIYvzHqbQO0gbh/ggWINu6e3+yzWokAE8U54=;
        b=qUuvM/AXh507usS3GLMoEKo5YCW4m8lIPphK2/CBD78lIlsa8T2T9HJqDHt7WKuXdA
         Sqe3D/v7f2Go/o2RCzTfTYZT0HxCSVk+hRfurqRg9+hDbGqcItomgbg48v9+vwcjUy96
         9qeOwRm3+dCwJUSDBcKoyD28UKvt/bAwoN5+XDvz2Bovzj5AHP3TrKE2C88V57UJJEF+
         hKzb1/Q5MlzsREoWS4D5z8as8m4+GfdQLbgbb+cOc70ssakfUVQFIAIiIq9nNrjawb1+
         o2ihwtKwpDKM4/93lYvi4UbqCB8DNiO78dONqAO/Kgf6jonsqC6WyeQ+cdqPFoCeVY7z
         vAKw==
X-Gm-Message-State: APjAAAXiArIqr/EPfuZybMYWCFO+S5CuoiPv04/q7HSg3XV2Y6nHvTQ2
        /UUewu4GpEoezMhyjAB5MxNvgJz7
X-Google-Smtp-Source: APXvYqw+DdTMnXJ8GmRg0HuK0sJKr8U+Z02WZScMH4hXt0jYiQ6ClhiYbPu+HeIQoB8c1sZWFEFm3w==
X-Received: by 2002:a63:d512:: with SMTP id c18mr32420591pgg.239.1561357490935;
        Sun, 23 Jun 2019 23:24:50 -0700 (PDT)
Received: from prsriva-ThinkPad-P50s.hsd1.wa.comcast.net ([2601:602:9c01:c794:e00a:1dbc:5f62:b8ea])
        by smtp.gmail.com with ESMTPSA id 191sm2641620pfu.177.2019.06.23.23.24.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:50 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V10 2/3] IMA: Define a new template field buf
Date:   Sun, 23 Jun 2019 23:23:30 -0700
Message-Id: <20190624062331.388-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624062331.388-1-prsriva02@gmail.com>
References: <20190624062331.388-1-prsriva02@gmail.com>
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
 security/integrity/ima/ima_main.c         |  4 +++-
 security/integrity/ima/ima_template.c     |  3 +++
 security/integrity/ima/ima_template_lib.c | 21 +++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++++
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..3d1cca287aa4 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,15 +69,16 @@ descriptors by adding their identifier to the format string
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
  - 'n-ng': the name of the event, without size limitations;
- - 'sig': the file signature.
+ - 'sig': the file signature;
+ - 'buf': the buffer data that was used to generate the hash without size limitations;
 
 
 Below, there is the list of defined template descriptors:
 
  - "ima": its format is ``d|n``;
  - "ima-ng" (default): its format is ``d-ng|n-ng``;
- - "ima-sig": its format is ``d-ng|n-ng|sig``.
-
+ - "ima-sig": its format is ``d-ng|n-ng|sig``;
+ - "ima-buf": its format is ``d-ng|n-ng|buf``;
 
 
 Use
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index bdca641f9e51..6aa28ab53d27 100644
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2507bee1b762..317c4b6f2c18 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -627,7 +627,9 @@ static void process_buffer_measurement(const void *buf, int size,
 	struct ima_template_entry *entry = NULL;
 	struct integrity_iint_cache iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
-					    .filename = eventname};
+					    .filename = eventname,
+					    .buf = buf,
+					    .buf_len = size};
 	struct ima_template_desc *template_desc = NULL;
 	struct {
 		struct ima_digest_data hdr;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 00dd5a434689..a01a17e5c581 100644
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

