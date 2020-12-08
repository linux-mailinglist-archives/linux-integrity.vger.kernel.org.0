Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F82D3175
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgLHRtz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 12:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgLHRty (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 12:49:54 -0500
Date:   Tue, 8 Dec 2020 19:49:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607449754;
        bh=rOJ6wd7pPv9VKVPvlMY8tmHKt2EG7z2LdgbuHHBAfBM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEYRfeTg3M0LKd3/09Wd6RwkuxU+RdWKeY9jt5u1xLhxEwW0JQAxrMDwiiLoL4EjF
         m08HD606VXjtVcf8OUY2IbPJEd9/bxiMe+45LZV7E9VyfC/rCkGGUzSry4pvNVfkoA
         kMnE8TseXtiGD4K49NYeKLTZ0VjSbnmvDmn/Cdlw5JD8Ur1/w34w+TIX5d8Ka3g2H0
         xOlP+HfbYAMpmoGibCcGP7MNZ8ORJBzOfXt7DDcqivg8cddhBK7TrU2zrPOBLL9CJQ
         WlIKQ8GHr4Wh5juj/wxkDhLXMavFoNbn397FRxCySP1js949sMRxd+PiecdofpBmLp
         bjV8CIPeuz4rw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, sumit.garg@linaro.org
Cc:     Elaine Palmer <erpalmerny@gmail.com>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Kenneth Goldman <kgoldman@us.ibm.com>, gcwilson@linux.ibm.com,
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Message-ID: <20201208174906.GA58572@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
 <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
 <20201204153037.GC4922@kernel.org>
 <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 08, 2020 at 10:02:57AM -0500, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Fri, 2020-12-04 at 17:30 +0200, Jarkko Sakkinen wrote:
> > On Wed, Dec 02, 2020 at 02:34:07PM -0500, gmail Elaine Palmer wrote:
> > > Hi Sumit,  
> > > 
> > > Thank you for the detailed descriptions and examples of trust sources
> > > for Trusted Keys.   A group of us in IBM (Stefan Berger, Ken Goldman,
> > > Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar)
> > > have been doing related work for quite some time, and we have one
> > > primary concern and some suggested changes to the document. 
> > > 
> > > Our primary concern is that describing a TEE as a Trust Source needs
> > > to be more specific.   For example, "ARM TrustZone" is not sufficient,
> > > but "wolfSSL embedded SSL/TLS library with ARM TrustZone
> > > CryptoCell-310" is.  Just because a key is protected by software
> > > running in a TEE is not enough to establish trust.  Just like
> > > cryptographic modules, a Trust Source should be defined as a specific
> > > implementation on specific hardware with well-documented environmental
> > > assumptions, dependencies, and threats.
> > > 
> > > In addition to the above concern, our suggested changes are inline
> > > below.
> > 
> > In order to give a decent review comment it should have two ingredients:
> > 
> > - Where the existing line of code / text / whatever goes wrong.
> > - How it should modified and why that makes sense. And use as plain
> >   English and non-academic terms as possible, if it is documentation.
> >   Further, scope is only the kernel implementation, no more or no
> >   less.
> > 
> > "do this" is not unfortunately an argument. Feedback is welcome when
> > it is supported by something common sensse.
> 
> Even after the code is fully debugged, reviewed and tested, our concern
> is that people will assume the security guarantees of TEE based trusted
> keys to be equivalent to that of a discrete TPM.
> 
> > 
> > Some meta suggestion of related to email:
> > 
> > Please also use a proper email client and split your paragraphs into
> > at most 80 character lines with new line characters when writing email.
> > I prefer to use 72 character line length so that there's some space
> > for longer email threads.
> 
> Sure, we'll re-post the suggested documentation changes/additions.
> 
> Mimi

So. Wouldn't it be a better idea to post a patch that Sumit could
squash to his (and add co-developed-by tag)?

/Jarkko
