Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5603A1D60C8
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2020 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEPMYw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 16 May 2020 08:24:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:41134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgEPMYw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 May 2020 08:24:52 -0400
IronPort-SDR: 5GGOFFlmcd7DAh2pW45QfHgJLfHmqDsZ+dFff21Bd4CTxG2UHi0sugbKLdUmpIJoD35zsMJlSO
 PcU6qfZU6tJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 05:24:51 -0700
IronPort-SDR: G4s2OUbwibzM8uqyTPI/JTWww1dSTQ2EICAMGtflvZH6alsATd1p/9OlxLT4Y+uBPKdBDOcOn/
 tqASp4WfjacQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="410752973"
Received: from ebutchex-mobl1.ger.corp.intel.com ([10.249.40.79])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2020 05:24:45 -0700
Message-ID: <967f6b0a1fd4ba6e2c44527174e1798de365da1a.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Sat, 16 May 2020 15:24:38 +0300
In-Reply-To: <1589568507.3653.18.camel@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515093000.naogi4a7j22bzggz@cantor>
         <1589568507.3653.18.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 11:48 -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 02:30 -0700, Jerry Snitselaar wrote:
> > On Fri May 15 20, Jarkko Sakkinen wrote:
> > > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> [...]
> > > > However, I don't have keyctl_read_alloc in my tree, so it may be
> > > > an incompatibility with another patch set.  What's your base and
> > > > what other patches do you have applied?
> > > 
> > > http://git.infradead.org/users/jjs/linux-tpmdd.git
> > > 
> > > Or exactly:
> > > 
> > > git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
> > > 
> > > /Jarkko
> > > 
> > 
> > keyctl_read_alloc is in the userspace keyctl program, right?
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
> 
> Hm, right thanks!  I just confirmed that linux-tpmdd.git with these
> patches applied still works for me.  I'm using the keyctl in debian
> testing, which identifies itself as version 1.6-6
> 
> I'll try building from git.
> James

Can you run the same exact command sequence that I posted?

/Jarkko

