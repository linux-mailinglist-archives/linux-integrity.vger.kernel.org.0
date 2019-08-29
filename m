Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58CAA1B45
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfH2NU0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 09:20:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:40105 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2NU0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 09:20:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="205714694"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2019 06:20:23 -0700
Date:   Thu, 29 Aug 2019 16:20:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
Message-ID: <20190829132021.6vfc535ecb62jokf@linux.intel.com>
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
 <20190827131400.qchcwa2act24c47b@linux.intel.com>
 <20190827151915.hb4xwr2vik2i5ryb@linux.intel.com>
 <797ff54e-dceb-21d2-dd74-e5244f9c6dfd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797ff54e-dceb-21d2-dd74-e5244f9c6dfd@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 27, 2019 at 03:34:36PM -0400, Stefan Berger wrote:
> On 8/27/19 11:19 AM, Jarkko Sakkinen wrote:
> > On Tue, Aug 27, 2019 at 04:14:00PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
> > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > 
> > > > The interrupt probing of the TPM TIS was broken since we are trying to
> > > > run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Need these:
> > > 
> > > Cc: linux-stable@vger.kernel.org
> > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > 
> > > Thank you. I'll apply this to my tree.
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > The commit went in the following form:
> > 
> > http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/9b558deab2c5d7dc23d5f7a4064892ede482ad32
> 
> I saw you dropped the stetting of the IRQ flag - I needed it, otherwise it
> wouldn't execute certain code paths.

I explained why I removed that part. There was no any reasoning for
it. Also, it cannot be in the same commit if it fixes a diffent
issue.


/Jarkko
