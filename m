Return-Path: <linux-integrity+bounces-5761-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE08A840C5
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E499E189C241
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F11280CF8;
	Thu, 10 Apr 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m487MtyL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1367280A53;
	Thu, 10 Apr 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281298; cv=none; b=mJRwrkTRdObzuc0UvM8R1ZcemdK1ePh+cF6XXnQZPYDJ52KInKSW8dA6ewSo3S6k2UJ8jZP/a+TENbUeupQh91qfW234uFn6fcWSzWH4/3kjCB1Ql9OvGo7flgiouQktw6YkEObnrwEh18aa4NgxuHFsk84D/T8xuQy7ACZYiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281298; c=relaxed/simple;
	bh=Usa5GY7gLd+h3dNhdsCfEGEE0m5r6uiwqcZ8ac0SqQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pPL+S9ulmP/kYBe2ZUu4jjiVPp2b0lbeIzxEDouMazhWkm3b5qJlklG03OeduaUh+vq1fJAE+pM2pHzsc9XlK12J6U6E1J3MITW1kAztQQopsG45eM6I3rUl+h45iPyuyBGPGsFRxMUDaoO6FAxxV3xlPTyS06eSFMRu8lZlxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m487MtyL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so489711a91.3;
        Thu, 10 Apr 2025 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744281296; x=1744886096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKoRPjjF2o3edAKt6JuTrWZHCul5MYWhGghZITYn0O0=;
        b=m487MtyLFmprLombHYrtFpyjP3n9Wo+Sdnb/TwL7msWWXh/5bRqVhKnkD4gVu0XTwc
         NPY2wiMezbARs6bcfR4ANptpCx3fdGxuGZXACKMkQdNcl5aoAuo7xqpWm+aw54XasB3a
         G/sfy4UJaPMmLD8T0O0YxQDBg+zn1GgZUugfoPjmUayVat36QnOs9/0jZAUvfnbZhJUI
         WF0p4AKY8HLllBL6lK/ZLRgnrX3L3H8cqIN3LgJljdb1sY5ZdUgbZvpS+wjzwzqJpEqT
         D4e0Qn9ogh1N85zw287nKyOa/nWJM5xN6b214c32vgzn60TVtm+/Dk9M4c2cT9kr1GWb
         YekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744281296; x=1744886096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKoRPjjF2o3edAKt6JuTrWZHCul5MYWhGghZITYn0O0=;
        b=VdyneZGCGu4ipSarLhiLUZbnSNf0Q0nmYHW7RJ4jUJOt4bYaNGBIGYFLY/UEHCVvnG
         4fzjBak+R/5Xv62oHnB1fADQXxFvH0vGk1jOZQ3MFDmJZ4xT8FdF8moqg9JfVpCajp+W
         vhMQWISusWPIWZBo04EeEUp/UDwlz/QZcZZ7qhDHbUuTQk3MZhuY5pGA6DM8mbP3H6IB
         0usp/9X6A0cTdYtDz76U7tzuA+Z9tyQpQG6wzUviACw3BXMXNEtY6zXO/Wx7syHU14ab
         sx2wYpnl0G0CKbx70f5xUyzY5xNHRrtWHT6ofj3S+1nRlkaX5jXwlC72GGm8smx3QLtG
         Uo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1xJaP1ModDTXptPZezmJhbrKw6XJoPOe2H0LiiK+ZFxEvnsvX0lHkcZEsOSqQ0rhHvvqR5evZBR5sSmCWGpE=@vger.kernel.org, AJvYcCX7HYANzBwqrOG3Lh/Z23qCUGYbkFa4XvFUMkr06vsohWmohnU3l6Ltw7iYhfWnYZnAnfcSi+2+575kbGsh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6nQvTDwYkUOLf4xYutUpWRQOJrpMiDjFEakGBj3KO2VWotec
	0jg6L02IDWSvXNgWsLbkM65FD1b+FbYY0RQJDyUPktyGCk3FqrOx
X-Gm-Gg: ASbGncuOYcUNvHhtI+bMAExgi+AvWq9SpuPXDNEdNJsvmbViqRh8g2W+/WDrzjE0cul
	SqNiNelq5hgKyweKNkWRNPT/lxEtIUQLMSTOvt0jEHwkPCN0HlMIzKfSsAvTIN6L93IX7cY+c3d
	Cs2y5hUJ0uZ7u6eDmwu+TOjfKQHbYoqgGQxOADZkUNnG8yKPLRKvWbcN4+50GvNI/nh+oQpMKGo
	L0COBOpCF34wsHBygMsVOWPpT54SkEeDaxWjut9PxHcrz/Tx1oWOY5i/eGYnKxkmgMc+gIxFX4m
	Kquo/fFD1m1h3d0uKwJBewld5vitOhRL1AW2tlCRgFOkzTbo2BBdMZ5ZE2lTkYXUXHpjzMqSXA=
	=
X-Google-Smtp-Source: AGHT+IHM90ALESQ/hFbECm2wePfkPahQU+NMHam5UYKUXQtopaaaZm2Ej9hTWt6CgT+IFZM55oe2rQ==
X-Received: by 2002:a17:90b:2d46:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-30718b82e49mr3438484a91.20.1744281296168;
        Thu, 10 Apr 2025 03:34:56 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:5da0:ac0c:6934:f07])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df4011f1sm3438980a91.41.2025.04.10.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:34:55 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v2] char: tpm: tpm-buf: Add sanity check fallback in read helpers
Date: Thu, 10 Apr 2025 16:04:42 +0530
Message-Id: <20250410103442.17746-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:

drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
uninitialized symbol 'value'.

Zero-initialize the return values in tpm_buf_read_u8(),
tpm_buf_read_u16(), and tpm_buf_read_u32() to guard against
uninitialized data in case of a boundary overflow.

Add defensive initialization ensures the return values are
always defined, preventing undefined behavior if the unexpected
happens.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250409205536.210202-1-purvayeshi550@gmail.com/
V2 - Update commit message to clarify patch adds a sanity check

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


