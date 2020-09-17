Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F366D26E08D
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgIQQW3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 12:22:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:43644 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgIQQWN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 12:22:13 -0400
IronPort-SDR: ZaXvWywsfbf/12JF3KptBpFN508iGkAL8MVW+95HVhVbdAS2y/F6+Kxd9ZzeGi8McEFuEOHlRk
 U71/qsW/oUCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236045"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:21:50 -0700
IronPort-SDR: trHhcLQ1BQG6RgqiolRqyttLbS6G0s9kB2GNYwfwgc4KfQyHIb3FBM1tAZeeUzazTznHkgCZMq
 uyAIhJqrRqaQ==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="483808637"
Received: from sdompke-mobl.ger.corp.intel.com (HELO localhost) ([10.249.45.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:21:44 -0700
Date:   Thu, 17 Sep 2020 19:21:42 +0300
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
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <20200917162142.GB9750@linux.intel.com>
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
 <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusted keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implementations like TPM, TEE etc. could be easily plugged-in.

I would rephrase this a bit:

"Add a generic trusted keys framework where underlying implementations
can be easily plugged in. Create struct trusted_key_ops to achieve this,
which contains necessary functions of a backend."

I remember asking about this approach that what if there was just a
header for trusted key functions and a compile time decision, which C
file to include instead of ops struct. I don't remember if these was a
conclusion on this or not.

E.g. lets say you have a device with TEE and TPM, should you be able
to be use both at run-time? I might play along how this works now but
somehow, in the commit message preferably, it should be conclude why
one alternative is chosen over another.

/Jarkko
