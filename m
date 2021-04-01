Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C7350E8B
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhDAFqi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 01:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDAFqS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 01:46:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C465061105;
        Thu,  1 Apr 2021 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617255978;
        bh=gxlixb9ixquq1ytVeiB0zWryyTuL9Sy+kKcjFn97ypc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJuDKPMURR1uM8Jva7ld8d3o1JQmXobSSyzpuhX17V1zmixlgUMSqI89FoUzr627J
         zuWG9c6TjUdH1avGicc8aiQ660VrJKuvqT6FhxGWVsnd40sSxddxKHlwjgKdHKInYG
         YsMHr+D8kTvE9/Dw7sUIjFi+2yvJD0aIqfsCSiqoSd6HTA6AX/jPR8iwMywSfOqu0s
         aaHKat+asI7ZAmwTKFI8P+OE/2nPqCUZp7tD8DitfRaH79OJ696D5uDYIkvnR/ydXZ
         g1KzVW3HnNolU9EKka11lTfR0roEffxv+rLyr3XTTwwm7P0AjAbWOeZxSh7QG5qA69
         22El4veFSw2Yg==
Date:   Thu, 1 Apr 2021 08:46:16 +0300
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
Message-ID: <YGVeKPcrySJCJfhp@kernel.org>
References: <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <YGOcZtkw3ZM5kvl6@gmail.com>
 <YGUGYi4Q3Uxyol6r@kernel.org>
 <YGUHBelwhvJDhKoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGUHBelwhvJDhKoo@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 31, 2021 at 04:34:29PM -0700, Eric Biggers wrote:
> On Thu, Apr 01, 2021 at 02:31:46AM +0300, Jarkko Sakkinen wrote:
> > 
> > It's a bummer but uapi is the god in the end. Since TPM does not do it
> > today, that behaviour must be supported forever. That's why a boot option
> > AND a warning would be the best compromise.
> > 
> 
> It's not UAPI if there is no way for userspace to tell if it changed.
> 
> - Eric

It's enough uapi for me. People might assume that the entropy source is
TPM for this, since it has been so far.

/Jarkko
