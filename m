Return-Path: <linux-integrity+bounces-7409-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384CBCBE11
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 09:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 200694E8678
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC023F26A;
	Fri, 10 Oct 2025 07:11:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5B1991D2;
	Fri, 10 Oct 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080315; cv=none; b=WbOqSyGwShGxl9sbzqNAoPBsZ7TOVVlIGFlEiUc8q1l+E8PIcKnFn6mlRvf9CdvI5hMfuAYI5anC1vcVzOX6RJk99JKTysCh5gJ6Zics8CJPG9BWxt/iqiYQGnYKtuKdZPGCVKjFzrKZC0UC6Cyllx2Uisk9BgNApUwJ6izN+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080315; c=relaxed/simple;
	bh=ItylXDBQlpp1zycVEsPz4/9Q9VmKWLt1RercsQM9iGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa+bAxzoM/Mupk5RVG+yDFQwuF9hOeQIM9Mp5Z8UGqu5fkxHFV46DTydjMwdB/WS+4DZOej7kdcPZir8m3QEIds9g06PgB+Me+Z+0jzZ0fJECAVDLe+T8ivdyoalqYUnbqecEsahYAbIWf3eRTdeko202E2+acGWJCF4GqkVtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5b13ae81.dip0.t-ipconnect.de [91.19.174.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2EE9C6028F360;
	Fri, 10 Oct 2025 09:11:28 +0200 (CEST)
Message-ID: <3cc8d276-f092-47eb-86d5-fd882692bccf@molgen.mpg.de>
Date: Fri, 10 Oct 2025 09:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: infineon: add bounds check in tpm_inf_recv
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010065252.4377-1-shahriyar@posteo.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251010065252.4377-1-shahriyar@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Shahriyar,


Thank you for the improved version.

Am 10.10.25 um 08:52 schrieb Shahriyar Jalayeri:
> Add two buffer size validations to prevent buffer overflows in
> tpm_inf_recv():
> 
> 1. Validate that the provided buffer can hold at least the 4-byte header
>     before attempting to read it.
> 2. Validate that the buffer is large enough to hold the data size reported
>     by the TPM before reading the payload.
> 
> Without these checks, a malicious or malfunctioning TPM could cause buffer
> overflows by reporting data sizes larger than the provided buffer, leading
> to memory corruption.
> 
> Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
> ---

A changelog would be nice to have here.

>   drivers/char/tpm/tpm_infineon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..0fe4193a3 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>   	number_of_wtx = 0;
>   
>   recv_begin:
> +    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */

`scripts/checkpatch.pl` should have complained about using spaces 
instead of tabs for indentation.

> +	if (count < 4)
> +		return -EIO;
> +
>   	/* start receiving header */
>   	for (i = 0; i < 4; i++) {
>   		ret = wait(chip, STAT_RDA);
> @@ -268,6 +272,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>   		/* size of the data received */
>   		size = ((buf[2] << 8) | buf[3]);
>   
> +		if (size + 6 > count)
> +			return -EIO;
> +
>   		for (i = 0; i < size; i++) {
>   			wait(chip, STAT_RDA);
>   			buf[i] = tpm_data_in(RDFIFO);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

