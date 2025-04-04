Return-Path: <linux-integrity+bounces-5598-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB39A7B83C
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 09:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE6A1898075
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426D146A60;
	Fri,  4 Apr 2025 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="o89W3YbK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D202E62B6;
	Fri,  4 Apr 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751693; cv=none; b=t5sqwTZ5SjBn2bw9X8bH4BeutxY2ObP1xYIyJtLB8IoV9Zolemrlb8QgNwiCr4xPEfk/qOvEbSwAlXBG+M7eIDXHMyL5xabvjiYQEigzd4UfIzJcM9vcuF8DfEGpmKl6YqO3PI3ymcQA3ChUFFj2KGhIcvifG8KRtgTHu/MHsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751693; c=relaxed/simple;
	bh=2/JScvOwZ7VhRJQXXo1N+2i+wXcN5K1lBC1eIXdvdQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sViYjZvMbLCE98zv/oTOzHlpi5Ee0qqzqMS6Daa95cKdgO+H7VHPZ4P6LRZUbDffBroKp/+H1hwOPThgCJGFr3c04j4uTINCdDbFmqywvYAn5j7by1xqz6CVtj4twU65O9x1l93Yu0uati0poeqFxG+LgWoN+8e/pOXFboa2OgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=o89W3YbK; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2YdnEUH1wsmqIUpTi67kfYO334IijJ7ao9U93PHnRDw=; b=o89W3YbKJ17EvI3O8gZ7qEoPKY
	bBemwLOdjgi2gxGEa9/8MaV1poqwOQMq7DgL7rnPqHsf0a7XgGgI+OVsum6/KDDS6FP0fMX2BTKRX
	sQuI4w2NyPAIhsMKMcTNWgnfEQb7vgcEAZVG9q2YM2oMcB/7vL/7E5t2ptdW9LArW5t+IHE3o+Peb
	fFH5fW0//sw8xeZWVuPnycrlON1uvlAaMAnEkuYFj0Jf4AYbFyHaGPaOJOmFJsp09Heooe47dadzP
	Dq+jxHBh/uf6kMlf78Y+WwheoOTLt+88lRvPXUmynYUgAECfoV00kCL49xi5hkCqkVbG3ki8ne92i
	6iGlweJA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u0bT9-00EExp-1Y;
	Fri, 04 Apr 2025 08:28:03 +0100
Date: Fri, 4 Apr 2025 08:28:03 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 9/9] tpm: End any active auth session before
 shutdown
Message-ID: <Z--KA3cyFGsqNBKE@earth.li>
References: <20250403192050.2682427-1-sashal@kernel.org>
 <20250403192050.2682427-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403192050.2682427-9-sashal@kernel.org>

NAK. Not sure on the logic that decided this was applicable for 5.4, but 
it's obviously not even been compile tested:

noodles@sevai:~/checkouts/linux$ git checkout v5.4.291
Updating files: 100% (13517/13517), done.
Previous HEAD position was 219d54332a09 Linux 5.4
HEAD is now at 52bcf31d8e3d Linux 5.4.291
noodles@sevai:~/checkouts/linux$ git grep tpm2_end_auth_session
noodles@sevai:~/checkouts/linux$ 

The auth session bits were introduced in 699e3efd6c645 (tpm: Add HMAC 
session start and end functions), which landed in 6.10.

On Thu, Apr 03, 2025 at 03:20:50PM -0400, Sasha Levin wrote:
>From: Jonathan McDowell <noodles@meta.com>
>
>[ Upstream commit 1dbf74e00a5f882b04b398399b6def65cd51ef21 ]
>
>Lazy flushing of TPM auth sessions can interact badly with IMA + kexec,
>resulting in loaded session handles being leaked across the kexec and
>not cleaned up. Fix by ensuring any active auth session is ended before
>the TPM is told about the shutdown, matching what is done when
>suspending.
>
>Before:
>
>root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
>root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
>root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
>root@debian-qemu-efi:~# systemctl kexec
>…
>root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
>- 0x2000000
>root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
>root@debian-qemu-efi:~#
>(repeat kexec steps)
>root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
>- 0x2000000
>- 0x2000001
>root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
>root@debian-qemu-efi:~#
>
>After:
>
>root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
>root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
>root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
>root@debian-qemu-efi:~# systemctl kexec
>…
>root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
>root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
>root@debian-qemu-efi:~#
>
>Signed-off-by: Jonathan McDowell <noodles@meta.com>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> drivers/char/tpm/tpm-chip.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>index 17fbd7f7a2954..b33e938d80e8a 100644
>--- a/drivers/char/tpm/tpm-chip.c
>+++ b/drivers/char/tpm/tpm-chip.c
>@@ -290,6 +290,7 @@ static int tpm_class_shutdown(struct device *dev)
> 	down_write(&chip->ops_sem);
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> 		if (!tpm_chip_start(chip)) {
>+			tpm2_end_auth_session(chip);
> 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
> 			tpm_chip_stop(chip);
> 		}
>-- 
>2.39.5
>
>

J.

-- 
... Inside every living person there's a dead person trying to get out.

