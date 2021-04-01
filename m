Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC923351957
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhDARw6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 13:52:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:40600 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhDARrI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 13:47:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0D0C5606BA22;
        Thu,  1 Apr 2021 13:16:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g4O_tLTycO8a; Thu,  1 Apr 2021 13:16:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9AA6F606BA25;
        Thu,  1 Apr 2021 13:16:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2cdZCkDK2XPn; Thu,  1 Apr 2021 13:16:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 30F67606BA22;
        Thu,  1 Apr 2021 13:16:54 +0200 (CEST)
Date:   Thu, 1 Apr 2021 13:16:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        kernel <kernel@pengutronix.de>,
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
Message-ID: <1465227062.139734.1617275814134.JavaMail.zimbra@nod.at>
In-Reply-To: <638717a5-a456-24a7-b0ab-9f71adb13687@pengutronix.de>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de> <1263763932.139584.1617272457698.JavaMail.zimbra@nod.at> <27d7d3fa-5df8-1880-df21-200de31cc629@pengutronix.de> <717795270.139671.1617274418087.JavaMail.zimbra@nod.at> <c72f93be-04e8-bb52-7252-4b4131648100@pengutronix.de> <1713376107.139705.1617275134320.JavaMail.zimbra@nod.at> <638717a5-a456-24a7-b0ab-9f71adb13687@pengutronix.de>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: mqcZxSDGQ+2iXRHRM0FbHdiOFBs5eA==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>> But using LUKS would mean that cryptsetup has access to the plain disc
>> encryption key material?
>> This would be a no-go for many systems out there, key material must not
>> accessible to userspace.
>> I know, distrusting userspace root is not easy, but doable. :)
> 
> The LUKS2 format supports tokens. I see no reason why the encrypted blob
> couldn't be stored there along with the usual metadata. cryptsetup would
> then load it as kernel trusted key and use it for dmcrypt decryption.
> 
> This will mean we have to part ways with features such as having multiple
> keys, but I think it's worth it to have a plug and play solution for
> trusted keys.

Ah, now I can follow your thoughts!
Yes, that would be nice to have. :)

I kind of assumed you want to use LUKS with passphrases and CAAM blobs.

Thanks,
//richard
