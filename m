Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040B92806A3
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgJAScC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:32:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:25276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732792AbgJASb6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:31:58 -0400
IronPort-SDR: Ar5kHokYJjIrbEWXm4GkXkwg9/aT+C5om/9Zv9EjNQXYcLd7FMK9bF+skCDxZp3magt3OY1VcS
 3EGu/Lf3JYmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="224421297"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="224421297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:31:44 -0700
IronPort-SDR: tyeGzwUH3EV0A9RbI87Y5PeLA/0N4LDG2Rdy1CVb8xBrdbPBl96ZWESds7R2Tx+mLXHfWtWeb8
 LEEwMM9a3PVw==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="504890753"
Received: from mcampone-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:31:41 -0700
Date:   Thu, 1 Oct 2020 21:31:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20201001183104.GA15664@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
 <20201001120125.GE32109@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001120125.GE32109@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 02:01:25PM +0200, Petr Vorel wrote:
> I'll need to keep these hacks for older kernels, but it's great that there is a
> better solution.
> 
> Other thing: do you know anybody practically uses more TPM devices in single
> machine? I'm asking that I work with tpm0 in ima_tpm.sh, but maybe I should
> allow user to redefine it to choose different device (or even run tests for all
> available devices).

You can create a proxy TPM device for a TPM emulator or a software TPM
(e.g. could be an SGX enclave) by using ioctl interface /dev/vtpmx,
provided by tpm_vtpm_proxy driver. QEMU provides a passthrough interface
from TPM devices to the VM, which can be utilized for this.

This one I know at least.

> Kind regards,
> Petr

/Jarkko
