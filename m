Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7E26E09D
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIQQZg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 12:25:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:44028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgIQQZ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 12:25:26 -0400
IronPort-SDR: DsXWU7/+aVl4TAJEdhk5F6Fs+Phw9NrPRiCQWH7IGatsQU9yHxXH632tOg0o67dpRUIRpldq1g
 ppDil8as2W/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236721"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:17 -0700
IronPort-SDR: PDAql5mIiHxBEiUG7vy+HU9oL6HWgsVWHNIh7FEw8CEQMferWTmRWED5XCtGpsb0o5BI7eIdwZ
 xfH048D/iB3A==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="452375009"
Received: from sdompke-mobl.ger.corp.intel.com (HELO localhost) ([10.249.45.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:08 -0700
Date:   Thu, 17 Sep 2020 19:25:06 +0300
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
Message-ID: <20200917162506.GC9750@linux.intel.com>
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
 <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
 <20200917162142.GB9750@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917162142.GB9750@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 17, 2020 at 07:21:49PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > support in case platform doesn't posses a TPM device.
> > 
> > So this patch tries to add generic trusted keys framework where underlying
> > implementations like TPM, TEE etc. could be easily plugged-in.
> 
> I would rephrase this a bit:
> 
> "Add a generic trusted keys framework where underlying implementations
> can be easily plugged in. Create struct trusted_key_ops to achieve this,
> which contains necessary functions of a backend."
> 
> I remember asking about this approach that what if there was just a
> header for trusted key functions and a compile time decision, which C
> file to include instead of ops struct. I don't remember if these was a
> conclusion on this or not.
> 
> E.g. lets say you have a device with TEE and TPM, should you be able
> to be use both at run-time? I might play along how this works now but
> somehow, in the commit message preferably, it should be conclude why
> one alternative is chosen over another.

We must somehow seal this discussion because the other changes are
based on this decision.

I don't think tail of this patch set takes a long time spin. This
is the main architectural decision.

/Jarkko
