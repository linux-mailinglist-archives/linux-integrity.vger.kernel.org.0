Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC43204669
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgFWA5Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:57:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:30893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbgFWA5Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:57:24 -0400
IronPort-SDR: nFlfadgr5cqrVqDoqqR/1q/bs0GJoNyxnVD61gFaPcXbrDHOzkDv/TRUl4YN2L8St1EvX6WZwM
 tnVGdFHtCCXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142185921"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142185921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 17:57:24 -0700
IronPort-SDR: fh/T/rBhYv8jBfWtzVOYXuWy1O+CAFWwv2Z6gTXsvpG4TW5bIEPA8bvatN7NxTH7jN34mBBr5N
 glmwZTFxbFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="275175309"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 17:57:19 -0700
Date:   Tue, 23 Jun 2020 03:57:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
Message-ID: <20200623005718.GE28795@linux.intel.com>
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
 <20200401083729.GD17325@linux.intel.com>
 <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
 <20200402192145.GB10314@linux.intel.com>
 <dfd2d622-90cb-9621-7b7d-5282f5ee7359@linux.ibm.com>
 <CAJZ5v0isZCK8o6hopUV3SP25P5+BwZGSSRFtGQrunQ0n45t68g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0isZCK8o6hopUV3SP25P5+BwZGSSRFtGQrunQ0n45t68g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 05:55:19PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 19, 2020 at 5:14 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> > On 4/2/20 3:21 PM, Jarkko Sakkinen wrote:
> > > On Wed, Apr 01, 2020 at 11:05:36AM +0200, Rafael J. Wysocki wrote:
> > >> On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
> > >> <jarkko.sakkinen@linux.intel.com> wrote:
> > >>> On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
> > >>>> From: Stefan Berger <stefanb@linux.ibm.com>
> > >>>>
> > >>>> Recent extensions of the TPM2 ACPI table added 3 more fields
> > >>>> including 12 bytes of start method specific parameters and Log Area
> > >>>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> > >>>> the existing structure with these fields to allow non-UEFI systems
> > >>>> to access the TPM2's log.
> > >>>>
> > >>>> The specification that has the new fields is the following:
> > >>>>    TCG ACPI Specification
> > >>>>    Family "1.2" and "2.0"
> > >>>>    Version 1.2, Revision 8
> > >>>>
> > >>>> Adapt all existing table size calculations to use
> > >>>> offsetof(struct acpi_table_tpm2, start_method_specific)
> > >>>> [where start_method_specific is a newly added field]
> > >>>> rather than sizeof(struct acpi_table_tpm2) so that the addition
> > >>>> of the new fields does not affect current systems that may not
> > >>>> have them.
> > >>>>
> > >>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > >>>> Cc: linux-acpi@vger.kernel.org
> > >>> I think I'm cool with this but needs an ack from ACPI maintainer.
> > >>>
> > >>> Rafael, given that this not an intrusive change in any possible means,
> > >>> can I pick this patch and put it to my next pull request?
> > >> Yes, please.
> > >>
> > >> Thanks!
> > > Great, thanks Rafael.
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> > > Do you mind if I add your ack to the commit?
> >
> 
> It looks like I missed the previous message from Jarkko.
> 
> Yes, please, feel free to add my ACK to the patch, thanks!

OK, this is great, thanks. I'll pick it to my tree then.

/Jarkko
