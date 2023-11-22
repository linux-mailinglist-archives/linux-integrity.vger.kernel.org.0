Return-Path: <linux-integrity+bounces-181-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C87F3E9F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 08:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5611C209EC
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494418C0F;
	Wed, 22 Nov 2023 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FD1A4;
	Tue, 21 Nov 2023 23:11:00 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2625861E5FE01;
	Wed, 22 Nov 2023 08:10:35 +0100 (CET)
Message-ID: <c9a92192-ee28-4bbf-a02d-1df0d5822027@molgen.mpg.de>
Date: Wed, 22 Nov 2023 08:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
To: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Hermin,


Thank you for your patch.

It’d be great if you removed the dot/period from the end of the commit 
message summary/title.

Am 22.11.23 um 07:55 schrieb Hermin Anggawijaya:
> Before sending a command to attempt the self test, the TPM
> may need to be started, otherwise the self test returns
> TPM2_RC_INITIALIZE value causing a log as follows:
> "tpm tpm0: A TPM error (256) occurred attempting the self test".

Please document on what platform this happens.

> Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
> ---
>   drivers/char/tpm/tpm2-cmd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..0530f3b5f86a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>   	if (rc)
>   		goto out;
>   
> +	rc = tpm2_startup(chip);
> +	if (rc && rc != TPM2_RC_INITIALIZE)
> +		goto out;
> +
>   	rc = tpm2_do_selftest(chip);
>   	if (rc && rc != TPM2_RC_INITIALIZE)
>   		goto out;
>   
>   	if (rc == TPM2_RC_INITIALIZE) {
> -		rc = tpm2_startup(chip);
> -		if (rc)
> -			goto out;
> -
>   		rc = tpm2_do_selftest(chip);
>   		if (rc)
>   			goto out;


Kind regards,

Paul

