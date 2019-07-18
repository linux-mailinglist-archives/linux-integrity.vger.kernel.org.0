Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944BE6D28F
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGRRKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 13:10:06 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:53366 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRRKG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 13:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563469806; x=1595005806;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uYQpB2SpaLcCphJei8uoWMZ+wuxVK+eGJl7as7wxcWw=;
  b=Getiwo6HDC7X5jixTRKAVPTKCsDAWsqxSb+rARyA7ZjqhgteZBvIINMQ
   2lqYkXtOrQ/tQSuAuU0xpKcEdzx4BtGrCevIMGF+wwo1WarOA4xYejtSU
   KwUCR/rXnRg507sAoFSErZDRjLtWA7vLhqwzP+Evu/naNQXHWPrf+7hn2
   g=;
IronPort-SDR: rHd4GE8rbjWoeoPfI8EXQQ+1NixxkdbxyuchgG3iLzVAzCtyI6EmxtNfwLf0/axLZVK91DdNNe
 KOTgfRoSQDSWC0H3Zlt/ixVA2s4UQoJ+ZCg/P8U7KnnU2GZ/Za0Dew6+mb4lSVe6NhjWgG5cJw
 sfFI1hCHCZ3mnovB2izFm6sv48SKfMRA9XmQJhh2NHrBEq/n2ZAAey8j9da1CS1j8Tj0nkXx8Q
 HZ1tXBRa51n23zbZ1uRDo2XLZvGKTknDxpuy8jcQ0Owd97YUF/AK6JbbFifZcqZ/t20rXXvdnw
 0iE=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="128253562"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="128253562"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 19:10:04 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 19:10:03 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Thu, 18
 Jul 2019 19:10:03 +0200
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     <Eyal.Cohen@nuvoton.com>, <jarkko.sakkinen@linux.intel.com>,
        <tmaimon77@gmail.com>
CC:     <oshrialkoby85@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <oshri.alkoby@nuvoton.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>, <kgoldman@us.ibm.com>,
        <nayna@linux.vnet.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
 <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <548d3727-4a8f-38d4-2193-8a09cbae1e64@infineon.com>
Date:   Thu, 18 Jul 2019 19:10:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE714.infineon.com (172.23.7.94) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18.07.2019 14:51, Eyal.Cohen@nuvoton.com wrote:
> Hi Jarkko and Alexander,
> 
> We have made an additional code review on the TPM TIS core driver, it looks quite good and we can connect our new I2C driver to this layer.

Great :) In the meantime, I've done some experiments creating an I2C 
driver based on tpm_tis_core, see 
https://patchwork.kernel.org/patch/11049363/ Please have a look at that 
and provide your feedback (and/or use it as a basis for further 
implementations).

> However, there are several differences between the SPI interface and the I2C interface that will require changes to the TIS core.
> At a minimum we thought of:
> 1. Handling TPM Localities in I2C is different

It turned out not to be that different in the end, see the code 
mentioned above and my comment here: 
https://patchwork.kernel.org/cover/11049365/

> 2. Handling I2C CRC - relevant only to I2C bus hence not supported today by TIS core

That is completely optional, so there is no need to implement it in the 
beginning. Also, do you expect a huge benefit from that functionality? 
Are bit flips that much more likely on I2C compared to SPI, which has no 
CRC at all, but still works fine?

> 3. Handling Chip specific issues, since I2C implementation might be slightly different across the various TPM vendors

Right, that seems similar to the cr50 issues 
(https://lkml.org/lkml/2019/7/17/677), so there should probably be a 
similar way to do it.

> 4. Modify tpm_tis_send_data and tpm_tis_recv_data to work according the TCG Device Driver Guide (optimization on TPM_STS access and send/recv retry)

Optimizations are always welcome, but I'd expect basic communication to 
work already with the current code (though maybe not as efficiently as 
possible).

> Besides this, during development we might encounter additional differences between SPI and I2C.
> 
> We currently target to allocate an eng. to work on this on the second half of August with a goal to have the driver ready for the next kernel merge window.
> 
> Regards,
> Eyal.
