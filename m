Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19496122ADF
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfLQMFO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 07:05:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:2665 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQMFO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 07:05:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 04:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="221746321"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 04:05:10 -0800
Message-ID: <5d0763334def7d7ae1e7cf931ef9b14184dce238.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of
 tpm_tis_core_init
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Date:   Tue, 17 Dec 2019 14:05:08 +0200
In-Reply-To: <CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com>
References: <20191211231758.22263-1-jsnitsel@redhat.com>
         <20191211235455.24424-1-jsnitsel@redhat.com>
         <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
         <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
         <20191217020022.knh7uxt4pn77wk5m@cantor>
         <CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-16 at 18:14 -0800, Dan Williams wrote:
> On Mon, Dec 16, 2019 at 6:00 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > On Mon Dec 16 19, Dan Williams wrote:
> > > On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
> > > > > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> > > > > issuing commands to the tpm during initialization, just reserve the
> > > > > chip after wait_startup, and release it when we are ready to call
> > > > > tpm_chip_register.
> > > > > 
> > > > > Cc: Christian Bundy <christianbundy@fraction.io>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: linux-integrity@vger.kernel.org
> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > > > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > 
> > > > I pushed to my master with minor tweaks and added my tags.
> > > > 
> > > > Please check before I put it to linux-next.
> > > 
> > > I don't see it yet here:
> > > 
> > > http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
> > > 
> > > However, I wanted to make sure you captured that this does *not* fix
> > > the interrupt issue. I.e. make sure you remove the "Fixes:
> > > 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
> > > tag.
> > > 
> > > With that said, are you going to include the revert of:
> > > 
> > > 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
> > 
> > Dan, with the above reverted do you still get the screaming interrupt?
> 
> Yes, the screaming interrupt goes away, although it is replaced by
> these messages when the driver starts:
> 
> [    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
> [    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
> [    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
> polling instead
> 
> If the choice is "error message + polled-mode" vs "pinning a cpu with
> interrupts" I'd accept the former, but wanted Jarkko with his
> maintainer hat to weigh in.
> 
> Is there a simple sanity check I can run to see if the TPM is still
> operational in this state?

What about T490S?

/Jarkko

