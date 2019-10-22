Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB67EE06A6
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2019 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJVOnX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 10:43:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:54388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVOnX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 10:43:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 07:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,327,1566889200"; 
   d="scan'208";a="197139153"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.120])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2019 07:43:20 -0700
Date:   Tue, 22 Oct 2019 17:43:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191022144320.GA3758@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <20191011130129.GA20277@linux.intel.com>
 <1570800093.5250.82.camel@linux.ibm.com>
 <20191014195725.GL15552@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014195725.GL15552@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 14, 2019 at 10:57:25PM +0300, Jarkko Sakkinen wrote:
> On Fri, Oct 11, 2019 at 09:21:33AM -0400, Mimi Zohar wrote:
> > On Fri, 2019-10-11 at 16:01 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 10, 2019 at 07:18:31PM -0400, Mimi Zohar wrote:
> > > > Create, save and load trusted keys test
> > > > 
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > Also can be used to test Sumit's patches i.e. there is an immediate
> > > application for this one. I'll use this check TPM 1.x and TPM 2.0
> > > trusted keys code.
> > > 
> > > You could sanity check your script for sending with my master, which
> > > already has those patches.
> > 
> > Sure, but due to the holidays that won't happen until the middle of
> > next week.
> 
> There is no immediate rush, or more like, this should not be rushed.
> 
> I'm also waiting v8 now because of sparse issues.

OK, so you must get rid of TrouSerS dependency. Otherwise this
is unsuitable for kernel selftests. Please do TPM 1.x with the
raw TPM device.

A legit selftest should be implemented only with POSIX assets.

/Jarkko
