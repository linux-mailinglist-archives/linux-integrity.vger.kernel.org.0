Return-Path: <linux-integrity+bounces-7362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721FBB687B
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Oct 2025 13:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0CE19C6A08
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Oct 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660D2EB861;
	Fri,  3 Oct 2025 11:22:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C00EAC7;
	Fri,  3 Oct 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759490559; cv=none; b=Y7213mIJJWo4UaTRdojRO7zS4t3/oSxhdV+AAH+OElnuOw3TqVpF87nv4wnln0DD27vPsPh4O8MsaHPezTA8O44AungQe6ZlvmEfpl0q+SR+X9QLimi1XCmQuekiVOsh5AcVi5Nif2Y7Y9LEO900n0OmIbeosdzKk8Hw5xOYxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759490559; c=relaxed/simple;
	bh=b6SU5mvE/HkngHcI4P6FuRygtR9g4MgLKx7IYFuXIXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGP3cLJNaC5GqRQqrRzj3GckSjd/NOIVvNCIGY3PFKDq6MdQUihDbMfxhQd3N2tQBDRsUduFB9rwLSb+6+RAlRIJJLk/fq/aSDrn/LOJbwqaWvLmyGUIFq0fbEyhM19A2ms/a4wZT54tAy16ek39s5BOIbV2LCKljj6dXVXSbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.39.179] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A73D56028F367;
	Fri, 03 Oct 2025 13:22:12 +0200 (CEST)
Message-ID: <c0a4d2bb-be78-4aac-b66b-c1eb766e7efd@molgen.mpg.de>
Date: Fri, 3 Oct 2025 13:22:11 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251003092544.12118-1-shahriyar@posteo.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251003092544.12118-1-shahriyar@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Shahriyar,


Thank you for your patch.

Am 03.10.25 um 11:25 schrieb Shahriyar Jalayeri:
> Ensure tpm_inf_recv() does not overflow the provided buffer when
> the TPM reports more data than the caller expects.

Is it possible to enforce this situation to ensure your patch works?

> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
> ---
>   drivers/char/tpm/tpm_infineon.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..eb6dd55ff 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>   	number_of_wtx = 0;
>   
>   recv_begin:
> +	if (count < 4) {
> +		dev_err(&chip->dev,
> +			"count less than the header size!\n");

Mention both values count and 4?

> +		return -EIO;
> +	}
> +

This is not described in the commit message.

>   	/* start receiving header */
>   	for (i = 0; i < 4; i++) {
>   		ret = wait(chip, STAT_RDA);
> @@ -268,6 +274,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>   		/* size of the data received */
>   		size = ((buf[2] << 8) | buf[3]);
>   
> +		if (size > count) {
> +			dev_err(&chip->dev,
> +				"Buffer too small for incoming data!\n");

I’d log both values, and also specify that the operation is aborted.

> +			return -EIO;
> +		}
> +
>   		for (i = 0; i < size; i++) {
>   			wait(chip, STAT_RDA);
>   			buf[i] = tpm_data_in(RDFIFO);


Kind regards,

Paul

