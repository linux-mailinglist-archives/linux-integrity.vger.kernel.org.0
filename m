Return-Path: <linux-integrity+bounces-7071-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA5B56ABA
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EF93BC302
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAD2D1319;
	Sun, 14 Sep 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg6q5pOO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475625EFBE;
	Sun, 14 Sep 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869575; cv=none; b=uXF5krzw/6W8NB7fkEfRgCXgiCtOyJvOkNKBhrpmPpaKyqVH6klGekpbA7RAfiKFRKhs5qPib1QQ1dDr1H/LQw/Aias/pI6qdwJuw9qRcC3tNr4Gmop2dsqYQ9wSDZ+i5S8JVKDXYRmYAJdhtKpMtvX/WChzbeJKRw9nuS1curw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869575; c=relaxed/simple;
	bh=QTWm3SlTvXKB49umrEkl2ESw+wFMXCFy0QzNstwdSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftyCn2C9Q0wV2z6B5qluIuPs7q2Yj9Loq5c+UpmHqDDJVpy7RstH3YfLY5vJ0Id3sCbl5ZkZSHLt83wqszHmOzEJXBHgGvIb368sHGpx3TtduDTLZ7gdeHrTJQELp2n5GpekzG+wr9jxXlqZP8PX9kiO7mXfl9sIRq2FnsEJBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg6q5pOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80E2C4CEF0;
	Sun, 14 Sep 2025 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757869575;
	bh=QTWm3SlTvXKB49umrEkl2ESw+wFMXCFy0QzNstwdSrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg6q5pOOrkbzJLe4Yk7575k9s0+3bBv2XvtrkfkiX1w6K0ZX+fqlMonsEcQtUuuTo
	 LnJJtpMCGB6n1Zaxwaf9cUohUyFRGm5wbNxxzughRjVTzcDeR5ivj1jYLUREnSastd
	 GuOsz1U3PfU+C6z+cEsW94mSWFUEcJAyl37jrWY+3c5V4vJW/ANONjy0IlhStirGCG
	 WwsG94HAYOSFyKPmDiuV70FWHS+Ru4NAV0DNxF3L0Q2ZaB2gCbikZLudeQLMmo3CeR
	 jQ7ig5fn6945HkBzN3CIvrSiuGRK6I1uOVkExSCh83D3z3INtAaN9IB3ogu7OLVD1t
	 Tsh4FQCFJURmA==
Date: Sun, 14 Sep 2025 20:06:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Mark Brown <broonie@kernel.org>,
	linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <aMb2A5KzQJNx3daG@kernel.org>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMLUIVjHZ6CFvd33@fue-alewi-winx>

On Thu, Sep 11, 2025 at 03:52:33PM +0200, Alexander Wilhelm wrote:
> Hello devs,
> 
> I'm trying to bring up the SLM9670 TPM 2.0 device connected via SPI on a QorIQ
> T1023-based board. Pin control is fully configured through the RCW, so I haven't
> added any additional properties in the device tree. The SPI controller accesses
> the TPM using `#CS0`.
> 
> However, the driver reads an incorrect vendor ID (0x1000000) and hangs during
> the startup sequence. A logic analyzer shows that the chip select line goes high
> immediately after transmitting 4 bytes, which, according to various forum
> discussions, does not comply with the TPM specification. Unfortunately, I
> haven't found a definitive solution to this issue.

So, at least the vendor ID is bogus meaning that TPM driver is doing
right thing.

> 
> Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a hardware
> limitation of the T1023? I've come across some suggestions that involve using a
> GPIO as an alternative chip select instead of the one provided by the SPI
> controller. Can anyone confirm whether this workaround is viable? I’d prefer to
> avoid a PCB redesign unless it's absolutely necessary.

My first guess would be that the firmware inside TPM actually does throw
a broken vendor ID but it is exactly a guess :-)

I'll follow this, and please cc me also to future threads but right now
I'm clueless.

> 
> 
> Best regards
> Alexander Wilhelm


BR, Jarkko

