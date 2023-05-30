Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14CC715BD8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjE3Kcc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjE3Kcb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 06:32:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFFF93;
        Tue, 30 May 2023 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685442714; i=linosanfilippo@gmx.de;
        bh=HLrwqdUJuqN16B/qjsE6jcWhUvILRIzmNm5SbVmJ4dY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BrPAynvcb6fpBI2DaSXRYjAr9zhgXRkTsbysxdy0gvSn00kbbPcFNbGT0ROmNuJue
         fd2xmSFnL0dGmANe0uxL2qoy/ScCYi/3opedQRCYOz7auHnmxu+/QRmuX8A9eFV8Qa
         QlFFBonjkHV+JtMYxIqbuYLNYmrl/2YnQm3QLGJwxFpKsTLQ3TDyufs4moKn8DnqIz
         nesByy0gXla/eJ4a0HwZ/AhMt05p5GULjW1Ac8/5t4mY4KbkQ6q9ZSw8GcDq5dsTRw
         /y2laYytEPXhaRCbjQOV32Hd9U6aVX9SZ+JXetr9NvYHbKl1CWFkUaRtQIznd7rTAi
         PKX5BKC/TYGTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.2.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1qSs0d0xqX-00jWHZ; Tue, 30
 May 2023 12:31:54 +0200
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
To:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
 <CSUM65JDEX5D.8GL20PUI2XDV@suppilovahvero>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <fa9d4714-1c26-7f3b-9d27-04295ef74a6c@gmx.de>
Date:   Tue, 30 May 2023 12:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CSUM65JDEX5D.8GL20PUI2XDV@suppilovahvero>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TZ4ZU+3gKuoxi5e6X3XtMH0VAzfEjg22iznnnKShF9rUjvFZbci
 9wocekfP/wJHdYRVPXkj7Jwh1wTWRm5fRYG8IngxSyTKOEklONBuyVfUo9Yr4Bav/ovajf5
 Np6Rhsya9u7Fvdqobsla/rEizzX1v8LKWRYsBVX8weJNmvLM++h3CC9IK+/b++xRVjY9DRg
 7ICAvpRdEgZi08EpgGSxQ==
UI-OutboundReport: notjunk:1;M01:P0:L/+dLP6F3pw=;OcvV0FoqD0LcMLZqCtBrgSMwCe5
 3+wgn+HVy6Qfuz9bgGMS51iiHkzqfNH76B++ujeTnoZBbMMNXa76k19m2W+pDus77L2BGGrEj
 gIyejMGMWjcW4KyeEnwGzf5H+uKIveYfj8X8NymS41TR2VN3VilAuzxHQq18qMzrwJr/ZXMrn
 pECu8EEzLDLnWqeMZCQ58m9/4XAJ3QlsHgJ1IX3HA0CiCC3hDO5+vzlvTo3c9tSkTsQ7h0k27
 9Ky37HDJXFHrB6xGv2P57w3LFDsTBK/I53gJaS032P30DssVmJ5CrGmauY36pAe+MMWqba+Je
 LcEV1+VR9Q1RB4w+cv+SL/9zMPh/1VKJHmMutnRUHM6guz0wAXAIgOEk0/XmQ5AB69u7r/Gko
 2Aux36dUBcWBhx4pwv4r/Xt+0TzL1k2rSuQndGGR4CZxSvHh+Vk+eXl70/QLJVlhBzFPWgc7R
 xzNHrMNKoZ+F55cU518hu0CdBvWl15yK3fe+b9kMEsYtWRldghpBgPFTQluAlB7rcI2tB0CBA
 RgQAbCEZ6t2/0odxlb9whujZwNU5cX2x4oVuTLykOi4PfRgEka6z79ZkDYM9rPTXZ2l9gWid7
 1gpF95dceOHbW/i9y+ugRMZqNrAKGb3EKfJpJbaaLmXFo4pVZReZVd+/gki5MXvgqTWWfVfBt
 24s4pmvLmJr/3S7WIZrH6LaC3TMYQ6I0RXeT7ZbPqvZS6rDWOQyuK2FeYoyK+1tA/BHobaCfk
 WM/rZgMwKpsQ5QT+qwEFo+XF2O3CCegpPo6m5m6hfUX6h4T4SFblsDsb8QY8YYnl/A9M9PIl/
 zFfbv+B0xLBCiHLZCaPPBeY1W/CixPj/joHPJJkkRexxAEUhVoYxSv/OrpyJO9BpxpK+M/mr7
 noAAy5MLeiElSQRlNNfUzYN8HbObuQebmgPehRcHgccsJKgxpG5gp5qsAwxEbtxA8bdMpxLKB
 YCIu9A==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 24.05.23 at 17:30, Jarkko Sakkinen wrote:
> On Wed May 24, 2023 at 6:58 AM EEST, Jarkko Sakkinen wrote:
>>>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interru=
pt);
>>>  	if (rc < 0)
>>> -		return IRQ_NONE;
>>> +		goto unhandled;
>>>
>>>  	if (interrupt =3D=3D 0)
>>> -		return IRQ_NONE;
>>> +		goto unhandled;
>>>
>>>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>>> @@ -780,10 +829,14 @@ static irqreturn_t tis_int_handler(int dummy, vo=
id *dev_id)
>>>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interru=
pt);
>>>  	tpm_tis_relinquish_locality(chip, 0);
>>>  	if (rc < 0)
>>> -		return IRQ_NONE;
>>> +		goto unhandled;
>>>
>>>  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>>  	return IRQ_HANDLED;
>>> +
>>> +unhandled:
>>> +	tpm_tis_process_unhandled_interrupt(chip);
>>> +	return IRQ_HANDLED;
>>>  }
>
> Some minor glitches I noticed.
>
> You could simplify the flow by making the helper to return IRQ_NONE.
>
> E.g.
>
> 	tpm_tis_relinquish_locality(chip, 0);
> 	if (rc < 0)
> 		return tpm_tis_process_unhandled_interrupt(chip);
>
> I'd recommend changing the function name simply tpm_tis_rollback_interru=
pt().
>

IMHO this name is worse, since this function does actually _not_ rollback =
interrupts
most of the times it is called. Only after an interrupt storm is detected =
(so currently
after it has been called at least 1000 times without rollback) it actually
rolls back interrupts and falls back to polling.

Maybe rather tpm_tis_check_for_interrupt_storm()?

Regards,
Lino


