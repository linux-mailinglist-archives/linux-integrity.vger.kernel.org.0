Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A81351386
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhDAK2M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 06:28:12 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60168 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDAK1z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6C52E606BA25;
        Thu,  1 Apr 2021 12:20:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Si3ccR2XFNkt; Thu,  1 Apr 2021 12:20:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0711E606BA27;
        Thu,  1 Apr 2021 12:20:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MFdJ5jY0cUlX; Thu,  1 Apr 2021 12:20:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C428E606BA25;
        Thu,  1 Apr 2021 12:20:57 +0200 (CEST)
Date:   Thu, 1 Apr 2021 12:20:57 +0200 (CEST)
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
Message-ID: <1263763932.139584.1617272457698.JavaMail.zimbra@nod.at>
In-Reply-To: <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvyj1aZ_3MuxJC6onejchV_6A8WbNR1vTLpSBF5QTxvLyQ@mail.gmail.com> <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: +Kg0jkvxiPr6cjcaexmg+qI/E7bbOw==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>> I'm pretty sure with minimal changes it will work with your recent approach too.
> 
> I am using dmsetup directly in my project. I am not familiar with cryptsetup
> plain. What benefits do you see with this over direct dmsetup?

cryptsetup is the de-facto standard to setup encrypted block devices.
There is a lot of existing tooling around cryptsetup already (systemd, etc..),
so being able to use CAAM keys for dm-crypt with cryptsetup seems natural to me.
Plain mode allows setting up dm-crypt without LUKS.

Thanks,
//richard
