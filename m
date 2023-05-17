Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF10970696F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjEQNPz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 May 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjEQNPc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 May 2023 09:15:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B7E63;
        Wed, 17 May 2023 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684329308; x=1715865308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ecB/Ynuoe6ZBhEhZKZfKwKnN2RXD5h7a/Zsh9Jhj7y8=;
  b=Et5m5zUehuGXCWfBLoVs2CmlwWdoXsOgtGofswpaHUHkyKwgVPSQPtlI
   JbINvdJ2pPsEjSTqRUcYaJcwLjusZiEQ12jl53A/omZHftN3wmVpLopqO
   g3GW46qjSaJTCSlHBGBaUvzP/e8rX9Lq6duNdeJEfc6apPQypGwPnsPNp
   8GDLguZ+8+xZi0W61yBVCBPdKrcP43WhgW4clPdE+D2E0NdGwpH/6fuvE
   ZwsswyfjS5oQNMHYeJX5mdvgSmpFbN1AVMj+PRUwNiCKTxeomE9h/QVb8
   oSrezko4/rHDw5psEktEWbIneCvlKbbQqI0zy/5RT1yw3rKOIT+i5MeXG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="354049404"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="354049404"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 06:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="813855021"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="813855021"
Received: from fabiobar-mobl.ger.corp.intel.com (HELO [10.251.219.163]) ([10.251.219.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 06:14:22 -0700
Message-ID: <886904c2-26ea-8876-a6cf-b8de6ff94799@linux.intel.com>
Date:   Wed, 17 May 2023 16:15:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        jsnitsel@redhat.com
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 17/05/2023 15:29, Peter Ujfalusi wrote:
> The interrupts initially works on the device but they will stop arriving
> after about 200 interrupts.
> 
> On system reboot/shutdown this will cause a long wait (120000 jiffies).
> 
> The interrupts on this device got enabled by commit
> e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> 
> Prior to this point the interrupts were not enabled on this machine.
> 
> Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi,
> 
> This patch applies on top of mainline since 6.4-rc1 takes about 2 minutes to
> reboot on this machine, linux-next have
> e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices
> 
> I'm not sure if I shouold send this on top of next or mainline is fine, please
> let me know the preferred way to get this to 6.4.

In 6.3 the kernel prints this on boot:
# dmesg -w | grep tpm
tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead

It is interesting that with 6.4 most of the times the interrupts got
enabled (without this patch) resulting stall during reboot/shutdown but
there are few boots when the driver falls back to polling and thus the
TPM driver works.

The command which 'locks' the system is TPM2_CC_SHUTDOWN, it is given
TPM_UNDEFINED as duration index by tpm2_ordinal_duration_index().

> 
> Regards,
> Peter
> 
>  drivers/char/tpm/tpm_tis.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7af389806643..aad682c2ab21 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
>  		},
>  	},
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "UPX-TGL",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +		},
> +	},
>  	{}
>  };
>  

-- 
Péter
