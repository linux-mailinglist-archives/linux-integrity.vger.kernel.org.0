Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4DC19D09B
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Apr 2020 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgDCHBc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Apr 2020 03:01:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:18429 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbgDCHBc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Apr 2020 03:01:32 -0400
IronPort-SDR: zP8KYOkfrF1Lh4tLJ2CYI5w74GdKOxSymxz8jVhmHZVE9SlR/xbFqCq7sbMQyeKBK094oL0TTm
 GkAcQhSlRMqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 00:01:32 -0700
IronPort-SDR: byiRMTrhb5XBXqTx15iVdR9oHh4AmpQIiQJnAKivtGn1djcuht1NL+AKYHxkpdiQnPxDzGdUr7
 GczmVQoc/6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="253272312"
Received: from kboulton-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.35.93])
  by orsmga006.jf.intel.com with ESMTP; 03 Apr 2020 00:01:28 -0700
Date:   Fri, 3 Apr 2020 10:01:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] tpm2: Make TPM2 logs accessible for non-UEFI
 firmware
Message-ID: <20200403070114.GD25305@linux.intel.com>
References: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 02, 2020 at 06:51:38PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This series of patches extends the existing TPM2 ACPI table with additional
> fields found in the TPM2 TCG ACPI specification (reference is in the patch)
> that allow access to the log's address and its size. We then modify the
> code that so far only enables access to a TPM 1.2's log for a TPM2 as well.
> This then enables access to the TPM2's log on non-UEFI system that for example
> run SeaBIOS.
> 
>    Stefan
> 
> v3->v4:
>   - Repost as one series
> 
> v2->v3:
>   - Split the series into two separate patches
>   - Added comments to ACPI table fields
>   - Added check for null pointer to log area and zero log size
> 
> v1->v2:
>   - Repost of the series
> 
> 
> 
> Stefan Berger (2):
>   acpi: Extend TPM2 ACPI table with missing log fields
>   tpm: Add support for event log pointer found in TPM2 ACPI table
> 
>  drivers/char/tpm/eventlog/acpi.c | 56 +++++++++++++++++++++++++---------------
>  drivers/char/tpm/tpm_crb.c       | 13 +++++++---
>  drivers/char/tpm/tpm_tis.c       |  4 ++-
>  include/acpi/actbl3.h            |  5 ++--
>  4 files changed, 51 insertions(+), 27 deletions(-)
> 
> -- 
> 2.14.5
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I'll apply this after I'll get Rafael's answer whether I can add his ack
to the commits.

/Jarkko
