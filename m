Return-Path: <linux-integrity+bounces-6554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D624AEA569
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906161C4297E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D42EE610;
	Thu, 26 Jun 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obXnOxuW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439072EE5FD;
	Thu, 26 Jun 2025 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962596; cv=none; b=kOJrNLa55dSILCQ9Fk3fm866sc1qxLmgQrqCDuN2HkL+sGuBiJF0bMawHhXoKrk7RmD1LCD8n13y5Mf4VvStZaktRD2sQyjbOTsGL3Fqi0irI2EVEZDsBQaSYuGpoi8IrWLioXix6+CET4YRc2dNq7fEdYnBQ1K+NE4UdXttL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962596; c=relaxed/simple;
	bh=HK6QzKIhv05JjZJ7L2Ck5DIM4l7O08A9SI3fi89DW5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJXKAVR8AWuxM3bhPsLkMU0WuacHno4AEkXd6jrbwzB7Z6GCGcer41IW4P+kJjkPvwak7HI/y7mwhsbMq6Wua2USPqKv9yzCOMGIBm82wK1zawOCKecu1HgeipLTeB2c/Q3mhtRXlmeU/q2mlMzv6e5gzfAEPfSosLqaC2+HqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obXnOxuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E8C4CEEF;
	Thu, 26 Jun 2025 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962595;
	bh=HK6QzKIhv05JjZJ7L2Ck5DIM4l7O08A9SI3fi89DW5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obXnOxuWOpRsPXLqtzOhtEbGgxKFSUsWykj07WB7WD9L1LRdROhvew3rnSywPA1uV
	 jHyC+rml3/9bvz+l3uc5iRuQhzUGflBycOYmpv1b/fShuCXmGcO0w1Q4S9AEN9SsMP
	 y7YAhMudzTqyS5+Php+Xb5USN3HbXxKQ2CvTjoWYl+hMDGHZzM33dlABJcLaEe6UD8
	 cocNBb+WHrhR023BtK20XVVA1Cm1uJzyI3Gd0qSMLmm0FkPtJMrNydE346X9vJoMI5
	 W69JKp0bzo0iVos2V0bcCw7Tw2kQDjyIN18HJmat8MKtiwB2rn1p381NqUFpgxXevl
	 mTcCTL4LGqA0w==
Date: Thu, 26 Jun 2025 21:29:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <aF2Rn0R4AlopEwz8@kernel.org>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
 <20250619025138.2854-4-zhaoqunqin@loongson.cn>
 <aFs2RDOeOKvWUN2L@kernel.org>
 <20250625080527.GN795775@google.com>
 <aFvhorr3kZSuzVpv@kernel.org>
 <20250625134047.GX795775@google.com>
 <aFwsIs6ri3HZictC@kernel.org>
 <20250626103030.GA10134@google.com>
 <aF0oHDVQKVfGZNV2@kernel.org>
 <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>

On Thu, Jun 26, 2025 at 08:48:35PM +0800, Huacai Chen wrote:
> But there is another coherency, you can see this in the 1st patch:
> 
> +static const struct mfd_cell engines[] = {
> + { .name = "loongson-rng" },
> + { .name = "loongson-tpm" },
> +};

I thought already after ffa driver from ARM that I need to fix up
the naming a bit before it explodes. Thus, I'll stick to this.

And e.g., I could easily find DRM driver with opposite order.

> 
> Huacai

BR, Jarkko

