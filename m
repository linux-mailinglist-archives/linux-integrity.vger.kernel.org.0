Return-Path: <linux-integrity+bounces-6478-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033AAE0614
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC6018830AA
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CA23B607;
	Thu, 19 Jun 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjvzaAOZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335F23A9A0;
	Thu, 19 Jun 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336651; cv=none; b=KetCmD8GcLUhG/+hits9Dli0eryp1SaJJ0HRnL/Dj8yP/BxlII/RhVZHhikqA0ktXDjX4k8asTgVslyD6rL4uV2e51n4qdr2Al2hqJCz/8+GHkJZ4T621MG5GkL6BO0VMXEpgFUa6NwsZ63Il+Te7zWlwpg6CCvaZSMNm8bTo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336651; c=relaxed/simple;
	bh=Fgi8mJjGyh6APrurlNo+Oa8NgU2tJtYEJ4GLdVYiq2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITUMCvRDOo5P0HntDYB0MAgnueGOeM4g99/79TdEbWkZrpW6YFfpaHll2LZ2iJxz3CcDQLo79Otp7WI5+phsmob/qNmFOqAI7yBz8Ugq9zf7tYl06EPEf27dqaAZCCwLQ9akEeIDHkYBZArcEKR5XsWq6BrLYJpNaad9FSbQaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjvzaAOZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso6714506d6.3;
        Thu, 19 Jun 2025 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750336648; x=1750941448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRGXw3/8o+QiDbUUcpd1AW+8YFqGLCtytf1OCxsP9Dw=;
        b=QjvzaAOZhLGQGnz5mylciEjUv4lOo/9612qkyvNmhU3q9VhUj+ncRBMuUTIQY3lCs1
         PizKKeT6wzQx1IIfuoHTxmuHWzp3SmTK9Lb73lUUfFLi9D4LtW/hzkwjlN+OZcKt0zNk
         sCN1PGUJhFOqn/1HsazTO0aIUZdFWbyiCgeuB3YgQvy3cukek5yB575UorprSj1LA8Ov
         bjeridvwHVyUaPam8SUk70kVcHodbUnR4yFzPfUas9dRptbiw1eCFgft35s34quGSwGz
         mPmDa9Gpcy7cAsqqDEx9W5BZBM7PxhggqD4qanbF8fWiUr5zTVHYrFUZx6lAU29YcKsv
         d26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750336648; x=1750941448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRGXw3/8o+QiDbUUcpd1AW+8YFqGLCtytf1OCxsP9Dw=;
        b=xJHJAZ6vQrP6aAM/KEaM1ShWzBqTkfVbaEDsWzFUCrOQcf69rVoZVp2KxN+tm/CcjG
         dZUMxeflQUNn0HwSBTbaw1sqcoNJeYQdWGvK2T7ukOv+XZZ22O5tVAbvrioVePo0C7cL
         rrkNtym/BQk+JOUdyCkdD/npL5yC5FhvNp8xL4zn+D8p2ki2QILWtNcIjKaYyC/p2dmF
         PrHIoTjsHS+8Cseem5KdtRBtkR0GPCi10zJKmwBIq5jAwN3VRv6bAmh+piXJY6sN8vAO
         HT2Po4UlhoayOfBxh+LIRrofXcOb7Yt8FpeH/bMVH5BM6FjnhvtZHNfdd2Tccs8XyBPC
         mUiw==
X-Forwarded-Encrypted: i=1; AJvYcCWRe6YaJrnM6xHATTHoYDELswYFgU1o35Fnu4+XveigBkKHeMqm7W5pRCEUIOI5j4HL9MEQK5SaquNXyk2d3QI=@vger.kernel.org, AJvYcCWbXbA/J0VO08m5NS/4mt+AGDrKVgPUQJex4yhio5fs1wKMHocBamAv+y8eN1aQJrc7YEl+wbbNtaPDn06s@vger.kernel.org
X-Gm-Message-State: AOJu0YyRmDTekWuvWb8xwoS5TQpW09UZcjE89Aw48+X+npUfmQ0pfvA5
	DjBFNrdl0VYxqjxusKC7k/h6/g9+HFEX0/ScUEwAjkwnRHdFZ6eqGyOq
X-Gm-Gg: ASbGncv01VgnbrwwABbg/h41XXDe4kVtnIMnRNElN79ZHsaBLAGuMUTs04W1hzYcHvs
	1vng81oXlH04dnSsOm6H9xOtxVjNRz+GgfYSmUWd/RBqJ6S5d2GTgO30tJFdJphGwNbLNa7VugG
	FUKCeCw1Es6DYkfTsigYT7gsJLR1OiSEdVhXyXWJnu3QyukJALUW8jvmKHMb7ZDxfehVkBX/gel
	saBT+avoTvDw9WKU786OfJj6/eVe2XWcZBJoK7eg/c3eBWaum6Jnzm8bGtD27Dvu35PhqsiOqoa
	a+guzMvw0afb35/zPrAr4jpmi2qTuUxyTSMNjRKl50VbiQFpftCieYzaGHuh1vgH/42P64hi34l
	RUFY27vWylo1pyMNhWj1tZVDKhuTL
X-Google-Smtp-Source: AGHT+IFi9UqMBcsVYCpE1jalNzymRRqKAStufhQdYJHMb54CAVzpptBBFyDKP0picQVvV20uBDwxZA==
X-Received: by 2002:a05:6214:f21:b0:6ef:3de:5ff7 with SMTP id 6a1803df08f44-6fb4772a8ecmr337935336d6.15.1750336648278;
        Thu, 19 Jun 2025 05:37:28 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd014e78a9sm6946476d6.10.2025.06.19.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:37:27 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions
Date: Thu, 19 Jun 2025 05:37:07 -0700
Message-ID: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace calls to scnprintf() with sysfs_emit() and sysfs_emit_at() in
sysfs show functions. These helpers are preferred in sysfs callbacks
because they automatically handle buffer sizing (PAGE_SIZE) and
improve safety and readability.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..421c6264bac9 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -52,7 +52,7 @@ static ssize_t tpm_show_ppi_version(struct device *dev,
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", chip->ppi_version);
+	return sysfs_emit(buf, "%s\n", chip->ppi_version);
 }
 
 static ssize_t tpm_show_ppi_request(struct device *dev,
@@ -87,11 +87,11 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		else {
 			req = obj->package.elements[1].integer.value;
 			if (tpm_ppi_req_has_parameter(req))
-				size = scnprintf(buf, PAGE_SIZE,
+				size = sysfs_emit(buf,
 				    "%llu %llu\n", req,
 				    obj->package.elements[2].integer.value);
 			else
-				size = scnprintf(buf, PAGE_SIZE,
+				size = sysfs_emit(buf,
 						"%llu\n", req);
 		}
 	} else if (obj->package.count == 2 &&
@@ -100,7 +100,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		if (obj->package.elements[0].integer.value)
 			size = -EFAULT;
 		else
-			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
+			size = sysfs_emit(buf, "%llu\n",
 				 obj->package.elements[1].integer.value);
 	}
 
@@ -211,9 +211,9 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	}
 
 	if (ret < ARRAY_SIZE(info) - 1)
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
+		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
 	else
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
+		status = sysfs_emit(buf, "%d: %s\n", ret,
 				   info[ARRAY_SIZE(info)-1]);
 	return status;
 }
@@ -255,22 +255,22 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	res = ret_obj[2].integer.value;
 	if (req) {
 		if (res == 0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0: Success");
 		else if (res == 0xFFFFFFF0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0xFFFFFFF0: User Abort");
 		else if (res == 0xFFFFFFF1)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0xFFFFFFF1: BIOS Failure");
 		else if (res >= 1 && res <= 0x00000FFF)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
 					   req, res, "Corresponding TPM error");
 		else
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
 					   req, res, "Error");
 	} else {
-		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
+		status = sysfs_emit(buf, "%llu: %s\n",
 				   req, "No Recent Request");
 	}
 
@@ -314,7 +314,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		}
 
 		if (ret > 0 && ret < ARRAY_SIZE(info))
-			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
+			str += sysfs_emit_at(str, "%d %d: %s\n",
 					 i, ret, info[ret]);
 	}
 
-- 
2.47.1


