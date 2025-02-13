Return-Path: <linux-integrity+bounces-4814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63ECA350F2
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96516CE63
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47200266B59;
	Thu, 13 Feb 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd+3PEos"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3D1714B7;
	Thu, 13 Feb 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484606; cv=none; b=HmFQnBiIiJnXuNmsFZlJZgvemuZ5LgLzhRK1fxky8F8oieRjCFa6eWkqj069IfFofrmMIZcLFAKJfQs/J/NBICkfbZeLHtnxkpMmFLHZztCionY5WafWLa2tW1xZDAhhBlEjU+2iae+5loxYPYKP86k3WpN4aNNlfUDbQEKHYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484606; c=relaxed/simple;
	bh=tPJVDzkw9dZftCkEk7dg854tzrJWiG4yXXnjKTij19I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOzm+U2/rqVPo76OGg7pLIhZanI1F0gHxnPEfNr7/Zz2rrD/nPttrDDGy7pIpTqZAB7dr6NBg2gLfLUcUwqS0JL4KzxTXUCnSMUUMlxCfRTIgVdBSnZ7ORQlfJVbHuc6PZaw5u+il66ajjjV1ENG3PT+M7YdTjxLd84LesTJI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd+3PEos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D4C4CED1;
	Thu, 13 Feb 2025 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484605;
	bh=tPJVDzkw9dZftCkEk7dg854tzrJWiG4yXXnjKTij19I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nd+3PEoswO2bSOWtqU91NTcMcpUKScLnvzmglkXZGBL/lgGtdEyJncCYtzQkFC8y2
	 ztBkkIWQsV6EOVNrYZWhBziAfWf9V2AVNhlhG0VAgJo5B+A3xmzC7W2KWzgTT2m5T3
	 Lcb1H7+kkPNkkeKrEpwz6SyO1Pxd9oFfRa8ZhpqtIm2lIYsjZoBR/2unKLf5BaiMwF
	 h3t3dwuiqVza4mAN4PuCyNYOqT81ibL/uKP5IMBh5UXOV5qcOBuSQ/pBc3DbcjYa3n
	 C3A24+zB5drv7F1CS7O4vg9y/RCBv94jGUjJeWXio4on9p3Ap3ydkgJ8yNRQOVc0ae
	 mumf/l3P9BLtA==
Date: Fri, 14 Feb 2025 00:10:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH v2 3/3] tpm: Add a driver for Loongson TPM device
Message-ID: <Z65tuC722nnuhWEO@kernel.org>
References: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
 <20250212033113.15137-4-zhaoqunqin@loongson.cn>
 <Z60SfDaWnbgddUnA@kernel.org>
 <c825cd7b-a255-d296-baa0-c1a746cb1bce@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c825cd7b-a255-d296-baa0-c1a746cb1bce@loongson.cn>

On Thu, Feb 13, 2025 at 11:56:25AM +0800, Qunqin Zhao wrote:
> 
> 在 2025/2/13 上午5:28, Jarkko Sakkinen 写道:
> > On Wed, Feb 12, 2025 at 11:31:13AM +0800, Qunqin Zhao wrote:
> > > TPM2.0 is implemented in Loongson security engine. This is the driver
> > TPM 2.0 or just TPM2 (either is fine with me). Quick reminder what
> > Loongson security engine (I could not know that and it would be nice
> > to have that in git log).
> 
> Looks like just TPM2 is better.

Either is fine :-)

> 
> Some explanations about Loongson security engine will be added to git log.
> 
> > 
> > > for it.
> > > 
> > > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > > ---
> > >   MAINTAINERS                 |   1 +
> > >   drivers/char/tpm/Kconfig    |   9 ++++
> > >   drivers/char/tpm/Makefile   |   1 +
> > >   drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 115 insertions(+)
> > >   create mode 100644 drivers/char/tpm/tpm_lsse.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6493d58436..6aad0f08ad 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13484,6 +13484,7 @@ LOONGSON CRYPTO DRIVER
> > >   M:	Qunqin Zhao <zhaoqunqin@loongson.com>
> > >   L:	linux-crypto@vger.kernel.org
> > >   S:	Maintained
> > > +F:	drivers/char/tpm/tpm_lsse.c
> > >   F:	drivers/crypto/loongson/
> > >   LOONGSON-2 APB DMA DRIVER
> > Probably MAINTAINERS update should be a separate patch.
> 
> Some  MAINTAINERS updates are not  separated form the driver patch.  Like
> the submit of "drivers/mfd/max7714*".
> 
> So it seems whether the updates to MAINTAINERS  are separated or not is OK.

I'd prefer them separated from code changes. They are separate tasks
per se.

BR, Jarkko

