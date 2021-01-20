Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B502FD299
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 15:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhATOWz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 09:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390289AbhATOWf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 09:22:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2D7F23329;
        Wed, 20 Jan 2021 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152514;
        bh=ZkozHMUf9stDUHKmkmTqqNuOaUV2CAaauHyw34bpx48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/+tZ5ML2YRbpnqwJCZ3J6qdvWT002Zjr+66oDAPFpC388jQqDKiemBdBsAKckpm8
         p9Ay084F4wq6CybP/avG+icvUin+D8doSLhiUmeIsBjZ3b+FmWYGW9FVl38IsHZZnb
         PSZw2wz9abn7jecNI5vVxpga4gbVt/yZroLz8kZ48NJzmDfpZ3bKmbysR/r73xcfqS
         hKcQCQVIQj1EEhebz6C5dmDGbq0VfTE3YF4Q4RbZSWSnDHvQOptDKfDeJO6pC+fLCW
         EgSE4KMyUYGFyAmf5zW727nNmyTst2zihekXMYQtHQ+g+UVGeC6XQKoHfB5f7Ev/Pd
         mNCAIsAdDWzSg==
Date:   Wed, 20 Jan 2021 16:21:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Elaine Palmer <erpalmerny@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
Message-ID: <YAg8faHy8JGEOrzM@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
 <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
 <X/pxpAfn4MFsXT4g@kernel.org>
 <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
 <X/9k19UoZZdC+y0+@kernel.org>
 <19d3547b-c285-aa98-0cc3-cc55ef09a1b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d3547b-c285-aa98-0cc3-cc55ef09a1b9@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 15, 2021 at 06:15:51PM -0500, Elaine Palmer wrote:
> 
> 
> On 1/13/21 4:23 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 12, 2021 at 10:55:44AM +0530, Sumit Garg wrote:
> > > On Sun, 10 Jan 2021 at 08:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
> > > > > Hi Jarkko, On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen
> > > > > <jarkko@kernel.org> wrote:
> > > > > > On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > > > > > > From: Elaine Palmer <erpalmer@us.ibm.com> Update
> > > > > > > trusted key documentation with additional
> > > > > > > comparisons between discrete TPMs and TEE.
> > > > > > > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> > > > > > Right, so OP-TEE is not the same as TEE. I did not know
> > > > > > this and the patch set does not underline this. I
> > > > > > re-checked the patches and none of them say explicitly
> > > > > > that OP-TEE is an application living inside TEE.
> > > > > This patch-set provides a trust source based on generic TEE
> > > > > interface where underlying TEE implementations like OP-TEE
> > > > > (drivers/tee/optee/), AMD TEE (drivers/tee/amdtee/) etc. can
> > > > > easily be hooked up. And this is similar to the TPM
> > > > > interface where underlying TPM implementations like discrete
> > > > > TPM, virtual TPM, firmware TPM etc. can be easily hooked up.
> > > > > > This essentially means that the backend needs to be
> > > > > > renamed as "op_tee".
> > > > > I don't see any need for this, see above.
> > > > Right, TEE is a protocol standard, just like TPM, and OP-TEE is
> > > > one implementation of this interface? I.e. OP-TEE does not
> > > > define API that is hard bound to OP-TEE?
> > > Yes, OP-TEE doesn't define a hard bound client interface API. The
> > > client API is based on TEE client API specification [1] from
> > > GlobalPlatform. [1]
> > > http://globalplatform.org/specs-library/tee-client-api-specification/
> > > -Sumit
> > Thanks, bookmarked. No need for name change. /Jarkko
> This discussion has illustrated that even those of us who live and
> breathe this stuff could use clarification.  Shouldn't we recommend
> that the Trust Source have a hardware root of trust?  We could be
> even more specific.  For example, the documentation could recommend
> that a TPM be evaluated under "TCG Protection Profile for PC Client
> Specific TPM 2.0" or later and a TEE be evaluated under GlobalPlatform
> "TEE Protection Profile v1.3, GPD_SPE_021" or later.  Of course, our
> recommendation would not be a requirement, but it would provide
> guidance for deployment as well as precedent for future Trust Sources.

Recommend what? Not following. I don't undestand what recommending
trust sources means, and why it's written as Trust Sources.

/Jarkko

> I know where I'm getting stuck is on TEEs as a concept vs
> TEEs with specific hardware requirements and interfaces.
> The same applies to TPMs.  There are hardware TPMs that meet
> the protection profile and there are other implementations
> (e.g., vTPMs) that use the same interface, but aren't anchored in
> hardware.
> 
> I know if I were deploying a server, mobile device, or IoT device, I'd
> want to know exactly what is protecting my keys.  A generic TPM or TEE
> doesn't tell me enough.
> 
> -Elaine
> 
> 
> 
