Return-Path: <linux-integrity+bounces-7146-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9BB821FB
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA41324CDF
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F702DCBF7;
	Wed, 17 Sep 2025 22:13:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598830BBA2;
	Wed, 17 Sep 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147206; cv=none; b=nUNxRgOdrukHygfjeRRoXtxGZ6Xlq0EIwoAPj8H8NE9/pM90ajTDBD2ICw++GjSzEunJSQkBUt3IaAgz13o6PoU2/tclVJ1gXEqVKJDSz6dK+nq6LkAYLASnfi0sNLD2q0XxH4QP40I8srQShbVUCpM4RRH1NvNU3D0u8lqkA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147206; c=relaxed/simple;
	bh=GrdDBAfmSXiAltqk82o1oRjarAsneKhZi0ywhKVk+a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDicY2tU6X8nWZ+21E03kB+K89IzspjqGlrujCD0rw2zQZoRgdMaKWR9dtZBLaKM9DbvpnG7Q18/F1b5AkyDO/BsNBtkls8mo48LvdTirn/w8rAnAIhFBsCNZyOUpEC3+9IVo6YjPph7GX60NoTilGMnN86MaPCwlOT+Otb1Ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af79c.dynamic.kabel-deutschland.de [95.90.247.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C798861E647BB;
	Thu, 18 Sep 2025 00:13:05 +0200 (CEST)
Message-ID: <53b303e1-4e75-4fb1-a700-ba4011c02e26@molgen.mpg.de>
Date: Thu, 18 Sep 2025 00:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis: Fix undefined behavior in
 tpm_tis_spi_transfer_half()
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 kyarlagadda@nvidia.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Justinien Bouron <jbouron@amazon.com>
References: <20250917153022.18567-1-gunnarku@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250917153022.18567-1-gunnarku@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gunnar,


Thank you very much for your patch.

Am 17.09.25 um 17:29 schrieb Gunnar Kudrjavets:
> When len is 0, the while loop in tpm_tis_spi_transfer_half() never
> executes, leaving ret uninitialized. This will lead to undefined
> behavior when the function returns.
> 
> The issue was introduced when tpm_tis_spi_transfer() was refactored
> to call tpm_tis_spi_transfer_half() or tpm_tis_spi_transfer_full().
> While ret is properly initialized in tpm_tis_spi_transfer_full(), it
> was missed in tpm_tis_spi_transfer_half().
> 
> Initialize ret to 0 at the beginning of the function to ensure
> defined behavior in all code paths.
> 
> Found by GCC 14.2.0 static analyzer with -fanalyzer.
> 
> Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>   drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 61b42c83ced8..1b6d79662ca1 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -85,7 +85,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
>   	struct spi_transfer spi_xfer[3];
>   	struct spi_message m;
>   	u8 transfer_len;
> -	int ret;
> +	int ret = 0;
> 
>   	while (len) {
>   		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

