Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA32F5494
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 22:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbhAMVZE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 16:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbhAMVYV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 16:24:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F01208E4;
        Wed, 13 Jan 2021 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610573020;
        bh=t8bCdPZCVkccgr/RQonsyxz8QpySml/FPPRsSWUxTOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixiW3kqdCp0Y0ojjPPOYNjZaTJc2PQufAGp56+AS6IzJJmG1eqrSXHY5Do5KjdZjU
         Ta5j78WPecnlJlPjUJa2jFVnsWRM4EXVCKDrXeknJcktqWQw7aoqc37IOJjhumBIn3
         HKA6g7/kxxyXuaGjw630iWxMshLf6r/HPV1uxhBSm+d1KtjdyKbkhAnVV7SZ89/kfp
         JiLhi5dQpjN1txS3SrMFb11NO3a+b76FJiH1lXL9+NN5wVhdfnpGk+XS2a4yxa8tEv
         1SgCqv+4R5TQVvfEwwo6ujIT68gD5k9/m5Q9jebRcHGNQXXjbl4NiXVPeu/v/8ErOW
         vwiigqdQHEuCA==
Date:   Wed, 13 Jan 2021 23:23:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
Message-ID: <X/9k19UoZZdC+y0+@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
 <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
 <X/pxpAfn4MFsXT4g@kernel.org>
 <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 12, 2021 at 10:55:44AM +0530, Sumit Garg wrote:
> On Sun, 10 Jan 2021 at 08:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
> > > Hi Jarkko,
> > >
> > > On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > > > > From: Elaine Palmer <erpalmer@us.ibm.com>
> > > > >
> > > > > Update trusted key documentation with additional comparisons between
> > > > > discrete TPMs and TEE.
> > > > >
> > > > > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> > > >
> > > > Right, so OP-TEE is not the same as TEE. I did not know this and the
> > > > patch set does not underline this.
> > > >
> > > > I re-checked the patches and none of them say explicitly that OP-TEE
> > > > is an application living inside TEE.
> > >
> > > This patch-set provides a trust source based on generic TEE interface
> > > where underlying TEE implementations like OP-TEE (drivers/tee/optee/),
> > > AMD TEE (drivers/tee/amdtee/) etc. can easily be hooked up. And this
> > > is similar to the TPM interface where underlying TPM implementations
> > > like discrete TPM, virtual TPM, firmware TPM etc. can be easily hooked
> > > up.
> > >
> > > >
> > > > This essentially means that the backend needs to be renamed as "op_tee".
> > > >
> > >
> > > I don't see any need for this, see above.
> >
> > Right, TEE is a protocol standard, just like TPM, and OP-TEE is one
> > implementation of this interface? I.e. OP-TEE does not define API
> > that is hard bound to OP-TEE?
> >
> 
> Yes, OP-TEE doesn't define a hard bound client interface API. The
> client API is based on TEE client API specification [1] from
> GlobalPlatform.
> 
> [1] http://globalplatform.org/specs-library/tee-client-api-specification/
> 
> -Sumit

Thanks, bookmarked. No need for name change.

/Jarkko
