Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B709A18B952
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCSO1U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 10:27:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:29627 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgCSO1U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 10:27:20 -0400
IronPort-SDR: wnimBr6TMM/qvZ3Eq8LRWvp9TFzr5L76J8AEl0FA2N+sA0p7u6eDtbUy6VtQOHI/9vn2IdObx9
 VFZZhG4B719w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 07:27:19 -0700
IronPort-SDR: EtchYp8B7uoiL7wXlFcN9kwhNz4PotBR5UDN4L88/9cjUnL/sX041L43u1+FsR1fQ8+fpnnp2x
 +Sf2pLhtxX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="245175060"
Received: from awagner-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.86.227])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 07:27:15 -0700
Date:   Thu, 19 Mar 2020 16:27:14 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sachinp@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
Message-ID: <20200319142714.GB3703@linux.intel.com>
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
 <20200318194247.GC48177@linux.intel.com>
 <4b2949a9-b251-906d-d513-1b2ccef758a0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2949a9-b251-906d-d513-1b2ccef758a0@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 18, 2020 at 03:53:54PM -0400, Stefan Berger wrote:
> On 3/18/20 3:42 PM, Jarkko Sakkinen wrote:
> > On Tue, Mar 17, 2020 at 09:08:19AM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > This patch fixes the following problem when the ibmvtpm driver
> > > is built as a module:
> > > 
> > > ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> > > make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> > > make: *** [Makefile:1298: modules] Error 2
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Hi, wrong tag (we use "tpm:"), missing fixes tag and please cc stable.
> > Thanks.
> 
> I did not add the fixes tag because I do not know the final commit hash, or
> is it the final commit hash once it is in linux-next? I doubt it with all
> the merging that can occur.

Can you send me a new version after rc1 is out?

/Jarkko
