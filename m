Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244028C6DC
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgJMBnM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 21:43:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:15405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgJMBnM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 21:43:12 -0400
IronPort-SDR: v+OHJDtpHHRyvZINB0s/fMjlwR3NasKMz0j1l72Ljqy+NXuqpZ/qVWYXxEcyHefXVPIvwA9Uui
 HGUiRs15KjUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165890360"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165890360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:43:11 -0700
IronPort-SDR: 8DDZae9ULC1Juos8+m1ku7wGzRyhk40RdQlxcgY5PDbFwqtOn4+rL76R0oYLFE3SMNuTLfHR2/
 er29pWA3DMqQ==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="463303490"
Received: from lusin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:43:06 -0700
Date:   Tue, 13 Oct 2020 04:43:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com, dhowells@redhat.com,
        jens.wiklander@linaro.org, corbet@lwn.net, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <20201013014304.GC41176@linux.intel.com>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusted keys
> support in case platform doesn't posses a TPM device.
> 
> Add a generic trusted keys framework where underlying implementations
> can be easily plugged in. Create struct trusted_key_ops to achieve this,
> which contains necessary functions of a backend.
> 
> Also, add a module parameter in order to select a particular trust source
> in case a platform support multiple trust sources.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This is exactly kind of place where I think static_call() should be
taken into use, which is a v5.10 feature [1]. For background and
context, I'd read [2].

The other thing that I see that does not make much else than additional
complexity, is trusted_tpm.ko. We can do with one trusted.ko.

I'd also *guess* that the static_call() mechanism does not work accross
module boundaries.

[1] https://lore.kernel.org/lkml/20201012155542.GA3557765@gmail.com/
[2] https://lwn.net/Articles/815908/

/Jarkko
