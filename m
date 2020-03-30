Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98119846A
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgC3T3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 15:29:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:22494 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgC3T3H (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 15:29:07 -0400
IronPort-SDR: 3yCyZfIqM4dAoYzPZbhDDq4ByCi9kAeXnRq5cpl1w7H3bKNMkvKURhbyOQAUTTYgJLqt3f/hTR
 GHX+Weq9Smwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 12:29:01 -0700
IronPort-SDR: XD/mPKGOPiBS2NXFfFRIh4DdUx3daTI3za0y7HR2QMWFaRFqs4r+MZzAeUxb9RIXdW6XqLFohE
 lfct1hrPGX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="294705053"
Received: from plachner-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.129])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 12:28:58 -0700
Date:   Mon, 30 Mar 2020 22:28:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] acpi: Extend TPM2 ACPI table with missing log
 fields
Message-ID: <20200330192830.GC1384380@linux.intel.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330151536.871700-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 30, 2020 at 11:15:34AM -0400, Stefan Berger wrote:
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

Cc: linux-acpi@vger.kernel.org

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

You have this comment:

/* Platform-specific data follows */

Can you elaborate a bit which platform you are speaking of? It is now
enabled for everything.

/Jarkko
