Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33C3A29AD
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2WXG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:23:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:16742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfH2WXG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:23:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 15:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="182478350"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 15:23:03 -0700
Date:   Fri, 30 Aug 2019 01:23:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH 2/2 v2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190829222301.iqtttpzn2dgoyrze@linux.intel.com>
References: <20190828004621.29050-1-jsnitsel@redhat.com>
 <20190828004621.29050-3-jsnitsel@redhat.com>
 <20190829144002.zhuqxnsswgl65pnm@linux.intel.com>
 <20190829202527.auyqek7yryuvaruk@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829202527.auyqek7yryuvaruk@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 29, 2019 at 01:25:27PM -0700, Jerry Snitselaar wrote:
> On Thu Aug 29 19, Jarkko Sakkinen wrote:
> > On Tue, Aug 27, 2019 at 05:46:21PM -0700, Jerry Snitselaar wrote:
> > > There was revealed a bug in the STM TPM chipset used in Dell R415s.
> > > Bug is observed so far only on chipset firmware 1.2.8.28
> > > (1.2 TPM, device-id 0x0, rev-id 78). After some number of
> > > operations chipset hangs and stays in inconsistent state:
> > > 
> > > tpm_tis 00:09: Operation Timed out
> > > tpm_tis 00:09: tpm_transmit: tpm_send: error -5
> > > 
> > > Durations returned by the chip are the same like on other
> > > firmware revisions but apparently with specifically 1.2.8.28 fw
> > > durations should be reset to 2 minutes to enable tpm chip work
> > > properly. No working way of updating firmware was found.
> > > 
> > > This patch adds implementation of ->update_durations method
> > > that matches only STM devices with specific firmware version.
> > > 
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > ---
> > > v2: Make suggested changes from Jarkko
> > >     - change struct field name to durations from durs
> > >     - formatting cleanups
> > >     - turn into void function like update_timeouts and
> > >       use chip->duration_adjusted to track whether adjustment occurred.
> > 
> > The code repetition looks horrible so I wrote a patch that should help:
> > 
> > https://patchwork.kernel.org/patch/11121475/
> > 
> > Read the remar that prepends the diffstat.
> > 
> > /Jarkko
> 
> LGTM, and testing it on a 1.2 tpm system here worked fine. You can add my
> Reviewed-by and Tested-by.
> 
> I have reworked this 2/2 patch to make use of these new structs and
> pull the tpm1_getcap calls out of the for loop. So I will submit a v3
> to go on top of your patch.

Add my patch to the patch set with the tags.

/Jarkko
