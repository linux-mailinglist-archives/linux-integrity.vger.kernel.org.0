Return-Path: <linux-integrity+bounces-7410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB95BCBF98
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A061A63BB6
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E052765EA;
	Fri, 10 Oct 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="WIcJYTg9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30556275860
	for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082605; cv=none; b=BuXAqQ008o5TEF0IQcwnM6L021OzkbWmGIX/uW2d0UHd6Op0YFeQiQOP/M7lUZIJVvUdxB3RwUHeVrDzXPCiLlWtfxZbpx5cJmiaYsKv7yw+YJbeot30kabJpjhSwdtNLoBK/o/n7PRmZF8Z6RLv1OwWjzLnfE5vWRjXB/AHNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082605; c=relaxed/simple;
	bh=nWfBJc5B5wABRBWXLCt4WnYkfqomk7df5BLYMujxSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syQIbUIeNGXO03p0ZHZ1u3wcQSOWsIKw1GQukP3KoMkIilmX89sl49v0QdcCS6tSdFPL7fLWSO2vtDff/BA/x9DleVj/N/TrTVKqz70GcsRgbK/qB4+tAvvnMa/9eTbJk8cdsAcTSKw9/Q7L8VCkVlH7AxPeF9O6vS6KmZ/Zxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=WIcJYTg9; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 046CF240027
	for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 09:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760082600; bh=U3yQSyvNq+LILqZiJHgKdf1FbljZv76FRIUyxVP3WOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=WIcJYTg9mmj7aPgDg4pOk3F9b0uCscXCSpwytC/7lgwY8UqoEsfySqGmzNQMBKqxr
	 61OSIah8ivmkB6WubV1Kprz8sI5gtAQFGDG6pyYrQm5gH7qqSguun2ZCj747/nt7ae
	 XsrDYMztHo8Vs6d6SN2MwgZw/xx8SP3KckylEPAykut/+0scTZeF2zRsMlGLWQFv2O
	 DnQuPyHLhZaD0PN4BSJ9gvYVE34xXLBsLlNqcJTGTx8N6nrDZXPdPCEi/YQY6yn6iC
	 4aXcesLtXvS1mclOtKnne31JdQwJIu6dMChsGKI88B5+F/NDc6PvslsQCbxXDzVC9r
	 i3jdczXBpBEtw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cjf6G6fXJz6v12;
	Fri, 10 Oct 2025 09:49:58 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: jarkko@kernel.org
Cc: shahriyar@posteo.de,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] tpm: infineon: add bounds check in tpm_inf_recv
Date: Fri, 10 Oct 2025 07:49:59 +0000
Message-ID: <20251010074956.6862-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two buffer size validations to prevent buffer overflows in
tpm_inf_recv():

1. Validate that the provided buffer can hold at least the 4-byte header
   before attempting to read it.
2. Validate that the buffer is large enough to hold the data size reported
   by the TPM before reading the payload.

Without these checks, a malicious or malfunctioning TPM could cause buffer
overflows by reporting data sizes larger than the provided buffer, leading
to memory corruption.

Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
---
Changelog:
v5:
	- replaced space indentation with tabs before the header comment
v4:
	- removed the curly braces around one line statements
v3:
	- removed dev_err() logs
	- added missing "fixes" tag
	- described header structure
	- fixed commit message length
	- removed use of local variable as constant
	- fixed check to account for off-by-six bytes
v2: 
	- added complete changes in the commit message
	- dev_err() logged expected sizes and stated operation is aborted

 drivers/char/tpm/tpm_infineon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..d76aae08b 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	number_of_wtx = 0;
 
 recv_begin:
+	/* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
+	if (count < 4)
+		return -EIO;
+
 	/* start receiving header */
 	for (i = 0; i < 4; i++) {
 		ret = wait(chip, STAT_RDA);
@@ -268,6 +272,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 		/* size of the data received */
 		size = ((buf[2] << 8) | buf[3]);
 
+		if (size + 6 > count)
+			return -EIO;
+
 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
 			buf[i] = tpm_data_in(RDFIFO);
-- 
2.43.0


