Return-Path: <linux-integrity+bounces-6509-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E13AE7649
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3D1189126B
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B7156228;
	Wed, 25 Jun 2025 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St5kISov"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419F3074BC;
	Wed, 25 Jun 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827845; cv=none; b=FxmV57832W4FW5Fs6bF7pHqEuk6tL/0NSh1qEW7pmtg9JdZKjUFK/sb0NJ8qmEZbUJNGgxFSA4Ei7dgI0VvtPWMiycnpANKo1w2tf63q0ZqRVsjTc5kW6pCWlx5zJXDDVO0j62FyqcCQZn79uFIW+TgScTxtYVdmAelx/lt7IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827845; c=relaxed/simple;
	bh=y5MCvutvHcvNX4Keb63b3B7N/mP9uFUORXHB07+l9GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sByZT/n1Oyl9z5LL7pYSHXgxUlxjPQiuvAgcFN3Fh0XVd6c1T5lBMSbpqnCPVFX2Lr2mdujGYsheuvxYAxNeFcRyKwWJ/Ms+wnBAa86dDGOg80eGnSV0jzynF0kd+wHRzK8EpEZ2alrufPSRUhrTT9QUpiOLA/Vqg5PvYlR64YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St5kISov; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fac7147cb8so21438866d6.1;
        Tue, 24 Jun 2025 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750827842; x=1751432642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmXcK6k38h6eC0gVXkVzWpNIJ0ZgWlljLA2mlEbIcz8=;
        b=St5kISovzHMHKVLvedc+QERpo9Bq/xgshfvECzlIcKFpUJuHHsO4A3r5xafQFZf80o
         atxE0j9Z4nkEnRpPJe13eV+ItRNQ1SiFrTyDtC/B2mTZzDlAUVJmzLiGLAH3lmuqpHYr
         NwTIFvBmxF2qIYy7qqg2lf5McR2yuApV/etj7BMGZXYO0hi2pZuPqlzM2fiqh5wD1pmP
         O4YMKaeEyxGguset9orju1qPYCzA6q/YceKInlJwd4ZE0AFSD6/pbmPFPSQNQjVVzwFX
         h7cgN19JzjUUy8EtdohY0yPccoOoRezUKjoeGqgwZKOYuROZMQ1ZdwDe4GDj2NVy4ZS2
         lhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750827842; x=1751432642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmXcK6k38h6eC0gVXkVzWpNIJ0ZgWlljLA2mlEbIcz8=;
        b=BNttp1aL0jw4JH7qkJgMB6LZOTJY4XAY0Ik66cIMEarOIzjKKsOEn2pkhr5QfKW2Lz
         r1yDMcCj2mlYq/mLWcZgqoALO+JT4YynTgV+jr2/Lv0m6BrQv2dd+2MuVZIraYrD1inm
         1piFaqmx3tGNKWdacfyYjqiuz2ItOLPUhAf+OwNOEr4xVxBgyip6rLge+Vy4xZ4KQqTA
         9/4yrp5NnCTppZzhfMtSLx56sxXBRN3nFMSLdwnRlBJRZCGBRdIk7jpNI/5qQThJxq0d
         7UuyS9a9mboszMkdANIsxZhD8F7xby++lK1lY4kUnrMVKg1Hz/K0KM5SZygjj2oCM40d
         yYFg==
X-Forwarded-Encrypted: i=1; AJvYcCVa2c1FyRWpJktV3hbgCANSpJCVlovuDPWkYlG1GNfxVTs0Ny8uXgQsk7kdVJ2Iq9CMkhfXbyNSBlksvP4vRwg=@vger.kernel.org, AJvYcCXtCo/rO7jTXBYmEQlXCeLxq508HyxdNX4cjYEuPjuBVPOa/Qg+WOP7vfVA5xy9LIrGZ4dl6Zb0brHQIvSR@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJ9ycfCny06oOBgGz0k3oKU37KtzqVlOMjbHGpbfI7bV/XS8/
	QPVHYVovmYviFt3TlUPKK3dH3TvlN9KtlInUCmBO+f2WzG8BfBobv4UI
X-Gm-Gg: ASbGncuaAIWUc8/0vLrgJxO4tpGx7otJmrYuqHm5lBNmTg1v4MXgczBZ9NgvUD4v+VK
	lmzzD70IkMXxDfWDrDiNWgQULgvtB5XyJIypLPZ4hR7u8IuvuMDUzXIwWVbq3bE4SIP7Gy/kkWD
	VUVeMsV4CYNwIh8wJ1798wpvgXf0PL/oQ0mQj/xFkEMPjmcEFwM3O8dtP6idiwCEqGeMGnRJkxm
	Jppif9LonCbYmmtndl5zZ6MJKe76mASDqrCCa4ySeiLr+iUDwMll0PmM+SU5iAUoMrlJMF0BYEF
	/WUao7QcdcXHysFl6Nej9DJqGq8Rf4uNf0LpyFY28r+DXYZbMbmLSI1b7xamaalyrf/ReEoMTD2
	qB3ErYfLGFgflYKk3LXzbHjDNHx+x
X-Google-Smtp-Source: AGHT+IHFiUnt/9yqS8qbgYpDfozkJ+jkoQIKcpL8XgHkZUa+KLljdHbvDsB/7fAE6hG29v5mnBYmww==
X-Received: by 2002:a05:6214:20cb:b0:6e8:ddf6:d11e with SMTP id 6a1803df08f44-6fd5ef83852mr25510976d6.21.1750827841892;
        Tue, 24 Jun 2025 22:04:01 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0959d85asm64173416d6.107.2025.06.24.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 22:04:01 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v4] tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions
Date: Tue, 24 Jun 2025 22:03:46 -0700
Message-ID: <20250625050346.11500-1-chelsyratnawat2001@gmail.com>
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
Changes in v4: 
- updated the commit message.
 
 drivers/char/tpm/tpm_ppi.c | 48 ++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..50f64d9b53c8 100644
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
+				size = sysfs_emit(buf, "%llu %llu\n", req,
 				    obj->package.elements[2].integer.value);
 			else
-				size = scnprintf(buf, PAGE_SIZE,
-						"%llu\n", req);
+				size = sysfs_emit(buf, "%llu\n", req);
 		}
 	} else if (obj->package.count == 2 &&
 	    obj->package.elements[0].type == ACPI_TYPE_INTEGER &&
@@ -100,7 +98,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		if (obj->package.elements[0].integer.value)
 			size = -EFAULT;
 		else
-			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
+			size = sysfs_emit(buf, "%llu\n",
 				 obj->package.elements[1].integer.value);
 	}
 
@@ -211,10 +209,10 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	}
 
 	if (ret < ARRAY_SIZE(info) - 1)
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
+		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
 	else
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
-				   info[ARRAY_SIZE(info)-1]);
+		status = sysfs_emit(buf, "%d: %s\n", ret,
+				    info[ARRAY_SIZE(info)-1]);
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


