Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA946E1EE
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGSHvV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jul 2019 03:51:21 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:50705 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSHvU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jul 2019 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563522678; x=1595058678;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4GdfmrkKT06GO7RCCmkbRB6SDwQ3x/rrhvJ/HISRK8k=;
  b=RlELKag34L5Qco/oaz3v9h3PDPOrf5tnFNsmgObAY/PSwcx1pYLmwMoH
   NRe4Ugefaey+t8wcO6XTs4YgW9APQij83FWzVLYOARLWgb44c5KJfcXGm
   P8uwGBwBjrGo/Xj4iVyCStVGaG9AFgGW5AWUw4lRxpD+JAr9yChuwv+UZ
   0=;
IronPort-SDR: fp1uO2tUMx0mrkha+4j7QUr9uQ5AEQGdnPiAIHQB/OezR1DkEawTdTGdyTARCnZe4wgUWUV5jF
 N+qEEGzf3zAA==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="6978599"
X-IronPort-AV: E=Sophos;i="5.64,281,1559512800"; 
   d="scan'208";a="6978599"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 09:51:17 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 19 Jul 2019 09:51:17 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Fri, 19
 Jul 2019 09:51:16 +0200
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
 <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
 <5d30b567.1c69fb81.e6308.74a2@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <7f570b08-59fb-add9-9502-96d284e0d4da@infineon.com>
Date:   Fri, 19 Jul 2019 09:51:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d30b567.1c69fb81.e6308.74a2@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE716.infineon.com (172.23.7.67) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18.07.2019 20:07, Stephen Boyd wrote:
> Quoting Alexander Steffen (2019-07-18 09:47:14)
>> On 17.07.2019 21:57, Stephen Boyd wrote:
>>>
>>> I think the idea is to let users override the quality if they decide
>>> that they don't want to use the default value specified in the driver.
>>
>> But isn't this something that applies to all TPMs, not only cr50? So
>> shouldn't this parameter be added to one of the global modules (tpm?
>> tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis,
>> tpm_tis_spi, ...) need this parameter to provide a consistent interface
>> for the user?
> 
> Looking at commit 7a64c5597aa4 ("tpm: Allow tpm_tis drivers to set hwrng
> quality.") I think all low-level drivers need to set the hwrng quality
> somehow. I'm not sure how tpm_tis_spi will do that in general, but at
> least for cr50 we have derived this quality number.
> 
> I can move this module parameter to tpm_tis_core.c, but then it will be
> a global hwrng quality override for whatever tpm is registered through
> tpm_tis_core instead of per-tpm driver. This is sort of a problem right
> now too if we have two tpm_tis_spi devices. I can drop this parameter if
> you want.

Since it does not seem like a critical feature, maybe just drop it for 
now. Then we can figure out a way to do it properly and add it later.

Alexander
