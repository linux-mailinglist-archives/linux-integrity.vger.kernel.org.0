Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72DB350ADF
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 01:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhCaXep (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 19:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhCaXec (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 19:34:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29A7C60724;
        Wed, 31 Mar 2021 23:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617233671;
        bh=VHAWYRxy4bXutKQaag3jfIG0mzVbXNUJpeALfhV5//A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lS+AwwMVCTIo09zlTKi4crYXm1RZfX3vKkF85+eCjryasiCbM1xrvOtDv+/mxAKZg
         4Ri8i+9lw2Fn3FRPM0x9Sf66YU7FqFO5U8fv30kRzJkWUfiOCPMFkV1Yg8bA0opOhZ
         Q5yAi3Cr1SogpVAe6mlqngN4ZUpiI0n8fupFhxJMHf7p9QyrR0cCuzkubdw0tQwsfF
         Bf6tbldLGu/mKxRzmNJd/09arSK6lVgEzksGj+ORJXiTXj34GxRDgPQEcHNF6uSc/c
         pMZSpd/2hZtjMog6+w33jGso1J6W7rqp/AvMRU8Szfb0K//JHWDVBh66LD2Ip7Cr19
         Fe7xvtDDgbqVw==
Date:   Wed, 31 Mar 2021 16:34:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <YGUHBelwhvJDhKoo@gmail.com>
References: <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
 <YGOcZtkw3ZM5kvl6@gmail.com>
 <YGUGYi4Q3Uxyol6r@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGUGYi4Q3Uxyol6r@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 01, 2021 at 02:31:46AM +0300, Jarkko Sakkinen wrote:
> 
> It's a bummer but uapi is the god in the end. Since TPM does not do it
> today, that behaviour must be supported forever. That's why a boot option
> AND a warning would be the best compromise.
> 

It's not UAPI if there is no way for userspace to tell if it changed.

- Eric
