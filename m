Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC935F744
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGDLg5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 07:36:57 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:2767 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGDLg5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 07:36:57 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 07:36:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1562240216; x=1593776216;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jj7pE5xyI7GKLRZzLxvYqwwU70BVQrx76pcVRLKA4RI=;
  b=I8myp0XAPwFYWUjtFKYtEWt3h4jGAVEHi+wgjypm5QiARvRvk7TzZTan
   W3ni6evVIN8maG4nq2whKh7mcSvndPa/tRRJVGi1qWQ7yeyBRkmnSPOhY
   hlafMmkea33Ogg0cAXvo+p4AspLJ3chtSvyj+mPPSkVkacVhjfTS8EVck
   Y=;
IronPort-SDR: IXo7G6x+FN7DENZq6DX7nJou9qS2eXOrvYbwJ9vgXAStjiOzFMQzGFiCywqbwRFxbyoO4qxlD3
 Ly1phjuUTNTw==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9307"; a="5415994"
X-IronPort-AV: E=Sophos;i="5.63,450,1557180000"; 
   d="scan'208";a="5415994"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 13:29:46 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  4 Jul 2019 13:29:45 +0200 (CEST)
Received: from [10.154.32.88] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Thu, 4
 Jul 2019 13:29:45 +0200
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Oshri Alkoby <oshrialkoby85@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <oshri.alkoby@nuvoton.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <gcwilson@us.ibm.com>,
        <kgoldman@us.ibm.com>, <nayna@linux.vnet.ibm.com>,
        <dan.morav@nuvoton.com>, <tomer.maimon@nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
Date:   Thu, 4 Jul 2019 13:29:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE716.infineon.com (172.23.7.67) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 04.07.2019 10:43, Jarkko Sakkinen wrote:
> Check out tpm_tis_core.c and tpm_tis_spi.c. TPM TIS driver implements
> that spec so you should only implement a new physical layer.

I had the same thought. Unfortunately, the I2C-TIS specification 
introduces two relevant changes compared to tpm_tis/tpm_tis_spi:

1. Locality is not encoded into register addresses anymore, but stored 
in a separate register.
2. Several register addresses have changed (but still contain compatible 
contents).

I'd still prefer not to duplicate all the high-level logic from 
tpm_tis_core. But this will probably mean to introduce some new 
interfaces between tpm_tis_core and the physical layers.

Also, shouldn't the new driver be called tpm_tis_i2c, to group it with 
all the other (TIS) drivers, that implement a vendor-independent 
protocol? With tpm_i2c_ptp users might assume that ptp is just another 
vendor.

Alexander
