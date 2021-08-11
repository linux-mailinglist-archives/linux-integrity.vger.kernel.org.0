Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24A3E8EE5
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhHKKnc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 06:43:32 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16]:11319 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhHKKnc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 06:43:32 -0400
Date:   Wed, 11 Aug 2021 10:43:01 +0000
Authentication-Results: mail-4316.protonmail.ch; dkim=none
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
From:   David Gstir <david@sigma-star.at>
Cc:     =?utf-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Reply-To: David Gstir <david@sigma-star.at>
Subject: Re: [PATCH 3/4] crypto: caam - add in-kernel interface for blob generator
Message-ID: <85A1078F-B8E1-4E5F-A59A-23BDFB750C83@sigma-star.at>
In-Reply-To: <7cc83edd-dc39-ee7e-d18c-30b2492247ea@pengutronix.de>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de> <4078060ab2e44114af8204b4defea4f3d4b9e285.1626885907.git-series.a.fatoum@pengutronix.de> <796E18E6-1329-40D6-B12F-4CE6C90DD988@sigma-star.at> <7cc83edd-dc39-ee7e-d18c-30b2492247ea@pengutronix.de>
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

> On 11.08.2021, at 12:22, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
>> Since you already assert that MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN
>> in security/keys/trusted-keys/trusted_caam.c, this will never
>> be an issue for CAAM-based trusted-keys though.
> I omitted checks in code, which are verified at compile-time.
> Would you prefer a runtime check to be added as well?

I’d say the compile-time check suffices, unless this is intended
to be used outside of trusted-keys. But I don’t think this is very likely…

Cheers,
David
