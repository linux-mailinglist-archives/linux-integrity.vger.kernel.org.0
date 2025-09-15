Return-Path: <linux-integrity+bounces-7092-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F478B585D6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 22:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662882A3A7D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC82288EE;
	Mon, 15 Sep 2025 20:15:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A601C5F2C;
	Mon, 15 Sep 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967328; cv=none; b=AdAi9DPBca651EzDRgmGxhkcivx7rU4A8EmTeQ2r1ud5nPt9cYkF4YaOK5pfTky+/V6f7QUmhtbTEdI3r5QVhfz6q/1ZYGOSEkTTsCcOX6kJnDpIc5JToWJ1B+IRmdEmrUCmVLxSbE7do5dS0pbD88bQJjx3fQeB6TfA3DHKdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967328; c=relaxed/simple;
	bh=GEvlCbW0Iy+b8ikUglHc1z5oUArAVq7KRM9VrsPA6gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vxg7mXi1SFKtVLdVTIaX54e0KT8dUBB4CUPggpu5DnKsbAZdCCuWe6sBKkNtLkXFCvfI1kBtwJQUE1E9I7mmo0Y866+PmMb8LUW25ClovY4ub6EJUTEl7AR9ysp8+f7o/1Okd5ScpzHrVJ2D0YpaZlJfX/XAu+VSAWMogMJTgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7be.dynamic.kabel-deutschland.de [95.90.247.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D03BB6028F36B;
	Mon, 15 Sep 2025 22:15:05 +0200 (CEST)
Message-ID: <17914806-345b-4554-8fff-b366c20a45bc@molgen.mpg.de>
Date: Mon, 15 Sep 2025 22:15:03 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis: Fix incorrect arguments in
 tpm_tis_probe_irq_single
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 stefanb@linux.vnet.ibm.com, christophe.ricard@gmail.com,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Justinien Bouron <jbouron@amazon.com>
References: <20250915182105.6664-1-gunnarku@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250915182105.6664-1-gunnarku@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gunnar,


Thank you for your patch.

Am 15.09.25 um 20:20 schrieb Gunnar Kudrjavets:
> The tpm_tis_write8() call specifies arguments in wrong order. Should be
> (data, addr, value) not (data, value, addr). The initial correct order
> was changed during the major refactoring when the code was split.
> 
> Fixes: 41a5e1cf1fe1 ("tpm/tpm_tis: Split tpm_tis driver into a core and TCG TIS compliant phy")

     $ git describe 41a5e1cf1fe1
     v4.7-rc2-83-g41a5e1cf1fe1

Interesting, that this did not cause more havoc.

> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 4b12c4b9da8b..8954a8660ffc 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -978,8 +978,8 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>   	 * will call disable_irq which undoes all of the above.
>   	 */
>   	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> -		tpm_tis_write8(priv, original_int_vec,
> -			       TPM_INT_VECTOR(priv->locality));
> +		tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality),
> +			       original_int_vec);
>   		rc = -1;
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

