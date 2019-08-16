Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF79090507
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2019 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHPP4W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Aug 2019 11:56:22 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:41162 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfHPP4V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Aug 2019 11:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1565970980; x=1597506980;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/hDSL5+yXqoK9ZsLrgrJU5OIaG5/nQmNtSKAOjdD5Ys=;
  b=ef5nPX/4oZeFlgML88udlsLtTMgeZjaVLkkV9Hus189mOPSkt0cCmRtD
   WVxtMZF6tNUUceb1rKrvclGaAwV/Op29gyz+rMbw3k11m0bczEiiJFGpk
   J4RE92cDfzWj35ysrVax00GPr+rqLfmjX9J+CyoiZGRW7/YES1SKt2bRR
   s=;
IronPort-SDR: dXXt6HEMEx/WscydFsl5+VseijR3m7xKZAmj8B3293TXnG4GLAm63P4myX6XzXZoCb58atKAYU
 NQI14GtphJIeA5xbP6Sbxik23S0sddvb4wz/5zRbHlv2j09zDxtDgYO1HOYvCRcfTP1ilxe8Ea
 IXLGAcr4mY1eoykPJLaZO+9L22dK2htGOGuUpy/M1WlYPuc//G6pjt0AVh1sOIYiVxZT2lz+yj
 +DOWYATCiMMcvfajSGrFhYiP2bD1uaCNyi/AWQIswnBlqzo85YWdiC0TQheokBUZqf3LVbJ3Jc
 ziQ=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9351"; a="130793049"
X-IronPort-AV: E=Sophos;i="5.64,393,1559512800"; 
   d="scan'208";a="130793049"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:56:19 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 16 Aug 2019 17:56:19 +0200 (CEST)
Received: from [10.154.32.23] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 17:56:18 +0200
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
To:     Stephen Boyd <swboyd@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-2-swboyd@chromium.org>
 <20190717113956.GA12119@ziepe.ca>
 <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
 <20190717165011.GI12119@ziepe.ca>
 <5d2f54db.1c69fb81.5720c.dc05@mx.google.com>
 <5d44be49.1c69fb81.8078a.4d08@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <d72750b9-38b8-172f-8902-427fcc3d0a5d@infineon.com>
Date:   Fri, 16 Aug 2019 17:56:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d44be49.1c69fb81.8078a.4d08@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE716.infineon.com (172.23.7.67) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 03.08.2019 00:50, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-07-17 10:03:22)
>> Quoting Jason Gunthorpe (2019-07-17 09:50:11)
>>> On Wed, Jul 17, 2019 at 09:42:32AM -0700, Stephen Boyd wrote:
>>
>> Yes. That's exactly my point. A hwrng that's suspended will fail here
>> and it's better to just not try until it's guaranteed to have resumed.
>>
>>>
>>> It just seems weird to do this, what about all the other tpm API
>>> users? Do they have a racy problem with suspend too?
>>
>> I haven't looked at them. Are they being called from suspend/resume
>> paths? I don't think anything for the userspace API can be a problem
>> because those tasks are all frozen. The only problem would be some
>> kernel internal API that TPM API exposes. I did a quick grep and I see
>> things like IMA or the trusted keys APIs that might need a closer look.
>>
>> Either way, trying to hold off a TPM operation from the TPM API when
>> we're suspended isn't really possible. If something like IMA needs to
>> get TPM data from deep suspend path and it fails because the device is
>> suspended, all we can do is return an error from TPM APIs and hope the
>> caller can recover. The fix is probably going to be to change the code
>> to not call into the TPM API until the hardware has resumed by avoiding
>> doing anything with the TPM until resume is over. So we're at best able
>> to make same sort of band-aid here in the TPM API where all we can do is
>> say -EAGAIN but we can't tell the caller when to try again.
>>
> 
> Andrey talked to me a little about this today. Andrey would prefer we
> don't just let the TPM go into a wonky state if it's used during
> suspend/resume so that it can stay resilient to errors. Sounds OK to me,
> but my point still stands that we need to fix the callers.
> 
> I'll resurrect the IS_SUSPENDED flag and make it set generically by the
> tpm_pm_suspend() and tpm_pm_resume() functions and then spit out a big
> WARN_ON() and return an error value like -EAGAIN if the TPM functions
> are called when the TPM is suspended. I hope we don't hit the warning
> message, but if we do then at least we can track it down rather quickly
> and figure out how to fix the caller instead of just silently returning
> -EAGAIN and hoping for that to be visible to the user.

There is another use case I see for this functionality: There are ways 
for user space to upgrade the TPM's firmware via /dev/tpm0 (using e.g. 
TPM2_FieldUpgradeStart/TPM2_FieldUpgradeData). While upgrading, the 
normal TPM functionality might not be available (commands return 
TPM_RC_UPGRADE or other error codes). Even after the upgrade is 
finished, the TPM might continue to refuse command execution (e.g. with 
TPM_RC_REBOOT).

I'm not sure whether all in-kernel users are prepared to deal correctly 
with those error codes. But even if they are, it might be better to 
block them from sending commands in the first place, to not interfere 
with the upgrade process.

What would you think about a way for a user space upgrade tool to also 
set this flag, to make the TPM unavailable for everything but the 
upgrade process?

Alexander
