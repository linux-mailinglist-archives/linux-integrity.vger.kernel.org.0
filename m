Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD03E5919
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhHJL3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 07:29:37 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42546 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbhHJL3g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 07:29:36 -0400
Date:   Tue, 10 Aug 2021 11:28:25 +0000
Authentication-Results: mail-4316.protonmail.ch; dkim=none
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
From:   David Gstir <david@sigma-star.at>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>
Reply-To: David Gstir <david@sigma-star.at>
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Message-ID: <74737543-4A73-49F8-92F7-F7FFE64A00DB@sigma-star.at>
In-Reply-To: <8321cac9-350b-1325-4b7e-390f4f292070@pengutronix.de>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de> <b9e44f8e-84a0-90be-6cfc-d3a0bde12178@pengutronix.de> <20210809093519.er32rmspuvkrww45@kernel.org> <8321cac9-350b-1325-4b7e-390f4f292070@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.0 required=10.0 tests=ALL_TRUSTED shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

> On 09.08.2021, at 12:16, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

[...]

> If it interests you, I described[2] my CAAM+ubifs+fscrypt use case in the
> discussion thread on my fscrypt-trusted-keys v1. Jan, a colleague of mine, held a
> talk[3] on the different solutions for authenticated and encrypted storage, which
> you may want to check out.
>
> I'd really appreciate feedback here on the the CAAM parts of this series, so this can
> eventually go mainline.

Since you mention the fscrypt trusted-keys use case:

I noticed that the key length for trusted-keys is limited to
256 - 1024bit keys. fscrypt does however also support keys
with e.g. 128bit keys (AES-128-CBC-ESSIV, AES-128-CTS-CBC).
AFAIK, CAAM and TEE key blobs would also support key lengths outside the 256 - 1024bit range.

Wouldn’t it make sense to align the supported key lengths?
I.e. extend the range of supported key lengths for trusted keys.
Or is there a specific reason why key lengths below 256bit are
not supported by trusted-keys?

Cheers,
David


