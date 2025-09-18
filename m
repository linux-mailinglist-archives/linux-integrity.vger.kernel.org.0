Return-Path: <linux-integrity+bounces-7165-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D280B85E15
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FCD565D73
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD1313530;
	Thu, 18 Sep 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC100AyL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468C306B03;
	Thu, 18 Sep 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210984; cv=none; b=WmEDvBUiocLU3GSImbRJ1OY/i3mq6SM5eJSwmjs/xWXwrSCGivPCaivjMnyno9dFVme1B/BF9GwZSOr4VcMl9sAogGPJWRxmzmW08t3m7OqRiDEFyr9RzZdfG2ii+amNNRJVCTcyhNkUKZqfCOl19tyQyYrb/FQLR/Eehc639Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210984; c=relaxed/simple;
	bh=Jgtrh3PiT1/38zWu/X1See2xjxUOHJSi+5E36xkobyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/pvoRTfzVtgcKBuwPOpb2bNPnq/0VCKYbyHbjiQ1u05yneUCvj9Hs5MMj6FKJxehiNhPFRz3f45vqviFbTpdyNvk1NCuyxu8teoXZOXJvL8t19sVnZVE4XcjDfo8Aa8l0pPbYM0V8IIYYLSMgx7IPI6nMsgQTPdKzXXOywqzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC100AyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C86BC4CEE7;
	Thu, 18 Sep 2025 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210983;
	bh=Jgtrh3PiT1/38zWu/X1See2xjxUOHJSi+5E36xkobyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TC100AyLnFNsIYbskZeZXMVO3WUlkQuNMfj+2zpwvr/G4h0j7FIxfsSQ2TayPVKoC
	 D+A8dJnekKpELxGNQG0gy/6zH2BXPoioaINMRfZPyKWsi7YD3G0rhtiQ4LY0lhrHXN
	 ixpeup+Vsz89nOrKqEIkCatILYyokOpoTdLu9KQjPM/GzBVoss+u8y3SlDzUGxZOEb
	 kAcl+ovuvukogbG1zbKIKgZ0HH8tQ1ske41RRM8NykYYhwKG2fCuyAknfjkWbIcwv9
	 pfTQsXZCBlWWtqQ9ut5QbPT9cvyI8WBrevgKCVYLE/rw9XjnTFhROqT7OsHB0jmZP4
	 vTOTNWiBiythw==
Date: Thu, 18 Sep 2025 18:56:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: loongson: Add bufsiz parameter to
 tpm_loongson_send()
Message-ID: <aMwro27XPfjv-tus@kernel.org>
References: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>

On Wed, Sep 17, 2025 at 10:09:00AM -0700, Nathan Chancellor wrote:
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
> Add the expected bufsiz parameter to tpm_loongson_send() to resolve the
> error.
> 
> Fixes: 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This is in Lee's ib-mfd-char-crypto-6.18 [1] so he will need to take it
> but I have CC'd the TPM folks as an FYI.
> 
> [1]: https://lore.kernel.org/20250902124205.GL2163762@google.com/
> ---
>  drivers/char/tpm/tpm_loongson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> index a4ec23639911..9e50250763d1 100644
> --- a/drivers/char/tpm/tpm_loongson.c
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	return cmd_ret->data_len;
>  }
>  
> -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
>  {
>  	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>  	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> 
> ---
> base-commit: 74fddd5fbab879a7d039d9fb49af923927a64811
> change-id: 20250917-tpm-loongson-add-bufsiz-e43f60016cca
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

Thank you I applied and it's still in time for first 6.18 PR.

BR, Jarkko

