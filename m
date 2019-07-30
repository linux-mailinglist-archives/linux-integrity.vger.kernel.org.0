Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6737B05D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfG3RmU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 13:42:20 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:23468 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3RmU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 13:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1564508538; x=1596044538;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u1ug0QK6quNbVSyr//SBMADRepDbDkeow8KcvedLTNc=;
  b=nGEOxUCQ/mIL0T4jdLldlZosLUzLWSh4rbN7ua5DTsBiUt93HLC7VJVj
   shitTJdTw/ZZ/XJBPYIc9L2OZE/7Rdao55MCblS4PnOEQ7cf8Gf+L9067
   YTpeu3TonpDyYVBGe00AeY8bzpjMU54ulISdDH1RRs6szpZS2szkEg6vg
   M=;
IronPort-SDR: nZp23Lb7MCjAsl1O2rUX/PhNWcB87/45mLn7TLJ5llPxFehzPykkxQFKQPCmpcZwAatBVyvCdT
 nR38+h2EXlGtRkAiYn4A6SKtR/vW/+NvwnS1uhzzjDFit/O1idY+UYPmaXhkXas+Sj3sAm2vYx
 1hCtYOyDjFNTQ4EQnr+6xiuEwGHOyQwXkPh1ux7aH7HXIfvYnR61U3RMSXy1J8bdMjDlgn+FLU
 gQmH6guxNNOz2lYjlgZWUS5PNYGzy4RxVawlMVumVT2q3IeGj67yC+HJsD45C1GjgoQdvkStkz
 pXA=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9334"; a="129245840"
X-IronPort-AV: E=Sophos;i="5.64,327,1559512800"; 
   d="scan'208";a="129245840"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 19:42:17 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 30 Jul 2019 19:42:16 +0200 (CEST)
Received: from [10.154.32.18] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Tue, 30
 Jul 2019 19:42:16 +0200
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     Benoit HOUYERE <benoit.houyere@st.com>,
        "Eyal.Cohen@nuvoton.com" <Eyal.Cohen@nuvoton.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>
CC:     "oshrialkoby85@gmail.com" <oshrialkoby85@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "oshri.alkoby@nuvoton.com" <oshri.alkoby@nuvoton.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@us.ibm.com" <gcwilson@us.ibm.com>,
        "kgoldman@us.ibm.com" <kgoldman@us.ibm.com>,
        "nayna@linux.vnet.ibm.com" <nayna@linux.vnet.ibm.com>,
        "Dan.Morav@nuvoton.com" <Dan.Morav@nuvoton.com>,
        "oren.tanami@nuvoton.com" <oren.tanami@nuvoton.com>,
        "Christophe Ricard (christophe.ricard@gmail.com)" 
        <christophe.ricard@gmail.com>, Elena WILLIS <elena.willis@st.com>,
        Olivier COLLART <olivier.collart@st.com>
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
 <2e86f1b6a3c04c9889d0f12f4eb079d4@SFHDAG3NODE3.st.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <ef3e9f2f-9c8e-7cc1-dc4c-dc1833592238@infineon.com>
Date:   Tue, 30 Jul 2019 19:42:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2e86f1b6a3c04c9889d0f12f4eb079d4@SFHDAG3NODE3.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE705.infineon.com (172.23.7.79) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Benoit,

good to see you're still around.

On 30.07.2019 10:39, Benoit HOUYERE wrote:
> Hi Alexander, Jarkko and Eyal,
> 
> A first I2C TCG patch (tpm_tis_i2c.c) has been proposed in the same time as tpm_tis_spi.c by Christophe 3 years ago.
> 
> https://patchwork.kernel.org/patch/8628681/

Thanks for mentioning this. I forgot it exists, since it was still on 
the old mailing list.

> At the time, we have had two concerns :
> 	1) I2C TPM component number, in the market, compliant with new I2C TCG specification to validate new I2C driver.
> 	2) Lots changing  was already provided by tpm_tis_spi.c on 4.8.
> 
> That's why Tpm_tis_i2c.c has been postponed.
> 
> Tpm_tis_spi Linux driver is now robust, if we have several different I2C TPM solutions today to validate a tpm_tis_i2c driver, I 'm ready to contribute to it for validation (STmicro TPM) or propose a solution compatible on 5.1 linux driver if needed under timeframe proposed (second half of august).

Could you run your tests against the simple implementation that I posted 
a while ago (https://patchwork.kernel.org/cover/11049365/) and provide 
your feedback? Since it is already based on the current tpm_tis_core, it 
is probably easier to integrate necessary changes there.

By the way, has it gotten any easier in the meantime to get hold of your 
TPMs to use them for kernel tests?

Alexander
