Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84996265F02
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKLtM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 07:49:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:28366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgIKLsV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 07:48:21 -0400
IronPort-SDR: hdPkqMFSo03m2Wla7DLAXL8YXq+dtu09mmtVRih7qAPOS22Kyx3Z8T0NxWKBP8JZZoFfK64fJJ
 0Gy6g8fD1g/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="158776210"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="158776210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:47:47 -0700
IronPort-SDR: CESeq24l0uQku2aI3NLAuVvRvfkb8dsKu35iz8crQChob8qm6GtBgOjwnVrbjmOIZouBz/4AfJ
 PuPpS8V2Ca0A==
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="334489030"
Received: from amaksymi-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:47:44 -0700
Date:   Fri, 11 Sep 2020 14:47:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg KH <greg@kroah.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200911114741.GA6877@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
 <1599515528.4232.55.camel@HansenPartnership.com>
 <20200908054552.GB303404@kroah.com>
 <20200908180513.GB5390@linux.intel.com>
 <1599588851.10803.29.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599588851.10803.29.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 08, 2020 at 11:14:11AM -0700, James Bottomley wrote:
> On Tue, 2020-09-08 at 21:05 +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 08, 2020 at 07:45:52AM +0200, Greg KH wrote:
> > > On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
> [...]
> > > > I've got to say I think binary attributes are actively evil.  I
> > > > can see
> > > > they're a necessity when there's no good way to represent the
> > > > data they
> > > > contain, like the bios measurement log or firmware code or a raw
> > > > interface like we do for the SMP frame code in libsas.  But when
> > > > there's a well understood and easy to produce user friendly non-
> > > > binary
> > > > representation, I think dumping binary is inimical to being a
> > > > good API.
> > > 
> > > Agreed.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Looking at the patch, something like <device>/pcrs/<hash>/<index>
> > would be a bit cleaner representation than the current <device>/pcrs-
> > <hash>/<index>.
> 
> That's actually a technical limitation of using the current attribute
> groups API: It's designed to support single level directories in sysfs
> (or no directory at all).  That's not to say we can't do multi-level
> ones, but if we do we have to roll our own machinery for managing the
> files rather than relying on the groups API.
> 
> Given that the current groups API does all the nasty lifetime
> management that I'd otherwise have to do in the patch, I have a strong
> incentive for keeping it, which is why the single <device>/pcrs-
> <hash>/<index> format.

OK, I do get that. I've tried to do something similar in past and it
turnd out to be a tremendous job.  I guess I'll have to re-review the
whole patch again. I'll prioritize that next week.

> James

/Jarkko
