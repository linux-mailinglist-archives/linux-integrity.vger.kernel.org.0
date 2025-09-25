Return-Path: <linux-integrity+bounces-7276-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D6CB9EFB8
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 13:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8017A163
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F52F39C9;
	Thu, 25 Sep 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwuPGGdv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8728B415;
	Thu, 25 Sep 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800797; cv=none; b=A5xtcCER2eXfmgn67woijLx9LdT4wYYZReh/oASf7l5SJOYul2eQtMiHC8XvyCmz80mJtf57KNsZ5sRcxgpivlorLYEDekEUd5reZJrKqgVWVmWlHRhpYUyGw/7aZNRVcLHl/O5OX5V/EJG99BGHIpLt/8Ussrf/8k0B/Jupk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800797; c=relaxed/simple;
	bh=uIjWLa1dN9i/G0KJUAxVqLgW9tfVxg6BEW2Z0MQba2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m1k55O3m6YKNCL95xEOTaBZk6pjWLdNUo/mPtxa9LAOB8tAwMJ5lA/7HNUJv3Mn5QITg3EsXM+MH56nejakbx5svx3Qf1VG0+TcZXHWoc5vGDdEJIYJqbu+w/QZkTJLuzhzmd08+4CPNpFkPVwbCYS4+25H1ss+ST6Vwyfny89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwuPGGdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D48C4CEF0;
	Thu, 25 Sep 2025 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800797;
	bh=uIjWLa1dN9i/G0KJUAxVqLgW9tfVxg6BEW2Z0MQba2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OwuPGGdvdQUi2oGo7DQ77NBPffsUy1SK+R/3nBa6RnNTk2+C3uqZEGjaEBfW5TL9r
	 DdyX/z7Iuer/X5YWIepLUO4L4VFfIhozDsX2Jo4dqrey1+i/X4G6v2v3ctVlIGkyrd
	 F8DNYyfco72pd3x9Ggds1nIXPHnBHlRFgdt0XvMZWqKHH6RO302ZbZTiODNufG+rnO
	 qj3n020ZBcPs4T3PXopkkT8T8YNs9yT4uC4DsZ6LZtRztuU0swws6uJZFuFLWRy2gH
	 dKiTJkgpdvOlGK2iCQBVnwAqtWgZe/WC5T2wZePhOcUhrk9xBmhQC69jcpd8soPvKn
	 omfHwITChAPqA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>, 
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
References: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
Subject: Re: (subset) [PATCH] tpm: loongson: Add bufsiz parameter to
 tpm_loongson_send()
Message-Id: <175880079495.625134.9934244689955652059.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 12:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-459a0

On Wed, 17 Sep 2025 10:09:00 -0700, Nathan Chancellor wrote:
> Commit 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device") has a
> semantic conflict with commit 07d8004d6fb9 ("tpm: add bufsiz parameter
> in the .send callback"), as the former change was developed against a
> tree without the latter change. This results in a build error:
> 
>   drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
>      48 |         .send = tpm_loongson_send,
>         |                 ^~~~~~~~~~~~~~~~~
>   drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
>   drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
>      31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>         |            ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] tpm: loongson: Add bufsiz parameter to tpm_loongson_send()
      commit: 39377467669197b02479798f49e3f19344155dc9

--
Lee Jones [李琼斯]


