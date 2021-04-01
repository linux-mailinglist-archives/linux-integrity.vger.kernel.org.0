Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7707351308
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhDAKGu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDAKGU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 06:06:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A3C0613E6
        for <linux-integrity@vger.kernel.org>; Thu,  1 Apr 2021 03:06:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lRuDN-00013V-QC; Thu, 01 Apr 2021 12:06:13 +0200
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard@nod.at>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
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
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
 <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
 <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
 <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at>
 <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
 <2034693332.137003.1617219379831.JavaMail.zimbra@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <f3399480-020e-e3ca-7e7c-eec641fe5afc@pengutronix.de>
Date:   Thu, 1 Apr 2021 12:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2034693332.137003.1617219379831.JavaMail.zimbra@nod.at>
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

Hello Richard,

On 31.03.21 21:36, Richard Weinberger wrote:
> James,
> 
> ----- Ursprüngliche Mail -----
>> Von: "James Bottomley" <jejb@linux.ibm.com>
>> Well, yes.  For the TPM, there's a defined ASN.1 format for the keys:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/tpm2-asn.h
>>
>> and part of the design of the file is that it's distinguishable either
>> in DER or PEM (by the guards) format so any crypto application can know
>> it's dealing with a TPM key simply by inspecting the file.  I think you
>> need the same thing for CAAM and any other format.
>>
>> We're encouraging new ASN.1 formats to be of the form
>>
>> SEQUENCE {
>>    type   OBJECT IDENTIFIER
>>    ... key specific fields ...
>> }
>>
>> Where you choose a defined OID to represent the key and that means
>> every key even in DER form begins with a unique binary signature.
> 
> I like this idea.
> Ahmad, what do you think?
> 
> That way we could also get rid off the kernel parameter and all the fall back logic,
> given that we find a way to reliable detect TEE blobs too...

Sounds good to me. Sumit, your thoughts on doing this for TEE as well?

> 
> Thanks,
> //richard
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
