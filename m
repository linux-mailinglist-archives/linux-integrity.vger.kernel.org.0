Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D21999E9
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgCaPia (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 11:38:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPia (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 11:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+gitPeRArdeA4p5pxqRTKKxGvRcHRsv7ZXkWGjwTB3M=; b=Yx4mVs54sJKW+wKK/7UWMK7Dvl
        mm58Z5IMAkRBe1mjDlvif+ypG91g7ziA5DdWq8WcA2c0cBWfXqtd0JBgq3N8jqVto2VF5hbU7EOwE
        q0Qc4WAzIpz67Q1v4X5L9PEHTWOj8uHnLc3sp25TooXlmnPpy5YuOONnn/tHaWhzMG8UdjzbRPF7B
        liboyLjieOJ8z51KkVdDuYq8jYeKRR84WfVNBWCzxS+AM4dAy6Zk1sZl6vZKTFW6PUzq1YMtFVxnZ
        Lo+POvvHdnUnLls+203QyYxDQKq4tpJdurI0X8ww3okBrX4ApMKOQn3Zp81m4D6VR/ykxOTT49yVd
        j7n5UqRA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIy6-0003mK-G1; Tue, 31 Mar 2020 15:38:22 +0000
Subject: Re: [PATCH v4 7/7] tpm: tpm_tis: add tpm_tis_i2c driver
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        jarkko.sakkinen@linux.intel.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-8-amirmizi6@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7365e83-06bf-e264-2b4d-3f34cc04ae2f@infradead.org>
Date:   Tue, 31 Mar 2020 08:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331113207.107080-8-amirmizi6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi--

On 3/31/20 4:32 AM, amirmizi6@gmail.com wrote:
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index aacdeed..b482bbf 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>           If you have a H1 secure module running Cr50 firmware on SPI bus,
>           say Yes and it will be accessible from within Linux.
> 
> +config TCG_TIS_I2C
> +       tristate "TPM I2C Interface Specification"
> +       depends on I2C
> +        depends on CRC_CCITT
> +       select TCG_TIS_CORE
> +       ---help---
> +         If you have a TPM security chip which is connected to a regular
> +         I2C master (i.e. most embedded platforms) that is compliant with the
> +         TCG TPM I2C Interface Specification say Yes and it will be accessible from
> +         within Linux. To compile this driver as a module, choose  M here;
> +         the module will be called tpm_tis_i2c.
> +

Please do as Documenatation/process/coding-style.rst says:

"Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces."

>  config TCG_TIS_I2C_ATMEL
>         tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
>         depends on I2C


thanks.
-- 
~Randy

