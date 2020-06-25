Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66A20A768
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406218AbgFYV0D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:26:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:48827 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403817AbgFYV0D (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:26:03 -0400
IronPort-SDR: y+q3Uf8YDcDgnsYsMtTnGF2uaMRFtkE8QpWKm2chTURxP/KRPh+PTe8nzU5HkV2TaQ32SwRlhv
 900rlhSYk8gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="124731935"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="124731935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:26:03 -0700
IronPort-SDR: Q+odNhtMPjew0ImPtdJD4sdw0uohNKzcyfPOD5ciV1P9lwDXaPusvAIDdbP7Hd+KrthabFOClc
 uS8RZ4vYJxeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="319847197"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2020 14:25:57 -0700
Date:   Fri, 26 Jun 2020 00:25:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200625212556.GC20341@linux.intel.com>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
 <8d19d5e2-91bc-09ad-6b94-d51a7aad6376@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d19d5e2-91bc-09ad-6b94-d51a7aad6376@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 08:41:18AM -0400, Stefan Berger wrote:
> On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
> > Re-allocate context and session buffers when needed. Scale them in page
> > increments so that the reallocation is only seldomly required, and thus
> > causes minimal stress to the system. Add a static maximum limit of four
> > pages for buffer sizes.
> > 
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> 
> You don't want to try a fixes tag? None of the previous versions of this
> code will work with newer versions of the TPM 2 then...

It's not a regression.

/Jarkko
