Return-Path: <linux-integrity+bounces-6495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D4AE31FE
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640EF3AE062
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B461F4E39;
	Sun, 22 Jun 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFMghYCb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707731E0DEA;
	Sun, 22 Jun 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624720; cv=none; b=m5roqYA6gS8W56FuNKDS5k3d7xF9oxWmskiBgcG2SwZTPcGVCf0eJtqKySWjK2RZmKbkRMX5RFEoH/KZOp7OrG9eTdfQnklpPQNr13EMvZAmrd17IHlLr9Tc34ZOcvupVI2ueDNt6oaHqvbxfptr7Py5NoLIIR78kvui8ZQIikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624720; c=relaxed/simple;
	bh=FsM9pggermSvNQPAiZXur5A/W3HYmPYGCh5koS2k+cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zf3hI2fLcymTr3PgCJOOsHQajbA1xbS9Q86v5yF5j25we0d5lFm1HEVVkBneYEJsEzjmkfxxwU96F/SRP5OieBvGw31slGD8mIHtQPNg7J1Y7pFHRfwZL0Gqd199eDNSbr4QYFgVwDYoxGV5VqVkxLUhC5WB5Oi8moK/zRm6ZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFMghYCb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d094ef02e5so369791585a.1;
        Sun, 22 Jun 2025 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750624717; x=1751229517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vldq3wxBKVz1slyoTUjG7bsKsHFPjugjSfGiRDEW8yk=;
        b=YFMghYCbFQ+fcSpIoJmarAVXMdRBUCEk21HyblDnwlx0bYveH1yJ1pYJQ5CK3TDYXO
         jVmbL1QKrof8wg+UaQCfb1bWTq3wxIovX8NVLenMHoVViGl/okAKLhBtYTEapEKVE70G
         Rp+hWDRfj7Srj9BLUgrplLQ2gFLD4Jc4kCkGFESwkzvdwN0EGL/KVRshfKU6d+q0z56A
         0vhy+rV3SG0iTju4KbGVoPhoqla/DmiJV6LpjCsftlo21Plxqr92j+WZ0odVkVeWCGt0
         c6LjsZuO6E9B/uKAdi0f+LipSaUEog9M2yirSBl2uXTxSnzaDkum27UazNvmOVfF/Gnm
         dANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750624717; x=1751229517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vldq3wxBKVz1slyoTUjG7bsKsHFPjugjSfGiRDEW8yk=;
        b=wZJtcMu+pdVh9sgHV1ZZs1j5ENMQYomeBvmUQ1wW2UsEmKB7lV1XYTPo6znLz+uZt8
         yvT11X2qdHC+ewvrOp8Fv/pJI6XZy3N8XGW+dmWt9YJmrNHMhBU7AyYPPG71kQ2mU6IR
         YwSRPCo7Bv6l7+G7nCwTX91lqE6qZa1+SkA5jPdN90AYdq2ntXqfZFp5rrX+0gqciARP
         hb1rLI+2uUcr3QiPwY2KjD9vXttMWxtb93OYpO7azWxKeI4c44m2p3dRCVdGkBsnfG2X
         APXsvy0gex919JqLLWPbflzG8ICvuc0YMMVou06ezTE9Ps3bvY+rBVAANjK55lYGmFnF
         On7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9aF7MO5z6/6MlBdsVl54NIAUq4UfU+PulTS79FyyQEFrHHOQK4mGFHkxZ5Nvh8giz3mdS/ygPZJgl+/r/@vger.kernel.org, AJvYcCXvJ8BSQifsvn2Ts1NbCvRX8kHaLudvb094aMyFOps7E314NyrWBtI7ER6FaM3Mm7RYRRwkxpdKAWrgtAWNIFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCSO6PWXtSkoF2h+HdELB9FsQpR8Wp478g1YApIRilWnZo5lz
	MsFa0zq2mYbUk2haPM9IrZlZvKEe42lu0Vue3T0ujMI0GAATCWv4WaYi
X-Gm-Gg: ASbGnctOx/1SFB/J+HsqXmXSyFOfmdmjH469IcfdiiTtb5kNjyq7ogF2CWSDU+hiMFe
	sjvnYmPQ/fuRBlWG1DEValHcVoon89gAUKy3LHpZwef3n4MgpUvew35Zf9M+n10qELb3zTY32bH
	sMOSdySWPwAYFnr3t6XdKYf1/dgh0pOst/qGyLGiJH9Y9HFMtqjDMeznAuMm6npAWvmBQg/gyR6
	Q45spcsM8R4VRTfWLhs//XK9AyS3EU1UFrIqpQhuCar8JquVZWkPkZ5WXXV/3YErZ/yAMTs9i8v
	XJzUyA/aWrVNhUIdRYZDfvtf7Jv92Y9SQ9lVfxmu1DYdfrPAtrM3P2TU9edEvN398xD5Lp2LUFM
	4MvmkLnXyZgBb3bil4UJRcyir+lg0
X-Google-Smtp-Source: AGHT+IGf2xdhN2hJXlXhg+b+LtU16QsWc8owUzTcVQ7v+4pWQIPT1GW7q7GpCZh0d4w8DSMFLa7nRQ==
X-Received: by 2002:a05:620a:24d4:b0:7d3:d8c8:1e32 with SMTP id af79cd13be357-7d3fbf74499mr1409978685a.3.1750624717212;
        Sun, 22 Jun 2025 13:38:37 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e5d257sm32384341cf.45.2025.06.22.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 13:38:36 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v3] tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions
Date: Sun, 22 Jun 2025 13:38:28 -0700
Message-ID: <20250622203828.193163-1-chelsyratnawat2001@gmail.com>
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
Changes in v3
- Replace char *str with int len in show_ppi_operations() 
- Update sysfs_emit_at() usage to use len as the offset
- Fix alignment

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


