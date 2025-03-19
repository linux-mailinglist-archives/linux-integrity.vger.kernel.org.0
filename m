Return-Path: <linux-integrity+bounces-5324-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6EA69303
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98677A2184
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10D1BD9C6;
	Wed, 19 Mar 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="IVK3+p1q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943591ACEAC;
	Wed, 19 Mar 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397582; cv=none; b=V9Qfapj3mCR8B+rh6sISEsjZHFdaexdOimHr1SZOvL9hSBCIWQfH9oWi8LOfTBlQC/SzDMVxYwxAQeB1A2eXZBmZN3JVuyG1uA9TzdSkgUDRkn0nGB5kHjylmJVG2K251MMuIBig7xMb0B2fGnpJsNqOwK8SOe1DowP2L13SIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397582; c=relaxed/simple;
	bh=KcHLJ/QsNgOh4B6y7uqMFVsxfiGDWdoCYOH1eLgn4sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2M/Q3wdO3X5sJIDDWVHPdmjcJqmk2NLDKKGLKyi45al5CJio0rESHTBtzrwsiYc6IysMwOzWhRPb7L5m1QVqcbHMLt2tAkhda7W6SZn+k6v7PJ6Hq/W+f9y4PyL/yB4NokoRGuLzyncgfMvAQM3nVqVhowZnjoXBfffJGDoLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=IVK3+p1q; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fTZgjwps+RlG0PmK2JugpS7IRw2AAcUb8lLUJBEKxA8=; b=IVK3+p1qUHnHkaNIPd6At4s7D0
	M6OuLHW9vI+rtqJU9/y5cYcsVqpkf5vH15saCfS5YTw7LhM0HlmGJu+q+TUTExmB4qn8QsYqFEQS/
	YiqWUcC+R/FnOx8GmZJuV+nR6uiNT2FPiO395lbSxaEB2aK9cBryUuri7f63sAWB69s78uqC3tDwt
	Fm79TPg2ucZadlPyFvnqwrtDiqCDn9J1+yNbZdughJxZnJSk+zg4jS/O4EN6UmG0UrvH13d9fnd+n
	jzvxxaVS3N8VhJzwlS5bcotIKbqgi7kSlueAVJKu+2NyK6vuCIF4GQVqp+tRSw14Tg0kHS7IG7NBY
	Yo9s8G4Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tuuXw-009gil-2o;
	Wed, 19 Mar 2025 14:37:28 +0000
Date: Wed, 19 Mar 2025 14:37:28 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: End any active auth session before shutdown
Message-ID: <Z9rWqCutMrz6sAgQ@earth.li>
References: <Z8rls0QkzOliECp_@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8rls0QkzOliECp_@earth.li>

Gentle poke about this patch, which I haven't seen any feedback for.  
It's causing us a problem in terms of having a string of kexecs result 
in the kernel no longer being able to talk to the TPM with an HMAC 
session, and the rng random data fetches from the TPM then failing.

On Fri, Mar 07, 2025 at 12:25:23PM +0000, Jonathan McDowell wrote:
>From: Jonathan McDowell <noodles@meta.com>
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
>---
> drivers/char/tpm/tpm-chip.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>index 7df7abaf3e52..87f01269b9b5 100644
>--- a/drivers/char/tpm/tpm-chip.c
>+++ b/drivers/char/tpm/tpm-chip.c
>@@ -300,6 +300,7 @@ int tpm_class_shutdown(struct device *dev)
> 	down_write(&chip->ops_sem);
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> 		if (!tpm_chip_start(chip)) {
>+			tpm2_end_auth_session(chip);
> 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
> 			tpm_chip_stop(chip);
> 		}
>-- 
>2.48.1
>
>

J.

-- 
I've got a trigger inside.

