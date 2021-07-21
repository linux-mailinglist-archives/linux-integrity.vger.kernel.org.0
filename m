Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F853D14C4
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhGUQWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhGUQWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 12:22:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFBC061575
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 10:02:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m6FcI-0006k1-92; Wed, 21 Jul 2021 19:02:42 +0200
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        horia geanta <horia.geanta@nxp.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
 <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
 <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at>
 <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
 <783613027.15909.1625223222889.JavaMail.zimbra@nod.at>
 <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
 <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <879d4cda-2ac1-d81b-7f4d-c08261e0aa0c@pengutronix.de>
Date:   Wed, 21 Jul 2021 19:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 20.07.21 21:19, Richard Weinberger wrote:
> On Fri, Jul 2, 2021 at 2:37 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>> Both is possible. If the string starts with "0x" it needs to be decoded to a
>>> 128 bit key. Otherwise it has to be a up to 16 byte string.
>>
>> Fine by me. Looking forward to your patches. :-)
> 
> I'm not sure how to proceed.  Should I base my changes on this series
> or do you plan to send an updated
> version soon?
> Maybe it makes also sense to base my DCP patch set on yours.
> 
> Trusted Keys maintainers, what do you prefer?

I sent out v3 despite the name (of course forgot that git-send-email -vX is silently
dropped when sending patch files directly..):

https://lore.kernel.org/linux-integrity/cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de/T/#t

I'd advise you base your changes on the first two patches there as well as the Kconfig fix/enhancement
I sent out separately:
https://lore.kernel.org/linux-integrity/20210721160258.7024-1-a.fatoum@pengutronix.de/T/#u

Those are relevant for you as well and I assume they should be good to be merged even if the
CAAM series turns out to need some more love.

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
