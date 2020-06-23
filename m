Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141E1204617
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgFWAqi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:46:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:16168 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbgFWAqf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:35 -0400
IronPort-SDR: /Z4hb4GYVsAdAxwZSePNBCTIVhRYVat8XFe90SRqfBIDXMCl6p4w7W6vrzfXJHuadxhAQdJJOm
 0YBo+uUeCu2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="124188874"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="124188874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 17:46:33 -0700
IronPort-SDR: rWeSbm9CZCiHPhUpZEU7GH6LDioA2Jd2TqMVzJ4gbEEthM5VKm9idhFIad41eSyGNxOEJhWezM
 A7K+4IdBRj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="478570904"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 17:46:30 -0700
Date:   Tue, 23 Jun 2020 03:46:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
Message-ID: <20200623004629.GA28795@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
 <20200617234250.GJ62794@linux.intel.com>
 <1592440063.3515.42.camel@HansenPartnership.com>
 <20200618071200.GB6560@linux.intel.com>
 <1592509514.15159.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592509514.15159.18.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 12:45:14PM -0700, James Bottomley wrote:
> On Thu, 2020-06-18 at 10:12 +0300, Jarkko Sakkinen wrote:
> > On Wed, Jun 17, 2020 at 05:27:43PM -0700, James Bottomley wrote:
> > > On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > > > > This patch adds a policy= argument to key creation.  The policy
> > > > > is
> > > > > the standard tss policymaker format and each separate policy
> > > > > line
> > > > > must have a newline after it.
> > > > 
> > > > Never heard of policymaker before and did not find TCG spec for
> > > > it.
> > > 
> > > It's not part of the spec.  Both the IBM and Intel TSSs define a
> > > policymaker tool to help you build policy hashes.  The format is
> > > simply
> > > a set of numbers that if hashed a line at a time produce the policy
> > > hash.
> > 
> > OK, so they both use this 'policymaker' format? Where is it
> > documented?
> 
> I don't think it is except in the source code of the tools.  It's
> basically a sequence of TPM2_PolicyXX statements laid out in binary end
> to end one per line as the TPM2 command value says they are hashed.  I
> can just say that if you prefer.  The example given is

There is no "the tools". There are multiple user space stacks.

I think that the format should be documented to Documents/security/tpm.

/Jarkko
