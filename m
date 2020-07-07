Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE62163EA
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGCW6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:22:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:32174 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGGCW6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:22:58 -0400
IronPort-SDR: TrbcWx1zr9VwTJ6nzVnWlUjqtgLKOO62r8xUeg7eCT3CbzKkO4qZdMcNBCsqnELuIg4QE4+A1P
 owXhUdyHGQIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145629098"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145629098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:22:57 -0700
IronPort-SDR: RRtLp7g7XBqNMCaJ1MBmtTIzeEI6oYPRvJ9iKakYDoQVPoamxok3QBYrXl8RoBtSiWzN603syM
 TI52Jr74Vpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="323392431"
Received: from pakumpul-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.16])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 19:22:53 -0700
Date:   Tue, 7 Jul 2020 05:22:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID
 IFX0102")
Message-ID: <20200707022252.GB112019@linux.intel.com>
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
 <87k0zgwc2s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0zgwc2s.fsf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 02:47:07PM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-07-06 13:53 MST:
> 
> > Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> > and tpm_infineon use the same device ID. Revert the commit and add a
> > remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> > module parameter").
> >
> > Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> > Reported-by: Peter Huewe <peterhuewe@gmx.de>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks.

PR sent https://lkml.org/lkml/2020/7/6/1127

/Jarkko
