Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A720A729
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405441AbgFYVCN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:02:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:24444 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405347AbgFYVCN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:02:13 -0400
IronPort-SDR: rMeBkFzC5wHops8amyd9Wwl6u53PjApIFys7KE5fsPc8yENuz8KaP40f7WLnmuYv5GTnBDoijN
 QbU9bMvK89cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132511756"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="132511756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:02:12 -0700
IronPort-SDR: BQSROp49MQ9J0Db6XnzAdYU+X7mKN3Pxg8zFxQJi72Ij8XrV4KZV/7+9tF8Ihjw++7hVrRp61R
 mnZCSkbZZGJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="479777206"
Received: from drews-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.247])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2020 14:02:10 -0700
Date:   Fri, 26 Jun 2020 00:02:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200625210202.GA20341@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625062150.idm6j3vm2neyt4sh@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
> On Thu Jun 25 20, Jarkko Sakkinen wrote:
> > Acer C720 running Linux v5.3 reports this in klog:
> > 
> > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> > tpm tpm0: tpm_try_transmit: send(): error -5
> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > tpm_tis tpm_tis: Could not get TPM timeouts and durations
> > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> > tpm tpm0: tpm_try_transmit: send(): error -5
> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > tpm_tis 00:08: Could not get TPM timeouts and durations
> > ima: No TPM chip found, activating TPM-bypass!
> > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> > 
> > % git --no-pager grep IFX0102 drivers/char/tpm
> > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> > 
> > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
> > mistake.
> > 
> > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Bugzilla has an example of similar behavior with v4.15. I'll apply this
asap.

/Jarkko
