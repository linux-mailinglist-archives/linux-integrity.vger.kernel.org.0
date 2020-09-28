Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF627B7C0
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 01:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgI1XPU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 19:15:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:43373 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgI1XPU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 19:15:20 -0400
IronPort-SDR: MzaTRTEU7O549N1iVOg0Ho0Z2QXbZ/VWnNTSbhN0Ga3HlmIohvOx4zr77dwO+knSqef/1Q4qUz
 nwI4/P+M4Dvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="161299359"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="161299359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 15:12:05 -0700
IronPort-SDR: ZI2krDy7kZ+beEy4ZmSSIHWOMd/Yk9o0NZOgvuU5LzRGKcNieeQL7dCOJOaEfQWWuMGwbqLXBB
 9eQ3j/xnupjA==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="457013032"
Received: from jlasecki-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.49.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 15:12:04 -0700
Date:   Tue, 29 Sep 2020 01:12:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
Message-ID: <20200928221202.GH2705@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
 <20200928001138.GE5283@linux.intel.com>
 <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
 <20200928112046.GA14051@linux.intel.com>
 <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
 <20200928163114.GC92669@linux.intel.com>
 <20200928170720.GA119268@linux.intel.com>
 <d44256f102c7be01808c5186d2c23b685ff090b7.camel@HansenPartnership.com>
 <20200928181304.GB122104@linux.intel.com>
 <6720ff958180a9e040c655dcfc281b3260fe88f2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6720ff958180a9e040c655dcfc281b3260fe88f2.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 11:26:41AM -0700, James Bottomley wrote:
> > Yes.
> > 
> > BTW, while doing this I think I noticed what was wrong in my test
> > kernel when I tested your series that introduces ASN.1 keys. I'll
> > test both before sending update to my fix. Hopefully I can give today
> > tested-by tags to that series.
> 
> Great ... the trusted key code doesn't use tpm_send, but the policy
> additions do so the latter will need updating (again).

Yes, I know. I can still test both by separately applying them on top
of the current master. If you can after that do the update (and after
the fixes have been applied), I can still get everything to the same
PR.

Sorry for latency because of some SGX discussions (this time retpoline
and CET collision), I'll try to get the testing done ASAP.

/Jarkko
