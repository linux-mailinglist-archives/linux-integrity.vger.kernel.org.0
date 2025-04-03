Return-Path: <linux-integrity+bounces-5595-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2006A7AF93
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 22:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D110D17F9CF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF82E62B0;
	Thu,  3 Apr 2025 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3EUOwXU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E02E62AC;
	Thu,  3 Apr 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708072; cv=none; b=gfCFtO59Z63GWSDar1UBKEQISREelpus8TFahE7ZpkK0hT1EqJRrl3to1mViTcixeqxEpQQNkW+Tlu6n2oXr+FX4oRpcqUl5C+2M9cy3q8L6o0dNcV1stodQ5xI2dKqxn7uh3R/82cba6p/tyONtRCT6tny/ckdK8htunJcwEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708072; c=relaxed/simple;
	bh=fSTP9hk2r75CUO4xrkqPz0MKNapjvhfwvVYOZuFXBcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8QP30S5SQWgNPbToX/aFVRDT5HdMAXVnc6I27Ze5hUKagTnztHw2x97XYH12piybcHMI0WRFi0SSe1dM4bbQJKBPYVDnrYCqzOAzaI87/xP8dBEAel96CToj0n6Ou/cueSSaVRBeYtnzs7Wrti58fIZAUbEfPMglU9IPZ1Id14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3EUOwXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54B3C4CEEB;
	Thu,  3 Apr 2025 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708071;
	bh=fSTP9hk2r75CUO4xrkqPz0MKNapjvhfwvVYOZuFXBcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3EUOwXUSLtpoP6ACPe3/jWJADvTuSNhnCecNcGUudE9pYBmirYNdlfT45XnUKawg
	 05j6BoGL5jHcSWj1ky+h9R+C8nXlMe2cRHX50Q80AfpH+N8tW6a+6D/fU/mrEOq/bU
	 bQCD0hteWcgPG+qvdHTMg/DSYW2c21S2YapfYLDZPrhSxkONbkXA1Mt/AuZr21S7k7
	 xe9S3RPCbMGb1hl/bSFiAb7UlEkI5pkyaSenxOFmdngEfp9PfV1ywMVyOYfr9Cy7Cg
	 R8FZJfHEJamnZakMk5uOQgsDCzJ827kGWCWwOa+ENnOnkPQC7E5hhLUdcglITUft2x
	 RazAYUU3dg81g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 9/9] tpm: End any active auth session before shutdown
Date: Thu,  3 Apr 2025 15:20:50 -0400
Message-Id: <20250403192050.2682427-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192050.2682427-1-sashal@kernel.org>
References: <20250403192050.2682427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit 1dbf74e00a5f882b04b398399b6def65cd51ef21 ]

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
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 17fbd7f7a2954..b33e938d80e8a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -290,6 +290,7 @@ static int tpm_class_shutdown(struct device *dev)
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
-- 
2.39.5


