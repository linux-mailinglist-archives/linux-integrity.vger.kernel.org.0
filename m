Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D156C2A1090
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 22:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ3VwX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 17:52:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:13754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJ3VwW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 17:52:22 -0400
IronPort-SDR: rz0d9B0zri0GKsaBXVtCz/g7Exu3szo3WA8tbWw8WXi8ygogFULRbWKP2XFX2BYYF5g/8Enptx
 7b6wOjVQsXTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230306363"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="230306363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 14:52:22 -0700
IronPort-SDR: 8rB8XqeOO6wR3N1B6aL6HhJJJ1Z7z5CVXZP5hTOqa0OpmfBIxF13t/uLyeAVTsIRcmXjC60PmU
 9uWPHtIWxH3A==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537215618"
Received: from psrecla-mobl1.ger.corp.intel.com (HELO linux.intel.com) ([10.252.45.227])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 14:52:18 -0700
Date:   Fri, 30 Oct 2020 23:52:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
Message-ID: <20201030215212.GE5666@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
 <875z75hkk8.fsf@redhat.com>
 <20201024121007.GA32960@kernel.org>
 <20201030121756.GB522355@kernel.org>
 <6ebaaa03669cbc92037b6f1ac8d8649744c01146.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebaaa03669cbc92037b6f1ac8d8649744c01146.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 30, 2020 at 08:47:30AM -0700, James Bottomley wrote:
> On Fri, 2020-10-30 at 14:17 +0200, Jarkko Sakkinen wrote:
> [...]
> > Just noticed that the short summary is wrong: a fix is not a clean
> > up.
> 
> I don't really think this is a fix.  What we currently have is working,
> just suboptimally.  This makes it work optimally, which is better, but
> it's not fixing anything because apart from a speed up in operations
> there will be no user visible change.  If we use the word "fix" it will
> excite all the automatic patch selectors for stable.
> 
> > Maybe "tpm_tis: Invoke locality release without wait" ? I'm also open
> > for other suggestions but the current is short summary does not
> > describe the patch.
> 
> That sounds fine, not having fix in the subject works for me.
> 
> James

OK, great.

/Jarkko
