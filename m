Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D10542EBF
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiFHLJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiFHLIt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA61B2168;
        Wed,  8 Jun 2022 04:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 881CFCE1D6F;
        Wed,  8 Jun 2022 11:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C9C34116;
        Wed,  8 Jun 2022 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686524;
        bh=bnCVPgqGZK5fBMahxZ7HHsO5nJ1Jj7QarAUy/aXfRws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c+C0Bs4PJEMrAs5KNJQYYQB770dgj5XpSjU3AsiD0N1+NCQIf7Dx3qcpzRjMACHv/
         aOXyvsLwpF3LVq9qVa1qXsEviv4RldtK1Fgvi9zYYeOdE3Hx6OIsxjugkLWuntRNJ8
         0bw3E2glXXDor1q8252nHJqrqhrzAMwyfgy0ge940nqs/HH0/33UBZRjuBfK0dVVJW
         DHGJBBu2PoM9xlXFCtRpE3HtIgny7SmKTISZZpacNcP1scv6xmtHIXfdUElkSJ3Yy6
         bEwqV6TZom+9LX6mZhiUkcBKNGByasRpl9UmEHtlZyUMh3B4Wjo1nsC0dAal3gDwlO
         8PbA7fVvkb/rw==
Message-ID: <830f58cbcae3275310fe8b132c8f7cb12842e0f4.camel@kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for v5.19-rc2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Wed, 08 Jun 2022 14:06:48 +0300
In-Reply-To: <20220608092646.3074700-1-jarkko@kernel.org>
References: <20220608092646.3074700-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-06-08 at 12:26 +0300, Jarkko Sakkinen wrote:
> The following changes since commit 9886142c7a2226439c1e3f7d9b69f9c7094c3e=
f6:
>=20
> =C2=A0 Merge tag 'input-for-v5.19-rc1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/dtor/input (2022-06-07 15:00:29 -0700)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.g=
it/ tags/tpmdd-next-v5.19-rc2
>=20
> for you to fetch changes up to 967a4b757b51164a3dc3307234fcb48b7be2745b:
>=20
> =C2=A0 KEYS: trusted: tpm2: Fix migratable logic (2022-06-08 12:13:26 +03=
00)
>=20
> ----------------------------------------------------------------
> A bug fix for migratable (whether or not a key is tied to the TPM chip
> soldered to the machine) handling for TPM2 trusted keys.
>=20
> ----------------------------------------------------------------
> david.safford@gmail.com=C2=A0(1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEYS: trusted: tpm2: Fix migratable logic
>=20
> =C2=A0security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Ugh, from-address in malformed. I'll need to redo the PR.

BR, Jarkko

