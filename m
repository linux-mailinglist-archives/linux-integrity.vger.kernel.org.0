Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601927DF17
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 05:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI3DnS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 23:43:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:12598 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI3DnS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 23:43:18 -0400
IronPort-SDR: BGIfqJxvEzDWScUFKNYnDlGj0GRo6qy589dP8OT+8hxga2ULFVIVR7v9JfjoAu7VQMx4dK8qBB
 WYc6QyUfKz5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="163218503"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="163218503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:43:15 -0700
IronPort-SDR: 2va6HXV67eEb6awrnM3uTZg5rq9GzeEiZSFuxgPmFsocB7umJI2yK4AhkG4tXhPZlyT6Ghh9Su
 wSgnMEty7w+A==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="495175680"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:43:13 -0700
Date:   Wed, 30 Sep 2020 06:43:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 0/5] TPM 2.0 trusted key rework
Message-ID: <20200930034311.GA881524@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 21, 2020 at 07:28:04PM -0700, James Bottomley wrote:
> Updated to fix compile problem identified by 0day
> 
> General cover letter minus policy bit:
> 
> This patch updates the trusted key code to export keys in the ASN.1
> format used by current TPM key tools (openssl_tpm2_engine and
> openconnect).  The current code will try to load keys containing
> policy, but being unable to formulate the policy commands necessary to
> load them, the unseal will always fail unless the policy is executed
> in user space and a pre-formed policy session passed in.
> 
> The key format is designed to be compatible with our two openssl
> engine implementations as well as with the format used by openconnect.
> I've added seal/unseal to my engine so I can use it for
> interoperability testing and I'll later use this for sealed symmetric
> keys via engine:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> 
> James

I started a kernel build for GLK NUC that I have. I'm hopeful that
tpm2-scripts fix will sort out this patch set. Will report the results
once I have them. I have a hunch that things will finally work out.

Using my master branch without the trusted keys fixes that I did.

/Jarkko
