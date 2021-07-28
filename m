Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC273D97CB
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhG1VwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 17:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhG1VwE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 17:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396A960F12;
        Wed, 28 Jul 2021 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627509122;
        bh=BFyX2UbVIXF8zczEHxk87K4K2XDamO91r3jwdx4AJwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0aiKzfAgvkB6HSHzGaoiqqiuH0enCVJ1s9y/nJB0nwKO+vvp24z8bjm9GNPhBgAq
         aNCkSiseircZZKNqDgEmTM/Kuqoyf/KJ174iZyLPmXrYXM8AM7bEl48ShFuZZrwj6w
         lbmSP9+dkHI1WdxxBLJ4uxY1uBStcFG3fBVOwF1Oj3oNeHcEugvtTZSjvOKWEaK7hk
         rQwHUbTYDeNDq+UTBaLS+GieZY8ocRWKjdFcCf/zZQN8+4VsN4K08iMftSAWZirlYk
         jQqqZX7pN0QLrUSeyLsMDwlHAEC7Mkhx3MK0PL/kHLtHt/EuyJBudd2BbY7qfjIztD
         vENWyvh5CvlWQ==
Date:   Thu, 29 Jul 2021 00:52:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Andreas Rammhold <andreas@rammhold.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: fix use as module when CONFIG_TCG_TPM=m
Message-ID: <20210728215200.nfvnm5s2b27ang7i@kernel.org>
References: <20210721160258.7024-1-a.fatoum@pengutronix.de>
 <20210727030433.3dwod2elwtdkhwsc@kernel.org>
 <fe39a449-88df-766b-a13a-290f4847d43e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe39a449-88df-766b-a13a-290f4847d43e@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 27, 2021 at 06:24:49AM +0200, Ahmad Fatoum wrote:
> On 27.07.21 05:04, Jarkko Sakkinen wrote:
> >> Reported-by: Andreas Rammhold <andreas@rammhold.de>
> >> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> >> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > 
> > Is it absolutely need to do all this *just* to fix the bug?
> > 
> > For a pure bug fix the most essential thing is to be able the backport
> > it to stable kernels.
> 
> Not much happened in-between, so a backport should be trivial.
> I can provide these if needed.

"not much" is not good enough. It should be "not anything".

/Jarkko
