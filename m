Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8719CA03
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbgDBTbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 15:31:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:55074 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389108AbgDBTbq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 15:31:46 -0400
IronPort-SDR: QiGyNbUFGh/kl5UgT6MXL48AH32OQO4b+wdFF1SQuiKXpRPWXpxnZRSX5vZzWUlPvDaGLC7whV
 hqnavcRWXi8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:31:39 -0700
IronPort-SDR: e818wdZCBUVsYzp4U6BJ2Qs8+Q43Q9Q/oXz4HQxZxW1jZNUehwjhCwCUuZOXi121xQ+V+8oFYI
 Ksm606buqnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="240914698"
Received: from hbriegel-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.101])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 12:31:36 -0700
Date:   Thu, 2 Apr 2020 22:31:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2] qtpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm
 driver as module
Message-ID: <20200402193134.GC10314@linux.intel.com>
References: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com>
 <20200319195706.GD24804@linux.intel.com>
 <2BF66599-184A-4647-BC57-105A1512F119@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2BF66599-184A-4647-BC57-105A1512F119@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 01, 2020 at 02:40:30PM +0530, Sachin Sant wrote:
> 
> 
> > On 20-Mar-2020, at 1:27 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Wed, Mar 18, 2020 at 09:00:17PM -0400, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >> 
> >> This patch fixes the following problem when the ibmvtpm driver
> >> is built as a module:
> >> 
> >> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> >> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> >> make: *** [Makefile:1298: modules] Error 2
> >> 
> >> Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> >> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > 
> 
> Ping. This failure can now be seen in mainline (cad18da0af) as well.

It is in my tree

/Jarkko
