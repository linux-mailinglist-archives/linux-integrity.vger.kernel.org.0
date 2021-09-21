Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5717E413BEB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 23:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhIUVEy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 17:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235206AbhIUVEx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 17:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6410C611C6;
        Tue, 21 Sep 2021 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632258204;
        bh=YhqVrip59Rt+ejldx4zOH6RSKXsNMGSJzfGiFZHPJQc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CzO/y6fFJ5EozaaIMR4bExW75mL3X4I3kZntrlReVCg/MSN9Xyp4w+ey6grOjXyx9
         0e7cCoz80zS26yz4soxWvi+mOYguNKYyG5MEGgBiMYCQ/KKgNzRxAu7wYQmBUthCkw
         ruQ4ODbvgWE+W5JmFNcnNEJ4spGkzPW+nVo9lFFgCFsy/Dy6pUJV6MaizMpmOiQ7aL
         BHVLpelKbsLEM5OoWkge8lytmNrrWOt2QmNaDbWQkSjn4b/4wcFSOoCvE5BtCm2Eyq
         uai6QSRBqwSnvQbiC1iFs0NZqIM2aYyOPxm/Ex6LAJztu0nOY8o59SbQnlcm66zAaL
         Im6OUuqSAQ25w==
Message-ID: <270f47e1b152a1fb8fd909ec188b5573176980fc.camel@kernel.org>
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Jones <pjones@redhat.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Wed, 22 Sep 2021 00:03:22 +0300
In-Reply-To: <20210916221416.onvqgz5iij3c7e6j@redhat.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
         <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
         <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
         <f6e2e17cc6c8a3056cc066a7baa4d943eeb47c84.camel@kernel.org>
         <20210916221416.onvqgz5iij3c7e6j@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-16 at 18:14 -0400, Peter Jones wrote:
> On Thu, Sep 16, 2021 at 06:15:50PM +0300, Jarkko Sakkinen wrote:
> > On Wed, 2021-09-15 at 15:28 -0600, Eric Snowberg wrote:
> > > > On Sep 15, 2021, at 11:57 AM, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > >=20
> > > > On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
> > > > > Back in 2013 Linus requested a feature to allow end-users to have=
 the=20
> > > > > ability "to add their own keys and sign modules they trust". This=
 was
> > > > > his *second* order outlined here [1]. There have been many attemp=
ts=20
> > > > > over the years to solve this problem, all have been rejected.  Ma=
ny=20
> > > > > of the failed attempts loaded all preboot firmware keys into the =
kernel,
> > > > > including the Secure Boot keys. Many distributions carry one of t=
hese=20
> > > > > rejected attempts [2], [3], [4]. This series tries to solve this =
problem=20
> > > > > with a solution that takes into account all the problems brought =
up in=20
> > > > > the previous attempts.
> > > > >=20
> > > > > On UEFI based systems, this series introduces a new Linux kernel =
keyring=20
> > > > > containing the Machine Owner Keys (MOK) called machine. It also d=
efines
> > > > > a new MOK variable in shim. This variable allows the end-user to =
decide=20
> > > > > if they want to load MOK keys into the machine keyring. Mimi has =
suggested=20
> > > > > that only CA keys contained within the MOK be loaded into the mac=
hine=20
> > > > > keyring. All other certs will load into the platform keyring inst=
ead.
> > > > >=20
> > > > > By default, nothing changes; MOK keys are not loaded into the mac=
hine
> > > > > keyring.  They are only loaded after the end-user makes the decis=
ion=20
> > > > > themselves.  The end-user would set this through mokutil using a =
new=20
> > > > > --trust-mok option [5]. This would work similar to how the kernel=
 uses=20
> > > > > MOK variables to enable/disable signature validation as well as u=
se/ignore=20
> > > > > the db. Any kernel operation that uses either the builtin or seco=
ndary=20
> > > > > trusted keys as a trust source shall also reference the new machi=
ne=20
> > > > > keyring as a trust source.
> > > > >=20
> > > > > Secure Boot keys will never be loaded into the machine keyring.  =
They
> > > > > will always be loaded into the platform keyring.  If an end-user =
wanted=20
> > > > > to load one, they would need to enroll it into the MOK.
> > > > >=20
> > > > > Steps required by the end user:
> > > > >=20
> > > > > Sign kernel module with user created key:
> > > > > $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> > > > >   machine_signing_key.priv machine_signing_key.x509 my_module.ko
> > > > >=20
> > > > > Import the key into the MOK
> > > > > $ mokutil --import machine_signing_key.x509
> > > > >=20
> > > > > Setup the kernel to load MOK keys into the .machine keyring
> > > > > $ mokutil --trust-mok
> > > > >=20
> > > > > Then reboot, the MokManager will load and ask if you want to trus=
t the
> > > > > MOK key and enroll the MOK into the MOKList.  Afterwards the sign=
ed kernel
> > > > > module will load.
> > > > >=20
> > > > > I have included links to both the mokutil [5] and shim [6] change=
s I
> > > > > have made to support this new functionality.
> > > >=20
> > > > How hard it is to self-compile shim and boot it with QEMU (I
> > > > do not know even the GIT location of Shim)?
> > >=20
> > > It is not hard, that is the setup I use for my testing.  Upstream shi=
m=20
> > > is located here [1].  Or you can use my repo which contains the neces=
sary
> > > changes [2].
> > >=20
> > > [1] https://github.com/rhboot/shim
> > > [2] https://github.com/esnowberg/shim/tree/mokvars-v2
> > >=20
> >=20
> > So, my 2nd Q would be: which order these should be upstreamed?
> >=20
> > Linux patch set cannot depend on "yet to be upstreamed" things.
> >=20
> > Code changes look good enough to me.
>=20
> We can carry this support in shim before it's in kernel.  Eric's current
> patch for shim and mokutil looks mostly reasonable, though I see a few
> minor nits we'll have to sort out.

I would revisit this patch set after there is an official shim release
out containing the new API. No  kernel patches, which depend on any
non-upstream changes, can be rightfully reviewed.

/Jarkko
