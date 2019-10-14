Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D235CD6A1B
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfJNT3U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:29:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:19103 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbfJNT3U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:29:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="198390316"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2019 12:29:14 -0700
Date:   Mon, 14 Oct 2019 22:29:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-ID: <20191014192913.GD15552@linux.intel.com>
References: <1570128827.5046.19.camel@linux.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A22E@ALPMBAPA12.e2k.ad.ge.com>
 <20191004182711.GC6945@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com>
 <20191007000520.GA17116@linux.intel.com>
 <59b88042-9c56-c891-f75e-7c0719eb5ff9@linux.ibm.com>
 <20191008234935.GA13926@linux.intel.com>
 <20191008235339.GB13926@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F2B995@ALPMBAPA12.e2k.ad.ge.com>
 <20191014190033.GA15552@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014190033.GA15552@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 14, 2019 at 10:00:33PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 09, 2019 at 12:11:06PM +0000, Safford, David (GE Global Research, US) wrote:
> > 
> > > From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Sent: Tuesday, October 8, 2019 7:54 PM
> > > To: Ken Goldman <kgold@linux.ibm.com>
> > > Cc: Safford, David (GE Global Research, US) <david.safford@ge.com>; Mimi
> > > Zohar <zohar@linux.ibm.com>; linux-integrity@vger.kernel.org;
> > > stable@vger.kernel.org; open list:ASYMMETRIC KEYS
> > > <keyrings@vger.kernel.org>; open list:CRYPTO API <linux-
> > > crypto@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > > Subject: EXT: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
> > > 
> > > On Wed, Oct 09, 2019 at 02:49:35AM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Oct 07, 2019 at 06:13:01PM -0400, Ken Goldman wrote:
> > > > > The TPM library specification states that the TPM must comply with
> > > > > NIST
> > > > > SP800-90 A.
> > > > >
> > > > > https://trustedcomputinggroup.org/membership/certification/tpm-certi
> > > > > fied-products/
> > > > >
> > > > > shows that the TPMs get third party certification, Common Criteria EAL 4+.
> > > > >
> > > > > While it's theoretically possible that an attacker could compromise
> > > > > both the TPM vendors and the evaluation agencies, we do have EAL 4+
> > > > > assurance against both 1 and 2.
> > > >
> > > > Certifications do not equal to trust.
> > > 
> > > And for trusted keys the least trust solution is to do generation with the kernel
> > > assets and sealing with TPM. With TEE the least trust solution is equivalent.
> > > 
> > > Are you proposing that the kernel random number generation should be
> > > removed? That would be my conclusion of this discussion if I would agree any
> > > of this (I don't).
> > > 
> > > /Jarkko
> > 
> > No one is suggesting that.
> > 
> > You are suggesting changing the documented behavior of trusted keys, and
> > that would cause problems for some of our use cases. While certification
> > may not in your mind be equal to trust, it is equal to compliance with 
> > mandatory regulations.
> > 
> > Perhaps rather than arguing past each other, we should look into 
> > providing users the ability to choose, as an argument to keyctl?
> > 
> > dave
> 
> I'm taking my words back in the regression part as regression would need
> really a failing system. Definitely the fixes tag should be removed from
> my patch.
> 
> What is anyway the role of the kernel rng? Why does it exist and when
> exactly it should be used? This exactly where the whole review process
> throughout the "chain of command" failed misserably with tpm_asym.c.
> 
> The commit message for tpm_asym.c does not document the design choice in
> any possible way and still was merged to the mainline.
> 
> Before knowning the answer to the "existential" question we are
> somewhat paralyzed on moving forward with trusted keys (e.g. paralyzed
> to merge TEE backend).
> 
> Your proposal might make sense but I don't really want to say anything
> since I'm completely cluesless of the role of the kernel rng. Looks like
> everyone who participated to the review process of tpm_asym.c, is too.

As a ABI backwards compatibility workaround I'd agree most likely agree
with you. As a guideline for new features there should be a framework on
how to decide what to do.

/Jarkko
