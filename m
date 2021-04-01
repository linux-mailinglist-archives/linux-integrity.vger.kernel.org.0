Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07FA350E93
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 07:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDAFui (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 01:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhDAFuI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 01:50:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ACDE60FEF;
        Thu,  1 Apr 2021 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617256208;
        bh=KIy5K4ZiwyDNq4I+K6ohLino9Gixd2dsgCQKQ07XJzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxMd1wiwtDhjVj5WEif7HEKwJNUeneUPwOmY+gqPMEgwcGvPRlwFU85/ow/6kVo4q
         P7G3hNm98MzdHjzXo7FstxQQCVsJM2QlJSTwBIfjqzNKZCm5LmuXgFvWdHi6xlfBwD
         IH5lY/nPvR+i9/ZHtTUosQtRh6Xa5oq128KURD18chrNcevRC8URIUdaazDDigDqw7
         nbsXpkABMylEy29S1kWHKgQ40bPWH4/wD1UtFFE4gZJr5jtU2tmnq9vT7/yX6Vyp68
         c8UNK0hdXIp98eERQK2kvGbSxCWOYJhygC1a41uYxijMw2BatkkCz/f6Ri/JmvVrfl
         YmPwvfdXH8msA==
Date:   Thu, 1 Apr 2021 08:50:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <YGVfDUHunGC44iuH@kernel.org>
References: <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <YGOcZtkw3ZM5kvl6@gmail.com>
 <YGUGYi4Q3Uxyol6r@kernel.org>
 <YGUHBelwhvJDhKoo@gmail.com>
 <20210401011132.GB4349@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401011132.GB4349@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 01, 2021 at 12:11:32PM +1100, Herbert Xu wrote:
> On Wed, Mar 31, 2021 at 04:34:29PM -0700, Eric Biggers wrote:
> > On Thu, Apr 01, 2021 at 02:31:46AM +0300, Jarkko Sakkinen wrote:
> > > 
> > > It's a bummer but uapi is the god in the end. Since TPM does not do it
> > > today, that behaviour must be supported forever. That's why a boot option
> > > AND a warning would be the best compromise.
> > 
> > It's not UAPI if there is no way for userspace to tell if it changed.
> 
> Exactly.  UAPI is only an issue if something *breaks*.

If there's even one user that comes shouting that he has a user space
configuration, where e.g. rng entropy is consumed constantly and the
code assumes that trusted keys does not add to that, then something
would break.

It would be a crap user space yes, but I don't want to go on reverting
because of that. I think there is small but still existing chance that
something could break.

Why not just add a boot parameter instead of making brutal enforcing
changes, indirectly visible to the user space?

/Jarkko
