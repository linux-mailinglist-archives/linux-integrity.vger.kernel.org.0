Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B808C35E9E
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFEOGK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 10:06:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:53436 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEOGK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 10:06:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:06:09 -0700
X-ExtLoop1: 1
Received: from araresx-wtg1.ger.corp.intel.com (HELO localhost) ([10.252.46.102])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2019 07:06:06 -0700
Date:   Wed, 5 Jun 2019 17:06:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190605140539.GA11331@linux.intel.com>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190603202815.GA4894@linux.intel.com>
 <20190603211648.GV12898@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603211648.GV12898@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 03, 2019 at 05:16:48PM -0400, Sasha Levin wrote:
> On Mon, Jun 03, 2019 at 11:28:15PM +0300, Jarkko Sakkinen wrote:
> > On Thu, May 30, 2019 at 11:27:56AM -0400, Sasha Levin wrote:
> > > Changes since v3:
> > > 
> > >  - Address comments by Jarkko Sakkinen
> > >  - Address comments by Igor Opaniuk
> > > 
> > > Sasha Levin (2):
> > >   fTPM: firmware TPM running in TEE
> > >   fTPM: add documentation for ftpm driver
> > 
> > I think patches start to look proper but I wonder can anyone test
> > these? I don't think before that I can merge these.
> 
> They're all functionally tested by us on actual hardware before being
> sent out.
> 
> The reference implementation is open and being kept updated, and an
> interested third party should be able to verify the correctness of these
> patches. However, it doesn't look like there's an interested third party
> given that these patches have been out for a few months now.

So can they be tagged with your tested-by?

/Jarkko
