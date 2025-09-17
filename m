Return-Path: <linux-integrity+bounces-7144-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8368B811FE
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806041C074CA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2C2FC86C;
	Wed, 17 Sep 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkffK2HW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53D2EAD0C;
	Wed, 17 Sep 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128947; cv=none; b=mkBxUiCVkQIpi6+ssFW9gTl1ja5a3dt6EjhrhrilBDW/JU+OXwagkhV6t6JlBnfwzv9MnFgFwGyoSmbTcPLpJDXa/YxkbB/RKmaJEl7+DMTD4J1AzF62Wp2KZ8uPiZyDDF/n6xoZ2jowBVbMBq6dKU5D5VxXWiv6E7eHLEWndyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128947; c=relaxed/simple;
	bh=ybViU5NWrDT7kCmPZeLitJ9YsoFcBxxvuApRKbRjteQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GKaq/aTrPDdxjavNm/1I3Y8UAeuCrUhHNwdG5S4dTTZf2Gk+64HWuwzJwB3140SMKZJFxFaJv6An4HP43ddEbKnhKG6fY3kW4uLWbKDBOSwjAfH+4enmxay31DRqp4jZFoaI9Z9f2ppnvSLcxKQXXBQgH5/P9cHbLfbu2kBbNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkffK2HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2365C4CEE7;
	Wed, 17 Sep 2025 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758128946;
	bh=ybViU5NWrDT7kCmPZeLitJ9YsoFcBxxvuApRKbRjteQ=;
	h=From:Date:Subject:To:Cc:From;
	b=KkffK2HWbImAZlcNRfsE9/xZz/knncuVFhScSZ5A8e82arwAO5GxhLwO0xGIkndkq
	 lmgl5H3aI5LQtW8dmkUUvGNeTxGQfyMTqEBSAwmXkZdp7EZUqqOY1qpq8vULU9ofQ2
	 BpHQA/tpnK/sQ8LfO8dmYsjAdfDvg1NHSrU6KtPYRrjgjgzqtdAiRXeHR6E49E7QaF
	 UGCmvEp+CPtMgx6BWUPhXpzknU4wr8fgnuddrdH9A8831dNBnmYSOupLL90HqN44p/
	 LBngFEdFOsnDltn/VSdczzJMhyqNvdhKEI4YSPukfeyUO/8K0u5DZX27vtel7ea5sb
	 Vx4ehsEh3uy6Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 17 Sep 2025 10:09:00 -0700
Subject: [PATCH] tpm: loongson: Add bufsiz parameter to tpm_loongson_send()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
X-B4-Tracking: v=1; b=H4sIACvrymgC/x3MTQqDMBBA4avIrDuQ+ItepXQRk4kOtIlkqoji3
 Q0uv8V7JwglJoGhOCHRxsIxZOhXAXY2YSJklw2lKhvV6w7/yw+/MYZJYkDjHI6rFz6Q6sq3Sun
 WWgO5XhJ53p/z+3NdN1F08OhpAAAA
X-Change-ID: 20250917-tpm-loongson-add-bufsiz-e43f60016cca
To: Lee Jones <lee@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>, 
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ybViU5NWrDT7kCmPZeLitJ9YsoFcBxxvuApRKbRjteQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBmnXhvUfNeWWbHLxv+G/Kc9zvUb38T+enOsKOqM1J12z
 QzBu20/O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEdnMwMlzsMQ786frGkuXq
 T362bxOur/Z3ED656E+nms9blc0/GqsZfjF9+RywqZlxCqPjg4JtO672BUT8aVs0K2311OfXDe8
 YPeMFAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device") has a
semantic conflict with commit 07d8004d6fb9 ("tpm: add bufsiz parameter
in the .send callback"), as the former change was developed against a
tree without the latter change. This results in a build error:

  drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
     48 |         .send = tpm_loongson_send,
        |                 ^~~~~~~~~~~~~~~~~
  drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
  drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
     31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
        |            ^~~~~~~~~~~~~~~~~

Add the expected bufsiz parameter to tpm_loongson_send() to resolve the
error.

Fixes: 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This is in Lee's ib-mfd-char-crypto-6.18 [1] so he will need to take it
but I have CC'd the TPM folks as an FYI.

[1]: https://lore.kernel.org/20250902124205.GL2163762@google.com/
---
 drivers/char/tpm/tpm_loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
index a4ec23639911..9e50250763d1 100644
--- a/drivers/char/tpm/tpm_loongson.c
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	return cmd_ret->data_len;
 }
 
-static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
 {
 	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
 	struct tpm_loongson_cmd *cmd = tpm_engine->command;

---
base-commit: 74fddd5fbab879a7d039d9fb49af923927a64811
change-id: 20250917-tpm-loongson-add-bufsiz-e43f60016cca

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


