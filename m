Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1039C92E9
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJBUfh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 16:35:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:1104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJBUfh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 16:35:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 13:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="392959811"
Received: from unknown (HELO localhost) ([10.252.17.180])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2019 13:35:34 -0700
Date:   Wed, 2 Oct 2019 23:35:33 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/4] tpm: add update_durations class op to allow
 override of chip supplied values
Message-ID: <20191002203533.GA17766@linux.intel.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142735.6280-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 02, 2019 at 07:27:32AM -0700, Jerry Snitselaar wrote:
> We've run into a case where a customer has an STM TPM 1.2 chip
> (version 1.2.8.28), that is getting into an inconsistent state and
> they end up getting tpm transmit errors.  In really old tpm code this
> wasn't seen because the code that grabbed the duration values from the
> chip could fail silently, and would proceed to just use default values
> and move forward. More recent code though successfully gets the
> duration values from the chip, and using those values this particular
> chip version gets into the state seen by the customer.
> 
> The idea with this patchset is to provide a facility like the
> update_timeouts operation to allow the override of chip supplied
> values.
> 
> changes from v3:
>     * Assign value to version when tpm1_getcap is successful for TPM 1.1 device
>       not when it fails.
> 
> changes from v2:
>     * Added patch 1/3
>     * Rework tpm_tis_update_durations to make use of new version structs
>       and pull tpm1_getcap calls out of loop.
> 
> changes from v1:
>     * Remove unneeded newline
>     * Formatting cleanups
>     * Change tpm_tis_update_durations to be a void function, and
>       use chip->duration_adjusted to track whether adjustment was
>       made.
> 
> Jarkko Sakkinen (1):
>       tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
> 
> Jerry Snitselaar (2):
>       tpm: provide a way to override the chip returned durations
>       tpm_tis: override durations for STM tpm with firmware 1.2.8.28
> 
> 

I applied to my master branch.

Probably hard to get wide testing given the "niche" case when the
issue happens. Should be sufficient that the commonc case still
works.

/Jarkko
