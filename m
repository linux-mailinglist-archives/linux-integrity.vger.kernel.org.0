Return-Path: <linux-integrity+bounces-4927-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73263A3DC3B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 15:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D3D164B26
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983251EF092;
	Thu, 20 Feb 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp82GZDt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AE1B85CC;
	Thu, 20 Feb 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060764; cv=none; b=EGNWaADFUh976WPB5H4p2UaHC4P1o6DwOFKrzagrxXxPX0gTgBOugA2T3vOOqxUmqyDkCSxzvdkyTlJwyEBNZNtapS2c+edEtc5OFuSTvTuA6ns8mSybSnstrmfzc4aQszj82XvZUjblbU50dM3nuA7xmXScDWhDP0QegwaFrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060764; c=relaxed/simple;
	bh=CgMhOLPIqnUrQGVtHOebIzfzAW0Y/EgFH2JAI5ghWFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZHfdnoEQtQqOP0vpRPnv5OPUGfPzunKd3LmlgD5ahlXvKJabHLuOJYY5pTT9hKVOO74xwov7gS0EWskIjt5IZ1ewgZzQQRQ/5iIOWT8JXAGskVRijQGHxq64UVX8jkAFMHnZZhenfscYz6AAEvR4iZTTp1JANcc0j+30paByZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp82GZDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C41C4CED1;
	Thu, 20 Feb 2025 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740060763;
	bh=CgMhOLPIqnUrQGVtHOebIzfzAW0Y/EgFH2JAI5ghWFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp82GZDtwZjIWdJWnPhv6HXLzuBd4Sg/sAZInCNWHt3XxsRyEJICw3ScJkMeJMHsU
	 qscALgBk3I+6fW1qIG1cyUH/fnMkeHssycGVm5Crk4KIpLpI9x/Pa1IhL/BZKbtVdK
	 tNzZrVoDAG1kJ6lFUS+5FZM/dfz7iVqbjNbPvNNU3YCiI86u6zQXXAvVXOKO5vzciV
	 UnPGI91eme0KXlHtyOvJ5IaZ+rWJGG/LvKNZieOBTkRK4WDVtbDGOrfcIxEj9I8iw1
	 gbY2L2Pmyazs7t5vtMtodyrAhFwyJH/JndFzm3Bbyb/FbO212W3t/hEsIltaIaieIV
	 VHPn8GlKtsNGA==
Date: Thu, 20 Feb 2025 16:12:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH V3 5/6] tpm: Add a driver for Loongson TPM device
Message-ID: <Z7c4V3vW5BV5XbdC@kernel.org>
References: <20250219073350.16915-1-zhaoqunqin@loongson.cn>
 <20250219073350.16915-2-zhaoqunqin@loongson.cn>
 <Z7XgLNU1xXqgOBIL@kernel.org>
 <4e0a3b40-07b8-06bf-8814-a121308ebf69@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e0a3b40-07b8-06bf-8814-a121308ebf69@loongson.cn>

On Thu, Feb 20, 2025 at 07:23:42PM +0800, Qunqin Zhao wrote:
> 
> 在 2025/2/19 下午9:44, Jarkko Sakkinen 写道:
> > > +
> > > +static const struct tpm_class_ops lsse_tpm_ops = {
> > > +	.flags = TPM_OPS_AUTO_STARTUP,
> > > +	.recv = tpm_ls_recv,
> > > +	.send = tpm_ls_send,
> > > +};
> > > +
> > > +static int lsse_tpm_probe(struct platform_device *pdev)
> > tpm_lsse_
> OK.
> > +
> > +static struct platform_driver lsse_tpm_driver = {
> > +	.probe   = lsse_tpm_probe,
> > +	.driver  = {
> > +		.name  = "ls6000se-tpm",
> > +	},
> > +};
> > +module_platform_driver(lsse_tpm_driver);
> > +
> > +MODULE_ALIAS("platform:ls6000se-tpm");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> > +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> > Remove MODULE_AUTHOR fields. Git encodes this already.
> 
> Do you mean that "modinfo" will still show the author after removing
> MODULE_AUTHOR fields?

What is the utility of showing that? Nobody ever updates those in real
life, so you really can't trust them anyhow. We're better of not showing
anything at all.

> 
> > 
> > > +MODULE_DESCRIPTION("Loongson TPM driver");
> > > -- 
> > > 2.43.0
> > > 
> > Prefix all with tpm_lsse instead of tpm
> 
> OK, thanks for your comments.
> 
> BR, Qunqin.
> 
> > 
> > BR, Jarkko
> 

BR, Jarkko

