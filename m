Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A771FEC04
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFRHMG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:12:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:35581 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgFRHMG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:12:06 -0400
IronPort-SDR: 6u+s8326HD1VCim3RwbxM/tAdZ31jJq05O4S7UcgPWJSoqQtKYyfrxvrD9R+m5rWZt5SqW708o
 ZdTEPFrQYOFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="203962997"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="203962997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:12:05 -0700
IronPort-SDR: /nL6ycUqvP1Yd1pawNIVqDwr6eGYQA4wJfbSu7n277Lhq42DVUvZzd14kC3yZ1kBHq/TGF3c0O
 pc/iQZii6WHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="263515215"
Received: from jkalinox-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.234])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 00:12:01 -0700
Date:   Thu, 18 Jun 2020 10:12:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
Message-ID: <20200618071200.GB6560@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
 <20200617234250.GJ62794@linux.intel.com>
 <1592440063.3515.42.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592440063.3515.42.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 05:27:43PM -0700, James Bottomley wrote:
> On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> > On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > > This patch adds a policy= argument to key creation.  The policy is
> > > the standard tss policymaker format and each separate policy line
> > > must have a newline after it.
> > 
> > Never heard of policymaker before and did not find TCG spec for it.
> 
> It's not part of the spec.  Both the IBM and Intel TSSs define a
> policymaker tool to help you build policy hashes.  The format is simply
> a set of numbers that if hashed a line at a time produce the policy
> hash.

OK, so they both use this 'policymaker' format? Where is it documented?

/Jarkko
