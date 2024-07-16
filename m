Return-Path: <linux-integrity+bounces-3138-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A22932E30
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823501C211C5
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EB19B59C;
	Tue, 16 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjGeDT12"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19761DDCE;
	Tue, 16 Jul 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146453; cv=none; b=rnCRzcou0vW+DYkrSlHvlObCmtYUUD90TYgh0JMXJHTIKhhfx76kJDVLcsxI7LqO1EeH0Bkzhw6jP3D0tU9veJZJSMxJNou+5CTQgV/vZ0LJXY6RgMpB+/NMyUA51h4DDK5SLBj4x/xB/y9sn/5ULTIdGeYqlAihG637ynGYBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146453; c=relaxed/simple;
	bh=pT5RpY9lauBmkOcsYuu4tTe9R4Aa3/4UfpKQYu5QfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv76DvoZlEvm5EIxflvo+BMFYN0RoS6oP/anCXzmvFI3x4iVdXsUlFlNKFa2GFYJWNzJWKToSOcCveByU6/R5ku3QIKYaFYqzJdfqAKHIsfjukAOy5q/XpQ9I7NFyucj3ZFdHy4DbZ7nnW8/OCiqO+jnIzm6Bg/MXLF4TTMmAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjGeDT12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FDDC116B1;
	Tue, 16 Jul 2024 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721146452;
	bh=pT5RpY9lauBmkOcsYuu4tTe9R4Aa3/4UfpKQYu5QfdM=;
	h=From:To:Cc:Subject:Date:From;
	b=EjGeDT12OdyyFi9IlXe3uM2QetKY/wnkWrKXyDdvQ0W1c/WywruYIHYpE3QruBBjC
	 Po61Bv5Vd2bGGyRFMnFsmHR4KlI+a2mEGALKBTf2sM+E0qfG5i/zAZFmBnZXfC+XyY
	 xqoFJYb7srotfzcX2cgOvA2evNzhNUbmLLDK9R8qbV3s6FcTK0+b3mseKLQJmh1RKi
	 NfLOWjGmafDEeF16IfFeZ6u6Z5Qlqw/uHyrzjv0QJAX93ZqTnSuIVZ3CsjuXlyHT2X
	 asvcC122tKDWMuAup3XE+o5sNywc80GmOg2VTT1QNcerVtxbdFL1CInWQ7HW/Lv7Pb
	 E1D77SEMf4ENg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Fix alignment of buf->handles
Date: Tue, 16 Jul 2024 19:13:46 +0300
Message-ID: <20240716161348.99858-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_buf_append_name() has the following snippet in the beginning:

	if (!tpm2_chip_auth(chip)) {
		tpm_buf_append_u32(buf, handle);
		/* count the number of handles in the upper bits of flags */
		buf->handles++;
		return;
	}

The claim in the comment is wrong, and the comment is in the wrong place
as it should not be anyway a concern of the "call site". So in essence
it is lying about the code.

Fix the alignment to be aligned with the claim in the comment and remove
the comment.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 1 -
 include/linux/tpm.h              | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..02fc5d4ff535 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -238,7 +238,6 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 
 	if (!tpm2_chip_auth(chip)) {
 		tpm_buf_append_u32(buf, handle);
-		/* count the number of handles in the upper bits of flags */
 		buf->handles++;
 		return;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e93ee8d936a9..4b55298520b5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -374,10 +374,10 @@ enum tpm_buf_flags {
  * A string buffer type for constructing TPM commands.
  */
 struct tpm_buf {
-	u32 flags;
+	u16 flags;
+	u16 handles;
 	u32 length;
 	u8 *data;
-	u8 handles;
 };
 
 enum tpm2_object_attributes {
-- 
2.45.2


