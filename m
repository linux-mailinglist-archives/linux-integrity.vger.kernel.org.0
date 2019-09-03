Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87007A6DF8
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfICQVn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:21:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:15893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfICQVn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:21:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="357790636"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2019 09:21:40 -0700
Message-ID: <86349fa9f24a30c382cf23f9f30a1e371af0e470.camel@linux.intel.com>
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue, 03 Sep 2019 19:21:39 +0300
In-Reply-To: <1567516984.10024.376.camel@linux.ibm.com>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
         <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
         <20190828161502.GC933@ziepe.ca>
         <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
         <20190902192632.GB5393@ziepe.ca> <1567460118.10024.316.camel@linux.ibm.com>
         <20190903055523.GA4500@ziepe.ca> <1567511346.10024.365.camel@linux.ibm.com>
         <20190903130713.GA5851@ziepe.ca> <1567516984.10024.376.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-03 at 09:23 -0400, Mimi Zohar wrote:
> On Tue, 2019-09-03 at 10:07 -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 03, 2019 at 07:49:06AM -0400, Mimi Zohar wrote:
> > > On Tue, 2019-09-03 at 02:55 -0300, Jason Gunthorpe wrote:
> > > > On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
> > > > > On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> > > > > > On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> > > > > > > On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> > > > > > > > > > So exposing PCRs and things through sysfs is not going to happen.
> > > > > > > > > > 
> > > > > > > > > > If you had some very narrowly defined things like version, then
> > > > > > > > > > *maybe* but I think a well defined use case is needed for why this
> > > > > > > > > > needs to be sysfs and can't be done in C as Jarkko explained.
> > > > > > > > > Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> > > > > > > > > TPM 2.0 is a reasonable request and probably could be implemented on
> > > > > > > > > TPM registration.
> > > > > > > > > 
> > > > > > > > > If exposing the PCRs through sysfs is not acceptable, then perhaps
> > > > > > > > > suggest an alternative.
> > > > > > > > Use the char dev, this is exactly what is is for.
> > > > > > > 
> > > > > > > What about a new /proc entry?
> > > > > > > Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> > > > > > > What about adding a new /proc/tpminfo that would print info like
> > > > > > > version, number of enabled PCR banks, physical interface [tis|crb],
> > > > > > > vendor, etc.
> > > > > > 
> > > > > > I thought we were not really doing new proc entries?
> > > > > > 
> > > > > > Why this focus on making some textual output?
> > > > > 
> > > > > I don't really care if we define procfs, sysfs, or securityfs file(s)
> > > > > or whether those files are ascii or binary.  Whatever is defined,
> > > > > should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).
> > > > 
> > > > Use an ioctl on the char dev?
> > > 
> > > Both TPM 1.2 and TPM 2.0 export the TPM event log as
> > > security/tpmX/binary_bios_measurements.  Wouldn't it make more sense
> > > to group the TPM information together, exporting other TPM information
> > > as securityfs files?
> > 
> > I don't know anything about security_fs, sorry
> 
> Jarkko, any comments/suggestions?
 
On exactly what?

/Jarkko

