Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70CA70B769
	for <lists+linux-integrity@lfdr.de>; Mon, 22 May 2023 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEVISP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEVISO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 04:18:14 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B3B4;
        Mon, 22 May 2023 01:18:12 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aecf5.dynamic.kabel-deutschland.de [95.90.236.245])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0AC9B61E4052B;
        Mon, 22 May 2023 10:17:46 +0200 (CEST)
Message-ID: <7840f8c2-a903-7d80-c4bd-8568ad1c8682@molgen.mpg.de>
Date:   Mon, 22 May 2023 10:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] tpm_tis_spi: fix:release chip select when flow control
 fails
Content-Language: en-US
To:     Peijie Shao <shaopeijie@cestc.cn>
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230522070140.33719-1-shaopeijie@cestc.cn>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230522070140.33719-1-shaopeijie@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Peijie,


Thank you for your patch.

The fix: tag in your commit message summary is uncommon. I suggest:

> tpm_tis_spi: Release chip select when flow control fails


Am 22.05.23 um 09:01 schrieb shaopeijie@cestc.cn:
> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> The failure paths in tpm_tis_spi_transfer() do not deactivate
> chip select. Send an empty message (cs_select == 0) to overcome
> this.

Does the standard require to deactivate it?

A note on your test setup would be nice to have in the commit message.

> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
> ---
> Changes since v1:
>      1. Deactive cs all of the failure path, not only flow control.

Deactivate


Kind regards,

Paul


>      2. change and update comments.
> ---
>   drivers/char/tpm/tpm_tis_spi_main.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 1f5207974..9bfaba092 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -136,6 +136,14 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>   	}
>   
>   exit:
> +	if (ret < 0) {
> +		/* Deactivate chip select */
> +		memset(&spi_xfer, 0, sizeof(spi_xfer));
> +		spi_message_init(&m);
> +		spi_message_add_tail(&spi_xfer, &m);
> +		spi_sync_locked(phy->spi_device, &m);
> +	}
> +
>   	spi_bus_unlock(phy->spi_device->master);
>   	return ret;
>   }
