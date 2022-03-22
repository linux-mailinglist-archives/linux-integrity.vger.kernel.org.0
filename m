Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E234E3D1F
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCVLEV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCVLEU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 07:04:20 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2D7EA25
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 04:02:53 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5ae922.dynamic.kabel-deutschland.de [95.90.233.34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E8D061EA1929;
        Tue, 22 Mar 2022 12:02:49 +0100 (CET)
Message-ID: <f1c910eb-4ac9-13b7-e7fc-5c42e72f8bbf@molgen.mpg.de>
Date:   Tue, 22 Mar 2022 12:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] tpm: Fix regression in tpm_tis_synquacer.c
Content-Language: en-US
To:     Johannes Holland <johannes.holland@infineon.com>
References: <20220322105933.1242-1-johannes.holland@infineon.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220322105933.1242-1-johannes.holland@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Johannes,


Thank you for the patch.


Am 22.03.22 um 11:59 schrieb Johannes Holland:
> Remove unused variables and type mismatch (integer from pointer without
> a cast).

Maybe also paste the compiler error message?

As it’s a regression, please also add a Fixes line.


Kind regards,

Paul


> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
>   drivers/char/tpm/tpm_tis_synquacer.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> index 2751be8e6065..679196c61401 100644
> --- a/drivers/char/tpm/tpm_tis_synquacer.c
> +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> @@ -39,11 +39,6 @@ static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
>   					enum tpm_tis_io_mode io_mode)
>   {
>   	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> -	__le16 result_le16;
> -	__le32 result_le32;
> -	u16 result16;
> -	u32 result32;
> -
>   	switch (io_mode) {
>   	case TPM_TIS_PHYS_8:
>   		while (len--)
> @@ -69,11 +64,6 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
>   					 enum tpm_tis_io_mode io_mode)
>   {
>   	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> -	__le16 result_le16;
> -	__le32 result_le32;
> -	u16 result16;
> -	u32 result32;
> -
>   	switch (io_mode) {
>   	case TPM_TIS_PHYS_8:
>   		while (len--)
> @@ -86,10 +76,10 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
>   		 * Due to the limitation of SPI controller on SynQuacer,
>   		 * 16/32 bits access must be done in byte-wise and descending order.
>   		 */
> -		iowrite8(&value[3], phy->iobase + addr + 3);
> -		iowrite8(&value[2], phy->iobase + addr + 2);
> -		iowrite8(&value[1], phy->iobase + addr + 1);
> -		iowrite8(&value[0], phy->iobase + addr);
> +		iowrite8(value[3], phy->iobase + addr + 3);
> +		iowrite8(value[2], phy->iobase + addr + 2);
> +		iowrite8(value[1], phy->iobase + addr + 1);
> +		iowrite8(value[0], phy->iobase + addr);
>   		break;
>   	}
>   
