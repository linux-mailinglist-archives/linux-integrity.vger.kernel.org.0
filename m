Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED34CAE3C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbfJCSdN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 14:33:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:57758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfJCSdM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 14:33:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 11:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="221875838"
Received: from okiselev-mobl1.ccr.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2019 11:33:08 -0700
Date:   Thu, 3 Oct 2019 21:33:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20191003183306.GC20683@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
 <20190926124635.GA6040@linux.intel.com>
 <20190926131227.GA6582@linux.intel.com>
 <1570020024.4999.104.camel@linux.ibm.com>
 <20191003113211.GC8933@linux.intel.com>
 <20191003113313.GD8933@linux.intel.com>
 <1570116261.4421.199.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570116261.4421.199.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 11:24:21AM -0400, Mimi Zohar wrote:
> On Thu, 2019-10-03 at 14:33 +0300, Jarkko Sakkinen wrote:
> 
> > > > Will this delay the TPM initialization, causing IMA to go into "TPM
> > > > bypass mode"?
> > > 
> > > Of course it will delay the init.
> > > 
> > > As I've stated before the real fix for the bypass issue would be
> > > to make TPM as part of the core but this has not received much
> > > appeal. I think I've sent patch for this once.
> 
> IMA initialization is way later than the TPM.  IMA is on the
> late_initcall(), while the TPM is on the subsys_initcall().  I'm not
> sure moving the TPM to core would make a difference.  There must be a
> way of deferring IMA until after the TPM has been initialized.  Any
> suggestions would be much appreciated.
> 
> (The TPM on the Pi still has a dependency on clock.) 

Right. I seriously need to study IMA code in near future with time.

> > It has been like that people reject a fix to a race condition and
> > then I get complains on adding minor latency to the init because
> > of the existing race. It is ridicilous, really.
> 
> I agree, but adding any latency will cause a regression.

OK, I get the picture here now. I have to some day look at the IMA
code and see if I could draft something that would improve the
situation. Thanks for explaining all this!

/Jarkko
