Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E92618FA
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgIHSF1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 14:05:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:15058 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731519AbgIHSFR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 14:05:17 -0400
IronPort-SDR: B/RpBAjW6w6Y0of6+cQxXJt0A79JXr6/g/qrl/coNd/Gz/WCpVqJyCUFPzMIqGmVj/DwPmPW/e
 Gp3dGW2ZXqQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158226419"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="158226419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 11:05:15 -0700
IronPort-SDR: Lm1krd4n7I978/rCoc205HyWTYbagP7GCfJOKDO45wZ0RsDVB71xN0pRtfRzqgPFDtJEr2t44r
 HR02tdzvSL9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="336496733"
Received: from jfontesg-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.71])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2020 11:05:13 -0700
Date:   Tue, 8 Sep 2020 21:05:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200908180513.GB5390@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
 <1599515528.4232.55.camel@HansenPartnership.com>
 <20200908054552.GB303404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908054552.GB303404@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 08, 2020 at 07:45:52AM +0200, Greg KH wrote:
> On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
> > On Mon, 2020-09-07 at 16:23 +0300, Jarkko Sakkinen wrote:
> > > On Mon, Sep 07, 2020 at 07:38:24AM +0200, Greg KH wrote:
> > > > Please just use a binary blob format.  Binary sysfs files are
> > > > exactly what this is for, you are just passing the data through the
> > > > kernel from the hardware to userspace.
> > > > 
> > > > You can have 24 binary files if that makes it easier, but the
> > > > existing format really is an abuse of sysfs.
> > 
> > There is no existing format for TPM 2.0 ... that's part of the problem
> > since we certainly didn't want to carry over the TPM 1.2 format.
> 
> Ok, then no, if there is not already a binary format then you should not
> use a binary sysfs file as you are then just sending a kernel structure
> to userspace, not a hardware structure.
> 
> > I've got to say I think binary attributes are actively evil.  I can see
> > they're a necessity when there's no good way to represent the data they
> > contain, like the bios measurement log or firmware code or a raw
> > interface like we do for the SMP frame code in libsas.  But when
> > there's a well understood and easy to produce user friendly non-binary
> > representation, I think dumping binary is inimical to being a good API.
> 
> Agreed.
> 
> thanks,
> 
> greg k-h

Looking at the patch, something like <device>/pcrs/<hash>/<index> would
be a bit cleaner representation than the current <device>/pcrs-<hash>/<index>.

/Jarkko
