Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97312D50E
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2019 00:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfL3X2m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 18:28:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:56340 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfL3X2l (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 18:28:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 15:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,376,1571727600"; 
   d="scan'208";a="215899055"
Received: from fjkilken-mobl.ger.corp.intel.com ([10.252.8.107])
  by fmsmga008.fm.intel.com with ESMTP; 30 Dec 2019 15:28:37 -0800
Message-ID: <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Dec 2019 01:28:36 +0200
In-Reply-To: <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
References: <1577122577157232@kroah.com>
         <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
         <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
         <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
         <20191228151526.GA6971@linux.intel.com>
         <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
         <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-12-29 at 23:41 -0800, Dan Williams wrote:
> This looked like the wrong revert to me, and testing confirms that
> this does not fix the problem.
> 
> As I mentioned in the original report [1] the commit that bisect flagged was:
> 
>     5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
> 
> That commit moved tpm_chip_start() before irq probing. Commit
> 21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
> does not appear to change anything in that regard.
> 
> Perhaps this hardware has always had broken interrupts and needs to be
> quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
> workaround.
> 
> 
> [1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/

I think for short term, yes, it is better to revert the commits
that make things more broken.

for-linus-v5.5-rc5 branch contains three commits that exactly do
this i.e. the reverts that Stefan sent and revert to Jerry's earlier
commit.

After that is out of the table it is easier to analyze how the code
should be actually refactored. Like, I have no idea when I get
local HW that can reproduce this and Jerry still seems to have the
same issue. It'd be nice make the exactly right changes instead of
reverts but situation is what it is.

Please check the branch and ACK/NAK if I can add tested-by's (and
other tags).

/Jarkko

