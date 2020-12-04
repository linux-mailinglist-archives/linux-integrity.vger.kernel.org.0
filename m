Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A032CE72E
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 05:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLDE5f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Dec 2020 23:57:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:57868 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgLDE5f (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Dec 2020 23:57:35 -0500
IronPort-SDR: r1GrSh4gnyYCyvlKMLVlLJg9YuSEW6ptXMs4jSL9EszPzoOWvjW53JT8k/PqHvBZo+myIyM6zu
 m4mtgqUa6KxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173483427"
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="173483427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:55:54 -0800
IronPort-SDR: bgheDsGPZ9owhwyBFa0mgmRNKQtcg7lM49LjEA4o4b+JY1KVBmazZ39mnoVyjIY3MgOpubmJcB
 GIag1LCNhdVQ==
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="482238162"
Received: from kramerha-mobl.ger.corp.intel.com (HELO linux.intel.com) ([10.252.53.177])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:55:51 -0800
Date:   Fri, 4 Dec 2020 06:55:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <20201204045545.GF84413@linux.intel.com>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
 <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 29, 2020 at 02:30:22PM -0800, James Bottomley wrote:
> +		default:
> +			/*
> +			 * If this warning triggers, send a patch to
> +			 * add both a PCR_ATTR_BUILD() macro above for
> +			 * the missing algorithm as well as an
> +			 * additional case in this switch statement.
> +			 */
> +			WARN(1, "TPM with unsupported bank algorthm 0x%04x",
> +			     chip->allocated_banks[i].alg_id);

Please use pr_info() here instead. We don't want to dump the stack
because of this. Nothing is working as far as kernel goes in an
unexpected manner.

/Jarkko
