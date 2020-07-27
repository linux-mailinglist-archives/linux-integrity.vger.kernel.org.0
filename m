Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E825722E7A9
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0IZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 04:25:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59391 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgG0IZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 04:25:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U3v2TZF_1595838353;
Received: from 30.27.116.241(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U3v2TZF_1595838353)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Jul 2020 16:25:54 +0800
Subject: Re: [PATCH] tpm: Fix the description error of the help information in
 Kconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christophe Ricard <christophe.ricard@gmail.com>,
        Peter Huewe <peter.huewe@infineon.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
References: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
 <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <13d8ab17-5cea-3e00-ecdb-87c68d7f2a15@linux.alibaba.com>
Date:   Mon, 27 Jul 2020 16:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for your advice, I have submitted a v2 patch.

Thanks,
Tianjia

On 2020/7/27 15:10, Arnd Bergmann wrote:
> On Mon, Jul 27, 2020 at 4:54 AM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> Obviously, the TPM version number in the help message is wrong, which
>> will cause confusion. This patch fixes it.
> 
> How is this "obvious"? I tried finding the specification and could not
> see anything
> to back up TIS 1.3 being only supported with TPM 1.3, or the existence of a
> TPM 1.3 specification at all.
> 
> Please consider that not everyone reading this patch description is deeply
> familiar with the details and explain exactly what the mistake is.
> 
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> In a bug fix, try to always add a 'FIxes' tag such as 'Fixes: 0edbfea537d1
> ("tpm/tpm_tis_spi: Add support for spi phy")', and Cc everyone that was
> involved in the original patch that introduced a bug so they can Ack or
> Nak it.
> 
>        Arnd
> 
>>   drivers/char/tpm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 58b4c573d176..8eedb3e704f3 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -62,7 +62,7 @@ config TCG_TIS_SPI
>>          help
>>            If you have a TPM security chip which is connected to a regular,
>>            non-tcg SPI master (i.e. most embedded platforms) that is compliant with the
>> -         TCG TIS 1.3 TPM specification (TPM1.2) or the TCG PTP FIFO
>> +         TCG TIS 1.3 TPM specification (TPM1.3) or the TCG PTP FIFO
>>            specification (TPM2.0) say Yes and it will be accessible from
>>            within Linux. To compile this driver as a module, choose  M here;
>>            the module will be called tpm_tis_spi.
>> --
>> 2.17.1
>>
