Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423C355847
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2019 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFYUBK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 16:01:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUBK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 16:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6msGs4jRGr4257DNcmHTCnokjcFenpvtSaGPOZEvIMs=; b=xGRRKMHbmmqanQ9tITE61l+mNJ
        6LCx7ONkiFAIMExSvrYEjXOre5a5lGp/9GjGrf8eWzeWVh45klQm4mio9xzWg5DHqRNNC+425Qvr5
        6YQVYknLtyEh85DoxLWPG8KdHUA9PrYt3IWcVSAd84W5X9/VnWbmkxVqL9dMt+SL+TnGPit4U5K4M
        IkxL60PL3kSDcLFHTZy0TMTBs7ykAXk+kDUbEOAXs51g2IfPb6gAU7/3IeG5d4ELN/UrJ/hv4rFY1
        VrYSg/JvUppeCDvMZ0y8/8zEwvaAphh8V+WNcTDxOfnck6CTYrbNZgCggffwMKWEGT0cnrDIOxqZA
        S1VG/IrQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfrcp-0006yw-C3; Tue, 25 Jun 2019 20:01:07 +0000
Subject: Re: [PATCH v6 1/2] fTPM: firmware TPM running in TEE
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org
References: <20190625195209.13663-1-sashal@kernel.org>
 <20190625195209.13663-2-sashal@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6d9dfee-b274-94e1-8402-5c130a7362b1@infradead.org>
Date:   Tue, 25 Jun 2019 13:01:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625195209.13663-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/25/19 12:52 PM, Sasha Levin wrote:
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 88a3c06fc153..facee3bb5607 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -164,6 +164,11 @@ config TCG_VTPM_PROXY
>  	  /dev/vtpmX and a server-side file descriptor on which the vTPM
>  	  can receive commands.
>  
> +config TCG_FTPM_TEE
> +	tristate "TEE based fTPM Interface"
> +	depends on TEE && OPTEE
> +	---help---
> +	  This driver proxies for fTPM running in TEE

acronym overload.  For the help text, I would at least s/fTPM/firmware TPM/.
Also, end that sentence with a '.'.

>  
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM


-- 
~Randy
