Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2627350AD3
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaXcD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 19:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhCaXbt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 19:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F74260FDB;
        Wed, 31 Mar 2021 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617233508;
        bh=22Sf+C8CNMBp5xxIlZSGAARcmSEGXDH2/y17KA34uHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLAhGd5dF1Cfe5ThbKZsmV5wk9gLsS57U6plIuuvArE60HI08QwBFhauWE9sOvNIz
         3PLR8A7R5B4VariiO6fUUcQkPJ4+V/GFZU17nbbyI1H9Fq5Uzo6OeW+YyZMvNsQe75
         ijCs6yoa9ABtG8hA/k0KlAJ72zlPsJ5bo1fU0FH75alQOFLQMV7k2Vdntuh2+Z7A4S
         7Fc5SgWybdXlwnky06ucIP+cQeKo1/q/zM7vUhlj+/kaLR7V3bsLDxB1jZyt3Uc5jP
         RxTMIQL6XGNWVQu0bFl4w85p6i7Xmzdxf6ignQIa+JBaHSc3gf0Lx5oCgFU7nsJ0+l
         IzyAqtQpF67Ig==
Date:   Thu, 1 Apr 2021 02:31:46 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Gstir <david@sigma-star.at>,
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
        Herbert Xu <herbert@gondor.apana.org.au>,
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
Message-ID: <YGUGYi4Q3Uxyol6r@kernel.org>
References: <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
 <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <YGOcZtkw3ZM5kvl6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGOcZtkw3ZM5kvl6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 30, 2021 at 02:47:18PM -0700, Eric Biggers wrote:
> On Sun, Mar 28, 2021 at 11:37:23PM +0300, Jarkko Sakkinen wrote:
> > 
> > Unfortunately, TPM trusted keys started this bad security practice, and
> > obviously it cannot be fixed without breaking uapi backwards compatibility.
> > 
> 
> The whole point of a randomness source is that it is random.  So userspace can't
> be depending on any particular output, and the randomness source can be changed
> without breaking backwards compatibility.
> 
> So IMO, trusted keys should simply be fixed to use get_random_bytes().
> 
> - Eric

It's a bummer but uapi is the god in the end. Since TPM does not do it
today, that behaviour must be supported forever. That's why a boot option
AND a warning would be the best compromise.

/Jarkko
