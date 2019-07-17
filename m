Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0133A6B780
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQHsG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 03:48:06 -0400
Received: from mail.dice.at ([217.10.52.18]:48619 "EHLO smtp2.infineon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfGQHsG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 03:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563349685; x=1594885685;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jLjRAVqSTndz5dE6IWJsxuPEGZffP354eiHvBjyHn60=;
  b=avRws9aS+PBEzH0udYw4KuxPTCpQ6xRWzXpNLbhC9+FVc18hmg9MLigw
   6YkDbk3ATtE4d/1cQu1UiJ1j4omja+rNu8myaGz98BUBUN5nSpcsw9l1L
   RFrjiIKb7mv67fKEE/BBGDR/9b2CekIyFs9XflPb3+EJWt7ns62i/omaZ
   Y=;
IronPort-SDR: 0RGylmZ7q/+cpH2mZauRiES1hBIz41p8bF2nW1YB4JTnC/l8OARGfVjKX8yMHZXJDYRe/3Ldg5
 OwlU/xuq9lmg==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="6748731"
X-IronPort-AV: E=Sophos;i="5.64,273,1559512800"; 
   d="scan'208";a="6748731"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 09:48:03 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 17 Jul 2019 09:48:03 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Wed, 17
 Jul 2019 09:48:03 +0200
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     Tomer Maimon <tmaimon77@gmail.com>,
        Oshri Alkobi <oshrialkoby85@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        devicetree <devicetree@vger.kernel.org>,
        AP MS30 Linux Kernel community 
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>, <kgoldman@us.ibm.com>,
        <nayna@linux.vnet.ibm.com>, IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        <eyal.cohen@nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <bccd2ebf-75b1-d02f-9283-4ffd7aa36616@infineon.com>
Date:   Wed, 17 Jul 2019 09:48:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE708.infineon.com (172.23.7.82) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 15.07.2019 10:08, Tomer Maimon wrote:
> Hi Jarkko and All,
> 
> Thanks for your feedback and sorry for the late response.
> 
> 
> Due to the amount of work required to handle this technical feedback and 
> project constraints we need to put this task on hold for the near future.
> 
> In the meantime, anyone from the community is welcome to take over this 
> code and handle the re-design for the benefit of the entire TPM community.

Too bad you lack the time to finish this.

If somebody else were to pick it up, would it be possible for you to 
provide a couple of TPMs that implement this protocol, so that it can be 
properly tested?

Alexander
