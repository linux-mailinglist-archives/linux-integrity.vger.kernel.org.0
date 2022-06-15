Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9054D43B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiFOWH7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiFOWH6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 18:07:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853722673;
        Wed, 15 Jun 2022 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655330862;
        bh=8zvgTqKZowSpOBFEUnhiFksEIfbT/Gv0cy1/m4B+SXc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=juahgP8nIUlVFRbBX44XcQ1Q7nDZ5Q5PkXd215yJl0rxaPddCY/7jAVwzkIede2i5
         KVhWkFgG6wKhLQVbIShEkxltcKOZ+azV4YzaiLaL0MRkAGzYCWNEdK/QJwtab+ZiwI
         jpkrNCijKVp9oJwbImPVy10QxWl4hS4jt0b50ZcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1noS4r3A36-00vP9A; Thu, 16
 Jun 2022 00:07:41 +0200
Subject: Re: [PATCH v5 05/10] tpm, tpm_tis: Store result of interrupt
 capability query
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-6-LinoSanfilippo@gmx.de> <YqoiWdwcds6AZgoO@iki.fi>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <2e4ab3f1-3bff-9c83-20d3-4eee10f8b412@gmx.de>
Date:   Thu, 16 Jun 2022 00:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YqoiWdwcds6AZgoO@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YXivV7v2VU7dH/KBpUThfqBN6lVUAHd/z1WmICVWlY4/OYFnO3G
 VcUifnbJgooLr73v9QJdCNWKD0c5IO2rXEQs4h+c+wc2MD2CNa4gVHmM1pzTQXr78hyAsH7
 ZIu31DisKcPK5Tkx9JUx8fIqpCka10/gXAtndb9d/k7Z/oZE2ehiVglkEMukQsufvgKe5YJ
 4LGB1Ly8LS6TBVWBz1vaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1CFKf9Plo4I=:2JfZM/GVrl30fCo3PcvClj
 yGz1phy3HNErg6KsaDPOgAhL2OR+J7T7DJmCGAihZwkSQb/OQG2ngSwtSS+XzZ7yNgY9ZP4tR
 KOUha7Ds23LKhJJ1Mhis6opBaq95Tx5IvRACf107RWH5EERXBqkihStbZREiO+yb8OLnHtZ8U
 pmzVUo/JtUNOEFgENpX7opv0vTsBwkleWgec5kvgHYvPXCsa68wlePVceFrCRTuXXfxPb1RGR
 boqlpHjgk4Nc0OcfJggiyNF5WmCP+czQnfDLem6bmVKdCq3JZsJoK9xANy4xscfLplyN1UOvS
 3aSUNnB+7zybvUhOmJVNfoTOhDlz/2Rngbb1eaw8lCsHpiyaDbxrU0V60VofWjILYysY3BjnP
 2is3WFlfJN5BnIIErYEGTIozIrgwsCsZAPdbAnYPSuy0v6BbHGyn5rQ5oMlQ0uOyBVSyOZhEt
 zsP6jyLIaKrNH+ceMWqr0c5qgt9K/s9tMs6uq3MG2/kWSq/WkJTzRW5fvu8hfysfBBB3OfyTI
 j1zjrAWUSkCu1NClp+aSQ13o+/2em+ee49dkTCGDrfJCKGBhwEPar4cUs/6Fch2XRJnOMkh8y
 cozllL2Ge8p9VLaea90FV71L2YbbreASSjqavaE6WkqIkNZo/q+GzKLb0nJ2N9j7W2uXMfktR
 O7JRwY7/hbT/KVP8slTo44ywYmrroGzGqFUjVVU23dhJxYbyuaLkb1AnHxTo9Ws84muQNNioE
 iTlN5dxhVQmBBHnsuKCQtNec6oQYrLwXztrZUP/ct7SQXz6H/dcZ9xW84MurkXJQmLPsgQpIJ
 3xl/BNPQT4ZKb+BopJAYA2FIE2eB4JPiY5GLrf+ix2phJ56E3hv7CPlJxijq6uTf9QDwTaBEl
 UwVQTyoZvgHQ9kE4lZwoAmTxPx0gtfNQ2Tjx86T05ovow9Ox67OCpjDgV21jy5Hq41+O1srTv
 /gZg4FNf0NKB0M7kQZe3brMoD5iXWFvIlhWHJXzqkiF1kQtwdIihhGFyQj7dnIQK5UEbtqMMe
 ncrv9hDoiPuAzylE4j4R2XevRxvnX0toyO07IKMUOHAUAtjS3/Gnt8NbKGB6MuT+25uMI9mXG
 AhVDD+RefTCnfvt0VW0261ufI3dg/TaIdupx1unmWEBASVAzh6WIGWndg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 15.06.22 at 20:18, Jarkko Sakkinen wrote:
> On Fri, Jun 10, 2022 at 01:08:41PM +0200, LinoSanfilippo@gmx.de wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> According to the TPM Interface Specification (TIS) support for "stsVali=
d"
>> and "commandReady" interrupts is only optional.
>> This has to be taken into account when handling the interrupts in funct=
ions
>> like wait_for_tpm_stat(). So query the set of supported interrupts and
>> store it in a global variable so that it can be accessed later.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 73 +++++++++++++++++----------------
>>  drivers/char/tpm/tpm_tis_core.h |  1 +
>>  2 files changed, 38 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 718525fcadc0..2f03fefa1706 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1007,8 +1007,39 @@ int tpm_tis_core_init(struct device *dev, struct=
 tpm_tis_data *priv, int irq,
>>  	if (rc < 0)
>>  		goto out_err;
>>
>> -	intmask |=3D TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
>> -		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
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
>> +		intmask |=3D TPM_INTF_CMD_READY_INT;
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
>> +	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
>> +		intmask |=3D TPM_INTF_LOCALITY_CHANGE_INT;
>> +		dev_dbg(dev, "\tLocality Change Int Support\n");
>> +	if (intfcaps & TPM_INTF_STS_VALID_INT) {
>> +		intmask |=3D TPM_INTF_STS_VALID_INT;
>> +		dev_dbg(dev, "\tSts Valid Int Support\n");
>> +	}
>> +	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
>> +		intmask |=3D TPM_INTF_DATA_AVAIL_INT;
>> +		dev_dbg(dev, "\tData Avail Int Support\n");
>> +	}
>> +
>>  	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
>>
>>  	rc =3D request_locality(chip, 0);
>> @@ -1042,32 +1073,6 @@ int tpm_tis_core_init(struct device *dev, struct=
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
>> @@ -1098,7 +1103,9 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>  		else
>>  			tpm_tis_probe_irq(chip, intmask);
>>
>> -		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>> +		if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>> +			priv->irqs_in_use =3D intmask;
>> +		} else {
>>  			dev_err(&chip->dev, FW_BUG
>>  					"TPM interrupt not working, polling instead\n");
>>
>> @@ -1145,13 +1152,7 @@ static void tpm_tis_reenable_interrupts(struct t=
pm_chip *chip)
>>  	if (rc < 0)
>>  		goto out;
>>
>> -	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask)=
;
>> -	if (rc < 0)
>> -		goto out;
>> -
>> -	intmask |=3D TPM_INTF_CMD_READY_INT
>> -	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
>> -	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
>> +	intmask =3D priv->irqs_in_use | TPM_GLOBAL_INT_ENABLE;
>>
>>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 0f29d0b68c3e..8e02faa4079d 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -96,6 +96,7 @@ struct tpm_tis_data {
>>  	u16 manufacturer_id;
>>  	int locality;
>>  	int irq;
>> +	unsigned int irqs_in_use;
>>  	unsigned long irqtest_flags;
>>  	unsigned long flags;
>>  	void __iomem *ilb_base_addr;
>> --
>> 2.36.1
>>
>
> int_mask would be imho a better name.
>
> Can you squash this and the following patch? It's good to slice in
> small patches but here I think it would make sense to tie the field
> to use case, in order for it to make sense.
>

Sure, will do so.

Regards,
Lino

