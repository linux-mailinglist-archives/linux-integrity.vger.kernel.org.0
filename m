Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D072319DAF
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 12:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBLL4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 06:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhBLL4R (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 06:56:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA09064E30;
        Fri, 12 Feb 2021 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613130937;
        bh=3Bnlji8C6VrEVzI6ipgGVfMw2GOAYYbWpHHf/dTmgEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDhRaDPeAyebakd2fDvbID0JOiK1rJcIbsRD19W4N9xy7D/NsCwEVI0O5JNOZiyK8
         Usa1Df8p8zRzfwCStZLtLp1aNY2vH2FRb/it59gz86WQpZRtYG/8lMVOZGOiDzbzdl
         +uMSBHhLFHPOPJLY9FVK7Vb3Tqv0KyWSQcKjbcNpq+eBPGXcr7KNtUDr0+OmAFt1pq
         kS+6QQPH44XZzU6l6KwLJ0SQ9/rVCWLYuFARvjSa/fPB3l1rF7KqWouPHm+h6wIw+D
         CVXROPD45Ig5h15s5Qrm7yKR8TMeQAxRqCM+HaMO2Du3IFpVSRqyUyCM1QltwYRmrm
         SOvDCxLnLahrg==
Date:   Fri, 12 Feb 2021 13:55:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v15 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <YCZssKIEGFML+4Br@kernel.org>
References: <20210127190617.17564-4-James.Bottomley@HansenPartnership.com>
 <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
 <1327393.1612972717@warthog.procyon.org.uk>
 <781858e64422e78d0285c6762470a3ef3b6a114d.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781858e64422e78d0285c6762470a3ef3b6a114d.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 10, 2021 at 08:12:19AM -0800, James Bottomley wrote:
> On Wed, 2021-02-10 at 15:58 +0000, David Howells wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > keyctl add trusted kmk "new 32
> > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001
> > > " @u
> > 
> > I presume there should be a space in there?
> 
> Um, yes.  My screen wraps at 80 characters which has keyhandle=
> conveniently on the next line.
> 
> James

Please send a new revision. There was already two checkpatch errors I had
to fix manually and also found 3rd issue when working with Sumit's patches:

trusted-y += trusted_tpm2.o tpm2key.asn1.o

Please line these up like

trusted-y += trusted_tpm2.o
trusted-y += tpm2key.asn1.o

Is coherent with the line adding trusted_tpm1.o, and makes merging new
features easier (e.g. TEE).

I dropped current patches.

/Jarkko
