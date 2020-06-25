Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35A6209887
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbgFYCei (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 22:34:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:56173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389278AbgFYCeh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 22:34:37 -0400
IronPort-SDR: vqGB6KUXPBpttfr6bEgGh6tX7u2BhK5EZRdck7WJv4jD15L4rgHTl9Wm0W7pABL/Tf7LssoK+Y
 OCgnR3Vq2pdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="144767468"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="144767468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 19:34:37 -0700
IronPort-SDR: MkabdPqQi7NtbJzRI+ShWSoaF7md6WdD7wUXVQO8l5HLJCWo7cAjQxsqa/TjOPR20qPIryQpeN
 RNaFhST1X2ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="452855331"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2020 19:34:33 -0700
Date:   Thu, 25 Jun 2020 05:34:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200625023431.GB270125@linux.intel.com>
References: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
 <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
 <20200625000021.GC21758@linux.intel.com>
 <9d94c704-5774-ceeb-e4f3-010f74ffe37b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d94c704-5774-ceeb-e4f3-010f74ffe37b@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 24, 2020 at 08:38:25PM -0400, Stefan Berger wrote:
> On 6/24/20 8:00 PM, Jarkko Sakkinen wrote:
> > On Tue, Jun 23, 2020 at 08:06:35AM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Recent extensions of the TPM2 ACPI table added 3 more fields
> > > including 12 bytes of start method specific parameters and Log Area
> > > Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> > > the existing structure with these fields to allow non-UEFI systems
> > > to access the TPM2's log.
> > > 
> > > The specification that has the new fields is the following:
> > >    TCG ACPI Specification
> > >    Family "1.2" and "2.0"
> > >    Version 1.2, Revision 8
> > > 
> > > Adapt all existing table size calculations to use
> > > offsetof(struct acpi_table_tpm2, start_method_specific)
> > > [where start_method_specific is a newly added field]
> > > rather than sizeof(struct acpi_table_tpm2) so that the addition
> > > of the new fields does not affect current systems that may not
> > > have them.
> > > 
> > I found at least one regression from this patch. Please remove my
> > reviewed-by comment form the next version.
> > 
> > Should have:
> > 
> >    Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
> > 
> > Please, add this.
> > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: linux-acpi@vger.kernel.org
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > ---
> > >   drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
> > >   drivers/char/tpm/tpm_tis.c |  4 +++-
> > >   include/acpi/actbl3.h      |  5 +++--
> > >   3 files changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > index a9dcf31eadd2..0565aa5482f9 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
> > >   	status = acpi_get_table(ACPI_SIG_TPM2, 1,
> > >   				(struct acpi_table_header **) &buf);
> > > -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> > > +	if (ACPI_FAILURE(status) || buf->header.length <
> > > +			offsetof(struct acpi_table_tpm2,
> > > +				 start_method_specific)) {
> > >   		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
> > >   		return -EINVAL;
> > >   	}
> > > @@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
> > >   		return -ENOMEM;
> > >   	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > > -		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
> > > +		if (buf->header.length <
> > > +			(offsetof(struct acpi_table_tpm2,
> > > +				  start_method_specific) +
> > Should be
> > 
> >    offsetof(struct acpti_table_tpm2, log_area_minimum_length)
> 
> 
> The old code had sizeof(*buf) with buf being 'struct acpi_table_tpm2' and
> that was equivalent to offsetof(struct acpi_table_tpm2,
> start_method_specific) since 'start_method_specific' is the first new field
> that we are adding right here. Also see 3rd paragraph in the patch
> description. The replacement rule described there should apply to all
> sizeof() calculations on 'struct acpi_table_tpm2.'

Aren't you ignoring sizeof(*crb_smc) then?

> 
> I'll address the other issues.
> 
> 
>    Stefan
