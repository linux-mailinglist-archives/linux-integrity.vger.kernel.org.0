Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81331784CD
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 22:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgCCVUU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 16:20:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:45009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732511AbgCCVUT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 16:20:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 13:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="274385105"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2020 13:20:16 -0800
Date:   Tue, 3 Mar 2020 23:20:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 6/6] security: keys: trusted: implement counter/timer
 policy
Message-ID: <20200303212010.GA110353@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-7-James.Bottomley@HansenPartnership.com>
 <20200303200820.GE5775@linux.intel.com>
 <1583268041.3638.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583268041.3638.9.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 03, 2020 at 03:40:41PM -0500, James Bottomley wrote:
> On Tue, 2020-03-03 at 22:08 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 02, 2020 at 07:27:59AM -0500, James Bottomley wrote:
> > > This is actually a generic policy allowing a range of comparisons
> > > against any value set in the TPM Clock, which includes things like
> > > the reset count, a monotonic millisecond count and the restart
> > > count.  The most useful comparison is against the millisecond count
> > > for expiring keys.  However, you have to remember that currently
> > > Linux doesn't try to sync the epoch timer with the TPM, so the
> > > expiration is actually measured in how long the TPM itself has been
> > > powered on ... the TPM timer doesn't count while the system is
> > > powered down.  The millisecond counter is a u64 quantity found at
> > > offset 8 in the timer structure, and the <= comparision operand is
> > > 9, so a policy set to expire after the TPM has been up for 100
> > > seconds would look like
> > > 
> > > 0000016d00000000000f424000080009
> > > 
> > > Where 0x16d is the counter timer policy code and 0xf4240 is 100 000
> > > in hex.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> > 
> > It is techincally possible to merge 1-5 without this and have
> > something functional?
> 
> Yes: it just adds to the policy types we understand, but we can still
> do password and PCR policies without this.

OK, cool. Did not mean  that I'd have any particular problem to merge
it. Just want to know the constraints that I live in.

/Jarkko
