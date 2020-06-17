Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7F1FD99E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQX3j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:29:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:38487 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQX3j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:29:39 -0400
IronPort-SDR: 2yjAB64GQoT9TWlx2Z2r87ieEOwxDisBzfeKUnn9vfoufIBYMl56kjtpatFhvfbEw9NxaETLfz
 oGoLUhMCn0gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:29:39 -0700
IronPort-SDR: 247+VGhQKN/DY2/6Wxaog/AFJvjsLF4s1fNpJ5GtTo8ygX127qibqdtOo80ZHz8YohLUIWMMgx
 1kaCm4ACWOug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="262734071"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2020 16:29:36 -0700
Date:   Thu, 18 Jun 2020 02:29:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: extra chip->ops check on error path in
 tpm_tis_core_init
Message-ID: <20200617232935.GF62794@linux.intel.com>
References: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
 <20200617022632.c6mhqg7jwolebxvx@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617022632.c6mhqg7jwolebxvx@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 07:26:32PM -0700, Jerry Snitselaar wrote:
> On Sat Jun 13 20, Vasily Averin wrote:
> > Found by smatch:
> > drivers/char/tpm/tpm_tis_core.c:1088 tpm_tis_core_init() warn:
> > variable dereferenced before check 'chip->ops' (see line 979)
> > 
> > 'chip->ops' is assigned in the beginning of function
> > in tpmm_chip_alloc->tpm_chip_alloc
> > and is used before first possible goto to error path.
> > 
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks, I added this to the commit.

/Jarkko
