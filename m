Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E735030C5DD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhBBQcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 11:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236520AbhBBQaI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 11:30:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02F1C64F72;
        Tue,  2 Feb 2021 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612283366;
        bh=z92uc1/pNzl5ssLYGJk8u4yt8XjE8IF2yKfBafnU9hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NljF1sC/ik29bEZoMBSoxiWfV2tb1C8f5Mvrg7c009Pnmz70bE4RYoWQooGkYqEvt
         WKXLzyrZefi1C6lURl0wb23et37ZZgh4G9iOWFI4aYqTm+Y59kP7fTb+jJw3r+6Ih5
         3XOe2vgMBvBsbSKC5sKz6sffDojTAOVLkR58GKokz9bvX5PvGFnrnp/US8n8R8qS4k
         VV3NtHcatniEpet5bwLu8RosqXju9qg2khN8AzfYNH9jUlJGuCqWaxq5uFelZmnXov
         GD7Xh9eMK8FY61WYnRhq0BegrORjprDCxVuwQZQ+C54UdWCiE1g5q8RLJ+4azk6Nbo
         hBnp6Id4RLeYw==
Date:   Tue, 2 Feb 2021 18:29:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tj <ml.linux@elloe.vision>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
Message-ID: <YBl933XkQimq5elb@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210128130753.1283534-1-lma@semihalf.com>
 <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
 <ghwnvtwifq.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghwnvtwifq.fsf@gouders.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 31, 2021 at 10:43:05AM +0100, Dirk Gouders wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> 
> > On Thu, 2021-01-28 at 14:07 +0100, Lukasz Majczak wrote:
> >> There is a missing call to tpm_request_locality before the call to
> >> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> >> approach might work for tpm2, it fails for tpm1.x - in that case
> >> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> >> without locality fails and in turn causes tpm_tis_core_init() to fail.
> >> Tested on Samsung Chromebook Pro (Caroline).
> >> 
> >> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> >
> > Is it possible that you test against linux-next and see if any
> > problems still arise? I've applied the locality fixes from James.
> 
> I tested current linux-next and the warning still appears,
> unfortunately.
> 
> I then incrementally applied further patches from James' series [1] and
> after "[PATCH v2 4/5] tpm_tis: fix IRQ probing" the warning has gone:
> 
> # dmesg | grep tpm
> [    7.220410] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
> [    7.322564] Modules linked in: iwlmvm(+) btusb btrtl btbcm btintel mac80211 amdgpu(+) iwlwifi drm_ttm_helper tpm_crb sdhci_pci ttm cqhci gpu_sched sdhci ccp cfg80211 rng_core tpm_tis tpm_tis_core tpm thinkpad_acpi(+) wmi nvram pinctrl_amd
> 
> You might notice there is another warning but that is rtc related and I
> still have to find out if that is something I should report.

1/5 and 2/5 are on the other hand unconditionally "right things" to
do. In your case the resulting state will anyway just result a polling
driver and the kernel state remains stable.

WARN_ONCE() is clearly an overkill, as kernel does not have inconsistent
state. Using WARN_ONCE() was a mistake.

I sent this fix: https://lore.kernel.org/linux-integrity/3936843b-c0da-dd8c-8aa9-90aa3b49d525@linux.ibm.com/T/#t

It will turn WARN_ONCE() to pr_warn_once() and also add the status code
to klog entry. It's sufficient in this case. For 3/5-5/5 we need more
time.

/Jarkko
