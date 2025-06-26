Return-Path: <linux-integrity+bounces-6548-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B3AE9DDA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFB1890435
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3682E11BF;
	Thu, 26 Jun 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA+ikgIN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033F2E11CB;
	Thu, 26 Jun 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942328; cv=none; b=BFWlO2af4jxjZIiS63t4xneq1ZGQK4ZoN2PakwdszKGAMkOyNIV5jOCsn9wobV4Ej3s50BhsOOg8k+Hsmy8bRVcs8FbJF1m/IEolQSHCtw3M2wpI3JaC9t5RH3U0BAB0M/logxj2Q6gRfP6PmuSwSFTxcfZ7qbKxBXCArCAHPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942328; c=relaxed/simple;
	bh=N3OpRUXDOUsw+2WC97BYicjtPe+MeGNQQFH1TS46I3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HojBMTyiSXVKKdUL6oHgYI2xjvPWKuhV3seCL9TT2KXhn0YyQJdkORn2mt5vpWSyY+kFpZvQtq1TaNVOmyX4mUu8S08p4k4ihQyNammX9e+XiMM/iHTzomcFRKNBgNsSNXCQpbt+W1A56V/aXOIBp3UTKsw3FjliKHHsX4b6kNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA+ikgIN; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso10163776d6.1;
        Thu, 26 Jun 2025 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750942326; x=1751547126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DaYvqqmqRnmD2gNBRrpwiHOM8KMu1vX8S3G0AqJmGoA=;
        b=EA+ikgINFPL1XMW6oc1Vm/3maZEExLiPbVYgRo4VOlOo5ciFxwfjVQSFyZYPJI31gB
         7FeD15skj6lKeabHs7Mi2srmbLlNUpO+UfZXH8xtWmlYfdjujMlgdV28JC9ZhGql5wV7
         2H5WjeDjHITbJe3umXKZXehARO8nHbynsic7c+RPHBWHBmbpCftXsOajFQiJWsyr5v8R
         2fMSars4dxXwqxXz/2OVpJKb8UMmBJKaO0iOlExuFnjSUr6KteE2xeJHGCDxkjYBTc9C
         cs+EZV5jhkRoStB5qrGtdwIDQ4An161AqOdIM15olWyywUErRVPv1XvPc0q1uvyCUB4N
         qf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942326; x=1751547126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaYvqqmqRnmD2gNBRrpwiHOM8KMu1vX8S3G0AqJmGoA=;
        b=mPFGjmU19UVf3Yv2IqmEEYLh8cFwodX9XQbdTv1Ukorn00Qafh83aY2xXms7Zr08T3
         KGs8dbdp8lUJGh9JBezi41pl84/YnWq9aB/9U3Nk4RQP1rs4Lzjnf0dyMKKS8dbBrLdD
         cf4aNfNsPyk2QiqBoheyJzDiUMo55fT9YX7Fmfde92XR+7bDRVB3p3mv3QgpAfo5R5Vz
         iKWWs1JU5jplDClCTFyJVXC6rerqsbzzWQpNAPw2EFLhkIsP11PKIP0aDpje+JVuYZKA
         S0mp/zWm+NpHQmsHwnamfQNw1c5b/Y/NBBtPFYdvgVKUlyUU4oMrHgSK+OeVyVGXWl0d
         e+xw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsbJ3FCxX9gKjdlu+TsZ12NT7q1GxRHWmEkuFTjoe7lBT4gFZxayUyO4o5C9rv9Vz9t7Ne94f70OAgoxN@vger.kernel.org, AJvYcCVK8jPQv77EctiXGfmh3/Mea3L4ipwkSGg3dGOLD0kc1ltpQhPwSupWn88yKD1f0n+gJCeJBlk8pw8cImSXCXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8WETNbdVqkRoJYoaJUDF0VEAx/7IJEapsiGCvQjyTXnoFb9t
	arQJwo+Lg3oqfqr2/V7wT93U2D9K48grc/UQ7C7HAb3kLoM8wOS7/KZP
X-Gm-Gg: ASbGncu0IZOHewzoMW9+8RIUJfPQgp39k0vwvKQIFMh3qrMGRHO6gqznUjHvvsEylls
	aSWapSS3i/ibujJ8QyR0GMUKyhMdOKZlrE2ZK+p4ksOOV5kTGbdaQMj3K3b1Nk7EtLKdVtVwqgn
	WtjSWix9I9gxCEESAXv40rBRtCXJj64tpyjGv/3UH4gFfzb7jxmPqdVuuWIl3xFuLFfjP0cv3ng
	Emo9ue67kWV9S4K6Hl6UVCcpD/y6Jx6vpdD9f4Kuw7IVelTXq9Rnz2RqqKgA5GF1fn0UeVPT1Iv
	jjsgBrTE250n9Fr2aEEa8OvpDNVlro8ZTC0wK71oVqaKsGqkMHNQ8XU0YHhMEzqJR3GsbcvQ79V
	rbE3f3YKRLFS5POZTAS+Ta9vrjZcN
X-Google-Smtp-Source: AGHT+IE8wIMHyCHzXXx7JimoDZhKcCp5I62DNf0YSpxQEBZQy0sGfmyY9hlAPLSfq+wTyBRjcaCiRg==
X-Received: by 2002:a05:6214:5249:b0:6fa:cd5e:f4 with SMTP id 6a1803df08f44-6fd7535ee88mr60280356d6.6.1750942325635;
        Thu, 26 Jun 2025 05:52:05 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730aaf8sm6851256d6.109.2025.06.26.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 05:52:05 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v5] tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions
Date: Thu, 26 Jun 2025 05:51:30 -0700
Message-ID: <20250626125130.28553-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formating the value to be
returned to user space. So replace scnprintf() with sysfs_emit().

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v5 : 
- Fix alignment and coding style problems

 drivers/char/tpm/tpm_ppi.c | 52 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..d53fce1c9d6f 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -52,7 +52,7 @@ static ssize_t tpm_show_ppi_version(struct device *dev,
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", chip->ppi_version);
+	return sysfs_emit(buf, "%s\n", chip->ppi_version);
 }
 
 static ssize_t tpm_show_ppi_request(struct device *dev,
@@ -87,12 +87,10 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		else {
 			req = obj->package.elements[1].integer.value;
 			if (tpm_ppi_req_has_parameter(req))
-				size = scnprintf(buf, PAGE_SIZE,
-				    "%llu %llu\n", req,
-				    obj->package.elements[2].integer.value);
+				size = sysfs_emit(buf, "%llu %llu\n", req,
+						  obj->package.elements[2].integer.value);
 			else
-				size = scnprintf(buf, PAGE_SIZE,
-						"%llu\n", req);
+				size = sysfs_emit(buf, "%llu\n", req);
 		}
 	} else if (obj->package.count == 2 &&
 	    obj->package.elements[0].type == ACPI_TYPE_INTEGER &&
@@ -100,8 +98,8 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		if (obj->package.elements[0].integer.value)
 			size = -EFAULT;
 		else
-			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
-				 obj->package.elements[1].integer.value);
+			size = sysfs_emit(buf, "%llu\n",
+					  obj->package.elements[1].integer.value);
 	}
 
 	ACPI_FREE(obj);
@@ -211,10 +209,10 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	}
 
 	if (ret < ARRAY_SIZE(info) - 1)
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
+		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
 	else
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
-				   info[ARRAY_SIZE(info)-1]);
+		status = sysfs_emit(buf, "%d: %s\n", ret,
+				    info[ARRAY_SIZE(info) - 1]);
 	return status;
 }
 
@@ -255,23 +253,23 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	res = ret_obj[2].integer.value;
 	if (req) {
 		if (res == 0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
-					   "0: Success");
+			status = sysfs_emit(buf, "%llu %s\n", req,
+					    "0: Success");
 		else if (res == 0xFFFFFFF0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
-					   "0xFFFFFFF0: User Abort");
+			status = sysfs_emit(buf, "%llu %s\n", req,
+					    "0xFFFFFFF0: User Abort");
 		else if (res == 0xFFFFFFF1)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
-					   "0xFFFFFFF1: BIOS Failure");
+			status = sysfs_emit(buf, "%llu %s\n", req,
+					    "0xFFFFFFF1: BIOS Failure");
 		else if (res >= 1 && res <= 0x00000FFF)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
-					   req, res, "Corresponding TPM error");
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
+					    req, res, "Corresponding TPM error");
 		else
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
-					   req, res, "Error");
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
+					    req, res, "Error");
 	} else {
-		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
-				   req, "No Recent Request");
+		status = sysfs_emit(buf, "%llu: %s\n",
+				    req, "No Recent Request");
 	}
 
 cleanup:
@@ -284,7 +282,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 {
 	int i;
 	u32 ret;
-	char *str = buf;
+	int len = 0;
 	union acpi_object *obj, tmp;
 	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
 
@@ -314,11 +312,11 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		}
 
 		if (ret > 0 && ret < ARRAY_SIZE(info))
-			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
-					 i, ret, info[ret]);
+			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
+					     i, ret, info[ret]);
 	}
 
-	return str - buf;
+	return len;
 }
 
 static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
-- 
2.47.1


