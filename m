Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F91A541
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfEJWc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 18:32:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41720 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfEJWcp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 18:32:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so3923454pfc.8;
        Fri, 10 May 2019 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbEXwJMOtDQCCWFKbIVF5kC5vfVIQcIDsT/50hWcZh8=;
        b=r1fdDXIzYcrBPoSBP9WfJyjDYuhPJV+VgznFwlHrLVUR8b5oxa7wxkxfFIJFsJQWuA
         2NrDJUahkOXB9W0JuXZ4bos3nKeE8fbLdsm3wQdTxHxv9mAb9xm63e84vIt4l+dDQaZD
         jxbi1BPUimFHFZL5n4KObwnfHWNThfv8SOeBk2YeKxbaW3mapt8EmS5vezxPGIwKsIXG
         5elxNb+o19cPE3c8eSSA72LLZ923ZAICgZlOQbRz+uUZnUNF26OectUoSfMVZm6KKIFL
         3PpbgoyUwDKsgt7LBzgCP6jmxVrrl7b1jhcu65Ct7O3DYCchcGtewegSab8NDQsWD20c
         ru0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbEXwJMOtDQCCWFKbIVF5kC5vfVIQcIDsT/50hWcZh8=;
        b=m1LzZW/UyPcrKAs/mncqPk91WCMAzw6lWWuahvc3cRyf623SDJ6Ty6JuvubJt4a++K
         C5CkNJeDHGaL9HTDKgZP7Wl3fKhOUQ9ncwgq80iA/yuVrKYtePvLik1kcVN9VLTtcbjg
         IJoJJxbN+gaEs/cXzgvImmhM5cQgpI7qZMhB1NboD9PTa2/ZRKaX83GtltpvRPp3SJHw
         enycEPHu12xmBEghvk555EWBA1hfdFHxk1OslOdPWt0FklleVFl3scnNZCAFWo9L+0ZR
         eY5tHaMeZoqhkKM1RD4v5AZ/v6ClVYXdSpAmnjfH9sXWJ5IeKmEXglFDoQYk0A1PJ7kM
         Dyow==
X-Gm-Message-State: APjAAAXqt2e59hsWJVDWliFd8ZdGCPhoFhpPt0LaF3BJVS9rbgDt/vX3
        QwKagwGHpqhMe7M9P1OA/9IsWmjFoMo=
X-Google-Smtp-Source: APXvYqy8pJcdJjNZja56wBzpWMfjAsOwf1ifL80e9RfHT6w4oQ6pwktnhPDDaZ78oAUL/HacPWt15g==
X-Received: by 2002:a63:1555:: with SMTP id 21mr16686114pgv.204.1557527563943;
        Fri, 10 May 2019 15:32:43 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id g72sm16907374pfg.63.2019.05.10.15.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:32:43 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 2/3 v5] add a new template field buf to contain the buffer
Date:   Fri, 10 May 2019 15:32:27 -0700
Message-Id: <20190510223228.9966-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223228.9966-1-prsriva02@gmail.com>
References: <20190510223228.9966-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

The buffer(cmdline args) added to the ima log cannot be attested
without having the actual buffer. Thus to make the measured buffer 
available to stroe/read a new ima temaplate (buf) is added. 
The cmdline args used for soft reboot can then be read and attested
later.

The patch adds a new template field buf to store/read the buffer
used while measuring kexec_cmdline args in the 
[PATCH 1/2 v5]: "add a new ima hook and policy to measure the cmdline".
Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 security/integrity/ima/ima_main.c         | 23 +++++++++++++++++++++++
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 21 +++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++++
 security/integrity/integrity.h            |  1 +
 5 files changed, 51 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d186bda25fe..ca12885ca241 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -605,10 +605,32 @@ static int process_buffer_measurement(const void *buf, int size,
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
 
+	struct buffer_xattr {
+		enum evm_ima_xattr_type type;
+		u16 buf_length;
+		unsigned char buf[0];
+	};
+	struct buffer_xattr *buffer_event_data = NULL;
+	int alloc_length = 0;
+
 	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
 	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
 		goto out;
 
+	alloc_length = sizeof(struct buffer_xattr) + size;
+	buffer_event_data = kzalloc(alloc_length, GFP_KERNEL);
+	if (!buffer_event_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	buffer_event_data->type = IMA_XATTR_BUFFER;
+	buffer_event_data->buf_length = size;
+	memcpy(buffer_event_data->buf, buf, size);
+
+	event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
+	event_data.xattr_len = alloc_length;
+
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 
@@ -638,6 +660,7 @@ static int process_buffer_measurement(const void *buf, int size,
 	}
 
 out:
+	kfree(buffer_event_data);
 	return ret;
 }
 
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
index 513b457ae900..95a827f42c18 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -162,6 +162,11 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
 }
 
+void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
+				struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+}
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
@@ -389,3 +394,19 @@ int ima_eventsig_init(struct ima_event_data *event_data,
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
+	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+
+	if ((!xattr_value) || (xattr_value->type != IMA_XATTR_BUFFER))
+		return 0;
+
+	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
+					DATA_FMT_HEX, field_data);
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
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..14ef904f091d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -74,6 +74,7 @@ enum evm_ima_xattr_type {
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_PORTABLE_DIGSIG,
+	IMA_XATTR_BUFFER,
 	IMA_XATTR_LAST
 };
 
-- 
2.20.1

