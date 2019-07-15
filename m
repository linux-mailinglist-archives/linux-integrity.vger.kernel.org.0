Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9802F68692
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfGOJpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 05:45:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:12295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbfGOJpu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 05:45:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 02:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="190510098"
Received: from pertsuli-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.224])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2019 02:45:42 -0700
Date:   Mon, 15 Jul 2019 12:45:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        devicetree <devicetree@vger.kernel.org>,
        AP MS30 Linux Kernel community 
        <linux-kernel@vger.kernel.org>, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com, kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        eyal.cohen@nuvoton.com
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Message-ID: <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 15, 2019 at 11:08:47AM +0300, Tomer Maimon wrote:
>    Thanks for your feedback and sorry for the late response.
>
>    Due to the amount of work required to handle this technical feedback and
>    project constraints we need to put this task on hold for the near future.
>
>    In the meantime, anyone from the community is welcome to take over this
>    code and handle the re-design for the benefit of the entire TPM community.

Ok, so there is already driver for this called tpm_tis_core.

So you go and create a new module, whose name given the framework of
things that we already have deployed, is destined to be tpm_tis_i2c.

Then you roughly implement a new physical layer by using  a callback
interface provided to you by tpm_tis_core.

The so called re-design was already addressed by Alexander [1].

How hard can it be seriously?

[1] https://lkml.org/lkml/2019/7/4/331

/Jarkko
