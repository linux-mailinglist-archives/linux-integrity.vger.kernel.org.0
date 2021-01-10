Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8812F04DB
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 04:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAJDRj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Jan 2021 22:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbhAJDRj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Jan 2021 22:17:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93C5B22507;
        Sun, 10 Jan 2021 03:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610248618;
        bh=0/faSiD+RC5oedQgVQ8n1GEL7aCxyH2Yq/wnxLRgX9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCMXa7RwJA/POYoDN6jzJhfZEu1cVc3e9Bcaqa0QQO7aLs4rs5xWoL+lWhAbqu07Y
         oTGveLkDknA98oUf7FxEgeWFjB83LRwQaFGlmmjijOyD5qSCicmm4u+5/QENRusu9b
         gBOexWM0c13lesrlTj3J43JEZJGp6D5nL46FrtLF3xW22ORODV/y0tQZsdKWE+FDBe
         jOWjIktKSq1ZtwmtWAOLakRkcZ3yCrLMDS0qIuryTcp7PeUrXzc+LPs5CxeKeuAm8v
         kYbkoBqzA2Mw8uiH6iXzLj2N4w5/gQnmnF/fITG85NsMeOGCcw/7EnuX2IoOTROUSL
         oPOXsdhub4s9w==
Date:   Sun, 10 Jan 2021 05:16:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
Message-ID: <X/pxpAfn4MFsXT4g@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
 <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
> Hi Jarkko,
> 
> On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > > From: Elaine Palmer <erpalmer@us.ibm.com>
> > >
> > > Update trusted key documentation with additional comparisons between
> > > discrete TPMs and TEE.
> > >
> > > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> >
> > Right, so OP-TEE is not the same as TEE. I did not know this and the
> > patch set does not underline this.
> >
> > I re-checked the patches and none of them say explicitly that OP-TEE
> > is an application living inside TEE.
> 
> This patch-set provides a trust source based on generic TEE interface
> where underlying TEE implementations like OP-TEE (drivers/tee/optee/),
> AMD TEE (drivers/tee/amdtee/) etc. can easily be hooked up. And this
> is similar to the TPM interface where underlying TPM implementations
> like discrete TPM, virtual TPM, firmware TPM etc. can be easily hooked
> up.
> 
> >
> > This essentially means that the backend needs to be renamed as "op_tee".
> >
> 
> I don't see any need for this, see above.

Right, TEE is a protocol standard, just like TPM, and OP-TEE is one
implementation of this interface? I.e. OP-TEE does not define API
that is hard bound to OP-TEE?

Better to ask the very basic questions out and loud to get this
right.

/Jarkko
