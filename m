Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14799D6A74
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfJNT53 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:57:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:12485 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbfJNT53 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:57:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="207316028"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2019 12:57:26 -0700
Date:   Mon, 14 Oct 2019 22:57:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191014195725.GL15552@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <20191011130129.GA20277@linux.intel.com>
 <1570800093.5250.82.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570800093.5250.82.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 11, 2019 at 09:21:33AM -0400, Mimi Zohar wrote:
> On Fri, 2019-10-11 at 16:01 +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 10, 2019 at 07:18:31PM -0400, Mimi Zohar wrote:
> > > Create, save and load trusted keys test
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Also can be used to test Sumit's patches i.e. there is an immediate
> > application for this one. I'll use this check TPM 1.x and TPM 2.0
> > trusted keys code.
> > 
> > You could sanity check your script for sending with my master, which
> > already has those patches.
> 
> Sure, but due to the holidays that won't happen until the middle of
> next week.

There is no immediate rush, or more like, this should not be rushed.

I'm also waiting v8 now because of sparse issues.

/Jarkko
