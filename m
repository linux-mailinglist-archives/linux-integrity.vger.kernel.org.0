Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17170F14D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjEXIog (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbjEXIof (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 04:44:35 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A65196;
        Wed, 24 May 2023 01:44:31 -0700 (PDT)
Received: from [192.168.0.185] (unknown [95.90.238.68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CFF5F61DFA909;
        Wed, 24 May 2023 10:43:26 +0200 (CEST)
Message-ID: <a1030692-e80f-a785-2e90-238d5f00a181@molgen.mpg.de>
Date:   Wed, 24 May 2023 10:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11 only
Content-Language: en-US
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, jsnitsel@redhat.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
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

Dear Peter,


Thank you for your patch.

Am 24.05.23 um 07:58 schrieb Peter Ujfalusi:
> The original patch which added the quirk would apply to all AAEON machines,
> which might or might not be valid.
> 
> The issue was discovered on UPX-i11 (TigerLake), it is not known if the
> i12 (AlderLake) version is affected.
> UP2 (ApolloLake) does not even have TMP module (no TPM drivers probing

s/TMP/TPM/

> and confirmed by dmidecode).

Another nit, the official spelling of the SOC names is with a space, for 
example, Tiger Lake [1].

> Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.
> 
> Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi Jarkko,
> 
> the patch is generated on top of your
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git : irq-storm
> 
> Regards,
> Peter
> 
>   drivers/char/tpm/tpm_tis.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..4357d4ba8f9e 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -143,6 +143,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>   		.ident = "UPX-TGL",
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
>   		},
>   	},
>   	{}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: https://en.wikipedia.org/wiki/Tiger_Lake
