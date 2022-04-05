Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE554F22EF
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiDEGQq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Apr 2022 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDEGQn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Apr 2022 02:16:43 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD5B2
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 23:14:44 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae8ff.dynamic.kabel-deutschland.de [95.90.232.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CA4A61E64846;
        Tue,  5 Apr 2022 08:14:43 +0200 (CEST)
Message-ID: <29700faa-6e23-78ee-8353-9a665374c487@molgen.mpg.de>
Date:   Tue, 5 Apr 2022 08:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drivers/char/tpm: Google TPM, additional DID:VID
Content-Language: en-US
To:     Jes Klinke <jbk@google.com>
References: <CANMTAZTAnGDxJri4_rogsW2Ev9tpFTSTBZaEvSNpgmjEUAgwBA@mail.gmail.com>
Cc:     linux-integrity@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CANMTAZTAnGDxJri4_rogsW2Ev9tpFTSTBZaEvSNpgmjEUAgwBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Jes,


Am 05.04.22 um 01:42 schrieb Jes Klinke:
> Accept one additional numerical value of DID:VID for Google TPM.

Mention the ID at least once in the commit message? In what device is it 
used?

For the summary, the prefix seems often just `tpm` or `char: tpm`.

tpm: cr50: Add new device/vendor ID 0x504a6666

> Signed-off-by: Jes B. Klinke <jbk@google.com>
> 

Superfluous blank line.

> ---
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index f6c0affbb4567..e5fb1ecc8fa2e 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,6 +31,7 @@
>   #define TPM_CR50_TIMEOUT_SHORT_MS 2 /* Short timeout during transactions */
>   #define TPM_CR50_TIMEOUT_NOIRQ_MS 20 /* Timeout for TPM ready without IRQ */
>   #define TPM_CR50_I2C_DID_VID 0x00281ae0L /* Device and vendor ID reg value */
> +#define TPM_TI50_I2C_DID_VID 0x504a6666L
>   #define TPM_CR50_I2C_MAX_RETRIES 3 /* Max retries due to I2C errors */
>   #define TPM_CR50_I2C_RETRY_DELAY_LO 55 /* Min usecs between retries on I2C */
>   #define TPM_CR50_I2C_RETRY_DELAY_HI 65 /* Max usecs between retries on I2C */
> @@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>    }
> 
>    vendor = le32_to_cpup((__le32 *)buf);
> - if (vendor != TPM_CR50_I2C_DID_VID) {
> - dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);

This line should be indented, shouldn’t it? Please send a properly 
formatted patch. Did you run it through `scripts/checkpatch.pl`?

> - tpm_cr50_release_locality(chip, true);
> - return -ENODEV;
> + if (vendor == TPM_CR50_I2C_DID_VID) {
> + dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> + client->addr, client->irq, vendor >> 16);
> + return tpm_chip_register(chip);
> + }
> + if (vendor == TPM_TI50_I2C_DID_VID) {
> + dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> + client->addr, client->irq, vendor >> 16);
> + return tpm_chip_register(chip);
>    }
> 
> - dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> - client->addr, client->irq, vendor >> 16);
> -
> - return tpm_chip_register(chip);
> + dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> + tpm_cr50_release_locality(chip, true);
> + return -ENODEV;
>   }
> 
>   /**

Please also mention in the commit message, what is changed here.


Kind regards,

Paul
