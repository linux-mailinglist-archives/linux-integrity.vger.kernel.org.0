Return-Path: <linux-integrity+bounces-5726-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBCA832D7
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C26446D07
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B220297E;
	Wed,  9 Apr 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGuOLviF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363F1DDC04;
	Wed,  9 Apr 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232149; cv=none; b=rJm163gHqSI5p2/8i0VcHqX66ebVk+T808tPQEc+FQUEgdqOpx1ELQlN2URwdlfUk8cRAGHQvyRuUjfae1M/vVn+o22n4FUVPmPNentV0+oFTf3JIvh5sn3UBatQSSd4VfmQ7eD9yuu+BYK2u9JHu580lzA6L3ORv/bujwMvBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232149; c=relaxed/simple;
	bh=EPn/d0cd3kjYwFoD8biIUR0OJ+wRMiKabWAhIrPT/2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C4mgkzUDsdzf7BJaiVUrkUwTlCpGZEuTN4CsEfnrDexHWbl1JhVJqxWnrWx3pxdSk2/B9fmNOlMl2KKUPUgTxjbkjWkqMFzV3qpar4vyUzIBqZoQiRs2c3Mo341ddT3Ma5P9UeuF5bmlQQXfqmJ3Q3kj1iEX9CxKc8QXSR6NQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGuOLviF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so30750b3a.2;
        Wed, 09 Apr 2025 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744232147; x=1744836947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QkpG4m8Lc/btjIEh5jay7XVuJOJzyS0YVOjKC0nw0g=;
        b=TGuOLviFP76RgHxquxIVbBQ3WDvyvk2uPHQoRNZ1vu8FMVrUzLQ0bILzzvUS2X4Cq+
         IeS2LSH95xLjhmerLe0lnd6b2hG7F6sP0JZMkg98n+0GxKsOvRbnkX0WGQkvERjGjOy9
         IR/gCRXPDb3TtZ8M3E8hE8MI86EBX/9SKpVLSwNCl2O4EMiFWk5JKTN9tSsLEu4fpb8Y
         nyt1DfQINTrl2DnKUOB1pv1eivjLoE3e6XqRJ56mJRRDrnPi4Jr7F2JgAeEEe6DTj2RN
         jQsoAHS0m2fX9LkBoGed55d7ZvNUGAFfZJNKfvyTGKy0uD8tNMQ7VhTrWLsrYiQiUGE3
         Zy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744232147; x=1744836947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QkpG4m8Lc/btjIEh5jay7XVuJOJzyS0YVOjKC0nw0g=;
        b=KaTaOw6IFT/zpwtgoyvMNd/RNysKVy743cevIr+9NgZA7fdAjzxy3QHu4MEWwALlP7
         I1mLDx4oDs1Zs25XG7gTjwdrB7dAQ1Ppaiv/oge0hJ4V3CiVLelDnToHt29hQAbdEazS
         KZu+A7CwBgLXeTpMGkMIaA6ztUodvG1tktK2GJABSFy+15/XpLeeGHy6OVr6UhWZVwhZ
         w6oLqq+JfLQym1+Wgu0SZ/uIeK9dSshh1mZ0/3zwUdx7Sp9iL/bjh3KOQM1NnqQKEdi7
         lsaNtI5KPKm/GvZIbvi3zGswjVziaYqCEYQsXy2Psyk46MEXGwsGPM7FVn0nzfoH74u7
         5SIA==
X-Forwarded-Encrypted: i=1; AJvYcCUDUSxdDDp0wgbNVzRu0Q3W6s4S1NMwAkXPvv6IGzZbbYMrdrpCpyEp3QztARI06saFUm13lVwZZn0OY0i7@vger.kernel.org, AJvYcCUpLVqVFJbx4h7W1jKWOBAMwXsBnQ9F/Jqj2u33AAheH7Bzm0Rp4F1a+/0fB0yZSRB0SsUQVu6HZgux+KA5ZFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkfACZBRA9Idp+MrrHumDAIFryyKOkMWgoPuiVhOUyjMa5jzmZ
	tCAcqjcAkvzkplod9XkKvNdxXURKanKMoM6xqCClT1iozmhFp7EM
X-Gm-Gg: ASbGnctyHUt9X9ogRfHEtHgMhT5z7r596Jt09yvE6PEWOzBuWEfRx1vXvsYhcjTX0hQ
	qgXWd/jDMniiotbmcbGgMeIeB26RZFue3nB/F8RvGSjrASYmy2AHD+m1qdXG2FsosvX6bsJr/Gu
	xlJkmT+ddv4up3jFhFgyFVtm+CA3TmzJQv/yQnF7PkZmMk+0wXgVvzmsF0tej5tos3rsw2/sWjf
	6skYG3qD3nuxj2KKEYu2f1N99GuBEZcvyCgwh0v3Ra5xDcleCus+nY3dWrjPqnMlvaONiC3+5l+
	VuQ490SmP9AvPnCw/XIv5oqitx4gc3l4+2kzoMR0LW8qUeBFWMpgyvNtlnDzObCphqbfNQ2slw=
	=
X-Google-Smtp-Source: AGHT+IGhGUwWPR32v/s/SkavVBdJ58Gtxo/MVhQ80j4uIDoiELiGftMvP4XeTKKA/0fHgSDCX83T/w==
X-Received: by 2002:a05:6a00:3987:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-73bbefabeeemr383715b3a.18.1744232146641;
        Wed, 09 Apr 2025 13:55:46 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:9312:7e1:b2cb:ef99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d46509sm1875527b3a.57.2025.04.09.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 13:55:46 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in read helpers
Date: Thu, 10 Apr 2025 02:25:36 +0530
Message-Id: <20250409205536.210202-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
uninitialized symbol 'value'.

Call tpm_buf_read() to populate value but do not check its return
status. If the read fails, value remains uninitialized, causing
undefined behavior when returned or processed.

Initialize value to zero to ensure a defined return even if
tpm_buf_read() fails, avoiding undefined behavior from using
an uninitialized variable.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/char/tpm/tpm-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index e49a19fea3bd..dc882fc9fa9e 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
  */
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
 {
-	u8 value;
+	u8 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
@@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
  */
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
 {
-	u16 value;
+	u16 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
@@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
  */
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
 {
-	u32 value;
+	u32 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
-- 
2.34.1


