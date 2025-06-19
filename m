Return-Path: <linux-integrity+bounces-6479-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 752BDAE06B6
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319291884EAA
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE624DD02;
	Thu, 19 Jun 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN91qdO8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1A24677E;
	Thu, 19 Jun 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338807; cv=none; b=MBYJekHbtsLpa7mAshWF4wNU+G5sbhrRuMFX4O9bUl2QpqHjw7gbnglKTO5T6ZwPXSE/9BuKwYxyhmkEkG5vrcaghOP5CQU6Roa4Rv8sZCRSZz+ktrRrgvo6nX8B366hbSawop363AhF86wEZwp61pU6dnKmjQWfyzUs+4cOAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338807; c=relaxed/simple;
	bh=bIK/6budNgvG72oKFlTYS9/dSDNFKzZHwI2wghWAvlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB/aGxPK6jLLUZ760UG5G1cZ50rSHOlRDWmF4Cis7v3cNvv0hvs8JRZayo4JG2b7w4VivX8nk8EoIpCInDwUKmP7zHORxwLhbye618fSjmTZyJ7GJpw6aGXz0F91xVm20vRVrl5d9FbZhoGSl7owMTpDyITZjRwGTF4PCvBIb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN91qdO8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6faf66905baso10671476d6.2;
        Thu, 19 Jun 2025 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338804; x=1750943604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCV+HjjoDipCo7IVnf8NCCKQ43tzrdnmvfExbXDzQgk=;
        b=nN91qdO8wgQcdQK21wY8SzBORkGGqFPGWyBimJfiYVi5c3761RrCPEb9c9H0GTnqxm
         6ilrI58yHaq3NFuZEzclYysEDI+cKxS+vt1g+WgpI019r4kSxjcuUAZSqPXlzvrEr3OU
         6GTV7dPmKVKZzVHfS/ejQjcNTJWIg31/SQLjv0i3eU921LpNys+6PeIcvw/glygPWR9C
         fEoxtIWQZdPYM379B2mZMGKlpOFT6Z1sVz1LGvpaRqSPpocmWKS4d//2tHXht4MpbRjw
         UUWcgmrEbGYyyTMz7VgsKUUtEnLxK3sNZMB2OSfWP208HBrADrtJTOSi1UmoUCasXPtg
         hgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338804; x=1750943604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCV+HjjoDipCo7IVnf8NCCKQ43tzrdnmvfExbXDzQgk=;
        b=vL1lHbxqvfsjiLZHtPDG9GXQqBdHzDIoA5YWRevA6q6puFBHGjNcmDMa3F18g/Ltvi
         /9nRyHjVUTbHIZ60L4ynjtm3D2zQ7ux6QfGESx/gxtvyntNZVcPCl64rSDPEsVTKcHzr
         0H0Qay9h3vv3xmWMVSNQGgKh7z6u0GLbQqNLUoqott/3socKIf9pDr3BGzrsHKsb4qyJ
         WdDhah/23SUrg4k0bAon4rmBiMIQjM9764R5GwTxqWjtQ5vHcMEhw/Z1FBrVfnX6Ha0/
         MJBYtgX0XsnlJarRgzEzab2ILoVykbTZ6+SCmDyq7vZZnal9Z4CmzkOaBv8yQ/frEfKF
         O6jw==
X-Forwarded-Encrypted: i=1; AJvYcCVxTfD51H0O+4Vg9AsT+9T0mOp272Wldks3O5ZzmAB9YGVccNiSAeVk3yKOl6fDCQ0wAgmFUkQ8gNQBQzXQ@vger.kernel.org, AJvYcCWVN1R8Jz+hD2sCQMspypdwvTNIN+AeiPRPsNeyaN1IfY676hSFY7NppvoIel4GF5mC6JxS7GYpWGD9iUNcqC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSuvqvOlL16wKHGECaCo506OSMouPEPb/fMRMk07PYWjb1TMh
	9RWc7bCNMUZfmjpUrV7TTG5dfcG7rMoh2NCmqs8WNowag7aDzmwDYcO9
X-Gm-Gg: ASbGncvVb0YoNP0QUSYVzZH2IU9CdjGJcPrZ9i/s5h1twLM8Er8zYY0In17PUVsyLPJ
	x1AWjI6TTmvlK3dcneQ1mHnNKfFyIUKQRT7CIXX/QDUwIyC+1HK6hsNcXo9ZxUboDgA7G7CzM7j
	cuXrF/bLAnomXAAUBeigdrPxsttls3TzjCUrYUHErE9/roppqx7CMZfuuVwyN3eoqMpApp3W2y6
	gc2f443crXp5SRLYitpDUcEBiK+h3vrVk7F9SW9ruSFBUnQQ/fgPZK/eeeMb8l6WZT9+lBjNb7K
	q1t1hwpi02qo13FgGVtOZVXwEYgE8N43Du7Q3w1s9cP/fDts6FI1KUHbpMBAvjo+TNcmbOQ8GHl
	hU0lXg+xjgtd9be8dhNG/BzeeaRwPt/2gq9qwH7c=
X-Google-Smtp-Source: AGHT+IExdStnCHjzsdA4GSW4nV9HKIjMFEKb/HwZY7IYhUqxOY72cf3bohKK4BFtw7VUJPX2LfVQOw==
X-Received: by 2002:a05:6214:1314:b0:6fa:fe02:8219 with SMTP id 6a1803df08f44-6fb47627bd2mr390874206d6.7.1750338803858;
        Thu, 19 Jun 2025 06:13:23 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd014fb7e4sm7260276d6.31.2025.06.19.06.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:13:23 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions
Date: Thu, 19 Jun 2025 06:13:12 -0700
Message-ID: <20250619131312.407615-1-chelsyratnawat2001@gmail.com>
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
Changes in v2: 
- Corrected sysfs_emit_at() usage to pass buf as first argument

 drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..2c0d1859284d 100644
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
+			str += sysfs_emit_at(buf, str - buf, "%d %d: %s\n",
 					 i, ret, info[ret]);
 	}
 
-- 
2.47.1


