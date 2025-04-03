Return-Path: <linux-integrity+bounces-5581-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC859A7A96C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A0017879E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBEC25334D;
	Thu,  3 Apr 2025 18:29:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E51253339;
	Thu,  3 Apr 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704969; cv=none; b=koJaPIqely8JMR5n1HLZ0c27QsuKqjn3DTWIOrwMNG/sNZbkWOqThhcTzSrEegKBScV5z2kUDkHRzRwuAiLO7g6kC5c/miCZJhVQUoJ+XKLTy9uZam0IZHEqsgbDlUaYmXVeNCkSosUKVrt8PMNo45kxXpPYaRM68xp/Ux9ciPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704969; c=relaxed/simple;
	bh=6NMfzsl+qbxslM1Q5CA3ElJX9ebSpetzhkAlaotbNOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKyNAIOY5AXitLfwG5ZBe35RJzDF/Wh+UBkO1GN72AIeeIwcKWh7S4bLWE+KKErGeBuw4QJ4RORaDQ1M+qjTY2XCzmQgJ141WSELHRst+d1/V11C21g5T89w+ikoXg1MTpPFO6tItr+n3u09ldJXfB+427BZszDo3kipsYGQzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5ae856.dynamic.kabel-deutschland.de [95.90.232.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C67A61E647B3;
	Thu, 03 Apr 2025 20:28:57 +0200 (CEST)
Message-ID: <4e4640bd-0313-4594-9667-82340ed9368a@molgen.mpg.de>
Date: Thu, 3 Apr 2025 20:28:56 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: tis: Increase the default for timeout B
To: Michal Suchanek <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <Z-6Gau3aCB7B3pB9@earth.li>
 <20250403182519.8412-1-msuchanek@suse.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250403182519.8412-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for the patch. For the summary/title you could be more 
specific by using *Double*:

tpm: tis: Double default for timeout B to 4 s

Am 03.04.25 um 20:25 schrieb Michal Suchanek:
> With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> C) can reach up to about 2250 ms.
> 
> Timeout C is retried since
> commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> 
> Timeout B still needs to be extended.

It’d be great if you could amend the commit message and add the Infinion 
device you have problems with, and maybe also add the error behavior.

> Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> V2: Only extend timeout B
> ---
>   drivers/char/tpm/tpm_tis_core.h | 2 +-
>   include/linux/tpm.h             | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 970d02c337c7..c272c25eb9d4 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -54,7 +54,7 @@ enum tis_int_flags {
>   enum tis_defaults {
>   	TIS_MEM_LEN = 0x5000,
>   	TIS_SHORT_TIMEOUT = 750,	/* ms */
> -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> +	TIS_LONG_TIMEOUT = 4000,	/* 4 sec */
>   	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
>   	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
>   };
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6c3125300c00..3db0b6a87d45 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -224,7 +224,7 @@ enum tpm2_const {
>   
>   enum tpm2_timeouts {
>   	TPM2_TIMEOUT_A          =    750,
> -	TPM2_TIMEOUT_B          =   2000,
> +	TPM2_TIMEOUT_B          =   4000,
>   	TPM2_TIMEOUT_C          =    200,
>   	TPM2_TIMEOUT_D          =     30,
>   	TPM2_DURATION_SHORT     =     20,


Kind regards,

Paul

