Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8613580
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfECWZc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfECWZc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so3571458pfd.1;
        Fri, 03 May 2019 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCYiRNnltpkvoj8ToixhqlqBTpeJ7lAyOQFKreaMHto=;
        b=j+uD5XuhlO/E0xasB/FTkqDwc1JF2EE3loRoxhhozBo09wg7SZIvnT/8snOPpjob8/
         JfQ1C1cssLbQIDhBxJmWkKOcM0YgWPtTCzt54AFwhuyx9uu3H1EANjXNLK2qyveBoHDr
         s0MKrF3HufoI6tJmyvNgxBVyh2CFklyq04n5ued5mvebpSIhomA6slfU9mhlkBatC7U7
         A09j+rMYm+i34Sb7tnrwAHZZUKO6ugT+gyp45KHoByp3jej/JbhtuUZ8wlYeaLF7G1gm
         2Tko4UrMBLY/B9GQsBNQ3QP8TRk6U7N7YExYDr8GV8b6870LaboHezK/KM+STqAdtNux
         beVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCYiRNnltpkvoj8ToixhqlqBTpeJ7lAyOQFKreaMHto=;
        b=SUV9U9oGBk122icGiqERl1Pj+ShA2UdqYUB7kI8ZqC3qH6u+KC6GLZLIzKwHK7WrwW
         LfgHxsW66i9L1sbn+JG8znAq4obElsHPLuvFn1J/twzxn/Y3ZqexB0R7oH9P3Ng9zRCd
         xn0fVBwiaaS42fAgpMNRFLH15vrbU8wTnWttRk4F3IFGOoAd0ImSkmmmRqQX/DaPO7cU
         R+Ho2xqghPCMl6zm/47Hl7AnUCfD7s3Pkz4LIw+fGpdvbAA6LGvIn0PwwwNPxyXI0/NZ
         1ZZic8I6cpEg+GGhWJoaTblIEUOttnf2BoFTwSBER76d1q2HPL9gnNm6LYaFlinxn5Jd
         24HQ==
X-Gm-Message-State: APjAAAVOOIOi9K/ksbtv3O7Y4XNy9oB5zr9SK1vx/lQRqKn5GddKbO/w
        NUWV+g63wtTBqK/VZ2jj91MSTyAMDM0=
X-Google-Smtp-Source: APXvYqzXmnh92kzvMCsoi/9maVTJasAr1J7QkHZ9L8sl3nrOen9tUfqBCvRr2TpBp3UNrQn75bnJ7A==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr14442618pfh.187.1556922331013;
        Fri, 03 May 2019 15:25:31 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:30 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 2/5 v4] add the buffer to the xattr
Date:   Fri,  3 May 2019 15:25:20 -0700
Message-Id: <20190503222523.6294-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

This change adds the buffer passed in to the xattr used for
template entries.

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
2.20.1

