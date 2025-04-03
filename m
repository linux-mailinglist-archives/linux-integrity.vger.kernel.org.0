Return-Path: <linux-integrity+bounces-5590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14DA7AE9C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 22:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED8D163FCC
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9D209F4A;
	Thu,  3 Apr 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfFIbtbj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02A209F43;
	Thu,  3 Apr 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707815; cv=none; b=VqjaAYrMLMTt30RuCsRyvGBl+fjIZvG3QWz2s77ax8UIVz38DFbeWCo2N3k7PeePJ6RsLXEJr1jgHJ7tcXYDboUVOudunxoVjDov1IRXPs6tkuDLb/nr9MbBC8KZIqy33cS5KgLOPAR5lBSMtKjKXoN60lCqMJrn5Qs9Xhi9wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707815; c=relaxed/simple;
	bh=0VF2LzGBub+hBJUyzP6SWup11ZhL4r4nVCB1/CkpoRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjsUieI6q7hvNNVVf1MDuP8Qzn6GwNFEh4P5COs0kLTGMzZGJ7//ks4mv5tCJ/Umd8bdn3AXqX5vqcfF7KEkdeUGioNJtrLoa57x9264wLVNSk87YDlP+3u4vckEDoaYHrQjfhuRjtBf2SZbw32hTNrfy2EZeXZgKjpDbasyp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfFIbtbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8A9C4CEE9;
	Thu,  3 Apr 2025 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707815;
	bh=0VF2LzGBub+hBJUyzP6SWup11ZhL4r4nVCB1/CkpoRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfFIbtbjuLp5dyaLga1llnqzORM3rPRSicqCTnsnn6Uqnx+DPicBjY6vj9A592E+C
	 YBD/6l5xjJ9mUozyukqQX5EgCLbObaN+a/iXUzD9+EyWxsRtS1Cg8WQ4hD/rhHTDqL
	 uEpiXcqPp7NnAl4i0SDCn0WQLRNJyNedV/hPFdanM3b4Ngg6fnSdOeApxwBtRVibAn
	 WaVpiBBjZkcDpBBrd9vuYyJ6+28FEkO1USyQzpunXbIqaG/+K6BdXwdx0DQqcmUqox
	 tF8BtfMKaw2jBzmqMJrlwj0ZVjynFLURvdBW/lDK5ko9PBwSe0AaI++sGz+4jMOAMd
	 0WPnxayo/KoNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 37/37] tpm: End any active auth session before shutdown
Date: Thu,  3 Apr 2025 15:15:13 -0400
Message-Id: <20250403191513.2680235-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 7df7abaf3e526..87f01269b9b53 100644
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
2.39.5


