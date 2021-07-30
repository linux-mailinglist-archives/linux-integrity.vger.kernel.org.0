Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716C03DB046
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 02:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhG3Ab0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 20:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhG3AbZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 20:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89A5F60F21;
        Fri, 30 Jul 2021 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627605081;
        bh=tLa7ubS7DmnPV6jzyo5485j3Db4T2l9MF1KXEfHI+rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qacHkv84pqSlRrdx8XK1m8p5gU2or65oviojOphjbshITub8rsRgZqR8HXt9hUe4R
         f1DaAoTQohTwGNwlq2ulcT7omqrE+U//1Cw4MT59FUFms5LD/C6suVTbQiSBWeD/Sl
         CzxLMalubLfcWU+LQb3Q685wJj+sjJ+7P6JBvrpMMJmK2lrTEIFuDZcTXjYdSadKpo
         DTJDroAcl6BIC25Ia/VHLwXJ/LpiRLlyAl0qB1dfciwpVinO054xFqIShds1ebePKw
         P/o0haka1iX7z+dCNgn078EzBuXC6SIQcGgnip9s+BP4EAE8DbaxBBEVdRc+JOhMaw
         SVoL395bhG1HQ==
Date:   Fri, 30 Jul 2021 03:31:17 +0300
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
Message-ID: <20210730002101.2tcb3bs2lxdvmuqk@kernel.org>
References: <20210721160258.7024-1-a.fatoum@pengutronix.de>
 <20210727030433.3dwod2elwtdkhwsc@kernel.org>
 <fe39a449-88df-766b-a13a-290f4847d43e@pengutronix.de>
 <20210728215200.nfvnm5s2b27ang7i@kernel.org>
 <f0f05df9-95bb-8b67-cecc-742af0b19f1e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f05df9-95bb-8b67-cecc-742af0b19f1e@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 29, 2021 at 12:29:38AM +0200, Ahmad Fatoum wrote:
> On 28.07.21 23:52, Jarkko Sakkinen wrote:
> > On Tue, Jul 27, 2021 at 06:24:49AM +0200, Ahmad Fatoum wrote:
> >> On 27.07.21 05:04, Jarkko Sakkinen wrote:
> >>>> Reported-by: Andreas Rammhold <andreas@rammhold.de>
> >>>> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> >>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >>>
> >>> Is it absolutely need to do all this *just* to fix the bug?
> >>>
> >>> For a pure bug fix the most essential thing is to be able the backport
> >>> it to stable kernels.
> >>
> >> Not much happened in-between, so a backport should be trivial.
> >> I can provide these if needed.
> > 
> > "not much" is not good enough. It should be "not anything".
> 
> "Not much" [code that could conflict was added in-between].
> 
> I just checked and it applies cleanly on v5.13. On the off chance
> that this patch conflicts with another stable backport by the time
> it's backported, I'll get a friendly automated email and send out
> a rebased patch.

What you should do is to split this into patch that exactly
fixes the issue, and to one that adds the "niceties".

/Jarkko
