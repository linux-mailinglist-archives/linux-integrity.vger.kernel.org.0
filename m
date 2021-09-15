Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6940CC10
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Sep 2021 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhIOR7B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Sep 2021 13:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIOR7A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Sep 2021 13:59:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D72FB61130;
        Wed, 15 Sep 2021 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631728661;
        bh=yrPKjuUAh/sdrdlpsTPesM9BsBY/6gkpojv1C9xWAqM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JN4FWT29WA8Z/iQH8pcgaOxa32DCkxL0QtG/mDJAkZlzU9xXBjlR8oayw4o5UWM4Y
         zQtFBFZQkyhvLiimmiRRIaOz1oTYqEH8Cfo98SgoFuOrszdiqvyKwrHTzLSVkJfhm4
         X+TXJnMNrLt22+J1zv/S8TTsqrUQmfKeyGLcmX4PbndLH9lTf18xCCw0IRiSE3tJkv
         69ASCnzHHNfcn37B4EGmgtbYd59AE77Wq9StUtyeXWgX9X9ufg1RhLAL3CBbGwDW7v
         biZrSipYtrE3H35ITRT2/gGTlkNJyaV+tXwQgwVSGHaScrE7S70cqLlnnOj9cv/hs9
         jsmcF04IvUwZw==
Message-ID: <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Wed, 15 Sep 2021 20:57:39 +0300
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
> Back in 2013 Linus requested a feature to allow end-users to have the=20
> ability "to add their own keys and sign modules they trust". This was
> his *second* order outlined here [1]. There have been many attempts=20
> over the years to solve this problem, all have been rejected.  Many=20
> of the failed attempts loaded all preboot firmware keys into the kernel,
> including the Secure Boot keys. Many distributions carry one of these=20
> rejected attempts [2], [3], [4]. This series tries to solve this problem=
=20
> with a solution that takes into account all the problems brought up in=
=20
> the previous attempts.
>=20
> On UEFI based systems, this series introduces a new Linux kernel keyring=
=20
> containing the Machine Owner Keys (MOK) called machine. It also defines
> a new MOK variable in shim. This variable allows the end-user to decide=
=20
> if they want to load MOK keys into the machine keyring. Mimi has suggeste=
d=20
> that only CA keys contained within the MOK be loaded into the machine=20
> keyring. All other certs will load into the platform keyring instead.
>=20
> By default, nothing changes; MOK keys are not loaded into the machine
> keyring.  They are only loaded after the end-user makes the decision=20
> themselves.  The end-user would set this through mokutil using a new=20
> --trust-mok option [5]. This would work similar to how the kernel uses=
=20
> MOK variables to enable/disable signature validation as well as use/ignor=
e=20
> the db. Any kernel operation that uses either the builtin or secondary=
=20
> trusted keys as a trust source shall also reference the new machine=20
> keyring as a trust source.
>=20
> Secure Boot keys will never be loaded into the machine keyring.  They
> will always be loaded into the platform keyring.  If an end-user wanted=
=20
> to load one, they would need to enroll it into the MOK.
>=20
> Steps required by the end user:
>=20
> Sign kernel module with user created key:
> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>    machine_signing_key.priv machine_signing_key.x509 my_module.ko
>=20
> Import the key into the MOK
> $ mokutil --import machine_signing_key.x509
>=20
> Setup the kernel to load MOK keys into the .machine keyring
> $ mokutil --trust-mok
>=20
> Then reboot, the MokManager will load and ask if you want to trust the
> MOK key and enroll the MOK into the MOKList.  Afterwards the signed kerne=
l
> module will load.
>=20
> I have included links to both the mokutil [5] and shim [6] changes I
> have made to support this new functionality.

How hard it is to self-compile shim and boot it with QEMU (I
do not know even the GIT location of Shim)?

I'm all my SGX testing already with TianoCore and QEMU so I
thought it might not be that huge stretch to get testing env
for this.

/Jarkko
