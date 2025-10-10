Return-Path: <linux-integrity+bounces-7411-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7EBCC056
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 10:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82807422139
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5526E6F8;
	Fri, 10 Oct 2025 08:03:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A21FF7B3;
	Fri, 10 Oct 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083385; cv=none; b=Njf0G2bqdARsVo1uTV1loyoVzVsz/T5dAznw/tKWBo8ITQXW/uk4dhQPGNVQqspOgsBqGCcJEjTXPW+3RAIVLCkDN2wqmj1MrwfojuHWigwaBeCOPNuHjxVD3d1o8dssar013A7viR6Og8SoaypB5u/UmK958D+6rYZcgydT314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083385; c=relaxed/simple;
	bh=yrH5cwTvmAFrqnJF1IG6QFpCBnGkg3t61LnX9CmgLiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyTlaUas2b9TEVviWqL9YfCXqMQcR8+1cWQLtFCM9optzhq2e6g8fxHH7wXKRde7/vkUEfIGq5Ttut9ziNiuYeRs5KbKegDNPtEFFn2g1Vn/9oBunyLzK1BR1b5Sl3OolgCejq0bif6moGsFvOvkgmo5cb47frzq+evk2tZT+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5b13ae81.dip0.t-ipconnect.de [91.19.174.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA0806028F361;
	Fri, 10 Oct 2025 10:02:07 +0200 (CEST)
Message-ID: <b1fbadb2-235e-4b08-afba-e397c6d076df@molgen.mpg.de>
Date: Fri, 10 Oct 2025 10:02:06 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tpm: infineon: add bounds check in tpm_inf_recv
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010074956.6862-1-shahriyar@posteo.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251010074956.6862-1-shahriyar@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Shahriyar,


Thank you for the improved version.

Am 10.10.25 um 09:49 schrieb Shahriyar Jalayeri:
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
> Changelog:
> v5:
> 	- replaced space indentation with tabs before the header comment
> v4:
> 	- removed the curly braces around one line statements
> v3:
> 	- removed dev_err() logs
> 	- added missing "fixes" tag
> 	- described header structure
> 	- fixed commit message length
> 	- removed use of local variable as constant
> 	- fixed check to account for off-by-six bytes
> v2:
> 	- added complete changes in the commit message
> 	- dev_err() logged expected sizes and stated operation is aborted
> 
>   drivers/char/tpm/tpm_infineon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..d76aae08b 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>   	number_of_wtx = 0;
>   
>   recv_begin:
> +	/* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
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

