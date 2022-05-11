Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15E5523E22
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbiEKT6R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbiEKT6Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:58:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9911F9A0C;
        Wed, 11 May 2022 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652299081;
        bh=DnQi+kYGURjHNKQ+4HyqoMBrfpTbkeC+W88d7BnxadA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XaeAFU5cHhFJWlL+ynCzu4CxMhRIval4oYAoM+7gtsOqTbiBj4gJ8ahbTvwNoR0Xs
         t1YaY3SsfiusNCL8vS8bubCKL2DwmrCBVH1dwSJf+d6lt1bE80nA/wiGQzIAKY5gGz
         kPPxVWG2FHkwe7MVqaoXV52j5FfwQCBgr6ROQghM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.12]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1ncoir0WmC-00CC6e; Wed, 11
 May 2022 21:58:01 +0200
Subject: Re: [PATCH v4 6/6] tpm, tpm_tis: Only enable supported IRQs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-7-LinoSanfilippo@gmx.de> <YnvRXiMxMRF3mIb8@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <e5081429-d313-ade2-0dda-b7ac88ebf4f9@gmx.de>
Date:   Wed, 11 May 2022 21:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnvRXiMxMRF3mIb8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VrLsUIij1zuxMSkL4gXWVBDdedrrX5LON4oknD+NladcBShhD12
 HOQWEkxL6k822imPobS8j9Hqh8ko4JFbIBiVEvoJ3GS1PoGyh7uSFM+MmOVIsJjspNT8o87
 vKb32pEX+UQsETuroodq/SW+e5+VQiG9NcyjdMAd2TV01SEAZo2bPAN7666FsQfTjgMI5tC
 MQlABrAKyUE9Y7ZzlkwEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L8hxUCebOv8=:Jo1zory9tW1IhkGMV/VjyX
 7z1Tp7sMV9vl5xKayZUFfTNG5R3LFLWEbkJDE8xsMhxRn6fj+6v4QmvB9LEdPuKc9Re2OWrc2
 pCUmv7QXEnMcVJ6/DJIuBptaxgl8deMJ9FIH6kZN0ne+//PRRYxbLT8QBr9m3jOQr//CRY4WK
 AGDHwLqp7Wo7IMSRMNo4oo20zM+ajI9Y1MA25MIiYl/5YozamTHlHr+TKq28E2BJLrkKj6N0R
 GijHQiPZczeL8gCMLnk6fwInquAGTE4Ot64Ibl45CGv+Az7dYLb5tBijtXYnIcjhQotZDHsSC
 auowTjuS6CWqLKnNRkrGx9WNXc8J1H+DzTaTr2fWbiL3E5RBlVKzxLgWHP2PRM/dghbDnNhsz
 u72HeChyQyFM2VFjjguTsN8RvYOr8yPw3/KTsNWyGiKqs4We8YtY0VQk0/srjal5SHOl9wjm3
 6t5n0voPi4ypwbhWxSceEiGgLjWjPT3NsQB/gcWZLtcYxfZ6puP/3QmAGDKzMH+G2Gtqk3FRC
 XRIUqGDko9nFFNU2APWha58rJxb9U1xa3IZE5wVvEdEUXE5OrO0MgLk20NJ6Jf3dAhYwuAiJ+
 hGWXE9ZmlGpCqNP64li9rCCEHBfL17iRarRc7s+XrM6WUSPowF5hgnFoHTcYgbojVtToCza8L
 xiL8RVe4YVh6KikDvwpY3VUcVxZwfAmKPuytUtchHySe5dovYqUtdptfHJaZKdFKn/jLrM8G4
 249IuzxKwCZX3iqI4BjieOB+xQaVye7qK+8pSmXXr7pco/bCJG/bSCJXimVxw2FoQPJMw22d1
 PyA/NYKshtjUMk5UG0QGe1t608RfjPg/RJ1cTObQGkfX4Or6PNmqqzpWRVFyP4olprq9teaHw
 BJcxRWrKvGCq8sbHHMv6BAr3EcTcKSMS37CS2Xj40Z3KvML/LN/qeoRZl1T26IBn33ADYVnb7
 GXBMPfc28ycHA2jQ6E7IqmLNuYQfO7itgDzp7lcJG5dwVRMTeQWJNPG/SsDPNXEYW3ItJ4hwf
 1XR0ud0g6WVO1lvNI55xJZ0qfL0fEuCtHz5SaVPxJ4WDOlq6d+jTxhnHVsJjmpDhj11BFA52V
 N7VQQX6h7A6KGY=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11.05.22 at 17:08, Jarkko Sakkinen wrote:
> On Mon, May 09, 2022 at 10:05:59AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Instead of blindly trying to enable all possible interrupts, use the re=
sult
>> from the capability query and request only the interrupts that are actu=
ally
>> supported.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 67 ++++++++++++++++++---------------
>>  drivers/char/tpm/tpm_tis_core.h |  1 +
>>  2 files changed, 37 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 4c65718feb7d..784e153e2895 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -976,13 +976,46 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>  		goto out_err;
>>  	}
>>
>> +	/* Figure out the capabilities */
>> +	rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps)=
;
>> +	if (rc < 0)
>> +		goto out_err;
>> +
>> +	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>> +		intfcaps);
>> +	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
>> +		dev_dbg(dev, "\tBurst Count Static\n");
>> +	if (intfcaps & TPM_INTF_CMD_READY_INT) {
>> +		priv->supported_irqs |=3D TPM_INTF_CMD_READY_INT;
>> +		dev_dbg(dev, "\tCommand Ready Int Support\n");
>> +	}
>> +	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
>> +		dev_dbg(dev, "\tInterrupt Edge Falling\n");
>> +	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
>> +		dev_dbg(dev, "\tInterrupt Edge Rising\n");
>> +	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
>> +		dev_dbg(dev, "\tInterrupt Level Low\n");
>> +	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
>> +		dev_dbg(dev, "\tInterrupt Level High\n");
>> +	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT) {
>> +		priv->supported_irqs |=3D TPM_INTF_LOCALITY_CHANGE_INT;
>> +		dev_dbg(dev, "\tLocality Change Int Support\n");
>> +	}
>> +	if (intfcaps & TPM_INTF_STS_VALID_INT) {
>> +		priv->supported_irqs |=3D TPM_INTF_STS_VALID_INT;
>> +		dev_dbg(dev, "\tSts Valid Int Support\n");
>> +	}
>> +	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
>> +		priv->supported_irqs |=3D TPM_INTF_DATA_AVAIL_INT;
>> +		dev_dbg(dev, "\tData Avail Int Support\n");
>> +	}
>> +
>>  	/* Take control of the TPM's interrupt hardware and shut it off */
>>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask)=
;
>>  	if (rc < 0)
>>  		goto out_err;
>>
>> -	intmask |=3D TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
>> -		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
>> +	intmask |=3D priv->supported_irqs;
>>  	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
>>
>>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> @@ -1009,32 +1042,6 @@ int tpm_tis_core_init(struct device *dev, struct=
 tpm_tis_data *priv, int irq,
>>  		goto out_err;
>>  	}
>>
>> -	/* Figure out the capabilities */
>> -	rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps)=
;
>> -	if (rc < 0)
>> -		goto out_err;
>> -
>> -	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>> -		intfcaps);
>> -	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
>> -		dev_dbg(dev, "\tBurst Count Static\n");
>> -	if (intfcaps & TPM_INTF_CMD_READY_INT)
>> -		dev_dbg(dev, "\tCommand Ready Int Support\n");
>> -	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
>> -		dev_dbg(dev, "\tInterrupt Edge Falling\n");
>> -	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
>> -		dev_dbg(dev, "\tInterrupt Edge Rising\n");
>> -	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
>> -		dev_dbg(dev, "\tInterrupt Level Low\n");
>> -	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
>> -		dev_dbg(dev, "\tInterrupt Level High\n");
>> -	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
>> -		dev_dbg(dev, "\tLocality Change Int Support\n");
>> -	if (intfcaps & TPM_INTF_STS_VALID_INT)
>> -		dev_dbg(dev, "\tSts Valid Int Support\n");
>> -	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
>> -		dev_dbg(dev, "\tData Avail Int Support\n");
>> -
>>  	/* INTERRUPT Setup */
>>  	init_waitqueue_head(&priv->read_queue);
>>  	init_waitqueue_head(&priv->int_queue);
>> @@ -1101,9 +1108,7 @@ static void tpm_tis_reenable_interrupts(struct tp=
m_chip *chip)
>>  	if (rc < 0)
>>  		goto out;
>>
>> -	intmask |=3D TPM_INTF_CMD_READY_INT
>> -	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
>> -	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
>> +	intmask |=3D priv->supported_irqs | TPM_GLOBAL_INT_ENABLE;
>>
>>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index c8972ea8e13e..3d6b05c6fdba 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -97,6 +97,7 @@ struct tpm_tis_data {
>>  	u16 manufacturer_id;
>>  	int locality;
>>  	int irq;
>> +	unsigned int supported_irqs;
>>  	unsigned long irqtest_flags;
>>  	unsigned long flags;
>>  	void __iomem *ilb_base_addr;
>> --
>> 2.36.0
>>
>
> Does the existing code cause issues in a some specific environment?
>
> BR, Jarkko
>

Not that I know of. This patch is not supposed to be a bugfix but an impro=
vement of
the existing code by using the information about supported interrupts whic=
h is collected during
the capability query. After the query we know exactly which irqs are suppo=
rted, so why not use
this knowledge when setting the irq mask?

Regards,
Lino

