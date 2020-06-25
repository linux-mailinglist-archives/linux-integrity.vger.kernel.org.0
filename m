Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16D720A770
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404313AbgFYV0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:26:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:39514 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403774AbgFYV0w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:26:52 -0400
IronPort-SDR: Whb6tZnqOrtJbrlxcglWCzWMtoOflJi3MXNUKa8eLEZo+UplrUBPfP45lx7yGuIr89iMtlXFMi
 u9BlgnnwHDGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144167268"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="144167268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:26:52 -0700
IronPort-SDR: AjDnvS+eQm+6YRfKwm5rPF/W5hb3S6SISBcX0Vohp2LS5P3idzO84SZIIRl9Ve5ghWKdwWGUT+
 J4o8gUcB/f0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="319847429"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2020 14:26:48 -0700
Date:   Fri, 26 Jun 2020 00:26:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jiandi An <anjiandi@codeaurora.org>
Subject: Re: [PATCH v6 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200625212646.GD20341@linux.intel.com>
References: <20200625124222.1954580-1-stefanb@linux.vnet.ibm.com>
 <20200625124222.1954580-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625124222.1954580-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 08:42:21AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we define
> a new structure acpi_tpm2_phy that holds these optional new fields.
> The new fields allow non-UEFI systems to access the TPM2's log.
> 
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
> 
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Jiandi An <anjiandi@codeaurora.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
