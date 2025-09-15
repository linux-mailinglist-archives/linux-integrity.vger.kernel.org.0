Return-Path: <linux-integrity+bounces-7094-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC13B58664
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16620200E6D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE429D27A;
	Mon, 15 Sep 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LweX9b4j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A6296BDA
	for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970566; cv=none; b=SMAS+gkTrtBDV7trNonLE7AYiD4N4IShVtgM11fzTjHv8laB1L5RYjwzY6sBINz2pA8uXCFv+k6OF0HFMBSqkpJoWeQbbFlA/p9lgrNZMrwmtgpBkOERdl9ds4KuobaFrb25lwy9AQNfMU71I7vlUx6LOiqHtThYER/SMK1Iaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970566; c=relaxed/simple;
	bh=1o5oLD1nW2vYvHdWxWzWqxYYU9xIfpJMUayT6KWEx6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8h06TCIgjv1nG9wvrautOD5gcBYX9zAxClnMiJSyo04lTwpGfAkxiyFjCQ4SyspRcq8jkflqrwxnoqQA5PHruT3jilQXLHUMU8/VvbRdLXBAlCPwapD2w/+m2SFuKjblzqSY8tfxhScuon5tFamgC9XbiwTO+L9yU8sE55Cbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LweX9b4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757970564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gRk+Dhyz/Rt8bBdgPWcmQtXkg10Hky7dCZIsexEx9dA=;
	b=LweX9b4j+19Lra6uvq9o6Lz8XljZzgcqb769/ohrXtZwhw+PLziNtuqwJbd7Qz0PsZdrXY
	S9cLfmYnJVCB+wDt2KkvavPlEGPZzUlQLdSws0eXLMXm5wEn04nb9edSla+CQQX8ZGiiBk
	Agh8kZxKG56Qpsbp7k8Bj5nL49Qwf60=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-KhyuQFqSOoaiWefwJDpKyA-1; Mon, 15 Sep 2025 17:09:17 -0400
X-MC-Unique: KhyuQFqSOoaiWefwJDpKyA-1
X-Mimecast-MFC-AGG-ID: KhyuQFqSOoaiWefwJDpKyA_1757970556
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so134849061cf.2
        for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 14:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757970556; x=1758575356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRk+Dhyz/Rt8bBdgPWcmQtXkg10Hky7dCZIsexEx9dA=;
        b=kfvXnTeAobrxQOy7bLDy49qrqjVqlum3v0azAnqr3nVbWWhlvpchlgq/VXBcLi/GT5
         6QQHxSfplKMchIfmGoQ6qiSL6Ktb8lVt91uMW5n0AL2ib+mBrSif5xdWXJlFOMC4+KQv
         0uVvnY71UPYkZgrEtkCLjktsOUY8IW2dpNI2Mr2q1dI/lAsTnZ0+4ttwFP5Nnx7hYh0I
         9T+Poh4wfp2x2XtZ/u5Wx0bclNyvJ7YBcZe4PcyG+XClyFvzRsap6VyUwVESWH2lcFDu
         NskNIUU4CLCGUtWXKQqxx00gmfZf6oZ75+18/Dq3oJskTrikr3LIafKbgeu27ndlVqjR
         opRw==
X-Forwarded-Encrypted: i=1; AJvYcCXHwH07RDhFs8Ei0PyeWUAE+DS0ssZvocGgfmD4XQK6M1HlrkZD9Co6hsnqiqhimmFdA40PyAhgVSTkF25UDxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyZbpI2U0kztpY+elLTZEwlcbLoueVaS87PbCxjFjQM/6zVWP
	m6GkcgwWuQT4KtOTtm4I5G0q8ua+JJGBkAPRZfvGgX6I72VDfp8Fj0pxfuGQ3NVuVOB2xwcU/gW
	diQYPabJrxeKKPonsRN9WqsOWGv8NPfOkBXut7mwpvgKr28MUvHi1uaPLFjjRk0h5NaUIxg==
X-Gm-Gg: ASbGncuDPOlmXsl1tffE5DDMmH5c8Oc3hq7HF+H5yZY80KOxWrHjJW6WngzTi2mFJoO
	WjNVKRL1iGT9GNxbVgsYUtO3KCtkVm9XA4Gq2ZivSHND8kPzJEn09XCW0lhRPPP739OxAqNw0z+
	yFa5KtxoO/olzId7gLoDQNhqJbUe+thzbtZUCcSitaB3zDX4WA4bhotIX3s5zQQksqeEustl7Sq
	sEf9tXPwbJL4YCXqbrXbO1k6sF7LAqkbFHi6FdTuYpO2GHRtsS0bacPAgFnzCG/9XRsRq1/bcrW
	iL60/4ZpFGPY0xYX1PUHMw8XLjtyT/7bUl6fZfQ9CVR1rp/yCm9RN+6+t8r66IaF36A=
X-Received: by 2002:a05:622a:199c:b0:4b7:b15c:b862 with SMTP id d75a77b69052e-4b7b15cb89cmr12367061cf.37.1757970556275;
        Mon, 15 Sep 2025 14:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpcknWUC49INxfvxBYAjx4+nObGIQTE8kvf5fRIUU5z5K6B1y7zajgOuX9rPRt6IhIRSIQLg==
X-Received: by 2002:a05:622a:199c:b0:4b7:b15c:b862 with SMTP id d75a77b69052e-4b7b15cb89cmr12366581cf.37.1757970555708;
        Mon, 15 Sep 2025 14:09:15 -0700 (PDT)
Received: from daleksan-thinkpadp1gen3.boston.csb ([205.220.129.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab685sm74158621cf.26.2025.09.15.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:09:15 -0700 (PDT)
From: Denis Aleksandrov <daleksan@redhat.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Denis Aleksandrov <daleksan@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v5] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Date: Mon, 15 Sep 2025 17:08:29 -0400
Message-ID: <20250915210829.6661-1-daleksan@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reads on tpm/tpm0/ppi/*operations can become very long on
misconfigured systems. Reading the TPM is a blocking operation,
thus a user could effectively trigger a DOS.

Resolve this by caching the results and avoiding the blocking
operations after the first read.

Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---

Changes in v5:
	- Unlocks the tpm_ppi_lock if cache_ppi_operations() returns and
	  error.

 drivers/char/tpm/tpm_ppi.c | 89 ++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index d53fce1c9d6f..47655407fea5 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =
 	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
 		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
 
+static const char * const tpm_ppi_info[] = {
+	"Not implemented",
+	"BIOS only",
+	"Blocked for OS by system firmware",
+	"User required",
+	"User not required",
+};
+
+/* A spinlock to protect access to the cache from concurrent reads */
+static DEFINE_SPINLOCK(tpm_ppi_lock);
+
+static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
+static bool ppi_cache_populated;
+
 static bool tpm_ppi_req_has_parameter(u64 req)
 {
 	return req == 23;
@@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	return status;
 }
 
-static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
-				   u32 end)
+static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
 {
 	int i;
 	u32 ret;
@@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 	union acpi_object *obj, tmp;
 	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
 
-	static char *info[] = {
-		"Not implemented",
-		"BIOS only",
-		"Blocked for OS by BIOS",
-		"User required",
-		"User not required",
-	};
-
 	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
 			    1 << TPM_PPI_FN_GETOPR))
 		return -EPERM;
 
 	tmp.integer.type = ACPI_TYPE_INTEGER;
-	for (i = start; i <= end; i++) {
+	for (i = 0; i <= PPI_VS_REQ_END; i++) {
 		tmp.integer.value = i;
 		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
 				   ACPI_TYPE_INTEGER, &argv,
 				   TPM_PPI_REVISION_ID_1);
-		if (!obj) {
+		if (!obj)
 			return -ENOMEM;
-		} else {
-			ret = obj->integer.value;
-			ACPI_FREE(obj);
-		}
 
-		if (ret > 0 && ret < ARRAY_SIZE(info))
-			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
-					     i, ret, info[ret]);
+		ret = obj->integer.value;
+		ppi_operations_cache[i] = ret;
+		ACPI_FREE(obj);
 	}
 
 	return len;
@@ -324,9 +325,30 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
 					   char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t len = 0;
+	u32 ret;
+	int i;
+
+	spin_lock(&tpm_ppi_lock);
+	if (!ppi_cache_populated) {
+		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
+		if (len < 0) {
+			spin_unlock(&tpm_ppi_lock);
+			return len;
+		}
 
-	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
-				   PPI_TPM_REQ_MAX);
+		ppi_cache_populated = true;
+	}
+
+	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
+		ret = ppi_operations_cache[i];
+		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
+			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
+							i, ret, tpm_ppi_info[ret]);
+	}
+	spin_unlock(&tpm_ppi_lock);
+
+	return len;
 }
 
 static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
@@ -334,9 +356,30 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
 					  char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t len = 0;
+	u32 ret;
+	int i;
 
-	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
-				   PPI_VS_REQ_END);
+	spin_lock(&tpm_ppi_lock);
+	if (!ppi_cache_populated) {
+		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
+		if (len < 0) {
+			spin_unlock(&tpm_ppi_lock);
+			return len;
+		}
+
+		ppi_cache_populated = true;
+	}
+
+	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
+		ret = ppi_operations_cache[i];
+		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
+			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
+							i, ret, tpm_ppi_info[ret]);
+	}
+	spin_unlock(&tpm_ppi_lock);
+
+	return len;
 }
 
 static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
-- 
2.48.1


