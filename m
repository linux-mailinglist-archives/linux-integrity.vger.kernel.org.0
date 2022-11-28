Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884F463A8C0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 13:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiK1MyD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 07:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiK1MyC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 07:54:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768515FE0;
        Mon, 28 Nov 2022 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669640016; bh=A0fnarZ/PFbQMO+SxuLH2LZkz5obExFbPaQzidAWHX8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qnDv8MLG+A0s1yvI5z+fc5OH/hqeTtRffgAlEF+tkwiliUMRwI/taZDS8Y52S4hKk
         KT4eKgsre6JCqpIj1w9dLre21o+/iFn5Dj/ALPHFquacTrmYkCXCMwJXBR5rFMJjV7
         rEpW9QYBv4IGAQocoWL9UWsZTHl17PGjzeBo5ysjgzlZlbAac3dM5oLxcQ8Lq8trzi
         LJgOAZZCB76jwVk+nDs09nX2QDmYxBdgw0iZfn8uC0LJBiMWcIln2ovz3hkFVjnLD1
         RUQ+oYdczZV/9z15Avqo94sWkOBS8sLMWEl4GhXPwxF3icdhSX0HFihirl3nGZxnLP
         bc9gZh00L0Fiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1oo1TK0Gly-00zHHL; Mon, 28
 Nov 2022 13:53:36 +0100
Message-ID: <3c8a9353-124a-4ace-320d-b3e811609502@gmx.de>
Date:   Mon, 28 Nov 2022 13:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v11 13/14] tpm, tpm_tis: startup chip before testing for
 interrupts
Content-Language: en-US
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <20221124135538.31020-14-LinoSanfilippo@gmx.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20221124135538.31020-14-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2cTxqiaUcYK828rliV464Ne0ZktJzDIYm492bblahPlIe5NtcIE
 9hc6g5pONQ2oQ5OUVVMPYot9ZnFh2T5HxvP/ovAS0smLSngHigiY0pTKDoNfEzRvlDtDO1W
 8mgyaoKySlZ0XZiCLw7m5/PexWVe3041MlSPFv7flciDEzU3PIOevu8PSH1etpnBj8bFb/y
 TfapLCQ45QFVOei5v1O+A==
UI-OutboundReport: notjunk:1;M01:P0:GZajJQRI1/c=;eGO9EFV96pbVQnnzFIJ8uh3m9O0
 2dTMJh+PJGqzpGHqsuyp3g07ffTxeAhzm/BvfT16S9uq/I8t7Wjg3RDbQKBVnDOyASqMpjr1L
 ZRSVjG28lU0P/zE8l15P1iA6VA+iTKW4ykQFRQjVfUTUth+65miJGvmAhdjLx8YpPtJ/DUpO2
 DAQx6B0KvwJI6Agsl87jAlaH+5t1CucEQf/5RzEpFyeTkBXyUZOKsLR8CVZVy6cDruB6ac35/
 Low72tZ2CBmyo9xLrBqGZh/rCehmhNOYdKAlN2m0/o3WsVvu3UWr00SS5UPqbttOuLA3NlMU1
 N42MD0Pwj2UUUZG2M3/B9NkkZ21ag28dAnN848p12JbKgUBnKfIPuQU559OC0Zmxq9q3Sq5iZ
 eZ0A7JGkzU/o2m4L50j6Xw1o9Lu4j+si1idoES6FVz3VviiBrPx36aCIXw7j7QJWIy2AYtYaA
 0lvPj7nSm0Qh2ErmPjajmEHaSp8A/aORGsSuKSRPaYI8CKoIMmVAqFAJkPydxtwRVC/rM0ept
 9f0aA08mRhJ3tVhfc+UuHr1tsPu8eL2uxHVqqJKd4kdPTjwdoHVvDqVNyVY5nllcrhzHLxNEl
 6a0ssLztDLXuiKczq38pSAjzKT5AUAYB2njx43gdIIwhSiYSiN5bnWwsujuWi9GqFbF00Wn3r
 zLcKQ/tDe4cIYukzlBG0Gx2OvrqM5QBpBZClVJHUJibn+M75l6FIVkDSWkAdfnHzHVe8J4wAI
 1hxBdEzouivEhbYOfpIJuG3r7r3DPj0TZqdV01iM2TbJpea5xf2d0/gh3L63HdF6OqRktueMl
 OvcDZLbK0ToS8yDHYshshRRolydtS8rGuRObcnJJUt1lgzoTfJSKafm+MXBYIqeWGnt1jivPr
 PeRZvjGDuUAg+7nTxvzzkzG4EoNgDcLqyGMLzN6nlQdDMqVO+qgbfverzEoazWIjRbBUSgZOL
 RFx4fw==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 24.11.22 14:55, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> In tpm_tis_gen_interrupt() a request for a property value is sent to the
> TPM to test if interrupts are generated. However after a power cycle the
> TPM responds with TPM_RC_INITIALIZE which indicates that the TPM is not
> yet properly initialized.
> Fix this by first starting the TPM up before the request is sent. For th=
is
> the startup implementation is removed from tpm_chip_register() and put
> into the new function tpm_chip_startup() which is called before the
> interrupts are tested.
>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c     | 38 +++++++++++++++++++++------------
>  drivers/char/tpm/tpm.h          |  1 +
>  drivers/char/tpm/tpm_tis_core.c |  5 +++++
>  3 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 783d65fc71f0..370aa1f529f2 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -543,6 +543,30 @@ static int tpm_get_pcr_allocation(struct tpm_chip *=
chip)
>  	return rc;
>  }
>
> +/*
> + * tpm_chip_startup() - performs auto startup and allocates the PCRs
> + * @chip: TPM chip to use.
> + */
> +int tpm_chip_startup(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	rc =3D tpm_chip_start(chip);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D tpm_auto_startup(chip);
> +	if (rc)
> +		goto stop;
> +
> +	rc =3D tpm_get_pcr_allocation(chip);
> +stop:
> +	tpm_chip_stop(chip);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_startup);
> +
>  /*
>   * tpm_chip_register() - create a character device for the TPM chip
>   * @chip: TPM chip to use.
> @@ -558,20 +582,6 @@ int tpm_chip_register(struct tpm_chip *chip)
>  {
>  	int rc;
>
> -	rc =3D tpm_chip_start(chip);
> -	if (rc)
> -		return rc;
> -	rc =3D tpm_auto_startup(chip);
> -	if (rc) {
> -		tpm_chip_stop(chip);
> -		return rc;
> -	}
> -
> -	rc =3D tpm_get_pcr_allocation(chip);
> -	tpm_chip_stop(chip);
> -	if (rc)
> -		return rc;
> -
>  	tpm_sysfs_add_device(chip);
>
>  	tpm_bios_log_setup(chip);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452..919bb0b88b12 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -190,6 +190,7 @@ static inline void tpm_msleep(unsigned int delay_mse=
c)
>  		     delay_msec * 1000);
>  };
>
> +int tpm_chip_startup(struct tpm_chip *chip);
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_=
core.c
> index ddaf362e62c1..94a2bfb244b3 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1129,6 +1129,11 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>  	/* INTERRUPT Setup */
>  	init_waitqueue_head(&priv->read_queue);
>  	init_waitqueue_head(&priv->int_queue);
> +
> +	rc =3D tpm_chip_startup(chip);
> +	if (rc)
> +		goto out_err;
> +
>  	if (irq !=3D -1) {
>  		/*
>  		 * Before doing irq testing issue a command to the TPM in polling mod=
e

Jarko, thanks for the review so far. What about this patch, are there any =
concerns from your side?

Regards,
Lino
