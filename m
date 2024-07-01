Return-Path: <linux-integrity+bounces-2947-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0091E317
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC70FB219B3
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E585016C6B0;
	Mon,  1 Jul 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkpMYn/h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6921339B1;
	Mon,  1 Jul 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846031; cv=none; b=Aea1Jl2V/8W8qZzeR1HXQzd8RFLcf8rM9T3DSMo1oxi7kEVu6J8mEn6MSa+Dt+v8DB9GCoRsA0ua5TGhExWPvD74Gj8R79osneAIs643lIbe+IwLaI+y5p+wKJ+aUT46mYA17nFlU5UtXof9gHhXBPdKc08w9sCL5sKkTLBVHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846031; c=relaxed/simple;
	bh=fbn2NGKb2qkaahIhbmmExTV1fZJk1OftjiQiEv/22fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qihrAFuUe/0gTr+hE/XkmxRIrBKJANPGWUW5OqIKSBK2Tj+6QyDcTHU/5t3XPXT+6WAieqs+okLljJmJCvW1rAyuI/ugqVHTHG5Io5x70+2K+Pu7fhDj6nJc8yjXoMc740atYkuI30swuBjw1jc7ObqCLFBINFZJFhL+zy1C9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkpMYn/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C0C116B1;
	Mon,  1 Jul 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846031;
	bh=fbn2NGKb2qkaahIhbmmExTV1fZJk1OftjiQiEv/22fk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fkpMYn/hbFQlOFDcDGu1lS8X4x8q5qttab8iLxUOFB3fE6cUtsZ1PlYPpnD8O4mKW
	 EtkIhdJpfE0rW+2koBvWajjvr+JWkhjhIL56kQfbNVv4MVu+9xgIZFWJ+li/Armu9c
	 QTxz13lOmcXy1CbEHO+NcV92Cx8DCMMOxKHPN+UdjpJfcAauSr/duTwaeF2OkQCER4
	 QtAyO0NXfojbp8wYQHKK+F+nm0nAdnzA7x93N3S3mmowjelPnupxFQyRiy9KHkiSKj
	 76F++uf92XObvdkBYlTWNKsuaIzXxU3RUZwi6o5ykHWMhsnRdh1bzegpdBCRC5YNxA
	 7IFIry89eWoAw==
Message-ID: <4258218f9de3a70e7a04783881baed3879a914f1.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] KEYS: trusted: add missing MODULE_DESCRIPTION()
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Date: Mon, 01 Jul 2024 15:00:28 +0000
In-Reply-To: <CAHC9VhSVSS46oCAz_NrUUGstmG3j0NVk70-SwwtCTVJ-R1Z+OA@mail.gmail.com>
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
	 <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com>
	 <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
	 <CAHC9VhSVSS46oCAz_NrUUGstmG3j0NVk70-SwwtCTVJ-R1Z+OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 12:54 -0400, Paul Moore wrote:
> On Wed, Jun 19, 2024 at 8:19=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > On Fri Jun 7, 2024 at 4:47 AM EEST, Jeff Johnson wrote:
> > > kbuild reports:
> > >=20
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trust=
ed-keys/trusted.o
> > >=20
> > > Add the missing MODULE_DESCRIPTION() macro invocation.
> > >=20
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > > =C2=A0security/keys/trusted-keys/trusted_core.c | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/key=
s/trusted-
> > > keys/trusted_core.c
> > > index 5113aeae5628..e2d9644efde1 100644
> > > --- a/security/keys/trusted-keys/trusted_core.c
> > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
> > > =C2=A0late_initcall(init_trusted);
> > > =C2=A0module_exit(cleanup_trusted);
> > >=20
> > > +MODULE_DESCRIPTION("Trusted Key type");
> > > =C2=A0MODULE_LICENSE("GPL");
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Are you planning on taking these patches Jarkko?

Hi, both are now applied.

Except slow phase this month as I'm on holiday. I'll take care of
v6.11 PR's.

BR, Jarkko

