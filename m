Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEC60548
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfGEL2N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 07:28:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:64432 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfGEL2N (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 07:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 04:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="339810868"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2019 04:28:07 -0700
Message-ID: <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        oshri.alkoby@nuvoton.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com, kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Date:   Fri, 05 Jul 2019 14:28:07 +0300
In-Reply-To: <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
         <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
         <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
         <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-04 at 12:48 -0500, Oshri Alkobi wrote:
> Alex, Jarkko, thank you very much for your feedbacks!

Please configure your email client to use plain text.

> I totally agree, there are some duplications that can be common, indeed it
> will require some work in tpm_tis_core.
> Since I believe it is not going to happen soon, I would suggest to examine
> what duplications can currently be dropped from the new driver, so the kernel
> will support the PTP I2C interface in the meantime.
> I will appreciate getting ideas about any tpm_tis_core logic that currently
> can be used as is by the new drive.

I rather wait for a solution that integrates with our mature stack for
TIS (or these days FIFO) than integrate something half-baked. If you
want something in, please do right things right.

What you are proposing would mean maintaining duplicate stacks forever.

> Since the TIS is an old specification that mostly defines FIFO for TPM1.2 I
> would say the name tpm_tis_i2c does not completely reflect its goal. However
> we really don't have any problem with any name that the group will agree on.
> Does tpm_ptp_i2c sound better than the current name?

Absolutely not going to use that name. The naming convention is what
it is for other drivers that are adapt tpm_tis_core to different HW
interfaces.

/Jarkko

