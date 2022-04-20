Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14860508664
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377830AbiDTKzN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359695AbiDTKzM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 06:55:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01C403C6;
        Wed, 20 Apr 2022 03:52:26 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BC4061CCD786;
        Wed, 20 Apr 2022 12:52:23 +0200 (CEST)
Message-ID: <c8f5ada2-c5cc-fe1b-bdeb-8b7d134250ee@molgen.mpg.de>
Date:   Wed, 20 Apr 2022 12:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] tpm: cr50: Add new device/vendor ID 0x504a6666
Content-Language: en-US
To:     "Jes B. Klinke" <jbk@chromium.org>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
References: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Jes,


Am 20.04.22 um 01:37 schrieb Jes B. Klinke:
> Accept one additional numerical value of DID:VID for next generation
> Google TPM with new firmware, to be used in future Chromebooks.
> 
> The TPM with the new firmware has the code name TI50, and is going to
> use the same interfaces.
> 
> Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> 
>   drivers/char/tpm/tpm_tis_i2c_cr50.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index f6c0affbb4567..4ddb8ff3a8569 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,6 +31,7 @@
>   #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
>   #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
>   #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
> +#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
>   #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
>   #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
>   #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
> @@ -742,15 +743,15 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>   	}
>   
>   	vendor = le32_to_cpup((__le32 *)buf);
> -	if (vendor != TPM_CR50_I2C_DID_VID) {
> +	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
>   		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
>   		tpm_cr50_release_locality(chip, true);
>   		return -ENODEV;
>   	}
>   
> -	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
>   		 client->addr, client->irq, vendor >> 16);
> -

Remove this blank line wasn’t needed, I gues.

>   	return tpm_chip_register(chip);
>   }
>   

Thank for addressing the other comments, and congratulations on getting 
your first commit into the Linux kernel.


Kind regards,

Paul
