Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710D34F3B6
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 23:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhC3Vra (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 17:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhC3VrZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 17:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42C3361969;
        Tue, 30 Mar 2021 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617140841;
        bh=efZTSeZg5XZdPMKissn/jqo8tvlWQesdN6Iq75XHvfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EE+/eIjWBtwuci++W9gjw+1hfjkCUOFnCek0S7tGuoWziUmlBjPnnpm164rZwfDBY
         OETzBbgFsd4ArFeux8BOHcSaFjhgoKtxe/qad/6J515m8BJgZkS1YcysvKmP3YKncx
         8zt6vjxgVBaG0PcEmKS/g2hq2rI50hR3FPOrHFo2OGMXjiaJ8ey50NjyxyMdSnHT+L
         JIyEytj9VSwvDsaDn5VwomZafE9p8mhiavJyKbOggr7x4oKSarCey3IdRTKN9GotAj
         UtMWIgxM7oa8aOBV6W1A57KLOx0kB2JZpXr1bkUDSjG3DQCRC59nKBaNJmmTPYAacD
         d4ZR6Vnd6a7UQ==
Date:   Tue, 30 Mar 2021 14:47:18 -0700
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
Message-ID: <YGOcZtkw3ZM5kvl6@gmail.com>
References: <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
 <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
 <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
 <YGDpA4yPWmTWEyx+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGDpA4yPWmTWEyx+@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 28, 2021 at 11:37:23PM +0300, Jarkko Sakkinen wrote:
> 
> Unfortunately, TPM trusted keys started this bad security practice, and
> obviously it cannot be fixed without breaking uapi backwards compatibility.
> 

The whole point of a randomness source is that it is random.  So userspace can't
be depending on any particular output, and the randomness source can be changed
without breaking backwards compatibility.

So IMO, trusted keys should simply be fixed to use get_random_bytes().

- Eric
