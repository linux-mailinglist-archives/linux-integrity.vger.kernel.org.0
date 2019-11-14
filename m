Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56072FCAE4
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNQlO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 11:41:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:28581 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKNQlO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 11:41:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 08:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="406378419"
Received: from pkamlakx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.10.73])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2019 08:41:10 -0800
Date:   Thu, 14 Nov 2019 18:41:07 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5
Message-ID: <20191114164047.GA9528@linux.intel.com>
References: <20191112195542.GA10619@linux.intel.com>
 <20191112195826.GA5584@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112195826.GA5584@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 03:58:26PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 12, 2019 at 09:55:42PM +0200, Jarkko Sakkinen wrote:
> > 1. Support for Cr50 fTPM.
> > 2. Support for fTPM on AMD Zen+ CPUs.
> > 3. TPM 2.0 trusted keys code relocated from drivers/char/tpm to
> >    security/keys.
> 
> Just to be clear, this is for the next merge window right?

v5.5-rc1

/Jarkko
