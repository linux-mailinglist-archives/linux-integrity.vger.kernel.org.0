Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048A41A55C
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfEJWiJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 18:38:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44578 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfEJWh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 18:37:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so3920708pfo.11;
        Fri, 10 May 2019 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbEXwJMOtDQCCWFKbIVF5kC5vfVIQcIDsT/50hWcZh8=;
        b=TcYtPFcqmJM5QCzQKdsaHDVEOJVlJsX8wGV6kBbxVG1qyVufYDlFsKa+5kbCFWpyiX
         +vDk+LPCnpCb0V7VjQUQ4BSNPWmLKTTmFR/YPfCLvi0PpCkPDlRJLe4n507fxvyWKt+V
         2rcKmVPrwZxof4OON99Q5rdbD/as/e5Phixk30dNrSL6aTsEA7/XrBT2VOPzOfBq7+kK
         /9gAK35rqAoUxT2O1HFZiJndYHP8tRrKxVjAfbGsbA3MT/O1Vx9q72VVlZRfyaHr1mdX
         rZPoEDo8A6CY3hP4azFcHzWNKLJHDq3sVvqbt3pVP62ZRU42OudeXsSF2hp4WmFHC2CJ
         wfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbEXwJMOtDQCCWFKbIVF5kC5vfVIQcIDsT/50hWcZh8=;
        b=TA5Sz8JvE/h/fI6EOmx94LXYkpL7dh6uLRNSSpYFJG6DAlnSXsuwa5kl3XfYjscIS2
         BFFm8BbwIxAD90F5kvEVUNqGz+bjZz+/l4bP8+3oSRcF6bVbdaOg2Yoyyh9MrKuxShr8
         N8tRltabI8F8As7+J/2imY+NKHR9q5cdm+b9UxG8xnTNsHM0Tcy5qBDdW8ZL1oO8Q1HE
         Xxq7MgrGmQTHjr/qRzIPm/HuNF/ocvzsrLzku3FRY4Y7ztmmoqyprBJLTiAvh8TdhVke
         70za7ZcTsSlo1WGKyaEiI6wg4F9C5XzXqXRKGzIZwzkoAeA3F3M47X6DaAg964RYvMWN
         9evg==
X-Gm-Message-State: APjAAAWX+XHn2GwjSaSlsCbyTZyUe5ef37NYJ9d7Hnq7a/cGAE+OFo2w
        TaywDO7EYjpu5txzqTPsPaUYnIW3NW0=
X-Google-Smtp-Source: APXvYqzjJr3YdkryE0ilpepGw2WGiwS81groppM5Cqsc9tuG0zvHKdptuh9wsuTjGf1+YgH11wSDGQ==
X-Received: by 2002:a65:5106:: with SMTP id f6mr16800600pgq.253.1557527878069;
        Fri, 10 May 2019 15:37:58 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id r74sm12459430pfa.71.2019.05.10.15.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:37:57 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 2/3 v5] add a new template field buf to contain the buffer
Date:   Fri, 10 May 2019 15:37:43 -0700
Message-Id: <20190510223744.10154-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223744.10154-1-prsriva02@gmail.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
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

