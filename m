Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF46379E5
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKXNZf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKXNZe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:25:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470DE13D3A;
        Thu, 24 Nov 2022 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669296307; bh=JR+1ymxijyNQgUsQNpDrkTDOpk2Q7NlTPJlOhYAB4iU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UqAqvFZ1zmGr72/X9y28SR33gHSzIxDfUIRk9JdkEyqjmwa9immmulXPebxsCJK0j
         7bLlMUmyGPJ9mvW2XOn5/BM1pceSyknKW0Lc3tz53aQfOVjLiPEDzbMtZaPRhQNr/9
         VluzZXmQHlJKQlhyiPKziC4K7flROfBXRX2PP4ZpMqNZL6o+XfH9jce97T4/uPFjVR
         n29ZJIXjj3Ppd4gbTefOU8VMibwG54eRfb8P++7VsPoqzEsqnGAcY/nWtuowlVjYb7
         ulIcSzQ2Vu8KFVrOdl8v+V6uabcOHwcLJEek180kq703U6Z0WOej8xnkO/lbT3dAnn
         +YO+0hWTYvmag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1p8Qwb3UMd-00ySke; Thu, 24
 Nov 2022 14:25:06 +0100
Subject: Re: [PATCH v10 04/14] tpm, tpm_tis: Do not skip reset of original
 interrupt vector
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
 <20221120133134.28926-5-LinoSanfilippo@gmx.de> <Y38V/7kXkWt9Fhy0@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <ce85d555-ae60-d7c1-70b1-b762997e9c94@gmx.de>
Date:   Thu, 24 Nov 2022 14:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Y38V/7kXkWt9Fhy0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ewnx8TV3SRMzArWaDc4NLeLmH85rw76r2BRp5Gth2V5mS5DPFQZ
 1VrQRLftH6rB8fUJngG0IAhf5hw5af2gdrZ3vFTlTbpZoUVuUZqNcuv+GSkKSyO4PDbJ4mU
 3WV9vqTCdMqnyeZJ+BAmUWta7b87yYCo9pJ26XbIj0O+2SXu+XFZ50BiJ3ip2XMrPpkHOlL
 75OE7TSpyx4giRMTE9ApQ==
UI-OutboundReport: notjunk:1;M01:P0:UdQFGZP+bKo=;NEL2K/2lEfx8QICLNOyjJ4H2pJZ
 aVPciSeQD7Z7MCQdV4maN8vgZ7U7Fmg/+iPw1YzAlF0u4s4vWUNrpPXLLGHZIbbno6SvuRwU9
 rXuOmRRWa8i7JQnHiXXTUwLSx2PU7PrQgmlVVcbgWZoRdiZ6sn/1RiDHblZ/cYEI/uHL8A1aA
 iQTaL7oigT51nJzeta1uqtOfrtMSLFKon96YjdWqrXysS4me9kNwUqnTWHCVUlJpe/vzsjMgP
 sk14BLCbqejioYXfiXjpoqWrI44/bnzEQoeJbtiBqqZ0dadj96EK9MGgvb/awYCp80c16cfuG
 IMgM/4YNyH/9bR+Wjx7ht4bClICsLnxruqI2f8BYLJAzsCeKpMZJwzevjVF13Zml1l3ukRTnk
 LojYWbaDS1jL37Z2Q7RAOPWGibRS0QgnPieyd1m9nzDssMBQrCZJTp9c7ktzKpjBfMyE6D+Au
 CQia5apBnu/V+bML6Au6eq9WNBRdRxUIjRQqSpstSpUa6C/IeQM6PjxegWt26Kdf46kDFsFQt
 CULSjccgzsFhP1QSmoPD5rLZAFi1eDlqIgftzhAV7Z6Xx6bbM9DlCdxCyJ7kmKhiT8nlGObEG
 1Iasq18l7TuSU/tp27xr/ne9iJc0VHlwRNSsPZJdDijsSQa1jb3OY2xm0IbNMq+DnIsg4YLyZ
 STJcO0XDXgFypy+KbdMXavuf/fwtNT1xgJwDuS/JCnKGomPrzOB6EKYejsSvJovbeMWrz9FeY
 GzTpOySdfmOnqf/MqNHz/K+bgVjYE4plTZ/ti3+MzPolrIaZLEBZbkpnorx3ZTWuMgiAXlV1l
 yETlp9DHVYOhC3lhTvDxYXbbcTlDdmCJf9DsplaUF6zpS0i4/5WK91lDRwPyiHohLxxN2OPwH
 yiW0iP9JAHUItFkeoiVIdkc5MljqUJPSTiNTKqU8QYlOMP2nnGl4P2d/9W7B/mcok26qYxm+3
 ynNr0A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 24.11.22 at 07:58, Jarkko Sakkinen wrote:
> On Sun, Nov 20, 2022 at 02:31:24PM +0100, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> If in tpm_tis_probe_irq_single() an error occurs after the original
>> interrupt vector has been read, restore the interrupts before the error=
 is
>> returned.
>>
>> Since the caller does not check the error value, return -1 in any case =
that
>> the TPM_CHIP_FLAG_IRQ flag is not set. Since the return value of functi=
on
>> tpm_tis_gen_interrupt() is not longer used, make it a void function.
>>
>> Fixes: 1107d065fdf1 ("tpm_tis: Introduce intermediate layer for TPM acc=
ess")
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 33 +++++++++++++--------------------
>>  1 file changed, 13 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 603b82ca56da..1eac1279594d 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -729,7 +729,7 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>
>> -static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>> +static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>>  {
>>  	const char *desc =3D "attempting to generate an interrupt";
>>  	u32 cap2;
>> @@ -738,16 +738,14 @@ static int tpm_tis_gen_interrupt(struct tpm_chip =
*chip)
>>
>>  	ret =3D request_locality(chip, 0);
>>  	if (ret < 0)
>> -		return ret;
>> +		return;
>>
>>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> -		ret =3D tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>> +		tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>
> In a successive patch:
>
> -               tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> +               ret =3D tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> `
>
> BR, Jarkko
>

If it was a single patch it would be IMHO correct to remove ret, since at =
this point it
is not needed any more. But as part of a series it is admittedly a bit odd=
 to remove the value only
to re-add it in a later patch of the same series. I will fix this and send=
 a v11.


Regards,
Lino

