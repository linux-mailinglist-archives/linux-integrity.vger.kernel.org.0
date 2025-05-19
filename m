Return-Path: <linux-integrity+bounces-6255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89801ABC97A
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 23:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD501765B9
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C522DA14;
	Mon, 19 May 2025 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOvVjtWY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763D22B8A9;
	Mon, 19 May 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689755; cv=none; b=dTRLyQ7dJZJjdBLvYN5d+Lu1+KQaBqvjx7mgftEZt4+JrJsfD55DBkUlkqAEvWUEJrzFv6tem0SjZsiCnvmVSPldScw6Np8v2vPXJSbv4IERjvTPrzqM5p/iDGuNnBpyR8RAHQSDa3kY8qJaqtdAWudH4wfAJbavyhshQikfO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689755; c=relaxed/simple;
	bh=7uUZ2Z89gZg9fTS1U7gwZQG9RsGBx0u2cF+JV+cXD3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxFGXEdT8V3LGjnWdxaxoYQvWRd5iBGXoBbusAFUg1XKDdCvDRuHU9KFnKR/uTSZafLWuP2jmwOrq4kAenVgqNuS85l169W+byYDDqnA+q3EbpcdmR2F13i4ZvHX0nMkWnZZZlrBtntKbyao6WNUaSVyjIbW6DK2aD4SbqeUXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOvVjtWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27690C4CEEB;
	Mon, 19 May 2025 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689754;
	bh=7uUZ2Z89gZg9fTS1U7gwZQG9RsGBx0u2cF+JV+cXD3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOvVjtWYxYaJIEjYSbo1F6rgiWQuBXvdFQQP7xq/AEAOegLdQaUorExLcP+86YOYE
	 UZgzjMCUs2lTxslLtTD6CnGyEBpI7E6oBA3rsalTUyAjz/91r3QfeBudfUU5xMK5k3
	 /OfCPddlGOezN1lyGcH2soK4Hl68bhPGvAKKyfVAUJ/upCwmSxU0VcsziuwIzy1w0X
	 wqVDx/A7pZxHXwLOyjUuuDbEMAsA64v3+YoITiv2cjPt07NKlXp9u5Efe4pB5ZW1AO
	 y64pN5ZwtV0Ay3cnyLGtlW4XazZsduHQoVMiXwvPc3M211Hu6FMKV8/Zry0jQDRnND
	 toPbGuSD0HZww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	jarkko.sakkinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/18] char: tpm: tpm-buf: Add sanity check fallback in read helpers
Date: Mon, 19 May 2025 17:22:05 -0400
Message-Id: <20250519212208.1986028-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212208.1986028-1-sashal@kernel.org>
References: <20250519212208.1986028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

[ Upstream commit 32d495b384a2db7d23c2295e03e6b6edb1c0db8d ]

Fix Smatch-detected issue:

drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
uninitialized symbol 'value'.
drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
uninitialized symbol 'value'.

Zero-initialize the return values in tpm_buf_read_u8(), tpm_buf_read_u16(),
and tpm_buf_read_u32() to guard against uninitialized data in case of a
boundary overflow.

Add defensive initialization ensures the return values are always defined,
preventing undefined behavior if the unexpected happens.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index e49a19fea3bdf..dc882fc9fa9ef 100644
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
2.39.5


