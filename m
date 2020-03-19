Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB318C21F
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSVQq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 17:16:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:13705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSVQq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 17:16:46 -0400
IronPort-SDR: kFWj6QTzoA9tNrJ6AycpRyGHDyCgUMnIi7bve/d1EpBn+YaiQCmQ2OsczPRHYBqEe2Y1dlzptB
 hmblyVMVCKqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 14:16:46 -0700
IronPort-SDR: OBRhkR5VnCf/p7xoXpuzUddSNSb1jZn/xUmnKQPVBXKXMUsYDj29anBBw5c+nly35wywnl9icp
 KXe3LQ+7zEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="237054181"
Received: from oamor-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.182.181])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2020 14:16:43 -0700
Date:   Thu, 19 Mar 2020 23:16:42 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sachinp@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
Message-ID: <20200319211642.GB167847@linux.intel.com>
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
 <20200318194247.GC48177@linux.intel.com>
 <4b2949a9-b251-906d-d513-1b2ccef758a0@linux.ibm.com>
 <20200319142714.GB3703@linux.intel.com>
 <17b5d98c-76b2-63c0-798a-920d91fec618@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b5d98c-76b2-63c0-798a-920d91fec618@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 19, 2020 at 11:56:11AM -0400, Stefan Berger wrote:
> On 3/19/20 10:27 AM, Jarkko Sakkinen wrote:
> > On Wed, Mar 18, 2020 at 03:53:54PM -0400, Stefan Berger wrote:
> > > On 3/18/20 3:42 PM, Jarkko Sakkinen wrote:
> > > > On Tue, Mar 17, 2020 at 09:08:19AM -0400, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > This patch fixes the following problem when the ibmvtpm driver
> > > > > is built as a module:
> > > > > 
> > > > > ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> > > > > make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> > > > > make: *** [Makefile:1298: modules] Error 2
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Hi, wrong tag (we use "tpm:"), missing fixes tag and please cc stable.
> > > > Thanks.
> > > I did not add the fixes tag because I do not know the final commit hash, or
> > > is it the final commit hash once it is in linux-next? I doubt it with all
> > > the merging that can occur.
> > Can you send me a new version after rc1 is out?
> 
> Michael Ellerman (cc'ed) told me that the fixes tag should 'work' once the
> bad patch is in linux-next. So I reposted yesterday (with a stray 'q' in the
> title :-( ):

OK, cool, I'll correct it and apply thanks.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
