Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768235077D
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhCaTg2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 15:36:28 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45764 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhCaTgX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D0CE860FB284;
        Wed, 31 Mar 2021 21:36:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eH0n2r8fHPTn; Wed, 31 Mar 2021 21:36:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 45DA360FB282;
        Wed, 31 Mar 2021 21:36:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nxuy-sYQlTu2; Wed, 31 Mar 2021 21:36:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03BFF60FB281;
        Wed, 31 Mar 2021 21:36:20 +0200 (CEST)
Date:   Wed, 31 Mar 2021 21:36:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, kernel <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Message-ID: <2034693332.137003.1617219379831.JavaMail.zimbra@nod.at>
In-Reply-To: <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com> <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com> <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at> <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: qVNalfbj1gU0jLT0w1bk9F+qRZwlVw==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James,

----- Ursprüngliche Mail -----
> Von: "James Bottomley" <jejb@linux.ibm.com>
> Well, yes.  For the TPM, there's a defined ASN.1 format for the keys:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/tpm2-asn.h
> 
> and part of the design of the file is that it's distinguishable either
> in DER or PEM (by the guards) format so any crypto application can know
> it's dealing with a TPM key simply by inspecting the file.  I think you
> need the same thing for CAAM and any other format.
> 
> We're encouraging new ASN.1 formats to be of the form
> 
> SEQUENCE {
>    type   OBJECT IDENTIFIER
>    ... key specific fields ...
> }
> 
> Where you choose a defined OID to represent the key and that means
> every key even in DER form begins with a unique binary signature.

I like this idea.
Ahmad, what do you think?

That way we could also get rid off the kernel parameter and all the fall back logic,
given that we find a way to reliable detect TEE blobs too...

Thanks,
//richard
