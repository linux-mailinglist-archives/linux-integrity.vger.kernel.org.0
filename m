Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DF719A76C
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgDAIhm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 04:37:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:4228 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbgDAIhg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 04:37:36 -0400
IronPort-SDR: AcdjHQV8OvQKXXJ5fpFG+xxnofjEeyp1ovN3+DpD60MFBOJbom9Q8BmBvO0+v5A+5ABAB8BJsg
 K060/dbiKm8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:37:35 -0700
IronPort-SDR: /b9M4uVVdfFwYF+eLcG0YgHzbAm+2wMrLNO/iMT7tdQjqU/n6RCUDHEDg1dQhNsSmXKOCvkOF6
 EtGE4tXUYcpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="422630387"
Received: from vikasjox-mobl.amr.corp.intel.com (HELO localhost) ([10.249.39.53])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2020 01:37:31 -0700
Date:   Wed, 1 Apr 2020 11:37:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc:     linux-integrity@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
Message-ID: <20200401083729.GD17325@linux.intel.com>
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> the existing structure with these fields to allow non-UEFI systems
> to access the TPM2's log.
> 
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
> 
> Adapt all existing table size calculations to use
> offsetof(struct acpi_table_tpm2, start_method_specific)
> [where start_method_specific is a newly added field]
> rather than sizeof(struct acpi_table_tpm2) so that the addition
> of the new fields does not affect current systems that may not
> have them.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org

I think I'm cool with this but needs an ack from ACPI maintainer.

Rafael, given that this not an intrusive change in any possible means,
can I pick this patch and put it to my next pull request?

/Jarkko
