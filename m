Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984C1D6031
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2020 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgEPJ7k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 16 May 2020 05:59:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:15794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgEPJ7k (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 May 2020 05:59:40 -0400
IronPort-SDR: AKop5e2fIh0vKS1BVtA6VkCFqF6Mr+96E/AP45RyU7nSO0GKYE71KwK/bsvSv9KkiykfUj26Qe
 8C9p2me3fc+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 02:59:39 -0700
IronPort-SDR: +hPc1VAvToZKqa+d2SYbYDTSV68pLKQhQ9KZGHaiQkLWlDilVCnl0h8+V2pVKOBA5th4rlP/1c
 UxAhz2NZVwjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="281482321"
Received: from dbobocel-mobl1.ger.corp.intel.com ([10.252.55.115])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2020 02:59:35 -0700
Message-ID: <1668d149a6604c598f87368a3ef7a9140cf7eb51.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Sat, 16 May 2020 12:59:34 +0300
In-Reply-To: <20200515093000.naogi4a7j22bzggz@cantor>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515093000.naogi4a7j22bzggz@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 02:30 -0700, Jerry Snitselaar wrote:
> On Fri May 15 20, Jarkko Sakkinen wrote:
> > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> > > On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> > > > > I'm compiling now kernel with all series included.
> > > > > 
> > > > > Kind of checking if I could just take the whole series. Let see.
> > > > > 
> > > > > In all cases I want the style errors in 3/8 to be fixes with a
> > > > > helper
> > > > > but maybe better to hold before sending anything. Possibly that is
> > > > > all
> > > > > needed I'll just carve that patch myself.
> > > > > 
> > > > > Please don't do anything for the moment.
> > > > 
> > > > This is what I tried first (with the full series applied):
> > > > 
> > > > #!/bin/sh
> > > > 
> > > > die()
> > > > {
> > > > 	keyctl clear @u
> > > > 	./tpm2-flush --all-transient
> > > > 	exit $1
> > > > }
> > > > 
> > > > KEYHANDLE=$(./tpm2-root-key || die 1)
> > > > KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE
> > > > hash=sha256" @u || die 1)
> > > > 
> > > > echo "$KEYID ($KEYHANDLE)"
> > > > 
> > > > keyctl pipe $KEYID > blob.hex || die 1
> > > > keyctl clear @u || die 1
> > > > 
> > > > echo "Import key from blob"
> > > > 
> > > > keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u
> > > > > > die 1
> > > > 
> > > > die 0
> > > > 
> > > > Result:
> > > > 
> > > > sudo ./keyctl-smoke.sh
> > > > 566201053 (0x80000000)
> > > > keyctl_read_alloc: Permission denied
> > > 
> > > Well, it's clearly failing in keyctl pipe
> > > 
> > > I do confess to never having tested a volatile primary, but I just did
> > > so and it works for me.  I will also add the keyhandle in the load
> > > isn't necessary, because it should be in the blob, but there should
> > > also be no harm (just tested).
> > > 
> > > However, I don't have keyctl_read_alloc in my tree, so it may be an
> > > incompatibility with another patch set.  What's your base and what
> > > other patches do you have applied?
> > 
> > http://git.infradead.org/users/jjs/linux-tpmdd.git
> > 
> > Or exactly:
> > 
> > git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
> > 
> > /Jarkko
> > 
> 
> keyctl_read_alloc is in the userspace keyctl program, right?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

Yes.

/Jarkko

