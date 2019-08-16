Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427DE90B92
	for <lists+linux-integrity@lfdr.de>; Sat, 17 Aug 2019 01:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfHPXzi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Aug 2019 19:55:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:56395 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfHPXzi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Aug 2019 19:55:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 16:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="206405897"
Received: from spdempse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 16:55:33 -0700
Date:   Sat, 17 Aug 2019 02:55:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Message-ID: <20190816235532.zwctk56harregq7x@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-2-swboyd@chromium.org>
 <20190717113956.GA12119@ziepe.ca>
 <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
 <20190717165011.GI12119@ziepe.ca>
 <5d2f54db.1c69fb81.5720c.dc05@mx.google.com>
 <5d44be49.1c69fb81.8078a.4d08@mx.google.com>
 <d72750b9-38b8-172f-8902-427fcc3d0a5d@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72750b9-38b8-172f-8902-427fcc3d0a5d@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 16, 2019 at 05:56:12PM +0200, Alexander Steffen wrote:
> > Andrey talked to me a little about this today. Andrey would prefer we
> > don't just let the TPM go into a wonky state if it's used during
> > suspend/resume so that it can stay resilient to errors. Sounds OK to me,
> > but my point still stands that we need to fix the callers.
> > 
> > I'll resurrect the IS_SUSPENDED flag and make it set generically by the
> > tpm_pm_suspend() and tpm_pm_resume() functions and then spit out a big
> > WARN_ON() and return an error value like -EAGAIN if the TPM functions
> > are called when the TPM is suspended. I hope we don't hit the warning
> > message, but if we do then at least we can track it down rather quickly
> > and figure out how to fix the caller instead of just silently returning
> > -EAGAIN and hoping for that to be visible to the user.
> 
> There is another use case I see for this functionality: There are ways for
> user space to upgrade the TPM's firmware via /dev/tpm0 (using e.g.
> TPM2_FieldUpgradeStart/TPM2_FieldUpgradeData). While upgrading, the normal
> TPM functionality might not be available (commands return TPM_RC_UPGRADE or
> other error codes). Even after the upgrade is finished, the TPM might
> continue to refuse command execution (e.g. with TPM_RC_REBOOT).
> 
> I'm not sure whether all in-kernel users are prepared to deal correctly with
> those error codes. But even if they are, it might be better to block them
> from sending commands in the first place, to not interfere with the upgrade
> process.
> 
> What would you think about a way for a user space upgrade tool to also set
> this flag, to make the TPM unavailable for everything but the upgrade
> process?
> 
> Alexander

NOTE: Just commenting the FW use case.

I don't like it because it contains variable amount of reserved time
for a hardware resource.

Right now a user thread gets a lease of one TPM command for /dev/tpm0
and that is how I would like to keep it.

/Jarkko
