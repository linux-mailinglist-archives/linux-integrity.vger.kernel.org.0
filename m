Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2A7C541B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Oct 2023 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjJKMhD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Oct 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjJKMhC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2023 08:37:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0191;
        Wed, 11 Oct 2023 05:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98410C433C7;
        Wed, 11 Oct 2023 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697027820;
        bh=ZUksIgIUwSU2RdI2JIQHXtQ6TwnvYAP8TApwF28ZrCY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KYdFpZyLDRnMy+fr5pC/pA+NPXwNISw/QF2QkvtnHsUjwHJvj3nd3rV1lF0lFOQOK
         rAKOyyAdGaQZEIIApnpmXq/DC/BCr2PjP4IFeFQ/IEiQSElsLyIUgcUTxAoV6Crixn
         R4CyhYa1w5geY70DGmFhywARqLKZ+lipAJLr5DGfogC+nvFSNTq5e9y/GE38emfqIc
         KC+bZ4NgdDxeAiao2q9xj522OCtds+pOm6qWxj6XWfVblNGWIKXYEjgTswps4njH4o
         0Xzzo4QvmzX+GcIcJYq8pfH+XpHVOIibpCyPIJatXFSKKvpu1Ax1JFb0IJf93A4UiE
         2AM+6xLPrpzYQ==
Message-ID: <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Oct 2023 15:36:55 +0300
In-Reply-To: <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
         <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
         <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
         <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > > >=20
> > > > > Do bind neither static calls nor trusted_key_exit() before a succ=
essful
> > > > > init, in order to maintain a consistent state. In addition, depar=
t the
> > > > > init_trusted() in the case of a real error (i.e. getting back som=
ething
> > > > > else than -ENODEV).
> > > > >=20
> > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=3DwhOPoLaWM=
8S8GgoOPT7a2+nMH5h3TLKtn=3DR_3w4R1_Uvg@mail.gmail.com/
> > > > > Cc: stable@vger.kernel.org=C2=A0# v5.13+
> > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys fra=
mework")
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > > =C2=A0security/keys/trusted-keys/trusted_core.c | 20 ++++++++++--=
--------
> > > > > =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
> > > > >=20
> > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security=
/keys/trusted-keys/trusted_core.c
> > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_random)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 get_random =3D kernel_get_random;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_seal,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_so=
urces[i].ops->seal);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_unseal,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_so=
urces[i].ops->unseal);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_get_random,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_random);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].ops->exit=
;
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->migratable=
;
> > > > > -
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->init();
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stati=
c_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stati=
c_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stati=
c_call_update(trusted_key_get_random, get_random);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trust=
ed_key_exit =3D trusted_key_sources[i].ops->exit;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migra=
table =3D trusted_key_sources[i].ops->migratable;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret || ret !=3D -ENODEV)
> > > >=20
> > > > As mentioned in the other thread, we should allow other trust sourc=
es
> > > > to be initialized if the primary one fails.
> > >=20
> > > I sent the patch before I received that response but here's what you
> > > wrote:
> > >=20
> > > "We should give other trust sources a chance to register for trusted
> > > keys if the primary one fails."
> > >=20
> > > 1. This condition is lacking an inline comment.
> > > 2. Neither this response or the one that you pointed out has any
> > > =C2=A0=C2=A0 explanation why for any system failure the process shoul=
d
> > > =C2=A0=C2=A0 continue.
> > >=20
> > > You should really know the situations (e.g. list of posix error
> > > code) when the process can continue and "allow list" those. This
> > > way way too abstract. It cannot be let all possible system failures
> > > pass.
> >=20
> > And it would nice if it printed out something for legit cases. Like
> > "no device found" etc. And for rest it must really withdraw the whole
> > process.
>=20
> IMO, it would be quite tricky to come up with an allow list. Can we
> keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
> these are all debatable.

Yes, that does sounds reasonable.

About the debate. Well, it is better eagerly block and tree falls down
somewhere we can consider extending the list through a fix.

This all wide open is worse than a few glitches somewhere, which are
trivial to fix.

BR, Jarkko
