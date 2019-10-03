Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF1CAE30
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfJCSbH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 14:31:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:45441 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbfJCSbH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 14:31:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 11:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="216909589"
Received: from jvalevi1-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2019 11:31:02 -0700
Date:   Thu, 3 Oct 2019 21:31:01 +0300
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
Message-ID: <20191003182934.GB20683@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
 <20190926124635.GA6040@linux.intel.com>
 <20190926131227.GA6582@linux.intel.com>
 <1570020024.4999.104.camel@linux.ibm.com>
 <20191003113211.GC8933@linux.intel.com>
 <1570106350.4421.166.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570106350.4421.166.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 08:39:10AM -0400, Mimi Zohar wrote:
> On Thu, 2019-10-03 at 14:32 +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 02, 2019 at 08:40:24AM -0400, Mimi Zohar wrote:
> > > On Thu, 2019-09-26 at 16:12 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Sep 26, 2019 at 03:46:35PM +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Sep 25, 2019 at 04:48:41PM +0300, Jarkko Sakkinen wrote:
> > > > > > -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > > > > > +		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
> > > > > > +			      TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_EXTEND);
> > > > > 
> > > > > Oops.
> > > > 
> > > > Maybe we could use random as the probe for TPM version since we anyway
> > > > send a TPM command as a probe for TPM version:
> > > > 
> > > > 1. Try TPM2 get random.
> > > > 2. If fail, try TPM1 get random.
> > > > 3. Output random number to klog.
> > > > 
> > > > Something like 8 bytes would be sufficient. This would make sure that
> > > > no new change breaks tpm_get_random() and also this would give some
> > > > feedback that TPM is at least somewhat working.
> > > 
> > > That involves sending 2 TPM commands.  At what point does this occur?
> > >  On registration?  Whenever getting a random number?  Is the result
> > > cached in chip->flags?
> > 
> > On registeration. It is just printed to klog.
> 
> What sets "TPM_CHIP_FLAG_TPM2" in chip->flags?  And when?
> 
> > 
> > > Will this delay the TPM initialization, causing IMA to go into "TPM
> > > bypass mode"?
> > 
> > Of course it will delay the init.
> 
> Delaying the init will most likely cause regressions on systems with
> TPM 1.2 systems.
> 
> Instead of sending the TPM 2.0 command and on failure sending the TPM
> 1.2 version of the command, could chip->flags be tested?  And if not
> chip->flags, then provide the TPM version as part of registration.

No rush pushing this forward. I got your point.

> > As I've stated before the real fix for the bypass issue would be
> > to make TPM as part of the core but this has not received much
> > appeal. I think I've sent patch for this once.
> 
> I must have missed this discussion.

Yeah, I think that'd be a great idea. We need a better control on
TPM core as multiple subsystem's depend on it in API level. Something
to reconsider in future.

/Jarkko
