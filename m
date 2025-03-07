Return-Path: <linux-integrity+bounces-5175-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A3BA567C3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 13:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEAD3A8B68
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20C219308;
	Fri,  7 Mar 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="qxu8OlZ3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63E218E9B;
	Fri,  7 Mar 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350331; cv=none; b=kQzKBU3I+bb+uGGLPIEgVOkKZcKybwTTx8WGlDQr+Ydd7eZYtdcbrNr6VGpuvj1vOdNU8VdxifJS4f4h/Kkl74ESsq0XS4AEs70vxWcYCgWxtgxm5pWUCmTm0s86K8USMur9Z5rpX6yhA/x7WfOyql8zKvlU3mbTvE0qNtIzJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350331; c=relaxed/simple;
	bh=GkxCs4YB8ASsPjX9IWShyzuObf+ZAxnIvvctr0chLgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2HQPcunCbFLC7Y3TLyeiUJCwiY6kCBmzoWXlMf7oe+FtTMVAc6ruiIDeda4OgCxXD57eqsRAklgoJW4MhmmURHlLEVFCFSB7WDzz5wA2GcKAZx5EoclLlSv96uVwX2PgjI2QdSQnB0dF4QuelrfA3a8tNlWfZ5rtfR4B6PeHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=qxu8OlZ3; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6UMNRM9uWjFBtWF7LyfW0g9MVh4V11YndHgWK9NCQm8=; b=qxu8OlZ3T82XliRM3GlO4qym/j
	wJ5rMG3nIaBEjwvHLCNaTYKvtNnwsR6Fi69R7wsao5aeSuR9GuV5Sen8OAyaz9xjBOCQ6cuj8J5Sp
	DL4ttjND6HmtHvu9dM8sFtwMgJAfn9jWVtqaukvqM48cYr9lZlV9mTNsCyGjkn0Z3R2E++DtE4cdv
	mCSjQ8w5R0ANu/db2tpN6moxmwHbVfahznF1iPt1i21pIhT7E4GM+tEXKjBbIZmEfNM4idZHkQoxd
	TQIo38MwiLTgIVAc0u8gejMfp7a4TASG2en2dpwkpPYpwC/FdQWH+0cSphjnBn0gQXwT/lAwps7aM
	EHPBf0FQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqWlX-00CyjR-2Y;
	Fri, 07 Mar 2025 12:25:23 +0000
Date: Fri, 7 Mar 2025 12:25:23 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: End any active auth session before shutdown
Message-ID: <Z8rls0QkzOliECp_@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

Lazy flushing of TPM auth sessions can interact badly with IMA + kexec,
resulting in loaded session handles being leaked across the kexec and
not cleaned up. Fix by ensuring any active auth session is ended before
the TPM is told about the shutdown, matching what is done when
suspending.

Before:

root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
root@debian-qemu-efi:~# systemctl kexec
…
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
- 0x2000000
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#
(repeat kexec steps)
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
- 0x2000000
- 0x2000001
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#

After:

root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
root@debian-qemu-efi:~# systemctl kexec
…
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e52..87f01269b9b5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -300,6 +300,7 @@ int tpm_class_shutdown(struct device *dev)
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
-- 
2.48.1


