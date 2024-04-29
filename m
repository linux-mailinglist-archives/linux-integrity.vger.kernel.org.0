Return-Path: <linux-integrity+bounces-2268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDC8B6399
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED201C22184
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05CA1422A6;
	Mon, 29 Apr 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VGeQupP6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4451419BC;
	Mon, 29 Apr 2024 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422605; cv=none; b=XYgmRs0qJliQR0u7VisL2Htv4vGJIfGR1NuEvxfdRFAqCYmloW2Tt85ghAxX77NhVDyiuAp3EIvWooiQ4GzYD9UZlPByoVBOLCPi0dahK8cInLKnjQ6/tv4GPbtkF97VUQC0hJODzbmlBPb3SZholkWV/f//+MPDj0F4DKh3jF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422605; c=relaxed/simple;
	bh=dwuGyYQKq/rRnuhCGin2sg2u+8jXwR0vnt4cki80AZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tz7NpnYZj2Vd0S38+TkDkJdZdSE6+Loc2paG4JnQu6MzQMHG8rVXBW15YCLP0dnYFlkXNwCTfc62ZmwOAO3v4MV7iL4VB4Ejn9PUOUCCtwcFawMNscyVNNhGEwiSa9i52nZRo2KYi7s3ep1n4ga1ijFf2wEXF4RH34nb4FlUzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VGeQupP6; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422603;
	bh=dwuGyYQKq/rRnuhCGin2sg2u+8jXwR0vnt4cki80AZQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=VGeQupP6RB4w4devzU/6yGvTR9etLH0TOorSXXoxlsDc4R5RfWGjsCLS54fo1Ekbz
	 sHuMwzW+o1KIVQ670y3CRt/3Oo5W2xQknkQND8x4ivDZWbapbH+YDyheO+Tq8bMG11
	 gIRkudA3geu2kGx7fagVRssUl7ZqXL6xYdfnCL/s=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id EF4B81281D87;
	Mon, 29 Apr 2024 16:30:03 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id bxvgKmpFozg1; Mon, 29 Apr 2024 16:30:03 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61FD712819F3;
	Mon, 29 Apr 2024 16:30:03 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 11/22] tpm: export the context save and load commands
Date: Mon, 29 Apr 2024 16:28:00 -0400
Message-Id: <20240429202811.13643-12-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2 session HMAC and encryption handling code needs to save and
restore a single volatile context for the elliptic curve version of
the NULL seed, so export the APIs which do this for internal use.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---

v5: add review
v7: add review
---
 drivers/char/tpm/tpm.h        | 4 ++++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..cbc9d1e2974d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -312,6 +312,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
 int tpm_devs_add(struct tpm_chip *chip);
 void tpm_devs_remove(struct tpm_chip *chip);
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset);
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle);
 
 void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 363afdd4d1d3..24479a81c23c 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 	kfree(space->session_buf);
 }
 
-static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-			     unsigned int *offset, u32 *handle)
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle)
 {
 	struct tpm_buf tbuf;
 	struct tpm2_context *ctx;
@@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	return 0;
 }
 
-static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
-			     unsigned int buf_size, unsigned int *offset)
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset)
 {
 	struct tpm_buf tbuf;
 	unsigned int body_size;
-- 
2.35.3


