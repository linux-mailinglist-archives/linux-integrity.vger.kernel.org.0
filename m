Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B64D9714
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbfJPQXf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 12:23:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:36442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfJPQXf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 12:23:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="202115587"
Received: from hagarwal-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.5.165])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2019 09:23:29 -0700
Date:   Wed, 16 Oct 2019 19:23:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191016162312.GA6279@linux.intel.com>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com>
 <20191016104110.GB10184@linux.intel.com>
 <CAE=Ncrb_7wQsv0_EvZWe5-WA2UU_GywgfnVo7hC-FDTY6bzpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=Ncrb_7wQsv0_EvZWe5-WA2UU_GywgfnVo7hC-FDTY6bzpFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 16, 2019 at 02:16:20PM +0300, Janne Karhunen wrote:
> On Wed, Oct 16, 2019 at 1:41 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > > > get_random_bytes().  TPM could have a bug (making results predicatable),
> > > > backdoor or even an inteposer in the bus. Salting gives protections
> > > > against these concerns.
> > >
> > > The current issue in the randomness from my point of view is that
> > > encrypted filesystems, ima etc in common deployments require high
> > > quality entropy just few seconds after the system has powered on for
> > > the first time. It is likely that people want to keep their keys
> > > device specific, so the keys need to be generated on the first boot
> > > before any of the filesystems mount.
> >
> > This patch does not have the described issue.
> 
> My understanding was that you wanted to make the tpm_get_random() an
> alternative to get_random_bytes(), and one reason why one might want
> to do this is to work around the issues in get_random_bytes() in early
> init as it may not be properly seeded. But sure, if you this wasn't
> among the problems being solved then forget it.

I'm trying to get a framework on how rng's should be used in the
kernel. There doesn't seem to be one.

/Jarkko
