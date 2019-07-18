Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0C6D249
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbfGRQrR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 12:47:17 -0400
Received: from mail.dice.at ([217.10.52.18]:8089 "EHLO smtp2.infineon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfGRQrR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 12:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563468436; x=1595004436;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OilpCINQlJ1Ia1M9So3ozgyl/1+paFeash3IP9Fq88I=;
  b=jUQU5IqSAkFMJanTXUC6Inprsa6Z+Dbsx4vuzhNk+Al/m++DCRSSSZvs
   67sLeBLL6o7MVXGNxvkKKAmNgiuGBgujOUHHOmpAJliLIv2S3SaHBwB/Q
   9BlYmjRBRacTpzoi11BRu1WttGQDoW/JPCJtS2ZvzJyHKrZb0RqP9heFf
   U=;
IronPort-SDR: wWDE+YOCDVSGwKN4aaA4IAK3vzAyij4qICrart3MqkiQBJ94n4NH60gKb+2uYxu+CyICuNEZKN
 a1Fr2jrq1LSg==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="6918400"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="6918400"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 18:47:15 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 18:47:14 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Thu, 18
 Jul 2019 18:47:14 +0200
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
Date:   Thu, 18 Jul 2019 18:47:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE704.infineon.com (172.23.7.78) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 17.07.2019 21:57, Stephen Boyd wrote:
> Quoting Alexander Steffen (2019-07-17 05:00:06)
>> On 17.07.2019 00:45, Stephen Boyd wrote:
>>> From: Andrey Pronin <apronin@chromium.org>
>>>
>>> +static unsigned short rng_quality = 1022;
>>> +module_param(rng_quality, ushort, 0644);
>>> +MODULE_PARM_DESC(rng_quality,
>>> +              "Estimation of true entropy, in bits per 1024 bits.");
>>
>> What is the purpose of this parameter? None of the other TPM drivers
>> have it.
> 
> I think the idea is to let users override the quality if they decide
> that they don't want to use the default value specified in the driver.

But isn't this something that applies to all TPMs, not only cr50? So 
shouldn't this parameter be added to one of the global modules (tpm? 
tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis, 
tpm_tis_spi, ...) need this parameter to provide a consistent interface 
for the user?

>> This copies a lot of code from tpm_tis_spi, but then slightly changes
>> some things, without really explaining why.
> 
> The commit text has some explanations. Here's the copy/paste from above:
> 
>>>    - need to ensure a certain delay between spi transactions, or else
>>>      the chip may miss some part of the next transaction;
>>>    - if there is no spi activity for some time, it may go to sleep,
>>>      and needs to be waken up before sending further commands;
>>>    - access to vendor-specific registers.
> 
> Do you want me to describe something further?
> 
>> For example, struct
>> cr50_spi_phy contains both tx_buf and rx_buf, whereas tpm_tis_spi uses a
>> single iobuf, that is allocated via devm_kmalloc instead of being part
>> of the struct. Maybe the difference matters, maybe not, who knows?
> 
> Ok. Are you asking if this is a full-duplex SPI device?

No, this was meant as an example for the previous question. As far as I 
understood it, cr50 is basically compliant to the spec implemented by 
tpm_tis_spi, but needs special handling in some cases. Therefore, I'd 
expect a driver for cr50 to look exactly like tpm_tis_spi except for the 
special bits here and there. The way buffers are allocated within the 
driver is probably not something that should differ because of the TPM chip.

Alexander
