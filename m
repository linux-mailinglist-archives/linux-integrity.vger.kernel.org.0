Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1F20989E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbgFYCw5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 22:52:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:60976 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389357AbgFYCw5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 22:52:57 -0400
IronPort-SDR: nfk4QQn3GecU8I3NcGRzMglSs60aO1EqDnBxuphr7eCuxEMTB2pr6LBmHP07EvqTZu3/n8a7rt
 9gmuWnwlE76A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143813874"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="143813874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 19:52:56 -0700
IronPort-SDR: 3NzIdllr45u+iyc9nWKWBmbNtHRCZngD2ePQu2iRdujhYn9r1WgsgeyxBpkQEsRQVOzLktUO14
 igE6Xtj0CsyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="301845959"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jun 2020 19:52:52 -0700
Date:   Thu, 25 Jun 2020 05:52:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200625025251.GC270125@linux.intel.com>
References: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
 <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
 <20200625000021.GC21758@linux.intel.com>
 <9d94c704-5774-ceeb-e4f3-010f74ffe37b@linux.ibm.com>
 <20200625023431.GB270125@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625023431.GB270125@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:34:38AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 24, 2020 at 08:38:25PM -0400, Stefan Berger wrote:
> > On 6/24/20 8:00 PM, Jarkko Sakkinen wrote:
> > > On Tue, Jun 23, 2020 at 08:06:35AM -0400, Stefan Berger wrote:
> > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > 
> > > > Recent extensions of the TPM2 ACPI table added 3 more fields
> > > > including 12 bytes of start method specific parameters and Log Area
> > > > Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> > > > the existing structure with these fields to allow non-UEFI systems
> > > > to access the TPM2's log.
> > > > 
> > > > The specification that has the new fields is the following:
> > > >    TCG ACPI Specification
> > > >    Family "1.2" and "2.0"
> > > >    Version 1.2, Revision 8
> > > > 
> > > > Adapt all existing table size calculations to use
> > > > offsetof(struct acpi_table_tpm2, start_method_specific)
> > > > [where start_method_specific is a newly added field]
> > > > rather than sizeof(struct acpi_table_tpm2) so that the addition
> > > > of the new fields does not affect current systems that may not
> > > > have them.
> > > > 
> > > I found at least one regression from this patch. Please remove my
> > > reviewed-by comment form the next version.
> > > 
> > > Should have:
> > > 
> > >    Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
> > > 
> > > Please, add this.
> > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > ---
> > > >   drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
> > > >   drivers/char/tpm/tpm_tis.c |  4 +++-
> > > >   include/acpi/actbl3.h      |  5 +++--
> > > >   3 files changed, 16 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > > index a9dcf31eadd2..0565aa5482f9 100644
> > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > @@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
> > > >   	status = acpi_get_table(ACPI_SIG_TPM2, 1,
> > > >   				(struct acpi_table_header **) &buf);
> > > > -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> > > > +	if (ACPI_FAILURE(status) || buf->header.length <
> > > > +			offsetof(struct acpi_table_tpm2,
> > > > +				 start_method_specific)) {
> > > >   		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
> > > >   		return -EINVAL;
> > > >   	}
> > > > @@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
> > > >   		return -ENOMEM;
> > > >   	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > > > -		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
> > > > +		if (buf->header.length <
> > > > +			(offsetof(struct acpi_table_tpm2,
> > > > +				  start_method_specific) +
> > > Should be
> > > 
> > >    offsetof(struct acpti_table_tpm2, log_area_minimum_length)
> > 
> > 
> > The old code had sizeof(*buf) with buf being 'struct acpi_table_tpm2' and
> > that was equivalent to offsetof(struct acpi_table_tpm2,
> > start_method_specific) since 'start_method_specific' is the first new field
> > that we are adding right here. Also see 3rd paragraph in the patch
> > description. The replacement rule described there should apply to all
> > sizeof() calculations on 'struct acpi_table_tpm2.'
> 
> Aren't you ignoring sizeof(*crb_smc) then?

Duh, it's there I see. Sorry, my mistake.

Please put the new fields in a separate struct:

struct acpi_tpm2_phy {
	u8  start_method_specific[12];
	u32 log_area_minimum_length;
	u64 log_area_start_address;
};

This way we don't have to obfuscate all the calculations and zero out
the need for 1/2 in this patch set.

/Jarkko
