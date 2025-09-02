Return-Path: <linux-integrity+bounces-6967-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4AB406A0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257163ADBEE
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6892E03EB;
	Tue,  2 Sep 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PApwUa/O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D92DF6F4
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823114; cv=none; b=Y1mxiGEagxUIE2xTuSE5wIMCNTTiYdqab17u+vveXm2B5GUSlNOsmxezJy6vwYg0bQKWjbctN1adOKQrKeLiufCAF2BTfud0WNHI3IXXIDZCYP+UoO+iiqeNNWXiYrrBM6SZFrCaHlUsBJ79THz27OF92071jmqrmbMTH96gwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823114; c=relaxed/simple;
	bh=D7HXpEU730OXpS/WZEfuIxfFn2o/NeLsQ0na54tZwHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkRcl87DZZsQAJHc85BcIT/98s+XhWG7XoyP8HV2C+SfILkCaVl23fYRbMFEg2WHr2VpPOfaLPP+P8PP2T+iPpldjJsiVIubkdC9CWNl6pNxsZJ11Vz+TfsgNV/xCfStpA6RmwAUg4v6isMIUeHn8naJRTiIp5UoeqxgoKffEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PApwUa/O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756823109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KCwmIuBVumzS/zqE7SJcaJXWGkBsvZeBHhi+FBAFQDU=;
	b=PApwUa/OPwCLXzNQ9CRXqFNHVvLQxZub/OWWhsdscIQPv5CQhcVBxPDw6h4F5jB6O9wiRh
	w3JGmBHNqA5E76EYBmRXChrxZ9OvEna5G69jKg3ZlHDezUhwDWjiowqtQi98eJjtkVqmKc
	BdtX2k9KV6vCktyeLEkgxH8bU1xRnQc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-MNAvf_5eP5GrlpF-q11hQA-1; Tue, 02 Sep 2025 10:25:06 -0400
X-MC-Unique: MNAvf_5eP5GrlpF-q11hQA-1
X-Mimecast-MFC-AGG-ID: MNAvf_5eP5GrlpF-q11hQA_1756823106
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2f78511e6so33281571cf.1
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823106; x=1757427906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCwmIuBVumzS/zqE7SJcaJXWGkBsvZeBHhi+FBAFQDU=;
        b=mF64dCsaW9YgNRqnU13NEUESYmFjFdCjrsZpop6CTCSPnLmov0BU6PEYDGEiqgfLye
         FG+HoNj/Nv8AIiXtjQJsJxbip6Dh1rm2KchwCAAfgYG1pvkWSYNbKlLS9d2+NapDIuoI
         dW8wMZF1j0nhsFJLJJUGJf8xhil9J4sp5db6NVdYt8Uys/v+0hBybISurWM627VNA8qk
         lBWaFM8J7nYEiYufZaXep9nWqe73bmxJcvTy5kN4nDu/FF2a3aoktbD4tjvNZ8ay5Bl5
         IYVznkO7f2+KW0RNhdni2+0oHrmDXB8MIDIKWKNjleYeExkhWy+eAXhG383GByDaaZFg
         kR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnzcPmI/c8vlqJHRCPyQIfmLFv+p/QFQHaNxoaWpXpKx5zpZVQqQL6dQ9OeOmpqzq7ue9vEXDXiDB4zzHnDlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjw/ApeqA6fYfkxYMFj3V0djkFcLzyex8ErQlDOHZcm3HPECMU
	u9Jl6bIXIjDB3Yszpl8wNji+UIMY7w5K8G6gyeJY1W8y+/D7zeTONriotsuuBGezShaoEXMVGQk
	PHvB80Zdo7cgvWTp9EPI/Tqw2Old/D7vzC6zl06sPVRvULzG2h/1tiwXDyw1CQP1p58l5vA==
X-Gm-Gg: ASbGncs7PPxrBVp2KrFd1BbMkhIRB7fpZ+mLhnaXw5QNLdHCTm9WCo12a0S3QOhqzKr
	KxZZCMQh92ZbDaQgLBptDmV8EMGSNVx2/9LHtskmepIAUsrb1WmlSH7a00qLjPUT8qHumO/De92
	Rv8nZ4uWXsxo3QUBTBIRXUwiekWgGvIl0g+3xK4/KcW5pBnegCGd6+GtD6/EaLFDTfuDdaG4zRP
	pW4k7GQINuAMUJrE7BWtwv4oB7liHMxGQB+sOrj5nZfc+NU06yAnh6BH7u0kVQsfFI1zUymJi5D
	DKZJXw/fejsl+2YkhXW9pFLalW8tlLOvSgLSCMMxTx124gHOgiKX9fhOSjXnik9KThkAhrhz
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr20121141cf.81.1756823105914;
        Tue, 02 Sep 2025 07:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBOvL4H6uwqZjEpalH9gAPguD3oZEVC672bSw1eO4PQCyQQlfXbcUKzK3Evm18/66GGuTWQ==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr20120641cf.81.1756823105329;
        Tue, 02 Sep 2025 07:25:05 -0700 (PDT)
Received: from daleksan-thinkpadp1gen3.boston.csb ([2601:189:8480:3170:a791:5837:3694:7627])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3461c8414sm12921361cf.17.2025.09.02.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:25:05 -0700 (PDT)
From: Denis Aleksandrov <daleksan@redhat.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Denis Aleksandrov <daleksan@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Date: Tue,  2 Sep 2025 10:24:30 -0400
Message-ID: <20250902142429.14041-2-daleksan@redhat.com>
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
---

Changes in v4:
	- Removes empty lines.
	- Reorders vars to reverse christmas tree.

 drivers/char/tpm/tpm_ppi.c | 85 +++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index d53fce1c9d6f..df34b215440d 100644
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
@@ -324,9 +325,28 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
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
+		if (len < 0)
+			return len;
 
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
@@ -334,9 +354,28 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
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
+		if (len < 0)
+			return len;
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


