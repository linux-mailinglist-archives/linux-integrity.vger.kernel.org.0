Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4F230A3D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgG1MdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 08:33:19 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40244 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729470AbgG1MdS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 08:33:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U43yTeQ_1595939593;
Received: from 30.27.116.241(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U43yTeQ_1595939593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 20:33:14 +0800
Subject: Re: [PATCH v2] tpm: Fix the description error of the help information
 in Kconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Ricard <christophe.ricard@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200727082245.32396-1-tianjia.zhang@linux.alibaba.com>
 <CAK8P3a0FkrTKvAgPi=tnsShK+=eysbfiRxUTqoxfs6SJVXXnpw@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <6153c7d6-306b-9dac-4401-aec3b53da7f5@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 20:33:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0FkrTKvAgPi=tnsShK+=eysbfiRxUTqoxfs6SJVXXnpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020/7/27 16:32, Arnd Bergmann wrote:
> On Mon, Jul 27, 2020 at 10:22 AM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> SPI protocol standardized by the TCG is described in the TCG PTP
>> specification 1.3 (chapter 6.4.6 SPI Bit Protocol), It was published by
>> TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf.
> 
> I'm still not convinced you got this right, the document you cite only
> seems to mention TPM 1.2 as the base for TIS 1.3, but not TPM 1.3.
> 
>       Arnd
> 

You are right, I was careless, thanks for your reply.

Thanks and best,
Tianjia

>> The TPM version number in the help message is wrong, which will
>> cause confusion. This patch fixes it.
>>
>> Fixes: 0edbfea537d1 ("tpm/tpm_tis_spi: Add support for spi phy")
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
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
