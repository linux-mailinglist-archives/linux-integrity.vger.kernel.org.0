Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331736588C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfGKOLC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 10:11:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:55699 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGKOLC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 10:11:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 07:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,478,1557212400"; 
   d="scan'208";a="365281707"
Received: from jsolavil-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.99])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2019 07:10:59 -0700
Date:   Thu, 11 Jul 2019 17:10:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Message-ID: <20190711141058.xfqpsfh4rzcjksth@linux.intel.com>
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

Will give a detailed review but generally we workaround firmware
issues when possible so in that way there is no argument here.

/Jarkko
