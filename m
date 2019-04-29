Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B47EC49
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfD2Vry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 17:47:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46452 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfD2Vrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so5780569pgg.13;
        Mon, 29 Apr 2019 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2t239L7s8Jpz4BJcRnXzFB8xlH6Q+7IBVrC0omZ+eM8=;
        b=Z6rmpTKN87HmmpMJxAU8VNq3T9zrkpJB/8GgR4Fbe7MNvdBf7pvLPXh30/YUi5PfWI
         pelqSEa4nKxFA5ujmL0jD3T4qPtT6//MEYg8mhXEgxg1jfSDc56R8pI05rYenNIbHDsb
         6j2q25wQfU9ji48lZLWzp/H9y8XtVM4C33dlMLAb1cOii4BEWvy6MmSgGkvnlUQI8lc8
         C5rVNUb4euCZcUrNrNbgDbwW+95xDtafAMJiuF6Z3xrYqvUGak2cli+GqM6v2011YcP9
         N2kExtGOS8T4MJG7CYkDe3nC48L210VvRBHGRhFv6x+TsjS11NVCVLmNkvDNthgpPyjb
         bGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2t239L7s8Jpz4BJcRnXzFB8xlH6Q+7IBVrC0omZ+eM8=;
        b=H/gdi6/d308qpe8sYbtSSOvErbKgxQYS/+q9FSoBC4YU9G66Havie8/9KNu+nae6qJ
         /7frSLz95cABjabj6Jt6u2oSPLx6QpTAABKsiywPPA3tZB5TFD5MXjMjxg0gyM7Lo2xd
         dmRJGFWb7ojkZJkeuWx86PM/JNysx3yvUhp2bXBz1iQV0ZnjUpqJVsqE7JbLjR1j9bE7
         FAswwvlZPS8J+0J0SoFeKT9pqxipjpeoHrPRZa2eyIVr3EU9DdQ1p/nh6LlYvwk8HOpR
         50LL3cuOGG8x41m3hx4Fed+t8VjYbfGdb0Sw1bHTcYL7QRgsfRq9RlmfL9mMrc4B6E1A
         fTGA==
X-Gm-Message-State: APjAAAWNGiH8dmktt/3OkT6x6OKz8jvqmsal+bpTTxDvdVU2NekoQRfF
        JPmEoYr6DW6BnAbfCqn6t8LXRbTPYWE=
X-Google-Smtp-Source: APXvYqxE08yrbx73yKN40LZmc8jwSD+97+3LuZyJMiRw1GAaoDobYCgOeh7WoQrueIiSqQ9qDQYlnQ==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr62610333pgk.382.1556574472952;
        Mon, 29 Apr 2019 14:47:52 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:9:445d:9822:2ddb:fb8c])
        by smtp.gmail.com with ESMTPSA id f66sm1941623pfg.55.2019.04.29.14.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:47:51 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v3 2/4] add the buffer to the xattr
Date:   Mon, 29 Apr 2019 14:47:41 -0700
Message-Id: <20190429214743.4625-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190429214743.4625-1-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

add the buffer to the xattr for a buffer case

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 security/integrity/ima/ima_main.c         | 37 ++++++++++++++++++++---
 security/integrity/ima/ima_template_lib.c |  3 +-
 security/integrity/integrity.h            |  1 +
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3db3f3966ac7..7362952ab273 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -603,16 +603,37 @@ static int process_buffer_measurement(const void *buff, int size,
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
+		struct buffer_xattr {
+		enum evm_ima_xattr_type type;
+		u16 buff_length;
+		unsigned char buff[0];
+	};
+
 	int violation = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct buffer_xattr *buffer_event_data = NULL;
+	int alloc_length = 0;
+	int action = 0;
 
 	if (!buff || size ==  0 || !eventname)
 		goto err_out;
 
-	if (ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr)
-		!= IMA_MEASURE)
+	action = ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr);
+	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
+		goto err_out;
+
+	alloc_length = sizeof(struct buffer_xattr) + size;
+	buffer_event_data = kzalloc(alloc_length, GFP_KERNEL);
+	if (!buffer_event_data)
 		goto err_out;
 
+	buffer_event_data->type = IMA_XATTR_BUFFER;
+	buffer_event_data->buff_length = size;
+	memcpy(buffer_event_data->buff, buff, size);
+
+	event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
+	event_data.xattr_len = alloc_length;
+
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 
@@ -630,17 +651,23 @@ static int process_buffer_measurement(const void *buff, int size,
 	if (ret < 0)
 		goto err_out;
 
-	ret = ima_store_template(entry, violation, NULL,
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL,
 					buff, pcr);
+
 	if (ret < 0) {
 		ima_free_template_entry(entry);
 		goto err_out;
 	}
 
-	return 0;
+	if (action & IMA_AUDIT)
+		ima_audit_measurement(iint, event_data.filename);
+
+	ret = 0;
 
 err_out:
-	pr_err("Error in adding buffer measure: %d\n", ret);
+	kfree(buffer_event_data);
+	pr_debug("%s return: %d\n", __func__, ret);
 	return ret;
 }
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..d22de3d8fcd9 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -383,7 +383,8 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 {
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
 
-	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
+	if ((!xattr_value) || !((xattr_value->type == EVM_IMA_XATTR_DIGSIG) ||
+		(xattr_value->type == IMA_XATTR_BUFFER)))
 		return 0;
 
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
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
2.19.1

