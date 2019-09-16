Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22E1B36D6
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfIPJHs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 05:07:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:2592 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbfIPJHr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 05:07:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176986019"
Received: from opirvulx-wtg.ger.corp.intel.com (HELO localhost) ([10.252.55.135])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2019 02:07:42 -0700
Date:   Mon, 16 Sep 2019 12:07:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Vanya Lazeev <ivan.lazeev@gmail.com>, arnd@arndb.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190916090741.GA31747@linux.intel.com>
References: <CAHjaAcStAfarJoPG0tbSY0BVcp0-7Lvah2FdpmC_eCFfxaSVFw@mail.gmail.com>
 <20190913140006.GA29755@linux.intel.com>
 <20190913140218.GB29755@linux.intel.com>
 <CAHjaAcSBCDnn7CwXfxYcfmRnAF2jdud1Sjwng_jtd8ASVS28Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcSBCDnn7CwXfxYcfmRnAF2jdud1Sjwng_jtd8ASVS28Sg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 02:29:01PM +0900, Seunghun Han wrote:
> >
> > On Fri, Sep 13, 2019 at 03:00:06PM +0100, Jarkko Sakkinen wrote:
> > > On Wed, Sep 11, 2019 at 02:17:48PM +0900, Seunghun Han wrote:
> > > > Vanya,
> > > > I also made a patch series to solve AMD's fTPM. My patch link is here,
> > > > https://lkml.org/lkml/2019/9/9/132 .
> > > >
> > > > The maintainer, Jarkko, wanted me to remark on your patch, so I would
> > > > like to cooperate with you.
> > > >
> > > > Your patch is good for me. If you are fine, I would like to take your
> > > > patch and merge it with my patch series. I also would like to change
> > > > some points Jason mentioned before.
> > >
> > > I rather handle the review processes separately because I can merge
> > > Vanyas's patch first. Bundling them into patch set would only slow
> > > down things.
> >
> > I did not ask to do anything. I just review code changes.
> 
> I got it. I should concentrate on my ACPI NVS problem.
> Thank you.

Eessentially what you want to do is to detach and backup the original
NVS resources and put them back to the list with insert_resource() when
tpm_crb is removed. At least I think this is what should be done but you
should CC your patch also to the ACPI list for feedback.

/Jarkko
