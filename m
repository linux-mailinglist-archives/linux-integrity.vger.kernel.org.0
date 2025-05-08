Return-Path: <linux-integrity+bounces-6161-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04748AB0429
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F27A189EAD6
	for <lists+linux-integrity@lfdr.de>; Thu,  8 May 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856028C02F;
	Thu,  8 May 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBAemuV/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363028AB0C;
	Thu,  8 May 2025 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734178; cv=none; b=UPfWOanqW5WJGso1NKqZHW+gDsLy8ehs/fE9pyT71KS6rdbgtLh0LWNd0f3V1nLolWNywWjlikBDf6kfUKmy14f7HlPveyHDDqNbAAwZ3hjM+ViEZxqnVQ1zvjCKSgariNix0vYVhxF9RvZCMkwqfq0Kg1iXxsjy/Qp5VOOq1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734178; c=relaxed/simple;
	bh=L8Vy+fp9wopLeLrPR788zu1k2LSwWnt9YjiccV1N4F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLHoi7p92VtOkxonNqxejy90Mk/tOrhpklFofI4ygJmmLZ3Si5qgaHLn4unPARifOue1kuu3YLuvoib98mJDDWidFETE+6ai9srCDhBztwRB1Z3pTijlMxuD2r1NFjvgxghZF3XrQEICeiyIzbVobrVIMvnKKWRTVOCrnDzmZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBAemuV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E081C4CEE7;
	Thu,  8 May 2025 19:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746734176;
	bh=L8Vy+fp9wopLeLrPR788zu1k2LSwWnt9YjiccV1N4F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBAemuV/4TTxH1AScYClBkNFj5f3qiUX5XN8QXHG2Cd7yrX4pJIawimMim9n3/407
	 ke/YVdOALeEJchebOPcU1d7/vWGDMIi5Yjfs1OC0sPyDc6I/EcFvt15CZHokiYlzTe
	 1b7yI1tMdOMsZqXtKJvX8WWAizJ6WaQlPZH8OqICGKpM/BLy0288hEY69M30qihn4j
	 mf+YWcldYkdjwUP9km6UFDAk0CdqvxzA4rbSF1G3VniP4/io2ddxDDvJGdJoA8vrey
	 mUW0FWOdEVVHX14kiD1OHyID1o0VxD9+LJueo2nZ+rLqiSaewY39/CqXUhFtfsgUGi
	 9NxzNCFoO3DaA==
Date: Thu, 8 May 2025 22:56:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, lee@kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <aB0MW6kQJHYW9LWi@kernel.org>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
 <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>

On Tue, May 06, 2025 at 04:13:04PM +0200, Stefano Garzarella wrote:
> > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> > +
> > +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> 
> Should we limit the memcpy to `count`?
> 
> I mean, can happen that `count` is less than `cmd_ret->data_len`?

It should check-and-fail:

	if (cmd_ret->data_len > count)
		return -EIO;

Thanks, this was a good catch.

> 
> Thanks,
> Stefano

BR, Jarkko

