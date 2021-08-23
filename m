Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE23F4F94
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhHWRgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhHWRgm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:36:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5640A610C7;
        Mon, 23 Aug 2021 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629740159;
        bh=IluvJAFzs124mybQWVQ1LgBYA5/M73Cpv6BXvuP3q3k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QQJcN4o9ecThyHtdXCR86jq4JCRRhl7Si2YiNYcBOrY2EMh9fJ7F9gULc1OaeFtHp
         UHaNXH9Ayk5EV1j0qBlwcXoWaO0B4/y1C5Ch52msJllTj/2WHmQCn1pTZ0ed78OiXA
         Bf9OuTDQDSPkIlxfpcRj4QUxMIJiEHt9qSgts4wdoy/dY7KYu3V0gqL0D7tEBJCPxO
         wX4D0VxHQ05/L2k49HhcOZNG3jnhzA2UQ7j6/+mLDIkdNJC7SKZ5zWChbEgbnMjz1N
         z7YhrG2YyLkzEJCB1yhlVMiI2lhPvSy4/NLWorp0e57FkdWb8HHINdjwFUbneKMGGd
         pSWx5f3UyIONg==
Message-ID: <335ba50bcb9069faac135bce77c6f7ba19bd90ca.camel@kernel.org>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
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
        konrad.wilk@oracle.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Mon, 23 Aug 2021 20:35:57 +0300
In-Reply-To: <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 09:10 -0400, Mimi Zohar wrote:
> On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
> > On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
> > > Many UEFI Linux distributions boot using shim.  The UEFI shim provide=
s
> > > what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Sec=
ure
> > > Boot DB and MOK keys to validate the next step in the boot chain.  Th=
e
> > > MOK facility can be used to import user generated keys.  These keys c=
an
> > > be used to sign an end-user development kernel build.  When Linux boo=
ts,
> > > pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in t=
he
> > > Linux .platform keyring. =20
> > >=20
> > > Currently, pre-boot keys are not trusted within the Linux trust bound=
ary
> > > [1]. These platform keys can only be used for kexec. If an end-user
> > > wants to use their own key within the Linux trust boundary, they must
> > > either compile it into the kernel themselves or use the insert-sys-ce=
rt
> > > script. Both options present a problem. Many end-users do not want to
> > > compile their own kernels. With the insert-sys-cert option, there are
> > > missing upstream changes [2].  Also, with the insert-sys-cert option,
> > > the end-user must re-sign their kernel again with their own key, and
> > > then insert that key into the MOK db. Another problem with
> > > insert-sys-cert is that only a single key can be inserted into a
> > > compressed kernel.
> > >=20
> > > Having the ability to insert a key into the Linux trust boundary open=
s
> > > up various possibilities.  The end-user can use a pre-built kernel an=
d
> > > sign their own kernel modules.  It also opens up the ability for an
> > > end-user to more easily use digital signature based IMA-appraisal.  T=
o
> > > get a key into the ima keyring, it must be signed by a key within the
> > > Linux trust boundary.
> >=20
> > As of today, I can use a prebuilt kernel, crate my own MOK key and sign
> > modules. What will be different?
>=20
> The UEFI db and MOK keys are being loaded onto the .platform keyring,
> which is suppose to be limited to verifying the kexec kernel image
> signature.  With a downstream patch, kernel modules are being verified
> as well.
>=20
> Initially Patrick Uiterwijk's "[PATCH 0/3] Load keys from TPM2 NV Index
> on IMA keyring" patch set attempted to define a new root of trust based
> on a key stored in the TPM.  This patch set is similarly attempting to
> define a new root of trust based on CA keys stored in the MOK db.
>=20
> The purpose of this patch set is to define a new, safe trust source
> parallel to the builtin keyring, without relying on a downstream patch.
> With the new root of trust, the end user could sign his own kernel
> modules, sign third party keys, and load keys onto the IMA keyring,
> which can be used for signing the IMA policy and other files.

I can, as of today, generate my own mok key and sign my LKM's, and
kernel will verify my LKM's.

What is different?


/Jarkko
