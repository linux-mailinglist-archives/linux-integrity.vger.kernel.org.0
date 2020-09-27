Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06FD27A4A0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 01:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0X7L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 19:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:40803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgI0X7L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 19:59:11 -0400
IronPort-SDR: SLjhBCtzX196bb3oUSU8uHkG2mGml7WqD+QGgr98sZheIbPQ1gaetOwqQlIHZ88tKz4dIxSivj
 FH/xZ/nLkQCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159265637"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="159265637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:59:10 -0700
IronPort-SDR: opfHP+mi7b+9hDG7K3XH6ZaD53EIAcHlw2mkDousIGYiufJK7+3aBAsiIOhyodytHmlVxPF98w
 WwVfw9OGLLww==
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="488339604"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:59:07 -0700
Date:   Mon, 28 Sep 2020 02:59:08 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 00/13] x86: Trenchboot secure dynamic launch Linux kernel
 support
Message-ID: <20200927235908.GC5283@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <20200925053051.GA165011@linux.intel.com>
 <8329607a-704d-1da0-dc7b-4b97c2440afb@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8329607a-704d-1da0-dc7b-4b97c2440afb@apertussolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 25, 2020 at 05:32:50PM -0400, Daniel P. Smith wrote:
> The work for this is split across different teams with different
> resourcing levels resulting in one organization working Intel and
> another working AMD. This then raised the concern over submitting a
> single patch set developed by two groups pseudo-independently. In this
> situation the result would be patches being submitted from one
> organization that had no direct development or testing and therefore
> could not sign off on a subset of the patches being submitted.

Not sure if internal team structures qualify as a techical argument for
upstream code.

> > I'd be more motivated to review and test a full all encompassing x86
> > solution. It would increase the patch set size but would also give it
> > a better test coverage, which I think would be a huge plus in such a
> > complex patch set.
> 
> We would not disagree with those sentiments but see the previous
> response about the conflict that exists.

At minimum, you have to make the case that the AMD support is easy to
tackle in to the framework of things you have later on.

/Jarkko
