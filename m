Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1237B349
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELBJu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 21:09:50 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:42829 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhELBJu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 21:09:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UYb.WBW_1620781721;
Received: from 30.225.35.235(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UYb.WBW_1620781721)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 09:08:41 +0800
Subject: Re: [PATCH] tpm_tis_spi: set default probe function if device id not
 match
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
 <YJXxDzougt3ZC01q@kernel.org>
 <e74fd54f-1700-4b06-a320-c0e257666565@linux.alibaba.com>
 <YJhIcIXMFj/LcYwu@kernel.org>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <0ec3ed60-6967-c14a-d1f3-0ff80c9d5003@linux.alibaba.com>
Date:   Wed, 12 May 2021 09:07:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJhIcIXMFj/LcYwu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

在 2021/5/10 4:39, Jarkko Sakkinen 写道:
> On Sat, May 08, 2021 at 10:46:57AM +0800, 乱石 wrote:
>> Hi,
>>
>> 在 2021/5/8 10:01, Jarkko Sakkinen 写道:
>>> On Fri, May 07, 2021 at 10:52:55PM +0800, Liguang Zhang wrote:
>>>> In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
>>>> kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
>>>> causes device probe fails. In order to make newer kernel to be
>>>> compatible with the older acpi definition, it would be best set default
>>>> probe function.
>>>>
>>>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>>>> ---
>>>>    drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>>>> index 3856f6ebcb34..da632a582621 100644
>>>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>>>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>>>> @@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>>>>    	tpm_tis_spi_probe_func probe_func;
>>>>    	probe_func = of_device_get_match_data(&spi->dev);
>>>> -	if (!probe_func && spi_dev_id)
>>>> -		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
>>>> -	if (!probe_func)
>>>> -		return -ENODEV;
>>>> +	if (!probe_func) {
>>>> +		if (spi_dev_id) {
>>>> +			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
>>>> +			if (!probe_func)
>>>> +				return -ENODEV;
>>> Perhaps also hear fallback to tpm_tis_spi_probe?
>>
>> Yes, I do not think of a good way. Do you have any suggestions?
> So, I just think that when you have this part:
>
>
> if (!probe_func) {
> 	if (spi_dev_id) {
>                  probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
>                  if (!probe_func)
>                          return -ENODEV;
>
> Why in here would not you also want to fallback to tpm_tis_spi_probe?

Sorry to trouble you, do you have a good way to resolve the compatible 
problem caused by kernel update (4.19 -> 5.10) ?


Liguang

>
> /Jarkko
