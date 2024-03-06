Return-Path: <linux-integrity+bounces-1590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B673C87352D
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Mar 2024 11:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8E41C20F2A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Mar 2024 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B68768FB;
	Wed,  6 Mar 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haklK8zI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4F7867E
	for <linux-integrity@vger.kernel.org>; Wed,  6 Mar 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722646; cv=none; b=nP5ChkbMG2F38Ar7OWtF03uSaZmEKK/RcFyHhmYJu/Im+3QqCJ7mIN/ay47F5+jiLpEGiyXvespvN2Rt2cKn0Ta9OjOUzRxHOlTxkhlTVK15iBpGvs4mA3JONUmGP+TRMUVtTNTdvTqL2Qq6n9KOXDiKJyFUPSqn19FW/MTA7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722646; c=relaxed/simple;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTGSZ29Wmt3EV/UnYMCFClHEedDEF2QCPvPHepcgSYY8R1bcLsR/W6Tbn2KnsxnOx6cVbvcnsBnmp1p6C0Rw2tpIl7NiOlOFRkMezNkveVQpsKGKHQ/T0KUO8sFD98wZfbkIih5SGzR7Z3KUGA8OAqBIolQkg7ah9AlgabjXfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haklK8zI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709722643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	b=haklK8zIYWRHUE6CsdFU6mKuSfAdw3bnoWMpTqlURIu3eq2L55rH2EVu0OkfUWUMJtT+UI
	5s0/q2f95roTGBeUKooPQB/m6X9E+ABEgXUWf0LJE8goagsHl4+LkS7Z3+cgq5KIhxZ+ls
	z07k2mIqCnvZ8FpfNNDMTAB5mWRMzvI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-chbzBM9xOHis0NZP7JjUAQ-1; Wed, 06 Mar 2024 05:57:21 -0500
X-MC-Unique: chbzBM9xOHis0NZP7JjUAQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e4dc811a7so620119f8f.1
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2024 02:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722640; x=1710327440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
        b=EJBkJWx4PkaW9piF5VMk4UM9QRfAbStDhFY7TSOBpNOO22lGHUaDgI4APHlQhjHP9g
         iVJUMUqrI+kPX93q+B9lJbSqUzrzvWAh4VAyt6Bk0dc0aoAjH/mEESWAgYrjsNrIzBec
         ztevo9bEo2beLfkmuE2PQdUYf5WeIp54Y5fKbaCYmrQkDnUt5N0yyyHw6vMV4GLwx3zM
         H4/JXfIoxcpIu5JnmE7ElsPHfJleOGCfsJbT73i1pLTpwtVGfxlkM+czpo76PCz36hLW
         6EAAUeNjcezL3KOp/Ju0Vv0z8ahCIge3dFP2VAhvCN47lV9hzLeZHH7kzbrjGz8jKRTC
         dyiQ==
X-Gm-Message-State: AOJu0YyDeTyb3FjosxJRicl9dI8dS1HS8qmouEtOhkJ9odaStBJW1P/B
	S744N3DlUT3/uoslVKp/HhrkkfglZ5qTlkUlwiZUjCNiraDqkGBWboPWnvzhjZKvA3lEMOduloA
	niUlOqQzpHlGydvd4+0Do51R3qpQC76HyehkkRQgXCRUOKKO1enERmVIgTnFCyIZ/lw==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001140wrb.38.1709722640458;
        Wed, 06 Mar 2024 02:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRZPOXIucKkLpt2y1Kl5ONuSx0wUfC6rVS8K/ER3pp2uiUyHn4H8Vrm+c3L1dNUe5NOyldIw==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001113wrb.38.1709722639939;
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm17353346wrb.115.2024.03.06.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Date: Wed, 6 Mar 2024 11:57:19 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <20240306-humongous-nuthatch-of-science-00e58b@houat>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv7pnznz2fqkk5di"
Content-Disposition: inline
In-Reply-To: <20240109002429.1129950-1-coxu@redhat.com>


--xv7pnznz2fqkk5di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry, Eric, James, Mimi, Paul, Serge,

On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
> Currently when the kernel fails to add a cert to the .machine keyring,
> it will throw an error immediately in the function integrity_add_key.
>=20
> Since the kernel will try adding to the .platform keyring next or throw
> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> so there is no need to throw an error immediately in integrity_add_key.
>=20
> Reported-by: itrymybest80@protonmail.com
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2239331
> Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine=
")
> Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Any chance this patch can be merged? This is breaking (at least) Fedora
at the moment.

Thanks!
Maxime

--xv7pnznz2fqkk5di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZehMDgAKCRDj7w1vZxhR
xRjcAQDO43bKYImGBD+B/EBUcAe1M2J0uqbm6+QesqiYtsPvGAD/fUFr3rDbhTvM
CAt76KLDM5Hbt0iKpgt0TgS06wTsLQQ=
=tyck
-----END PGP SIGNATURE-----

--xv7pnznz2fqkk5di--


