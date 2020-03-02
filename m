Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17320175935
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCBLIw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 06:08:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:41429 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLIw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 06:08:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="412243500"
Received: from aorourk1-mobl.ger.corp.intel.com (HELO localhost) ([10.251.86.123])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 03:08:50 -0800
Date:   Mon, 2 Mar 2020 13:08:49 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-ID: <20200302110849.GA3979@linux.intel.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
 <20200225164850.GB15662@linux.intel.com>
 <1582765091.4245.33.camel@HansenPartnership.com>
 <20200227161949.GD5140@linux.intel.com>
 <1582820506.18445.3.camel@HansenPartnership.com>
 <1582825769.18445.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582825769.18445.18.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 27, 2020 at 09:49:29AM -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 08:21 -0800, James Bottomley wrote:
> > On Thu, 2020-02-27 at 18:19 +0200, Jarkko Sakkinen wrote:
> [...]
> > Ok, I'll add that commit as the fixes; it certainly makes no sense to
> > backport this change before the above commit.
> 
> This is what I currently have.  Do you want me to resend the whole
> series?

I prefer to review full snapshots of the series.

/Jarkko
