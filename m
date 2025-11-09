Return-Path: <linux-integrity+bounces-7609-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D7C43872
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 113FC34751B
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887221FF55;
	Sun,  9 Nov 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsWT4CJc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82334D3A9;
	Sun,  9 Nov 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663408; cv=none; b=CREf8ZQDC7Hew/5WVr3nXSnwtkAkQAJP9NUPL8ep55+B6uh3LFvRrNPmIr8bS6slecmekN9h+iEdq3194uVSYeYbpTNfpGfpoQM8qXBuinrrmQn6e+eoHQTeJAog+aOBAkepGhErPsNEaQf++ddLRWCWGwA5h4A4ajx+VZBwOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663408; c=relaxed/simple;
	bh=5CbNfJSCxl8HnzpXwbj6AAiDFFskY5T1/xV5lkIEmYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV9jRQ6nz28oR5IRk9miL1sBuWPCQx4Ats4Pqvqxw6X9+MTxLGlWmOtu49SidWjgLrxIw75I3n3gJfKWynuGL0yXlRR79B36ENwJjU9FO/Cc+HvN1G8IZ+mL5l8MjKrmuA0ykzj2XV2br3u203QofAy4C3k52FZo5P2R4r8TbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsWT4CJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB04C4CEF8;
	Sun,  9 Nov 2025 04:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663407;
	bh=5CbNfJSCxl8HnzpXwbj6AAiDFFskY5T1/xV5lkIEmYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsWT4CJcOnoXmiMm7bX3qTOENwIr71B6rdC5ssF0Hglo1gwuLcslrSoalIOlQcTj3
	 qROtz73xYD/cMkB4++r3Uelu/oA51M0+S3zb6/seEtoJDMkn9MI9mnmMH5+fgKx6Yg
	 hZ39g+K/Ng4L56glUYuIZqOU+rVE4URpH0XgcNgYuoGDzRbqNvCvwpr7D0d2ACIQYA
	 QV7W45qHee1T+qIhLUPYjC0u/C9kMjd1s8ouDEM5FxnGdYEnkLgK3Gwi4nDqWlEWJD
	 JM8HGcF6Es08PYV06Y22ab4Q5HporTmG9QxkD/DZHfjh4RFSRlhI8MU7SjGwVl3V/9
	 zemUw3GDPDIlw==
Date: Sun, 9 Nov 2025 06:43:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <aRAb7KEPmPmoyQbm@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>

On Tue, Oct 28, 2025 at 06:46:39AM +0100, Jan Kiszka wrote:
> On 27.10.25 20:51, Jarkko Sakkinen wrote:
> > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
> >> the current time epoch to its NV storage every 4 seconds if there are
> >> commands sent to it. The 60 seconds periodic update of the entropy pool
> >> that the hwrng kthread does triggers this, causing about 4 writes per
> >> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
> >> for its backing NV storage.
> >>
> >> It is therefore better to make the user intentionally enable this,
> >> providing a chance to read the warning.
> >>
> >> [1] https://github.com/Microsoft/ms-tpm-20-ref
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
> > writes NVRAM,  then the implementation is broken.
> 
> It's not OP-TEE, but it might be indeed an artifact of the reference
> implementation that the fTPM is using because it is also targeting
> simulation:
> 
> https://github.com/microsoft/ms-tpm-20-ref/blob/ee21db0a941decd3cac67925ea3310873af60ab3/TPMCmd/tpm/src/main/ExecCommand.c#L99
> (Page 942 in [1])
> 
> -> ... ->
> 
> https://github.com/microsoft/ms-tpm-20-ref/blob/main/TPMCmd/tpm/src/subsystem/Time.c#L68
> (Page 1075 in [1])
> 
> > 
> > Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
> > distantly relates on using NVRAM.
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
> > 
> > BR, Jarkko
> 
> Given how detailed [1] is, we likely need to address that directly there
> to avoid spreading this issue into fTPMs. Fact is, that there firmware
> implementations out there which exactly do what [1] suggests: writing to
> NV every 4 seconds on every command.

We don't reference code as a certified hardware product, sorry.

> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

BR, Jarkko

