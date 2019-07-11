Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D065FE7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGKTQ0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 15:16:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:40959 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfGKTQ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 15:16:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 12:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="189609914"
Received: from mmoerth-mobl6.ger.corp.intel.com (HELO localhost) ([10.249.35.82])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2019 12:16:23 -0700
Date:   Thu, 11 Jul 2019 22:16:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Message-ID: <20190711191622.w3s5g2xtn7sa5lm3@linux.intel.com>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 12:29:30PM +0000, Safford, David (GE Global Research, US) wrote:
> Most x86 desktops and laptops have firmware TPMs which support the
> CRB interface. Unfortunately, the linux tpm_crb driver depends on
> perfectly correct ACPI tables, and there are a *lot* of systems out
> there with broken tpm_crb entries. (Not one of my five tpm_crb
> systems works with the existing driver.) While it is good to
> encourage vendors to fix their firmware, many refuse ("It works on
> Windows"), leaving users in the lurch.
> 
> This patch adds a kernel parameter "tpm_crb.force=1" that works
> around the problem in every case I have tested so far. Basically
> it does two things:
> 	- it trusts the cmd and resp addresses in the CRB registers
> 	- it ignores all alleged IO resource conflicts
> 
> Both workarounds make sense. If there really were an address conflict,
> or if the register values really were wrong, the device would not be
> working at all. And testing with this patch has shown that in every
> case (so far), the problem has been bogus ACPI entries.
> 
> This patch is against the upstream 5.2 kernel.
> 
> Signed-off-by: David Safford <david.safford@ge.com>

OK so in the past we've figured out the right way workaround these as
we've encountered faulty TPMs. tpm_crb does not depend on perfectly
correct ACPI tables. It already does some fixups for certain situations.

This change does not have a scope to put short.

/Jarkko
