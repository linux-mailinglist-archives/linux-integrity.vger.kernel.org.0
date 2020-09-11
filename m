Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE28B265F09
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgIKLtJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 07:49:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:48953 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgIKLs1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 07:48:27 -0400
IronPort-SDR: 3AnpwDsXuE06RIg+I1Gk/jjAaR15AZVFbylKOadIh46/jHevA5BtbJ4idR8TjmllFNJ9jMFzp3
 awxLB00ozzzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="138758154"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="138758154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:48:27 -0700
IronPort-SDR: y/vYZamaS5v01sprW1Hq3VAz1KZgkumJU8FeuFXu/b5jA3fOjhzwpMXKq6fBzPbb5TjR1CkqYq
 7ctqNySjkVuw==
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="334489179"
Received: from amaksymi-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:48:23 -0700
Date:   Fri, 11 Sep 2020 14:48:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200911114820.GB6877@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
 <1599515528.4232.55.camel@HansenPartnership.com>
 <20200908054552.GB303404@kroah.com>
 <20200908180513.GB5390@linux.intel.com>
 <1599588851.10803.29.camel@HansenPartnership.com>
 <20200909070729.GD311356@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909070729.GD311356@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 09, 2020 at 09:07:29AM +0200, Greg KH wrote:
> On Tue, Sep 08, 2020 at 11:14:11AM -0700, James Bottomley wrote:
> > On Tue, 2020-09-08 at 21:05 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 08, 2020 at 07:45:52AM +0200, Greg KH wrote:
> > > > On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
> > [...]
> > > > > I've got to say I think binary attributes are actively evil.  I
> > > > > can see
> > > > > they're a necessity when there's no good way to represent the
> > > > > data they
> > > > > contain, like the bios measurement log or firmware code or a raw
> > > > > interface like we do for the SMP frame code in libsas.  But when
> > > > > there's a well understood and easy to produce user friendly non-
> > > > > binary
> > > > > representation, I think dumping binary is inimical to being a
> > > > > good API.
> > > > 
> > > > Agreed.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Looking at the patch, something like <device>/pcrs/<hash>/<index>
> > > would be a bit cleaner representation than the current <device>/pcrs-
> > > <hash>/<index>.
> > 
> > That's actually a technical limitation of using the current attribute
> > groups API: It's designed to support single level directories in sysfs
> > (or no directory at all).  That's not to say we can't do multi-level
> > ones, but if we do we have to roll our own machinery for managing the
> > files rather than relying on the groups API.
> 
> Agreed, do NOT do multi-level attribute groups please, userspace tools
> will not handle them well, if at all.

OK, thanks for confirming this.

/Jarkko
