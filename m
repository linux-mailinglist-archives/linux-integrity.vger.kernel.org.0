Return-Path: <linux-integrity+bounces-7277-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F63B9EFBB
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234101BC5FE9
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD292F5320;
	Thu, 25 Sep 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNGQvdGX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAF2E7BBA;
	Thu, 25 Sep 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800841; cv=none; b=juGVKkdqABUVOjq715NYUMehsgmGTUAXUTgCu5XkFmCu43ynyaJAg3niV6LPEvpJpN/xDy57nPbaAAUkgZ5Kaf94YPW+76L5GJZF/Gfs/4y2FbN1RAFiSem/NKHAgdK389wDvd3lj3oZWzz51ipBWlYEXciNqX5zyfaaxjl0RXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800841; c=relaxed/simple;
	bh=Q3mnrcj8p/uRIBTdnzGuB5Det4n2w9w+3xRaLJY2D3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJQZyLSP3lPaFfM7w1glNQX4Whj97UFT90GvqdvzkCtyl1uIMZljOiGxtdJs7VwlsRSr5kh2ZrGvIFLccxPPy7giWuxWtSnhtYqz+9rodUwWqwe0SuZmhxJnjPKTab3Z2gVnmzSmpPQ+7F0HpmXhgiRR9NSSRUTvSgN60yFu5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNGQvdGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5E2C4CEF0;
	Thu, 25 Sep 2025 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800839;
	bh=Q3mnrcj8p/uRIBTdnzGuB5Det4n2w9w+3xRaLJY2D3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNGQvdGXwm6ZVpTcPjbD5Jnno6KeDcj08N6lkPwzK/2RPHTvoebC3gvA5IiTqlsna
	 PeJetyH52SLwwzfj8Da1MJti41CDQG0FOobCzw4XSVVdPAvzzTu4B5YFfR24kK4Br5
	 xcM7Bgrbmijb6l0Kl60Euuvf8bVN7ezsly0SjvDBEr18dFICIVQT2HgMEU2tpVDbOB
	 UveaMEe//PHt12z/zPyNYF6R3ZYst/WNva5koGGEg9tIXnE6FyldFNi02X6ECujBn1
	 oax5mc70SipIvNnnNT1vGEbOV4QGjeqez15Zp9G8KSJn5b/0xZJM6bJzILFvZkkEn/
	 Ax/SdTY94DcIA==
Date: Thu, 25 Sep 2025 12:47:14 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] tpm: loongson: Add bufsiz parameter to
 tpm_loongson_send()
Message-ID: <20250925114714.GE8757@google.com>
References: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
 <175880079495.625134.9934244689955652059.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175880079495.625134.9934244689955652059.b4-ty@kernel.org>

On Thu, 25 Sep 2025, Lee Jones wrote:

> On Wed, 17 Sep 2025 10:09:00 -0700, Nathan Chancellor wrote:
> > Commit 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device") has a
> > semantic conflict with commit 07d8004d6fb9 ("tpm: add bufsiz parameter
> > in the .send callback"), as the former change was developed against a
> > tree without the latter change. This results in a build error:
> > 
> >   drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
> >      48 |         .send = tpm_loongson_send,
> >         |                 ^~~~~~~~~~~~~~~~~
> >   drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
> >   drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
> >      31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> >         |            ^~~~~~~~~~~~~~~~~
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] tpm: loongson: Add bufsiz parameter to tpm_loongson_send()
>       commit: 39377467669197b02479798f49e3f19344155dc9

Send for testing.

Will follow-up on the PR once complete.

-- 
Lee Jones [李琼斯]

