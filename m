Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC459057D
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2019 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfHPQMX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Aug 2019 12:12:23 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:12579 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfHPQMX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Aug 2019 12:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1565971942; x=1597507942;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bgES1UYn0OuA320DgkfnUC8CamR/cYkzaiUabM53suw=;
  b=HXDV63xIo1KPL25cPQXcnNIZviPtza327YogRP9xGwBl1NkWSFcnQABe
   VmeqjvIStyk5/wKgfsehgqVv2xWdW7e3ztq/9ue47UYmqMEhbs1UtjvD+
   8FeXZPKKllEtEgwXQDKI7EL6NlgPcK+FtSRTP4B8wrVSW8Z/TGA49eHh7
   c=;
IronPort-SDR: 8YlII0WjOxYtD4qCKYv394YhifjoK5oMFvGsKVFSc0QP5WqoZIwxYrIX/yf7mAbmHDbna5x/SC
 KcmRUZf++ZtQgqFiH2OEToP2vCTL98eZbc5IqO2v7yqs3My1Cd+sJ1a2NLSIBf/a0q/SPw22yc
 2bl2Q5FTvf9yTqBVunhFF8ExXUK2qv8xv2zeJi+GywWP2UKakc2X4ifrqb+M+kHrtKZLLskOYp
 +3JFLD3G1QeUpp8AgT27IXwDqas/zvd/PjDn4K3O7alaH0rOqLRTewosgjZlJ8AFaaq2NSGGvv
 t2E=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9351"; a="130794383"
X-IronPort-AV: E=Sophos;i="5.64,393,1559512800"; 
   d="scan'208";a="130794383"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 18:12:21 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 16 Aug 2019 18:12:20 +0200 (CEST)
Received: from [10.154.32.23] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 18:12:20 +0200
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     Oshri Alkobi <oshrialkoby85@gmail.com>
CC:     <Eyal.Cohen@nuvoton.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <tmaimon77@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <oshri.alkoby@nuvoton.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>, <kgoldman@us.ibm.com>,
        <nayna@linux.vnet.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>, <amir.mizinski@nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
 <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
 <548d3727-4a8f-38d4-2193-8a09cbae1e64@infineon.com>
 <CAM9mBwL=5+pGTYUKbSdw5F6soR=tW-cqfbEQ9_NmCQTO=fSVZQ@mail.gmail.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <528c9364-f4f4-d7c1-5e58-6ba6b8e90a6c@infineon.com>
Date:   Fri, 16 Aug 2019 18:12:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAM9mBwL=5+pGTYUKbSdw5F6soR=tW-cqfbEQ9_NmCQTO=fSVZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE713.infineon.com (172.23.7.71) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 15.08.2019 19:03, Oshri Alkobi wrote:
> On Thu, Jul 18, 2019 at 8:10 PM Alexander Steffen
> <Alexander.Steffen@infineon.com> wrote:
>>
>> On 18.07.2019 14:51, Eyal.Cohen@nuvoton.com wrote:
>>> Hi Jarkko and Alexander,
>>>
>>> We have made an additional code review on the TPM TIS core driver, it looks quite good and we can connect our new I2C driver to this layer.
>>
>> Great :) In the meantime, I've done some experiments creating an I2C
>> driver based on tpm_tis_core, see
>> https://patchwork.kernel.org/patch/11049363/ Please have a look at that
>> and provide your feedback (and/or use it as a basis for further
>> implementations).
>>
> 
> Sorry for the late response.
> 
> Thanks Alexander, indeed it looks much simpler.
> I've checked it with Nuvoton's TPM - basic TPM commands work

Nice :)

> I only
> had to remove the first msg from the read/write I2C transmitting
> (from/to TPM_LOC_SEL), the TPM couldn't handle two register writes in
> a sequence.
> Actually it is more efficient to set TPM_LOC_SEL only before locality
> check/request/relinquish - it is sticky.

There is one problem though: Do we assume that only the kernel driver 
will communicate with the TPM or might there be something else that also 
talks to the TPM?

If it is only the kernel driver, we could probably skip setting 
TPM_LOC_SEL at all, since it defaults to 0 and the driver will never use 
anything else. If something else does its own I2C communication with the 
TPM, it might write different values to TPM_LOC_SEL at any time, causing 
the kernel driver to use a different locality than intended. This was 
the reason I always set TPM_LOC_SEL within the same transaction.

> I still didn't manage to work with interrupts, will debug it.

Interrupt support might be broken in general at the moment, see this 
thread: https://www.spinics.net/lists/linux-integrity/msg08663.html

> We weren't aware to the implementation of Christophe/ST which looks
> good and can be complement to yours.
> If no one is currently working on that, we can prepare a new patch
> that is based on both.
> Please let us know.

I won't have the time to do anything, at least for the next two weeks, 
so feel free to pick it up.

>>> However, there are several differences between the SPI interface and the I2C interface that will require changes to the TIS core.
>>> At a minimum we thought of:
>>> 1. Handling TPM Localities in I2C is different
>>
>> It turned out not to be that different in the end, see the code
>> mentioned above and my comment here:
>> https://patchwork.kernel.org/cover/11049365/
>>
>>> 2. Handling I2C CRC - relevant only to I2C bus hence not supported today by TIS core
>>
>> That is completely optional, so there is no need to implement it in the
>> beginning. Also, do you expect a huge benefit from that functionality?
>> Are bit flips that much more likely on I2C compared to SPI, which has no
>> CRC at all, but still works fine?
>>
> 
> I2C is noisy bus with potentially more devices with larger variety
> than SPI. I2C may have more than one master and may have collisions
> and/or arbitration.

If multi-master usage is a concern, there are probably a lot more places 
in the driver that need to be adapted to deal with concurrent 
access/data corruption. For now, I'd assume a single master, similar to SPI.

Alexander
