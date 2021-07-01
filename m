Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B23B97BB
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jul 2021 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhGAUpa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jul 2021 16:45:30 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51298 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhGAUp3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jul 2021 16:45:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6216D6108476;
        Thu,  1 Jul 2021 22:42:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kLydErpcW5Ws; Thu,  1 Jul 2021 22:42:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C39FC6108472;
        Thu,  1 Jul 2021 22:42:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LbgvkTJUFHdW; Thu,  1 Jul 2021 22:42:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 844066083273;
        Thu,  1 Jul 2021 22:42:55 +0200 (CEST)
Date:   Thu, 1 Jul 2021 22:42:55 +0200 (CEST)
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
Message-ID: <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at>
In-Reply-To: <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de> <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: g8issG6CVMbkLEBHiev9vrinZL1Dqw==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
> +static struct caam_blob_priv *blobifier;
> +
> +#define KEYMOD "kernel:trusted"

I'm still think that hard coding the key modifier is not wise.
As I said[0], there are folks out there that want to provide their own modifier,
so it is not only about being binary compatible with other CAAM blob patches in the wild.

I'll happily implement that feature after your patches got merged but IMHO we should first agree on an interface.
How about allowing another optional parameter to Opt_new and Opt_load and having a key modifier
per struct trusted_key_payload instance?

Thanks,
//richard

[0]
https://patchwork.kernel.org/project/linux-crypto/patch/319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de/#24085397

