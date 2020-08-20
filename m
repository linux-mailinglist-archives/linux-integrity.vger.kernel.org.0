Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176624C20E
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgHTPWi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 11:22:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:46206 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgHTPWh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 11:22:37 -0400
IronPort-SDR: zqti3doL8LMcm8QdlX6y6LQxHhXNZ6L5+1Mjmy0x2v7m/Y19gPM1E2+Eyiv5xkawgFSGG9VUw/
 YzQ26ivmfzBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="219625024"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="219625024"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:22:37 -0700
IronPort-SDR: H5CfAfQRZMcNLjVFWh2EkS9QAaSYVF75jouccqLLIZiJOFaPz5CiZxTg6TuG7+ncfVGjWbRBND
 RnuBwk9XpVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="401189863"
Received: from mkidd-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.244])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2020 08:22:35 -0700
Date:   Thu, 20 Aug 2020 18:22:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200820152234.GA5462@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <1597769070.3898.36.camel@HansenPartnership.com>
 <20200818171712.GZ24045@ziepe.ca>
 <1597776566.3898.52.camel@HansenPartnership.com>
 <20200819215332.GI9942@linux.intel.com>
 <1597877175.4030.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597877175.4030.17.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 03:46:15PM -0700, James Bottomley wrote:
> On Thu, 2020-08-20 at 00:53 +0300, Jarkko Sakkinen wrote:
> > > On Tue, 2020-08-18 at 14:17 -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:
> > > > 
> > > > > The question you should be asking isn't whether the information
> > > > > *could* be obtained by other means, but whether providing it in
> > > > > this form facilitates current operations and whether the
> > > > > interface would have users.
> > > > 
> > > > Sure. What are the use cases that need PCRs but no other TPM
> > > > operations?
> > > > 
> > > > The cover letter didn't say. As PCR is really only useful in the
> > > > context of the local TPM I'm not thinking of anything..
> > > 
> > > The three use cases I picked up at the Boot and Security MC were:
> > > 
> > >    1. local log verification: a script can run through the IMA
> > > ascii log
> > >       and construct the PCR 10 hash which can then be verified
> > >    2. Knowing what the PCR values actually are for sealed
> > > keys.  With the
> > >       current trusted key infrastructure you have to calculate and
> > > supply
> > >       the hash yourself.  With the new proposed infrastructure, the
> > > hash
> > >       would be calculated by the seal operation, but you're still
> > > going to
> > >       need the actual PCR values to debug unseal failures.
> > >    3. As a stability check for log shipping: you read the PCR take
> > > the log
> > >       then read the PCR: if the two reads are the same the PCR
> > > backing the
> > >       log is stable for quoting.
> > > 
> > > James
> > 
> > The proposed sysfs attributes are racy in the sense that PCRs could
> > change in-between reading different hashes.
> 
> That's not really a problem, is it?  For use case 2. we expect them to
> be stable otherwise you're doing the wrong thing sealing to them. For
> the IMA PCR you use the stability protocol in 3.
> 
> > A blob containing all the hashes would make more sense as it does not
> > have this issue.
> 
> It doesn't really buy anything though.  If you're verifying the log you
> always have the problem that the PCR and the log are at different
> points, so you follow the protocol in 3. or read PCR then log and
> unwind the log until it matches or you've gone too far.
> 
> > If this is for scripts to further process, it is also more efficient
> > than printable ASCII text.
> 
> I'm not fundamentally opposed to binary attributes, but realistically
> if I want the hash of PCRs 1 4 and 6 it's not fundamentally different
> to me whether I do
> 
> cat /sys/class/tpm/tpm0/pcr-sha256/1 /sys/class/tpm/tpm0/pcr-sha256/4 /sys/class/tpm/tpm0/pcr-sha256/6|sha256sum
> 
> or
> 
> cat /sys/class/tpm/tpm0/pcr-sha256/1 /sys/class/tpm/tpm0/pcr-sha256/4 /sys/class/tpm/tpm0/pcr-sha256/6|xxd -r -p|sha256sum
> 
> The point being the tool to convert the hex output back to binary
> already exists and is well known ... and binary attributes have nasty
> console properties if you accidentally cat them directly.
> 
> James

This does not look like a kind of framework of things that we want
to maintain. Especially given that it is easy to get all the data
through /dev/tpm0 easily. It is an enormous addition to uapi with
a questionable value.

/Jarkko
