Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5943151A2E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2020 13:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBDMAw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Feb 2020 07:00:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:55649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgBDMAw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Feb 2020 07:00:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 04:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="279039776"
Received: from kirillbx-mobl.ccr.corp.intel.com (HELO localhost) ([10.251.84.125])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2020 04:00:49 -0800
Date:   Tue, 4 Feb 2020 14:00:48 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 4/6] tpm: tpm_tis_spi: Support cr50 devices
Message-ID: <20200204120048.GA28552@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20190920183240.181420-5-swboyd@chromium.org>
 <007dfd87-5170-684a-26dc-9e7533d42034@infineon.com>
 <5e38bcbd.1c69fb81.a383.c572@mx.google.com>
 <9064d7e2-d0ae-0cf0-294f-a795da336a6f@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9064d7e2-d0ae-0cf0-294f-a795da336a6f@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 04, 2020 at 08:15:49AM +0100, Alexander Steffen wrote:
> The scripts are effectively using modprobe/rmmod/etc. and those need the
> name. modprobe can be fixed by defining an alias, but this does not work for
> rmmod. Many other things also depend on the name, e.g. module blacklisting
> or the output of lsmod, where people might now get confused by the
> difference between "tpm_tis_spi_mod" and "tpm_tis_i2c". Also, there are many
> tutorials out there, that explicitly tell users to run something like
> "modprobe tpm_tis_spi", which won't work anymore now.
> 
> So, if there is a good reason to break compatibility, I'm fine with that.
> But in this case, isn't there some way to achieve the desired functionality
> without changing the name? Even if it is a little more complex than the
> three-line change above, that would probably be worth it.

Nope, you're right. I'll work out a fix for this and
add you as reported-by.

/Jarkko
