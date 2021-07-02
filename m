Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3B3B9F54
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhGBK4S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 06:56:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39292 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGBK4S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 06:56:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF14D606BA30;
        Fri,  2 Jul 2021 12:53:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hG49krIohN_g; Fri,  2 Jul 2021 12:53:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 52AA1606BA4F;
        Fri,  2 Jul 2021 12:53:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yiX2RLkjjlHe; Fri,  2 Jul 2021 12:53:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 121A7606BA30;
        Fri,  2 Jul 2021 12:53:43 +0200 (CEST)
Date:   Fri, 2 Jul 2021 12:53:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
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
Message-ID: <783613027.15909.1625223222889.JavaMail.zimbra@nod.at>
In-Reply-To: <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de> <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de> <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at> <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: YNq+u/AVc12Aad/zgRj+Xah98DqV1g==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>> I'm still think that hard coding the key modifier is not wise.
>> As I said[0], there are folks out there that want to provide their own modifier,
>> so it is not only about being binary compatible with other CAAM blob patches in
>> the wild.
> 
> I don't think the characterization as a salt is accurate. AFAIU it's more
> of a namespace, so blobs being loaded are "type-checked" against the modifier.

Well, the CAAM programmer's reference manual states that the blob key is a 128 bit modifier
and has two purposes:
1. It can be used as tag to provide separation between blobs to detect accidental replacement of blobs.
2. But it can also be treated as secret to provide additional protection. Because the blob encryption
key derivation includes the key modifier.

While you have case 1 in mind, I care about case 2. :-)
 
>> I'll happily implement that feature after your patches got merged but IMHO we
>> should first agree on an interface.
>> How about allowing another optional parameter to Opt_new and Opt_load
> 
> Sound good to me. pcrlock for TPM trusted keys has the same interface.
> 
> I'd prefer the new option to accept strings, not hex though.

Both is possible. If the string starts with "0x" it needs to be decoded to a
128 bit key. Otherwise it has to be a up to 16 byte string.

Thanks,
//richard
