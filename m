Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114627DE8E
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgI3ClG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:41:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:29302 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgI3ClG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:41:06 -0400
IronPort-SDR: 7bhZrM1FwYR09lti464m96lDlQzO2qyvUKuWcm5EsvYWHNYjtIhJQQZbq5SjXBY7VMpZe3Stsr
 7mBPyTr8VhCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="223941936"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="223941936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:41:02 -0700
IronPort-SDR: KuiyPdSRmPJt4sg5ICruluMUP42tmdUM+5MZ2hHFAtmY5Iz+R2E5G09uL9D0FHja1Saq3l81oz
 RYOksQmbzK+w==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="494909272"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:41:00 -0700
Date:   Wed, 30 Sep 2020 05:40:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 4/4] Revert "tpm: Revert "tpm_tis_core: Turn on the TPM
 before probing IRQ's""
Message-ID: <20200930024058.GL808399@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929223216.22584-5-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 03:32:16PM -0700, James Bottomley wrote:
> Revert the patch aa4a63dd9816 which stops interrupt probing from
> working, now that it should be safe to allow interrupt probing on all
> systems without incurring interrupt storms.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

I will give this the review tag once the 1-3 have it.

/Jarkko
