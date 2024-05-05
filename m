Return-Path: <linux-integrity+bounces-2337-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAA48BBEE4
	for <lists+linux-integrity@lfdr.de>; Sun,  5 May 2024 02:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F5F28202D
	for <lists+linux-integrity@lfdr.de>; Sun,  5 May 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989E801;
	Sun,  5 May 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0uFbkB6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A1191;
	Sun,  5 May 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714868128; cv=none; b=QWPqPf0AiwM0RGGoHtzFnquY8FmI2YeWd0+B/31bzLXqaqrhBuf43WJJl0Dch4eUVpuf4xe34iPPS2eAiezd7J/GMvOUkQY06GALOjtNC/Kcg1G4F4Wp/XSDvse4uAcUE1ZbUBpEjdnlGW4vPGyowZ2KA2LNgKBP7EPqPWWqHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714868128; c=relaxed/simple;
	bh=Us12kLS2/JZzE9OjnNQSSWjgW41q/1qK+0tYJ109430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe12wYUL5AuwOiFg2pJpBydk7OATwXAsRIZqOb/Dbyiss3czJWpWzf3gaP+f8mfYfeGgXKTzwPYbVTAasSrQYoofUWq5LYEcjN/A5Y5of3KeTimj7xjdMOdBNnENt2OEdHYq527VR9TzYIp4mFTHKxXWKUZV3ky8+nY8c0Vv9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0uFbkB6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec4dd8525cso6328525ad.3;
        Sat, 04 May 2024 17:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714868125; x=1715472925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgS8JoAt6F27d1bbCvSCcX4fIE1TnZzCg1FmdDqGcZI=;
        b=N0uFbkB6jlEaPVaOkdFzQg50wGVyjtKlAT3sTV6Q1wl8d6l6Xslb0jv8uf3R25h8Vb
         tQsr+pzftUPFvfauxRNFUWxeHVqk+2/GkzR9xk1MCJ60cyEGTpv32mcpuKmD1kc8Egbz
         vsm3zfxNnG7vFZf4HXCFb0hKVEchgUQIZgj0R+ssWzz6zCkwcJIf3GEb0ykNOHMclFrw
         ThB3bpYZgAWRIuwMHUsR/WMYdJyhtIeQyLQ9NVkZQXg5aQNda0gEHC/JY1L7FQPD7euN
         hJPdS6nDAlq1RFpXrT9XKI7x2/9TN5HjBBZeRWkk9CUam2mffol8nXHPOsBcoDYtnCpN
         slsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714868125; x=1715472925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgS8JoAt6F27d1bbCvSCcX4fIE1TnZzCg1FmdDqGcZI=;
        b=wKFsWS6sAadDXIujg0o/v1q1dSOqM5tVT4I8jlEtWrIK73hknDfP9422oPMfkDrVZD
         eqGtCiXx4GamW5aKQvXKCjSKsDhFLfKoJYlM50aEWUnqyPQrt6LZxA+uaRIuwipm2Knz
         AU0r85HdkcFOEzi3OJnvbAlwvqN4nrmGZjEtwqXC64U55TszEn9c5QCDvtbDryFK1RSI
         5NiXHK1o7btqB4oPD6wJLNVcLBuU77Stu4cRnOQ7cXqR84qS6fhPEuqRjGR5XPwKeYR2
         iq37+Zf0IeZZtdK1LgAyx7KnLvKtYw0Bs5ataG1S/4hERgAHvpA4IuPodqCfM3Fsvnpr
         Fc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWEjhnFrI5QyOCG09iEPWqDmGN1fyBoYOR3i4aKKWfKPgfv77Rqfi224NjfrpQIxy1MkX0Fp5XHtR+fzyQwkvq6VBTnOXeBvF9dgsavW3M5HMGE1HdjQu21OrDe5ZWf1HEgWDnBHQG9AC3NVnzW0eXmi/cFqpvBv2lliq8pw1Ewjek8aEU++fOfj68OmCAfNnIuinkFZHmRdQuVsBDfBZQ4ICsfrHsZOBwGv+shx1Fqp5q6ugtDTTsGEEEl1D8l8oqptgyEcXCSLg==
X-Gm-Message-State: AOJu0Yw5aS/Ye9GcDBg/BwHHL/jmFCtqhaLCCEcuvlVve1FlkFzsjKQl
	On3koFLDz39sSniWvUSRXDETmx4SpWV1/Im/nsHC7BJL0h8fOKAf
X-Google-Smtp-Source: AGHT+IEuepOKmbUX0nP6tkkmgH/wJcdmWEBFxatponT+7JHJdiSXjE9CQIyDOyyrEvUleV3UtJK/YA==
X-Received: by 2002:a17:903:2403:b0:1e5:8175:4968 with SMTP id e3-20020a170903240300b001e581754968mr5632206plo.9.1714868124735;
        Sat, 04 May 2024 17:15:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ld14-20020a170902face00b001e0c568ae8fsm5583101plb.192.2024.05.04.17.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 17:15:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 133A9184947D8; Sun, 05 May 2024 07:15:18 +0700 (WIB)
Date: Sun, 5 May 2024 07:15:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu,
	ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v18 20/21] Documentation: add ipe documentation
Message-ID: <ZjbPlk8ZwFZwdqJJ@archie.me>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-21-git-send-email-wufan@linux.microsoft.com>
 <ZjXsBjAFs-qp9xY4@archie.me>
 <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="InlbHezzGTuEcuIT"
Content-Disposition: inline
In-Reply-To: <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>


--InlbHezzGTuEcuIT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2024 at 01:13:16PM -0700, Fan Wu wrote:
>=20
>=20
> On 5/4/2024 1:04 AM, Bagas Sanjaya wrote:
> > On Fri, May 03, 2024 at 03:32:30PM -0700, Fan Wu wrote:
> > > +IPE does not mitigate threats arising from malicious but authorized
> > > +developers (with access to a signing certificate), or compromised
> > > +developer tools used by them (i.e. return-oriented programming attac=
ks).
> > > +Additionally, IPE draws hard security boundary between userspace and
> > > +kernelspace. As a result, IPE does not provide any protections again=
st a
> > > +kernel level exploit, and a kernel-level exploit can disable or tamp=
er
> > > +with IPE's protections.
> >=20
> > So how to mitigate kernel-level exploits then?
> >=20
> One possible way is to use hypervisor to protect the kernel integrity.
> https://github.com/heki-linux is one project on this direction. Perhaps I
> should also add this link to the doc.

OK.

>=20
> > > +Allow only initramfs
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > <snipped>...
> > > +Allow any signed and validated dm-verity volume and the initramfs
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > <snipped>...
> >=20
> > htmldocs build reports new warnings:
> >=20
> > Documentation/admin-guide/LSM/ipe.rst:694: WARNING: Title underline too=
 short.
> >=20
> > Allow any signed and validated dm-verity volume and the initramfs
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > Documentation/admin-guide/LSM/ipe.rst:694: WARNING: Title underline too=
 short.
> >=20
> > Allow any signed and validated dm-verity volume and the initramfs
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > Documentation/arch/x86/resctrl.rst:577: WARNING: Title underline too sh=
ort.
> >=20
> > I have to match these sections underline length:
> >=20
> > ---- >8 ----
> > diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admi=
n-guide/LSM/ipe.rst
> > index 1a3bf1d8aa23f0..a47e14e024a90d 100644
> > --- a/Documentation/admin-guide/LSM/ipe.rst
> > +++ b/Documentation/admin-guide/LSM/ipe.rst
> > @@ -681,7 +681,7 @@ Allow all
> >      DEFAULT action=3DALLOW
> >   Allow only initramfs
> > -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +~~~~~~~~~~~~~~~~~~~~
> >   ::
> > @@ -691,7 +691,7 @@ Allow only initramfs
> >      op=3DEXECUTE boot_verified=3DTRUE action=3DALLOW
> >   Allow any signed and validated dm-verity volume and the initramfs
> > -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ::
> > @@ -725,7 +725,7 @@ Allow only a specific dm-verity volume
> >      op=3DEXECUTE dmverity_roothash=3Dsha256:401fcec5944823ae12f62726e8=
184407a5fa9599783f030dec146938 action=3DALLOW
> >   Allow any fs-verity file with a valid built-in signature
> > -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ::
> > @@ -735,7 +735,7 @@ Allow any fs-verity file with a valid built-in sign=
ature
> >      op=3DEXECUTE fsverity_signature=3DTRUE action=3DALLOW
> >   Allow execution of a specific fs-verity file
> > -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ::
> >=20
> > > +Additional Information
> > > +----------------------
> > > +
> > > +- `Github Repository <https://github.com/microsoft/ipe>`_
> > > +- Documentation/security/ipe.rst
> >=20
> > Link title to both this admin-side and developer docs can be added for
> > disambiguation (to avoid confusion on readers):
> >=20
> > ---- >8 ----
> > diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admi=
n-guide/LSM/ipe.rst
> > index a47e14e024a90d..25b17e11559149 100644
> > --- a/Documentation/admin-guide/LSM/ipe.rst
> > +++ b/Documentation/admin-guide/LSM/ipe.rst
> > @@ -7,7 +7,8 @@ Integrity Policy Enforcement (IPE)
> >      This is the documentation for admins, system builders, or individu=
als
> >      attempting to use IPE. If you're looking for more developer-focused
> > -   documentation about IPE please see Documentation/security/ipe.rst
> > +   documentation about IPE please see :doc:`the design docs
> > +   </security/ipe>`.
> >   Overview
> >   --------
> > @@ -748,7 +749,7 @@ Additional Information
> >   ----------------------
> >   - `Github Repository <https://github.com/microsoft/ipe>`_
> > -- Documentation/security/ipe.rst
> > +- :doc:`Developer and design docs for IPE </security/ipe>`
> >   FAQ
> >   ---
> > diff --git a/Documentation/security/ipe.rst b/Documentation/security/ip=
e.rst
> > index 07e3632241285d..fd1b1a852d2165 100644
> > --- a/Documentation/security/ipe.rst
> > +++ b/Documentation/security/ipe.rst
> > @@ -7,7 +7,7 @@ Integrity Policy Enforcement (IPE) - Kernel Documentati=
on
> >      This is documentation targeted at developers, instead of administr=
ators.
> >      If you're looking for documentation on the usage of IPE, please see
> > -   Documentation/admin-guide/LSM/ipe.rst
> > +   `IPE admin guide </admin-guide/LSM/ipe.rst>`_.
> >   Historical Motivation
> >   ---------------------
> >=20
> > Thanks.
> >=20
>=20
> My apologies for these format issues and thanks for the suggestions. I wi=
ll
> fix them.

Oh, I forgot to also add :doc: directive for the last reference link:

---- >8 ----
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index fd1b1a852d2165..aa2e64d4119f3e 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -7,7 +7,7 @@ Integrity Policy Enforcement (IPE) - Kernel Documentation
=20
    This is documentation targeted at developers, instead of administrators.
    If you're looking for documentation on the usage of IPE, please see
-   `IPE admin guide </admin-guide/LSM/ipe.rst>`_.
+   :doc:`IPE admin guide </admin-guide/LSM/ipe>`.
=20
 Historical Motivation
 ---------------------

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--InlbHezzGTuEcuIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjbPjgAKCRD2uYlJVVFO
o8HPAQDxhozqHxPAtlb/vByqFj4O4DT+qZVm5PvJcv9tnq0aCQD7BQbQr6wEPrYZ
0lIMQIcpVMj+XdMBtixikEDTadIDHQI=
=mp4a
-----END PGP SIGNATURE-----

--InlbHezzGTuEcuIT--

