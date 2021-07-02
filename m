Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2160A3BA08E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhGBMgh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhGBMgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 08:36:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF6C061764
        for <linux-integrity@vger.kernel.org>; Fri,  2 Jul 2021 05:34:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lzIMq-0003K9-Jc; Fri, 02 Jul 2021 14:34:00 +0200
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard@nod.at>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
Date:   Fri, 2 Jul 2021 14:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <783613027.15909.1625223222889.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 02.07.21 12:53, Richard Weinberger wrote:
> Ahmad,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>>> I'm still think that hard coding the key modifier is not wise.
>>> As I said[0], there are folks out there that want to provide their own modifier,
>>> so it is not only about being binary compatible with other CAAM blob patches in
>>> the wild.
>>
>> I don't think the characterization as a salt is accurate. AFAIU it's more
>> of a namespace, so blobs being loaded are "type-checked" against the modifier.
> 
> Well, the CAAM programmer's reference manual states that the blob key is a 128 bit modifier
> and has two purposes:
> 1. It can be used as tag to provide separation between blobs to detect accidental replacement of blobs.
> 2. But it can also be treated as secret to provide additional protection. Because the blob encryption
> key derivation includes the key modifier.
> 
> While you have case 1 in mind, I care about case 2. :-)

Ah, using the key modifier as a passphrase didn't occur to me.

>>> I'll happily implement that feature after your patches got merged but IMHO we
>>> should first agree on an interface.
>>> How about allowing another optional parameter to Opt_new and Opt_load
>>
>> Sound good to me. pcrlock for TPM trusted keys has the same interface.
>>
>> I'd prefer the new option to accept strings, not hex though.
> 
> Both is possible. If the string starts with "0x" it needs to be decoded to a
> 128 bit key. Otherwise it has to be a up to 16 byte string.

Fine by me. Looking forward to your patches. :-)


Cheers,
Ahmad

> 
> Thanks,
> //richard
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
