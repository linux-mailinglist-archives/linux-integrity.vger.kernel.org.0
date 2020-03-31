Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBA1995D8
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgCaLzE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 07:55:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:3310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaLzD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 07:55:03 -0400
IronPort-SDR: qptgvVR5XEKkpafjV3Qffhf2dIE+DQ6bS9EGfg9AYJg+sHiC4/aJZLJ8CueKhzJqhTMdP0StQu
 cFkrNidEYT/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:55:03 -0700
IronPort-SDR: x76DcEdvDe15XUQfjkSFQGaycHeZFzHRQPfcDKVvKInN8DhRXpcnI5zrKvsou97YxQT6ZS2T59
 HXurVOG+0O5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="272720072"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 04:55:01 -0700
Date:   Tue, 31 Mar 2020 14:55:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200331115500.GC8295@linux.intel.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-2-stefanb@linux.vnet.ibm.com>
 <20200330192830.GC1384380@linux.intel.com>
 <fa195dea-205b-fd0e-fb58-8d185a4a13c6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa195dea-205b-fd0e-fb58-8d185a4a13c6@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 30, 2020 at 05:26:25PM -0400, Stefan Berger wrote:
> On 3/30/20 3:28 PM, Jarkko Sakkinen wrote:
> > On Mon, Mar 30, 2020 at 11:15:34AM -0400, Stefan Berger wrote:
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
> > Cc: linux-acpi@vger.kernel.org
> > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > You have this comment:
> > 
> > /* Platform-specific data follows */
> 
> You mean there 'was this comment'? I actually removed this comment because I
> didn't know what it meant or what it has to do with 'platform':
> 
> -
> -       /* Platform-specific data follows */
> +       u8  start_method_specific[12];
> +       u32 log_area_minimum_length;
> +       u64 log_area_start_address;
> 
> Specs: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
> 
> PDF Page 16 / Doc page 10 bottom.
> 
> start_method_specific is obviously related to the start_method field. The
> subsequent two fields are optional and show those 2 filelds we know from the
> TCPA ACPI table.

You should CC the change to linux-acpi because it touches their files.
For this reason preferably this change should be commit of its own.

/Jarkko
