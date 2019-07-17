Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584C26B7D7
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfGQIHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 04:07:15 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:52686 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQIHO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 04:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563350834; x=1594886834;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4z8rxvDFgVBdoxBzX19X1thxGhp4/RCT8vCaBQ2HjL4=;
  b=ljc+WDQOcA2UhEbHr5rorNGC3DJD/0xDeMSSRtkEey+fT64LXfG0cog4
   udRK/4YdA/fYktxi9A1sVpoOC6C57FgFqdQ6l1HWa6QazwaDFuouch7Eh
   wyx0tj2UNHwHPEkAKQ/eEjpGt5qmLtT/cGi81GU+lCDV+qdZgIA5TiGf2
   w=;
IronPort-SDR: mcBktrLRJoHDdVZv9GPazml1hMWVNYSfuqiIsCjRKVtImCc0b1m2JqHtkJ3ZVDppWMbcZWEY3S
 pHsDC3CyCj49pYxQ0xfdNOnrSAVLob2r+wXUvid8wKYgjXEwBvaHabON+mqJVvFnZTX5v3SFRk
 XDcU05JRi1TbLTmy5nN2Pj6lwqt6mdEU7q6NiTmy2hWF6kHB8EzM8E7LyAzp4I/IGC7DcEVRLg
 0CwVSzw8TjI3TR3j5A+wOaUZKpdpIdi9ifGCPyDNOWwSPTaQgK5yjYNx2TRKTAGFfxzs1JhmFq
 o6I=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="128087258"
X-IronPort-AV: E=Sophos;i="5.64,273,1559512800"; 
   d="scan'208";a="128087258"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 10:07:13 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 17 Jul 2019 10:07:12 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Wed, 17
 Jul 2019 10:07:12 +0200
Subject: Re: [PATCH v2 3/6] tpm_tis_spi: add max xfer size
To:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-4-swboyd@chromium.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <7daa4875-eddd-518d-2622-754ccfbfc421@infineon.com>
Date:   Wed, 17 Jul 2019 10:07:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716224518.62556-4-swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE714.infineon.com (172.23.7.94) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 17.07.2019 00:45, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Reject burstcounts larger than 64 bytes reported by tpm.

This is not the correct thing to do here. To quote the specification:

"burstCount is defined as the number of bytes that can be written to or 
read from the data FIFO by the software without incurring a wait state."
(https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf 
Page 84)

If the FIFO contains 1k of data, it is completely valid for the TPM to 
report that as its burstCount, there is no need to arbitrarily limit it.

Also, burstCount is a property of the high-level TIS protocol, that 
should not really care whether the low-level transfers are done via LPC 
or SPI (or I2C). Since tpm_tis_spi can only transfer 64 bytes at a time, 
it is its job to split larger transfers (which it does perfectly fine). 
This also has the advantage that burstCount needs only to be read once, 
and then we can do 16 SPI transfers in a row to read that 1k of data. 
With your change, it will read 64 bytes, then read burstCount again, 
before reading the next 64 bytes and so on. This unnecessarily limits 
performance.

Maybe you can describe the problem you're trying to solve in more 
detail, so that a better solution can be found, since this is clearly 
something not intended by the spec.

Alexander
