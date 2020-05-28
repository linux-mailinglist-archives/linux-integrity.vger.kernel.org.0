Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51CE1E6A20
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406183AbgE1TKZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 15:10:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:22208 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406129AbgE1TKY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 15:10:24 -0400
IronPort-SDR: fVVSCS3j6dBFtCGtclrb0JGtFZoq/RKxk+RVnY8SVZGazVMrIdh1hKO7T18SZRAtYRxDf9eaoH
 er+Bpto7Sscw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:10:23 -0700
IronPort-SDR: lfCxX18BigE0qmNfQKYWRA9KnhGelelDH/RpP0+t4IY/awrHmgmzRhvv6n4H3rkmkQs+mz7Euu
 bWlikEEaSY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="292101076"
Received: from jtitox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.56.171])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 12:10:20 -0700
Date:   Thu, 28 May 2020 22:10:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Guzman <alex@guzman.io>
Subject: Re: [PATCH v2] tpm: fix TIS locality timeout problems
Message-ID: <20200528191018.GB2147934@linux.intel.com>
References: <1590689457.3449.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590689457.3449.7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 28, 2020 at 11:10:57AM -0700, James Bottomley wrote:
> It has been reported that some TIS based TPMs are giving unexpected
> errors when using the O_NONBLOCK path of the TPM device. The problem
> is that some TPMs don't like it when you get and then relinquish a
> locality (as the tpm_try_get_ops()/tpm_put_ops() pair does) without
> sending a command.  This currently happens all the time in the
> O_NONBLOCK write path. Fix this by moving the tpm_try_get_ops()
> further down the code to after the O_NONBLOCK determination is made.
> This is safe because the priv->buffer_mutex still protects the priv
> state being modified.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206275
> Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
> Reported-by: Mario Limonciello <Mario.Limonciello@dell.com>
> Tested-by: Alex Guzman <alex@guzman.io>
> Cc: stable@vger.kernel.org
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thanks a lot! Merging this soon.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarko
