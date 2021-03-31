Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53F6350676
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhCaSgX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 14:36:23 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44632 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhCaSgL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 14:36:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D1D0D606BA3F;
        Wed, 31 Mar 2021 20:36:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id auclVmt-zenX; Wed, 31 Mar 2021 20:36:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 32C50627AFCE;
        Wed, 31 Mar 2021 20:36:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ywQbLygSeGs; Wed, 31 Mar 2021 20:36:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D39D4606BA3F;
        Wed, 31 Mar 2021 20:36:07 +0200 (CEST)
Date:   Wed, 31 Mar 2021 20:36:07 +0200 (CEST)
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
Message-ID: <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at>
In-Reply-To: <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com> <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: xbZUpghZowrq6I0Q8ESVpM8UhKDwsA==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James,

----- Ursprüngliche Mail -----
> Von: "James Bottomley" <jejb@linux.ibm.com>
>> On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <a.fatoum@pengutronix.de
>> > wrote:
>> >     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
>> 
>> Is there a reason why we can't pass the desired backend name in the
>> trusted key parameters?
>> e.g.
>> keyctl add trusted $KEYNAME "backendtype caam load $(cat ~/kmk.blob)"
>> @s
> 
> Why would you want to in the load?  The blob should be type specific,
> so a TPM key shouldn't load as a CAAM key and vice versa ... and if
> they're not they need to be made so before the patches go upstream.

I fear right now there is no good way to detect whether a blob is desired
for CAAM or TPM.

> I could possibly see that you might want to be type specific in the
> create, but once you're simply loading an already created key, the
> trusted key subsystem should be able to figure what to do on its own.

So you have some kind of container format in mind which denotes the
type of the blob?

Thanks,
//richard
