Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A103643F852
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Oct 2021 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhJ2IBc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Oct 2021 04:01:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhJ2IBb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Oct 2021 04:01:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1E59F1F456E9
Subject: Re: [PATCH] tpm: tpm_tis_spi_cr50: Add default RNG quality
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
References: <20211027120233.2489258-1-angelogioacchino.delregno@collabora.com>
 <YXpHjUefFqmqrUbW@iki.fi>
 <e42ab3e1-6d07-c7bd-8d70-53f17a1228bc@collabora.com>
 <YXtkejWpeU6D4s1z@iki.fi>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f5d843a1-a59f-6f17-66c7-5c9b0023393f@collabora.com>
Date:   Fri, 29 Oct 2021 09:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXtkejWpeU6D4s1z@iki.fi>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Il 29/10/21 05:03, Jarkko Sakkinen ha scritto:
> On Thu, Oct 28, 2021 at 10:55:56AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 28/10/21 08:47, Jarkko Sakkinen ha scritto:
>>> On Wed, Oct 27, 2021 at 02:02:33PM +0200, AngeloGioacchino Del Regno wrote:
>>>> To allow this device to fill the kernel's entropy pool at boot,
>>>> setup a default quality for the hwrng found in Cr50.
>>>>
>>>> After some testing with rngtest and dieharder it was, in short,
>>>> discovered that the RNG produces fair quality randomness, giving
>>>> around 99.93% successes in rngtest FIPS140-2.
>>>>
>>>> Notably, though, when testing with dieharder it was noticed that
>>>> the p-values distribution wasn't uniform in all the cases, so a
>>>> conservative quality value was chosen.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    drivers/char/tpm/tpm_tis_spi_cr50.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
>>>> index ea759af25634..d6195fb58036 100644
>>>> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
>>>> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
>>>> @@ -264,6 +264,7 @@ int cr50_spi_probe(struct spi_device *spi)
>>>>    	phy = &cr50_phy->spi_phy;
>>>>    	phy->flow_control = cr50_spi_flow_control;
>>>>    	phy->wake_after = jiffies;
>>>> +	phy->priv.rng_quality = 700;
>>>
>>> How did you end up exactly to this number ('700')?
>>>
>>> /Jarkko
>>>
>>
>> As for what I've seen with rngtest, the number should be much higher, but
>> dieharder gave 3 WEAK results over 114, which isn't optimal. As also explained
>> in the commit message, the p-values distribution also wasn't uniform in all
>> of the cases, so I've applied an arbitrary penalty to the calculated values.
>>
>> In any case, that's how it went:
>>
>> The dieharder results were averaged, then normalized (0-1000) and re-averaged
>> with the rngtest result (where the result was given a score of 99.93% of 1000,
>> so 999.3), then aggregated together and averaged again.
>> An arbitrary penalty of -100 was applied due to the retrieved value, which
>> brings us finally to 700.
> 
> Please, add this to the commit message for reference.
> 
> In addition, please use a named constant instead of magic number, e.g.
> 
> /* Default quality for hwrng. */
> #define TPM_CR50_DEFAULT_RNG_QUALITY            700
> 
>> Regards,
>> - Angelo
> 
> /Jarkko
> 

Sure! Will do for v2.

Thanks,
- Angelo
