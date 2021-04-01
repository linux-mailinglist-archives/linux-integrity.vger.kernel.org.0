Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE803513F6
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhDAKz2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 06:55:28 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60844 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhDAKy5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 06:54:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E55D960FB28C;
        Thu,  1 Apr 2021 12:53:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kHf6bXNSWmLt; Thu,  1 Apr 2021 12:53:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 76B666071A7C;
        Thu,  1 Apr 2021 12:53:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q_FICC5ApzVQ; Thu,  1 Apr 2021 12:53:38 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3928660FB28C;
        Thu,  1 Apr 2021 12:53:38 +0200 (CEST)
Date:   Thu, 1 Apr 2021 12:53:38 +0200 (CEST)
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
Message-ID: <717795270.139671.1617274418087.JavaMail.zimbra@nod.at>
In-Reply-To: <27d7d3fa-5df8-1880-df21-200de31cc629@pengutronix.de>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvyj1aZ_3MuxJC6onejchV_6A8WbNR1vTLpSBF5QTxvLyQ@mail.gmail.com> <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de> <1263763932.139584.1617272457698.JavaMail.zimbra@nod.at> <27d7d3fa-5df8-1880-df21-200de31cc629@pengutronix.de>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: DfD/q4ZvfJZf2mMkmIDHHYWuBGwS1g==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Do you mean systemd-cryptsetup? It looks to me like it's just a way to supply
> the keyphrase. With trusted keys and a keyphrase unknown to userspace, this
> won't work.

Nah, I meant existing scripts/service Files.

> I don't (yet) see the utility of it without LUKS. Perhaps a command dump on how
> to do the same I did with dmsetup, but with cryptsetup plain instead could
> help me to see the benefits?

My reasoning is simple, why do I need a different tool when there is already one
that could do the task too?
Usually the systems I get my hands on use already dm-crypt with cryptsetup in some way.
So I have the tooling already in my initramfs, etc.. and need to adopt the callers of cryptsetup a little.

If I need all of a sudden different/additional tooling, it means more work, more docs to write,
more hassle with crypto/system reviewers, etc...

I don't want you to force to use cryptsetup.
The only goal was pointing out that it can be done with cryptsetup and that there
is already code such that no work is done twice.
One the kernel side it does not matter.

Thanks,
//richard
