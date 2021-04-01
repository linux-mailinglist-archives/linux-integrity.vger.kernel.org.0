Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B9350ECE
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 08:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhDAGDu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 02:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233219AbhDAGDk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 02:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C04461055;
        Thu,  1 Apr 2021 06:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617257019;
        bh=xt6GQYsb58xuQ6PPnQZNlaKyr1g0GjRYBFrfAuKY2t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1Qt48hXISX/0tFEftpS56HuuzWK2yhF8NA6tlN9DbOlNoRic99mX4UqP85MlVPC+
         /wD/PmfERDh5wOjvraogBFYLnf0LRsOE9QKfOrcgjXqMwX1xwuJo62xwTYse0Zw8dB
         GzWE0pO3I/UDUaiA5JGffU2/M9qXqmYaIDyuTUdYdeEPq827TGHwLjvgcIrtZDzJb0
         oEiC+HE6KHGa1SdyGn8z+FD7mDFUgVNkSJCTwb+XcS3KzibyfWK1f8vsapZcAgH9e1
         zpLPnXmR3P5w6xLmYqO2YXih4YGc2w6F/KSBotAWogQaiG2lhnEbcYGD2P0Bmubnoq
         vTlmBPA7bbDwQ==
Date:   Wed, 31 Mar 2021 23:03:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Gstir <david@sigma-star.at>,
        Sumit Garg <sumit.garg@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YGViOc3DG+Pjuur6@sol.localdomain>
References: <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <YGOcZtkw3ZM5kvl6@gmail.com>
 <YGUGYi4Q3Uxyol6r@kernel.org>
 <YGUHBelwhvJDhKoo@gmail.com>
 <20210401011132.GB4349@gondor.apana.org.au>
 <YGVfDUHunGC44iuH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVfDUHunGC44iuH@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 01, 2021 at 08:50:05AM +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 01, 2021 at 12:11:32PM +1100, Herbert Xu wrote:
> > On Wed, Mar 31, 2021 at 04:34:29PM -0700, Eric Biggers wrote:
> > > On Thu, Apr 01, 2021 at 02:31:46AM +0300, Jarkko Sakkinen wrote:
> > > > 
> > > > It's a bummer but uapi is the god in the end. Since TPM does not do it
> > > > today, that behaviour must be supported forever. That's why a boot option
> > > > AND a warning would be the best compromise.
> > > 
> > > It's not UAPI if there is no way for userspace to tell if it changed.
> > 
> > Exactly.  UAPI is only an issue if something *breaks*.
> 
> If there's even one user that comes shouting that he has a user space
> configuration, where e.g. rng entropy is consumed constantly and the
> code assumes that trusted keys does not add to that, then something
> would break.
> 
> It would be a crap user space yes, but I don't want to go on reverting
> because of that. I think there is small but still existing chance that
> something could break.

random.c no longer provides any interfaces that subtract entropy credits, as
that was never something that made sense.  So "consuming" all the entropy from
random.c isn't a thing anymore.

> 
> Why not just add a boot parameter instead of making brutal enforcing
> changes, indirectly visible to the user space?

Why not just fix this bug instead of providing an option to fix it that everyone
will need to remember to provide?

- Eric
