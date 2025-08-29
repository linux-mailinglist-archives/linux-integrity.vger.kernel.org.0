Return-Path: <linux-integrity+bounces-6949-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48271B3C214
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Aug 2025 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04321586117
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Aug 2025 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177F335BB1;
	Fri, 29 Aug 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9MSJNvF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D340D9B
	for <linux-integrity@vger.kernel.org>; Fri, 29 Aug 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489961; cv=none; b=B/Pf35xWpaPNOwixRRbT7u/mAO2gizEJ8wB/RQn5f9D+tCsf8FSmpmGXVDvyiypNit1/uXiROFYtiXJJeBy596W9tk622Odv5w0DoYc+n/7lpkWpfcNQFi9rei6oEo+IQR/WAdx0j3mbVjEiWF/H9z4udYyQFpV+3onG9398KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489961; c=relaxed/simple;
	bh=67BiwGDF2QshU4Cqu4P3f9Cn9P9ApYmC7Xwv0YVdjjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3MAZ1BfNbWTezMJCikKaNDCzqKnERU17Q/M8yQDhxfQGVTP49Uyq3ySz6hMmVmIBGkEPHQwv4UD6KhbWN5xT44PFLY7lBsFkZIIZwNUSuFtvPwoUAH1o0tiK3D8Ha8cySRovw66Lsm+ZFgkmjRJbNSWv/He/nGGwDBciXUJ2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9MSJNvF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756489956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ey9cpKGoTIW3egBjfZcs4xRk6vKxtTKk6VcxXuz3jEc=;
	b=L9MSJNvFJKVV4wOgAvxMw9o2YYRoyS97U33sx8BxLyi6C+Q/39EEWxgWUGxE9ebOSJE53p
	36EbYo4ygWthA0DYJAf+2NFS+hq9qDUJ6RZlRtKFGCia1GacCSLlN19835d6GArBbJkpf4
	vnV4IObFQC+uvdFAARLSYdphnRhyhag=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-ovU2A5F2P-SnFjp_gzjSbA-1; Fri, 29 Aug 2025 13:52:34 -0400
X-MC-Unique: ovU2A5F2P-SnFjp_gzjSbA-1
X-Mimecast-MFC-AGG-ID: ovU2A5F2P-SnFjp_gzjSbA_1756489954
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e8704c5867so787341985a.1
        for <linux-integrity@vger.kernel.org>; Fri, 29 Aug 2025 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489954; x=1757094754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey9cpKGoTIW3egBjfZcs4xRk6vKxtTKk6VcxXuz3jEc=;
        b=MUZ160MJvrQp0E4J0Hp9tTSodnJ3rQbQzJdA3ey1tVhI/KxrmmuCel0hFbLCi25k2n
         PLkqQfBjgUAOiyg9IQF9EA9PIRAfGL82cQCkpgaeB1xpezOorZY6bmI9STDSeZyMAKpO
         Av9wW5p61Bwz16bVP/yQlVQI+RevpHhtJ8X1tSm9OplLDDY4+TUN9YS3fo+2YPGpoo7A
         +o25PFTGCF2S2nDx29+AOKE/2FVQ/4/e55N2aIxv9RB+9jP635NoA64Xz+OFHmaWu5kA
         AI75IxrG/H6s2zp/VaXXgQ9K9JwHLSjZgk83XnfWIACLyDBk/xwpwM6pW0f2aE2pUaAB
         tJeA==
X-Forwarded-Encrypted: i=1; AJvYcCXnpJ+DuXXzeeRd0sqxN3DkyyN3vXJBhQdRwJX9NQKXf4FYB6+q23Bgwm/0rTGJnDmhn5u2vlXLnVWuBpMnqnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/v5HH/hb6TSj/9aib0IENg/LxaeeBa/H8Z/h8O55bOgzZg+w
	JDXQtSMCVr9vWx5y5jmQxhLAqCW7Hsft+6IOiT9V0rKsLMI6v85VDItZc+LBG4JXfiA64ebwT0g
	5DVeVLKrO+kaf0uVNVoQz0IZGvcOyQuR7R4Nf1F45tAwyINCq5znBXsorcvrPXXrYiWyhmw==
X-Gm-Gg: ASbGncvM+5iGWVfBavR6yPHrnRucPb5Z6bm8k3VNnfjteLTvTPLgbcMk9wWZ1KXSI+g
	jnT6EaijVoF1G0dFxNqoo36lgTPQusKhoeYEBK0UGjKyBhB25hd+vgQLj3IFurreDGumZHxOjrc
	G4n/Ca3h2njaW9QgkWECkkz01Sj3XWkrJeqTQjVxLbAS3YojseA/Hxp1xaTJRAphGyl8oQsvQ87
	8QBVX+1WycEsXatRYjRRueRwOcpWPHE/MnkzIyMYiSjzZamRajotw27Oj91AGJX/7uG9oO3rExk
	f60fyJXLM1wWsg/hMqkGZxhMZqE4sSY5zqBaYiKsskuF8EtvtFppdko1TpoBBPQtQUYQSa/uOWx
	PDttewJbu3NTR6J56wV4ZQUj9D3JT6U87BI5MzYwuR+9cCDNJgRcI8apDYRrBhiBm47164w3s5i
	g=
X-Received: by 2002:a05:620a:2953:b0:7f7:e6de:3709 with SMTP id af79cd13be357-7f7e6de39c0mr1211905885a.32.1756489954246;
        Fri, 29 Aug 2025 10:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Ym/WQxhbPtyU3s+3io8JIhGJEAnrd+ViRQ3EDhQvcAEwhubikpbzkxidOztKivWcOMBWqw==
X-Received: by 2002:a05:620a:2953:b0:7f7:e6de:3709 with SMTP id af79cd13be357-7f7e6de39c0mr1211902085a.32.1756489953713;
        Fri, 29 Aug 2025 10:52:33 -0700 (PDT)
Received: from daleksan-thinkpadp1gen3.boston.csb (146-115-41-251.s4857.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com. [146.115.41.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6715desm20258101cf.24.2025.08.29.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 10:52:33 -0700 (PDT)
From: Denis Aleksandrov <daleksan@redhat.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Denis Aleksandrov <daleksan@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Date: Fri, 29 Aug 2025 13:51:53 -0400
Message-ID: <20250829175152.9704-2-daleksan@redhat.com>
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

Changes in v3:
	- Generalizes ppi info to all architectures.
	- Adds reporting of "Not implemented" in ppi operations range.

 drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index d53fce1c9d6f..a59b6da69bf6 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
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
+		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
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


