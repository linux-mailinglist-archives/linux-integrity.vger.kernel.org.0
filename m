Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA8150348
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2020 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBCJUm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Feb 2020 04:20:42 -0500
Received: from smtp11.infineon.com ([217.10.52.105]:27099 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBCJUm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Feb 2020 04:20:42 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Feb 2020 04:20:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1580721642; x=1612257642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S+aFt3xpcgLC1SHHmrUIQUyVr6Ob8IJ2Z341QwbK1Dw=;
  b=btfmWO7ZFibYtWQTA+6iB1ZyZIQ54XzrEzO7pQjou9IW3rk4OhJYpI2J
   0wZJgAnDJcplP0la9DmuZX5amcB0FP+aKhhGOSkIPD6MmpOZTOL1UZOU5
   4b9p150Zbo9LySfsqgvL8sB5NFPY4T6Zevo9DZiYb6wPd3si+/NPdNfmj
   I=;
IronPort-SDR: 0I5YmOzQwtppJhTcYNFeSh1RQc9kh0GwWJKUsikBGmre1oF1gDyUj+tPLQhHdkgBluO40UUH3m
 rF7E4t+wVfix9NN3COPNew6PbW2rZPttOaZRQbq87spnvDK31BPPHfUG8VUOd8x+daDtMji9TY
 cRpAnQdNjjMYdGsRS0c0h1LdPSqZnA4M/nFgoXiq/mXeN40LSWPqxld3Ktfg/OrxiCtqxcrTST
 KEyZw6od2zKhQAnQ5sRBww7YO6jv/ToiG/QAAXrG74dBvI/vx2n8LelyqfiEGCZvIiC85DRjlQ
 f/U=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9519"; a="147917928"
X-IronPort-AV: E=Sophos;i="5.70,397,1574118000"; 
   d="scan'208";a="147917928"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 10:13:34 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  3 Feb 2020 10:13:33 +0100 (CET)
Received: from [10.154.32.73] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 3 Feb
 2020 10:13:33 +0100
Subject: Re: [PATCH v7 4/6] tpm: tpm_tis_spi: Support cr50 devices
To:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20190920183240.181420-5-swboyd@chromium.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <007dfd87-5170-684a-26dc-9e7533d42034@infineon.com>
Date:   Mon, 3 Feb 2020 10:13:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20190920183240.181420-5-swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 20.09.2019 20:32, Stephen Boyd wrote:
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index a01c4cab902a..c96439f11c85 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
>   tpm-$(CONFIG_OF) += eventlog/of.o
>   obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
>   obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> -obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> +obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
> +tpm_tis_spi_mod-y := tpm_tis_spi.o
> +tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>   obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>   obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>   obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o

This renames the driver module from tpm_tis_spi to tpm_tis_spi_mod, was 
this done intentionally? When trying to upgrade the kernel, this just 
broke my test system, since all scripts expect to be able to load 
tpm_tis_spi, which does not exist anymore with that change.

Alexander
