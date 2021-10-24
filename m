Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A429438B0C
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Oct 2021 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJXRqL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Oct 2021 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJXRqL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Oct 2021 13:46:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C16C061745;
        Sun, 24 Oct 2021 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nFn6fi/iskR5+ltkie8eDQymFVJfaUyjj9/k24bqil0=; b=pDdtD1cxcIbdnIUPmFsmt4VhD5
        BFLCCa96wHcTyeenK04CvmYCouHdUq34C+4tPCQvM9pjlqPQyJ6lA+8Duwr4VxIJ85N283gYQfbGn
        UZhFnmaN5Omckopj0DAF7mL+/TBURDYZJlCUvvzN54e4hUDcKusGlVjrKv9VZsvrDg7QD4NvyuItN
        bAFTpXBu9eFRnKwh9+Q6rlKauyqRg06Eicbkbqzmo6whYolp1yEjOUdxokyZezBkscHUqWSZPec5f
        Ut8TMRDL2Fjf6YpDpiSdAtado8oUohK8JwjETLqeZS8W933khRpVNXBL1e1AMittAYAFVTFZZbe0V
        kVoMcLMA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mehX6-00EPLj-Pa; Sun, 24 Oct 2021 17:43:44 +0000
Subject: Re: [PATCH v17 5/6] tpm: tpm_tis: Add tpm_tis_i2c driver
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com, jarkko@kernel.org,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
References: <20211024164855.250362-1-amirmizi6@gmail.com>
 <20211024164855.250362-6-amirmizi6@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0c82d83-7b92-3cb6-5f08-acfc33d275be@infradead.org>
Date:   Sun, 24 Oct 2021 10:43:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211024164855.250362-6-amirmizi6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/24/21 9:48 AM, amirmizi6@gmail.com wrote:
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4308f9c..ba90137 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -86,6 +86,18 @@ config TCG_TIS_SYNQUACER
>   	  To compile this driver as a module, choose  M here;
>   	  the module will be called tpm_tis_synquacer.
>   
> +config TCG_TIS_I2C
> +	tristate "TPM I2C Interface Specification"
> +	depends on I2C
> +	select CRC_CCITT
> +	select TCG_TIS_CORE
> +	help
> +	  If you have a TPM security chip, compliant with the TCG TPM PTP
> +	  (I2C interface) specification and connected to an I2C bus master,
> +	  say Yes and it will be accessible from within Linux.
> +	  To compile this driver as a module, choose  M here;

	                                      choose M here;
[drop one space]

> +	  the module will be called tpm_tis_i2c.


-- 
~Randy
