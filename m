Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D03E42EB
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHIJfo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 05:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234678AbhHIJfl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 05:35:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E037460F35;
        Mon,  9 Aug 2021 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501721;
        bh=nru4pTl6a8kjzx9EdAHayPIK2KO3nYM89wQwNSafjqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVhX4qzKwcOpV7F15Pp1UztEPx439TchRe9Zu6yd/x5nY24z+cDkAFXalmE2q1dEj
         V4xYOjpgTeGSMHB2DNI6oP/b1aTM6IG7vWWDnBe+uOLmlBGxnkFxvtUREsssWf359G
         Az/R4JxdAxc0ZI5Au8ePC8YcFXcbY6rKVqWj/LvA8OlzLTJN16zs2g0RJ8pYsIi3ew
         79AInD9p5gX9tCp4rUYUMa3gNxTp2peHH9xGyHlXCYnWZ91DEcDnrwk1GjyQUBqqy7
         +efDd2JZ2y0CqEjM1RRWAiSqNGk3iQeNnZbfKd/qgeuK7tklZqYZmp2nIDxPIuWQMd
         4dnwJR0MUy3fg==
Date:   Mon, 9 Aug 2021 12:35:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
Message-ID: <20210809093519.er32rmspuvkrww45@kernel.org>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <b9e44f8e-84a0-90be-6cfc-d3a0bde12178@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e44f8e-84a0-90be-6cfc-d3a0bde12178@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 06, 2021 at 05:12:19PM +0200, Ahmad Fatoum wrote:
> Dear trusted key maintainers,
> 
> On 21.07.21 18:48, Ahmad Fatoum wrote:
> > Series applies on top of
> > https://lore.kernel.org/linux-integrity/20210721160258.7024-1-a.fatoum@pengutronix.de/T/#u
> > 
> > v2 -> v3:
> >  - Split off first Kconfig preparation patch. It fixes a regression,
> >    so sent that out, so it can be applied separately (Sumit)
> >  - Split off second key import patch. I'll send that out separately
> >    as it's a development aid and not required within the CAAM series
> >  - add MAINTAINERS entry
> 
> Gentle ping. I'd appreciate feedback on this series.

Simple question: what is fscrypt?

/Jarkko
