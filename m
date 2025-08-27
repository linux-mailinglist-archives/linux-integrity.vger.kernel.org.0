Return-Path: <linux-integrity+bounces-6930-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D5B377A9
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D95C5E8065
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B227707;
	Wed, 27 Aug 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOCQEyp/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815E272E41
	for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261301; cv=none; b=XXTNsalpF4Y0lA0U2b85vYiwxaNANjf1cWsGCPf5KqUtiGN6PGlruzekIaFEHSFSI3PdtHbbq6H+TSkDVU+oWCfELM5bVOTIKM+5xUlrgcX6/A12yD/bY1JxmYnDrJo2MnvYyah/vdU0/gN5cBldQbVyEPXPQ3Atv9bSXbRXdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261301; c=relaxed/simple;
	bh=JcL4rZy62TmJlN6hVyF9BvVAd+fcH2tjIayI1a+afD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RivM0VVpUJV6ArAvnzyw3wUIT+BwUaaG1QqdCH6xM2HjcP82jwqq1OMECbPBbxnHiG/2GQdrFyYuDvnamz38+E1cP6zH8aAhwIBJc7i/BmlhpmrYoVidPM5FgHS7vAl22Y9o7bQ1KVnJ6HvtjBYzX3b5QV7sDEXpaOLGZ6JeEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOCQEyp/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756261298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ly8Yz31yyzlq4KfYk+o3xCB/D2ZL9wZ+s6+4OCcY0V8=;
	b=DOCQEyp/MAnhXSx9JaLoVqMGe9MAZD3XF3wLJJ4xAAU7HfNQt71GRGfkbhmR+QYfv3XNVO
	C0g8fPwKUpqJg2hWoG1IVUsY/c4aUi0hx+KFNzP+AABex1VFmJqX5cZwtyu7N4X6Q7t+Gn
	i1Y83sCsVr8Fnn6ObJwMsJyqKlpcGPs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Ccl8PDKQP2qZvzmEyHPj7g-1; Tue, 26 Aug 2025 22:21:35 -0400
X-MC-Unique: Ccl8PDKQP2qZvzmEyHPj7g-1
X-Mimecast-MFC-AGG-ID: Ccl8PDKQP2qZvzmEyHPj7g_1756261294
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b29a0b8a6aso150727331cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 Aug 2025 19:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261294; x=1756866094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly8Yz31yyzlq4KfYk+o3xCB/D2ZL9wZ+s6+4OCcY0V8=;
        b=VkXKqdi5WLkUPJlrb642bOwOMqnqcJryomiWlvZSCO0XGJatMikQ3ecKk4+RtKgQ31
         XC5N4qyeRKAIFqey8napJSCovgUy/8b01IVPVJP6Iik42gUUqtiMdbxGrksJfLVJxzfb
         G+UrQRKFkEqDqhQYuFd0oTH8S5jTzsncSlusNvb2hK0mrfKUMMznfTpw/6Xa+AH2L9ha
         +dcx8xKbCCihIRCbZ7vwoyzsgzlR6Y7zGm2kr8iRHDb7/o1w2rOJoGW/7t+pgzE1h9he
         DR30VKiauTxJB8VsJEDBHRIXO5mzSdbxBTyativcMjrD4u7J8lvTe+A6cziTmt0aMFrh
         5xgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgcXZPxpZNZL9fdPH8nn4adfM7UGEG6dWYVPzltButCp0vq4tjVuVbGwjqZhBAQ5Q2P/hzBw8KlHUPUDlb+HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWuiCO0W57LYwVfEGZFLAatiiefmMQQEmzvlioRhzmt7fg5Ij
	9RpUCfyaSO81fg3oMeOs3o2Nd5cUKzBeTjLmAQGg2JB+GPyk/O6a02m5yXvQpuGAEY0sMKE5DRk
	5DQiVd7Yu+EvYQVamXTL7TDqcspknQJMjbJEa8dLRem0eM7WQXwQJdw+kTPPbqjvY/96IaW7+OV
	V1Hw==
X-Gm-Gg: ASbGncuNcu2j2yabDvMi0i5OAFr304kiPRXRi/byHUqRViZ/qVVnQiTMcaNkDfS56CT
	XQnlueXgXV/Ts4H8sVcXDy5iiGr0jORogpmtolNrIs71G6CoKtajJFH21eR/1o+YZ9+RhU1PRER
	ETzODXNYmSIveA4kFuBMzJi7QELr+PLPJ55Y85qysqbHozMYEIJVdNyf4/1hpKci9N/J9zY/ST6
	0EA7TfJOVVoJElmMaYvY/90B1KrDba5Z1CAIPieTZrIDpycXFgQdhuaNcDFSbEaVUYn71iV8KFK
	hD+Vnq+RU/+EbAd2LwR67D64txSah8kHDsdRk7F5//Wk4KB/TvaysbRdhR58N+WEC+lPEt8+xpX
	ZvGI6U6N+VuSXXW/TSZldAM6W0Xa47Q==
X-Received: by 2002:a05:622a:a07:b0:4b2:8ac4:ef51 with SMTP id d75a77b69052e-4b2aab3ff68mr254568791cf.72.1756261294394;
        Tue, 26 Aug 2025 19:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1ovSXSgoQ7bOKUmkzJnSu05QFOb8guz7G+LDnBGeHJFp7Z14ivGVu8fxuqa66rpyDp3i9Q==
X-Received: by 2002:a05:622a:a07:b0:4b2:8ac4:ef51 with SMTP id d75a77b69052e-4b2aab3ff68mr254568631cf.72.1756261294038;
        Tue, 26 Aug 2025 19:21:34 -0700 (PDT)
Received: from daleksan-thinkpadp1gen3.boston.csb (ip-185-104-139-73.ptr.icomera.net. [185.104.139.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e1eb30sm83874781cf.40.2025.08.26.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:21:33 -0700 (PDT)
From: Denis Aleksandrov <daleksan@redhat.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Denis Aleksandrov <daleksan@redhat.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Date: Tue, 26 Aug 2025 22:21:02 -0400
Message-ID: <20250827022102.17731-1-daleksan@redhat.com>
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
---

Changes in v2:
 - Replaced file permission change with a caching mechanism as
   suggested by Jarkko.

 drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index d53fce1c9d6f..e0212893748e 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
 	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
 		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
 
+static const char * const tpm_ppi_info[] = {
+	"Not implemented",
+	"BIOS only",
+	"Blocked for OS by BIOS",
+	"User required",
+	"User not required",
+};
+
+/* A spinlock to protect access to the cache from concurrent reads */
+static DEFINE_SPINLOCK(tpm_ppi_lock);
+
+static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
+
+static bool ppi_cache_populated;
+
 static bool tpm_ppi_req_has_parameter(u64 req)
 {
 	return req == 23;
@@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	return status;
 }
 
-static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
-				   u32 end)
+static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
 {
 	int i;
 	u32 ret;
@@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
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
@@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
+	int i;
+	ssize_t len = 0;
+	u32 ret;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
-				   PPI_TPM_REQ_MAX);
+	spin_lock(&tpm_ppi_lock);
+	if (!ppi_cache_populated) {
+		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
+
+		if (len < 0)
+			return len;
+
+		ppi_cache_populated = true;
+	}
+
+	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
+		ret = ppi_operations_cache[i];
+		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
+			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
+							i, ret, tpm_ppi_info[ret]);
+	}
+	spin_unlock(&tpm_ppi_lock);
+
+	return len;
 }
 
 static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
+	int i;
+	ssize_t len = 0;
+	u32 ret;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
-				   PPI_VS_REQ_END);
+	spin_lock(&tpm_ppi_lock);
+	if (!ppi_cache_populated) {
+		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
+
+		if (len < 0)
+			return len;
+
+		ppi_cache_populated = true;
+	}
+
+	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
+		ret = ppi_operations_cache[i];
+		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
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


