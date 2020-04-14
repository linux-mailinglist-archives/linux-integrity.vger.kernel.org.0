Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF61A74C9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406633AbgDNH36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 03:29:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:46489 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406631AbgDNH35 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:57 -0400
IronPort-SDR: 6e9ILlvig8Iv7RrHr/qR+YoqIz/22i3gdcK9g2uQXpsfUhSTL0oxKd8KHy7E5gfU4/oDaESdUi
 mOZxyoys9TBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 00:29:56 -0700
IronPort-SDR: EsEakIQVMAszRJ7SduQBFy1ioFSV3Wt4cZnXwXUPa8/MmyJOeYCuONkiJ9OMJ/Pdb8JlVtZMsO
 Hfki/ckE7k8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="256426116"
Received: from elenamax-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.42.208])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2020 00:29:51 -0700
Date:   Tue, 14 Apr 2020 10:29:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2] qtpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm
 driver as module
Message-ID: <20200414072950.GD8403@linux.intel.com>
References: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com>
 <20200319195706.GD24804@linux.intel.com>
 <2BF66599-184A-4647-BC57-105A1512F119@linux.vnet.ibm.com>
 <20200402193134.GC10314@linux.intel.com>
 <87k12ikhye.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k12ikhye.fsf@mpe.ellerman.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 14, 2020 at 10:51:37AM +1000, Michael Ellerman wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> > On Wed, Apr 01, 2020 at 02:40:30PM +0530, Sachin Sant wrote:
> >> > On 20-Mar-2020, at 1:27 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >> > 
> >> > On Wed, Mar 18, 2020 at 09:00:17PM -0400, Stefan Berger wrote:
> >> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >> >> 
> >> >> This patch fixes the following problem when the ibmvtpm driver
> >> >> is built as a module:
> >> >> 
> >> >> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> >> >> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> >> >> make: *** [Makefile:1298: modules] Error 2
> >> >> 
> >> >> Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")
> >> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> >> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> >> >> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> >> > 
> >> 
> >> Ping. This failure can now be seen in mainline (cad18da0af) as well.
> >
> > It is in my tree
> 
> Can you please send it to Linus?
> 
> cheers

Yes.

/Jarkko
