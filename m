Return-Path: <linux-integrity+bounces-7072-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB88B56ABE
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB5D7A54C1
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D32D1319;
	Sun, 14 Sep 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYQ3Kc1r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF736D;
	Sun, 14 Sep 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869733; cv=none; b=fTzQA/gf8NrdeAxFt/G/zkbl+EDh/fnb/JFfNFqOiGCKMDZ74mB+J12zUMEcSWnwvutIASDs2T90Qpz76zvOmKNOUfCVW6FC3Fqzl6dFhrG+lLdMDiSJ7kqCzmPAU7JCYXDf5kIm7qmPGQklvchIeSbIuH2kyst4mHMobJYj3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869733; c=relaxed/simple;
	bh=fGRi7r7UGdfTvtG9WrDVbW6OFN2VqaZtKsuCj4RwQJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkAe17k1lIuTFZCONaGDwskwBYT/XmkrP7yKfy6s5M1xH/Cy61QvqVoAJK6iprWY8BvrP1OnXPsNzDOFt6sNkUYOlqHLXMhkeP0HfHJC4w2zkPDdPayvEHClUwPTwdSZgWb8V3VXR4mvSZnSaD+gqeAWT/q6PDp/p12fT10ydEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYQ3Kc1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80387C4CEF0;
	Sun, 14 Sep 2025 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757869731;
	bh=fGRi7r7UGdfTvtG9WrDVbW6OFN2VqaZtKsuCj4RwQJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYQ3Kc1rdfz64Zw6jS1oG6Isaz5iT8f9/5lLGLoGRuOowmZlHExNqrqofr08pn3j2
	 d1NiVlgOgRb4CQWez5s+tNLIAGNBYLdbhJtGJLypmZOOp4vVIhc8V28GKBfF8MOcLQ
	 IcyQZz/WePKMKxHVtKV7Yk3QUM4Ulph8ga9ERBZe2vuFG9BUg2npgHMGQeqAee0JNU
	 UhKtWnXuom1t7y7IvS+B7KIyHMun17+shetZlM3f4p7UUQJs+/f+842KdeYUbXPSJQ
	 CDq1deWz4OG9orumLhUYKkCXyHLIGw/Xgxob0RkyPX7D7JKoI2/jcVfISPZhegWhGo
	 1+4Xt5aesMMoQ==
Date: Sun, 14 Sep 2025 20:08:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Mark Brown <broonie@kernel.org>,
	linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <aMb2oEN7HPeqQjQE@kernel.org>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
 <aMb2A5KzQJNx3daG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMb2A5KzQJNx3daG@kernel.org>

On Sun, Sep 14, 2025 at 08:06:15PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 11, 2025 at 03:52:33PM +0200, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm trying to bring up the SLM9670 TPM 2.0 device connected via SPI on a QorIQ
> > T1023-based board. Pin control is fully configured through the RCW, so I haven't
> > added any additional properties in the device tree. The SPI controller accesses
> > the TPM using `#CS0`.
> > 
> > However, the driver reads an incorrect vendor ID (0x1000000) and hangs during
> > the startup sequence. A logic analyzer shows that the chip select line goes high
> > immediately after transmitting 4 bytes, which, according to various forum
> > discussions, does not comply with the TPM specification. Unfortunately, I
> > haven't found a definitive solution to this issue.
> 
> So, at least the vendor ID is bogus meaning that TPM driver is doing
> right thing.
> 
> > 
> > Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a hardware
> > limitation of the T1023? I've come across some suggestions that involve using a
> > GPIO as an alternative chip select instead of the one provided by the SPI
> > controller. Can anyone confirm whether this workaround is viable? I’d prefer to
> > avoid a PCB redesign unless it's absolutely necessary.
> 
> My first guess would be that the firmware inside TPM actually does throw
> a broken vendor ID but it is exactly a guess :-)

Ugh, no. Probably it is device tree given false data. I recall we have
some ways to override device tree, so find the data sheet for the TPM
and rewrite the ids I suppose.

BR, Jarkko

