Return-Path: <linux-integrity+bounces-4630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2EA1AA6D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 20:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A6D188D276
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DB17085C;
	Thu, 23 Jan 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+5861lj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFF153BF8;
	Thu, 23 Jan 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661209; cv=none; b=QoDo9PMf3IT25LLmFuZbAAjUIgvsWaHTTCflelnCgPeGLB6wsFq2h7TdrKW6blAHA0XlnZ9W4AVvreSinTWv3zIMCW+pve+GC/RkK97M4rnxTWTRmcdrDUx1q7wqgosCJwAulbUiJcf8p80c6SFMQw53LQNdAx3l1N3g6F0xMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661209; c=relaxed/simple;
	bh=lNvFblm0tA75dRFkK2dQQ2vP5N1S9A5oJ9+tZziA3SU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svqQxiX9STAEoCFIshgKcccGSUBfOcO2rNcG6mNIo2AV/V9UPx3D+OlIaaqqjlR1IvCdoZJO2VLJJHAqbvqFp4sISnHw1ZgpEAqUEug9cO5BX8j6d2a7PWI4ZMs/kVeAyPxZ/ORALl8+6O0A73fibP7/045dY8ZrQD7Il9beVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+5861lj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21680814d42so21924925ad.2;
        Thu, 23 Jan 2025 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661207; x=1738266007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGNk0E1QQh9jtcLegFAVre19rme1v+GqwcPtvIzl+1s=;
        b=R+5861lji0BtabkkiCj0H4SN/x89FJMsQkAoILlgyvHiayuR88Bu2GOxQKoH4XGdFE
         r7uQqqlwGTNQ0KlDnElJoIZiIkr+SjufvNu7dnyyU0CMw3Sms0K6PUUfIzrkIkWHeLht
         2461HF/YeLA/RyoLxOXSKxhgntEfuXMA6+3kQYqt7GKzG9FjbU9KFopqVunl6KnEmjUX
         Po0EmCfJ/3ARi+/eEe54O6lYFf6zjZs7zj18gyysGzhuYNiJ44QML95vbpq5k0Umhl3o
         R1yptL9e39ncixI/XrYM99vnCxFubWQk+VfuhWKvm/zD4c696Fdo0r6GOLBRO4UzdRaI
         D8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661207; x=1738266007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGNk0E1QQh9jtcLegFAVre19rme1v+GqwcPtvIzl+1s=;
        b=gUTs2neuN8CBXeh1cHovVkBYq8U8ojPVYFIbp1jMcl5YojIzX1XCt7TwiT/b879sVh
         Rtox1qVKzUQb011or8hB3tvvlwVELF6KS/Xwddua5rkX+EplWpRK0zrZqSCAPJl/+09u
         gi4YIWbuOlOLs5zg7P8thanmHWMQ9xeXkm60V2wwWSDjaProEwxw4ScWPb1BDOOdyA8B
         /VasnBtVCd1zrzfmznGjERxPC0+UdA8eRMcbVY1/gIprs17qrCVHg2t8x/bm1D/S4I8C
         an79S/naqeVjxWPBb+ga8dcQGokRus1qDdLXl1DGJoAum8NPhW8by1ZkqwISMCGWLN3Z
         pTGg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1Yq4raqHpTEPH9U3IhgGy2cgPA3pf1+4FofQ9JAbweSe5ftAM/Dpkj+cybuCcWTzXt7QvKBcozlBBvY=@vger.kernel.org, AJvYcCXrAYCjNFj01cXYDRbdRuo/ocY/p2JO8jQJg1HinrGrhqinMPx97vGzkRerJLVDSmsOPSzKLid6IA7iJ2ChttHEebtf8Jon@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPWqR1zq6RX05j+zfjPVJu+zlw99VNV1a4hHXh2sCkFxdlkFg
	9+jDkDflFYwqP199yq9TNOE3s1p5h2f5efks3cK4Kzc9pbb88/UO
X-Gm-Gg: ASbGnctbwL0mCsw6hUucqaZKC4Wrw3AVa8NvtJ+1/Rkh/LWqRNtkFQHHraF4crLNrQk
	W/VgDtWTaeu0ieaX9f2cyhRZxyy8k2ysQyjKqH8VZkkJZH7KTlGOfMnLESkqev3GWVfwOABP7G6
	GfmLS19OCPCiEfo/PL82s6374wYFoqtNegs2olp3ZaTSJRX4Iaiee/Dmqvdz+IsfczY3EY5N5sB
	EXtUDdcFrM3mF1mAVPIs2SmkjpVHPF8IqJYl6p3XqQbCjj0IM0UpfsqLz8QlwKbbchmBaorpmT/
	lg==
X-Google-Smtp-Source: AGHT+IFOJ0YepxdXCiA5AdmwfYu25lYNDwnM4txqqU57cNwYZy5mXZ0IROA1Lb7I0hEy4FBbPXVl6g==
X-Received: by 2002:a17:903:2344:b0:210:fce4:11ec with SMTP id d9443c01a7336-21c352ddf4emr456747045ad.1.1737661207398;
        Thu, 23 Jan 2025 11:40:07 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21da413f453sm2680515ad.120.2025.01.23.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:40:06 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] integrity: fix typos and spelling errors
Date: Fri, 24 Jan 2025 01:07:44 +0530
Message-Id: <20250123193742.2623-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix typos and spelling errors in integrity module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers. 

 security/integrity/evm/evm_crypto.c | 2 +-
 security/integrity/evm/evm_main.c   | 2 +-
 security/integrity/ima/ima_main.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 7c06ffd633d2..a5e730ffda57 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -180,7 +180,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 }
 
 /*
- * Dump large security xattr values as a continuous ascii hexademical string.
+ * Dump large security xattr values as a continuous ascii hexadecimal string.
  * (pr_debug is limited to 64 bytes.)
  */
 static void dump_security_xattr_l(const char *prefix, const void *src,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 377e57e9084f..0add782e73ba 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -169,7 +169,7 @@ static int is_unsupported_hmac_fs(struct dentry *dentry)
  * and compare it against the stored security.evm xattr.
  *
  * For performance:
- * - use the previoulsy retrieved xattr value and length to calculate the
+ * - use the previously retrieved xattr value and length to calculate the
  *   HMAC.)
  * - cache the verification result in the iint, when available.
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..cdb8c7419d7e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -983,9 +983,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	}
 
 	/*
-	 * Both LSM hooks and auxilary based buffer measurements are
-	 * based on policy.  To avoid code duplication, differentiate
-	 * between the LSM hooks and auxilary buffer measurements,
+	 * Both LSM hooks and auxiliary based buffer measurements are
+	 * based on policy. To avoid code duplication, differentiate
+	 * between the LSM hooks and auxiliary buffer measurements,
 	 * retrieving the policy rule information only for the LSM hook
 	 * buffer measurements.
 	 */
-- 
2.39.5


