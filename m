Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B184A3F1851
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhHSLim (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 07:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238276AbhHSLim (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 07:38:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B14A61152;
        Thu, 19 Aug 2021 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629373085;
        bh=ztpTlKzDLnuXMkA6oqHi+0cvd0vo10eKEycotaJ9HBo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HUowvtbQtFmr68GYqsmFe38XS4JsbnrsAO+F4q2I/tDtZxtgQILgLJgEGc8+f/Cz0
         uF8Ubu3FSMm8ezSeqFodFen4pHy/m4q7VrYbBct6Y4SEymSKzj6Ufc0u6kb/BloHFa
         MNKWa+cD49KUeXPOK2WvNvhKTeS4nY7kv459yxcJCmdrIjGQNsbN6JQW9LXGzt7e5x
         DCqe9yLWhvphgQGYiAXRUF2OM+ATZbvmlXeBM0j6DsYeRI1WNrXDDynv6Y36TLEC73
         djxJnjdAtPzSGGtrluo65CZd6rhR/zah6L6wG7Bi9S4MCc3W8RtGmGe3gc9AFPs+6B
         w2BNLl0YwdGqw==
Message-ID: <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
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
Date:   Thu, 19 Aug 2021 14:38:03 +0300
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-user development kernel build.  When Linux boots,
> pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
> Linux .platform keyring. =20
>=20
> Currently, pre-boot keys are not trusted within the Linux trust boundary
> [1]. These platform keys can only be used for kexec. If an end-user
> wants to use their own key within the Linux trust boundary, they must
> either compile it into the kernel themselves or use the insert-sys-cert
> script. Both options present a problem. Many end-users do not want to
> compile their own kernels. With the insert-sys-cert option, there are
> missing upstream changes [2].  Also, with the insert-sys-cert option,
> the end-user must re-sign their kernel again with their own key, and
> then insert that key into the MOK db. Another problem with
> insert-sys-cert is that only a single key can be inserted into a
> compressed kernel.
>=20
> Having the ability to insert a key into the Linux trust boundary opens
> up various possibilities.  The end-user can use a pre-built kernel and
> sign their own kernel modules.  It also opens up the ability for an
> end-user to more easily use digital signature based IMA-appraisal.  To
> get a key into the ima keyring, it must be signed by a key within the
> Linux trust boundary.

As of today, I can use a prebuilt kernel, crate my own MOK key and sign
modules. What will be different?

> Downstream Linux distros try to have a single signed kernel for each
> architecture.  Each end-user may use this kernel in entirely different
> ways.  Some downstream kernels have chosen to always trust platform keys
> within the Linux trust boundary for kernel module signing.  These
> kernels have no way of using digital signature base IMA appraisal.
>=20
> This series introduces a new Linux kernel keyring containing the Machine
> Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.

I would name it as ".machine" because it is more "re-usable" name, e.g.
could be used for similar things as MOK. ".mok" is a bad name because
it binds directly to a single piece of user space software.

/Jarkko
