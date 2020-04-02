Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91A19C9F0
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbgDBTWD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 15:22:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:40920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgDBTWD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 15:22:03 -0400
IronPort-SDR: LVoV64XSlcBf2YFP5MixYctj01nU7A/aoWUnZ57XQZG5z8aROlLEzGywkiJMki3K3FDgpL0Fic
 oonUTB1XRcUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:22:02 -0700
IronPort-SDR: HPlrlLEifWROXK4+Dc1PcEvewa6yrANYd49N+uhhrAgGykfTHlVfk/hOoA+z5G7tR9/eMPMwPE
 q7MhMagLko8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="242612758"
Received: from hbriegel-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.101])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2020 12:21:58 -0700
Date:   Thu, 2 Apr 2020 22:21:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
Message-ID: <20200402192145.GB10314@linux.intel.com>
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
 <20200401083729.GD17325@linux.intel.com>
 <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 01, 2020 at 11:05:36AM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > >
> > > Recent extensions of the TPM2 ACPI table added 3 more fields
> > > including 12 bytes of start method specific parameters and Log Area
> > > Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> > > the existing structure with these fields to allow non-UEFI systems
> > > to access the TPM2's log.
> > >
> > > The specification that has the new fields is the following:
> > >   TCG ACPI Specification
> > >   Family "1.2" and "2.0"
> > >   Version 1.2, Revision 8
> > >
> > > Adapt all existing table size calculations to use
> > > offsetof(struct acpi_table_tpm2, start_method_specific)
> > > [where start_method_specific is a newly added field]
> > > rather than sizeof(struct acpi_table_tpm2) so that the addition
> > > of the new fields does not affect current systems that may not
> > > have them.
> > >
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: linux-acpi@vger.kernel.org
> >
> > I think I'm cool with this but needs an ack from ACPI maintainer.
> >
> > Rafael, given that this not an intrusive change in any possible means,
> > can I pick this patch and put it to my next pull request?
> 
> Yes, please.
> 
> Thanks!

Great, thanks Rafael.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Do you mind if I add your ack to the commit?

/Jarkko
