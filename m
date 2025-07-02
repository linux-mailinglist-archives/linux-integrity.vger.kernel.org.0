Return-Path: <linux-integrity+bounces-6589-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA5AF651B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53927521CD8
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD4D2459D1;
	Wed,  2 Jul 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0l3irHS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6311EC014;
	Wed,  2 Jul 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495147; cv=none; b=g6MbZGvtobxb9FJICy7EIq8Bx+um+XImrNdfHprRmUEaBTHs0FP1BJwuvfrYsG2BEOz5Vun+PdffEctceVNFoC98l2C8zMp4Wq6moTHxVnffiOEx//tBSJ0Dru2eZdoSxeawbJ/iXA3kw0+D1hSgwW7VyHchC2vTTRENhD7FAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495147; c=relaxed/simple;
	bh=MwSzMaVxElbMoA80k1apSgysQXQEqvxMNUak62jT0TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuHrewttuqTmYmPwRSFJA+TzQOOfpP3c5+OEG5qzZevePZYQeN8CTALpCn69fH39kS7pdlnz9LjAbezkXJJypxdOfokhORdKcowm0jAUpDwQbraVk4hnf1we4nW3P4uk4WNri8L0bcVToYYBRO9v3zFv5TRuDl06M0w1shen2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0l3irHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA1EC4CEE7;
	Wed,  2 Jul 2025 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495147;
	bh=MwSzMaVxElbMoA80k1apSgysQXQEqvxMNUak62jT0TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0l3irHSIuKJitCC+fz/PUca4JhrF6A12hcwBs7eBf1yWZih4NxOlkv8YokfZHKWE
	 NpqhGqn3j1QGOs2mml7tFRGAjzTq/jwHFZEohhg15dyhgaeTsgv8mpvecQ8IULDfHB
	 gCKfjvxRDoj4q76HD2tciCBBxzliVx1q6G+RyweQ4Clns7F6rpXfzwigGv50ALEtTJ
	 ouEVqkcEe7avVJhgGBuxHySex2eKFzUqD1GR4hp3MGrLdjE77ZGbK9WhoTJs/rntcv
	 nDxjGIos0ccLW6nlcyDluQX24aDt9Uu+MxQm4VFNQz97zIb5j9dcj2VI3of6tStfOg
	 zggxhoclzbszQ==
Date: Thu, 3 Jul 2025 01:25:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Lee Jones <lee@kernel.org>,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <aGWx5-XvdhpLdXEC@kernel.org>
References: <aFs2RDOeOKvWUN2L@kernel.org>
 <20250625080527.GN795775@google.com>
 <aFvhorr3kZSuzVpv@kernel.org>
 <20250625134047.GX795775@google.com>
 <aFwsIs6ri3HZictC@kernel.org>
 <20250626103030.GA10134@google.com>
 <aF0oHDVQKVfGZNV2@kernel.org>
 <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
 <aF2Rn0R4AlopEwz8@kernel.org>
 <86b5e396-54d4-7b36-8848-06f41083ba59@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86b5e396-54d4-7b36-8848-06f41083ba59@loongson.cn>

On Fri, Jun 27, 2025 at 02:46:11PM +0800, Qunqin Zhao wrote:
> 
> 在 2025/6/27 上午2:29, Jarkko Sakkinen 写道:
> > On Thu, Jun 26, 2025 at 08:48:35PM +0800, Huacai Chen wrote:
> > > But there is another coherency, you can see this in the 1st patch:
> > > 
> > > +static const struct mfd_cell engines[] = {
> > > + { .name = "loongson-rng" },
> > > + { .name = "loongson-tpm" },
> > > +};
> > I thought already after ffa driver from ARM that I need to fix up
> > the naming a bit before it explodes. Thus, I'll stick to this.
> > 
> > And e.g., I could easily find DRM driver with opposite order.
> Next revision:
> 
> +static const struct mfd_cell engines[] = {
> +	{ .name = "loongson-rng" },
> +	{ .name = "tpm_loongson" },
> +};
> Then
> "loongson-rng" can match MFD and Crypto subsystem naming convention.
> "tpm_loongson" can match TPM subsystem naming convention.

Great, this works for me. Thank you, appreciate it!

> 
> 
> Thanks,
> Qunqin
> 
> > > Huacai
> > BR, Jarkko
> 

BR, Jarkko

