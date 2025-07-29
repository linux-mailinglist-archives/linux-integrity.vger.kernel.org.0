Return-Path: <linux-integrity+bounces-6747-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFAB149CF
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jul 2025 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4957AEDFA
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jul 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01746275867;
	Tue, 29 Jul 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchiq.pl header.i=@launchiq.pl header.b="TwoW0hej"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.launchiq.pl (mail.launchiq.pl [57.129.61.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F186235055
	for <linux-integrity@vger.kernel.org>; Tue, 29 Jul 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.61.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776766; cv=none; b=lYjrAIRv9+y2cQLTtDWYMihy+lMwUru/F4lUg0FwWXTXfYK4NVRgECUHIACc02P67WF89WbB144WD1pI1KzxXwqs9otCH8wKyu/OekM0e6k1etBBQmBSo9QDEwv9qNI4Y20YEZ2xBjl+c1oqlBoX4G/kZR+XyD5V7mfRZlDbyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776766; c=relaxed/simple;
	bh=1nV56yiRn7w88ZKIfi9xMzQzsEglWEb9KKVoIWzOJTA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=LGoJmjbGM0Am0+65oVREyasf6g9bytiXQ1nm3Dtj53SeXElqr3qcndl1uk9rEEEXoxUOWdq07CTVXXXPcc150SETrhqBgAXRSBc6En5UQsckYKmQly/a8atllHiblmDf1QyXOwpc0KFgpHjXxUXtKjIrQBRHS5EGkcPPxEShjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=launchiq.pl; spf=pass smtp.mailfrom=launchiq.pl; dkim=pass (2048-bit key) header.d=launchiq.pl header.i=@launchiq.pl header.b=TwoW0hej; arc=none smtp.client-ip=57.129.61.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=launchiq.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchiq.pl
Received: by mail.launchiq.pl (Postfix, from userid 1002)
	id AC2312459E; Tue, 29 Jul 2025 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=launchiq.pl; s=mail;
	t=1753776756; bh=1nV56yiRn7w88ZKIfi9xMzQzsEglWEb9KKVoIWzOJTA=;
	h=Date:From:To:Subject:From;
	b=TwoW0hejifMTXIhKdOyY7s2tJ6kNw/H5VBwWnJTSjaG0l2DlNmTR3t5xCbSYuuLN1
	 DXKibE2LxYBsXDwbbI+PlAIEn+yO4eJW6AlaGlwTX+anFKSmXPiwU4M0a5J/M2ftCK
	 eJIkYagkYNgzG+WKmO0WR081fyTPVWD33J0VqvyP3hvVGOfS3nP9onz71t0QDltkMZ
	 L4a44KsJurkbQ/P8wJw+y4ejUVrikdsPzHIz0orv8ChrawM5JMSWDb8/m3XrRVVgSb
	 tbmvyhOWRS1CVTT/5b+oLascuWm8mLtpsGZwPtcAtBGtF33U+lgKqNxc4aImqZDb8a
	 ArobhurSzV0JA==
Received: by mail.launchiq.pl for <linux-integrity@vger.kernel.org>; Tue, 29 Jul 2025 08:11:22 GMT
Message-ID: <20250729064500-0.1.3m.az7i.0.brf8bhpajd@launchiq.pl>
Date: Tue, 29 Jul 2025 08:11:22 GMT
From: "Grzegorz Sutor" <grzegorz.sutor@launchiq.pl>
To: <linux-integrity@vger.kernel.org>
Subject: Umowa vPPA - termin spotkania
X-Mailer: mail.launchiq.pl
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

mamy rozwi=C4=85zanie, kt=C3=B3re pozwala zabezpieczy=C4=87 korzystn=C4=85=
 cen=C4=99 energii na d=C5=82ugie lata =E2=80=94 bez konieczno=C5=9Bci zm=
iany obecnego dostawcy i bez inwestycji w instalacje odnawialne.

Proponujemy wsp=C3=B3=C5=82prac=C4=99 w oparciu o wirtualne umowy PPA (vP=
PA) =E2=80=93 to rozliczany finansowo kontrakt oparty na cenach SPOT, kt=C3=
=B3ry:

=E2=80=A2 stabilizuje koszty energii na 3 do 7 lat,
=E2=80=A2 wspiera realizacj=C4=99 polityki ESG i obni=C5=BCa =C5=9Blad w=C4=
=99glowy,
=E2=80=A2 zapewnia elastyczno=C5=9B=C4=87 zakupow=C4=85 =E2=80=93 cz=C4=99=
=C5=9B=C4=87 energii w sta=C5=82ej cenie z OZE, reszta  =20
  rozliczana na bie=C5=BC=C4=85co,
=E2=80=A2 nie wymaga zmian technicznych ani formalnych po stronie Pa=C5=84=
stwa firmy.

Wsp=C3=B3=C5=82pracujemy z przedsi=C4=99biorstwami zu=C5=BCywaj=C4=85cymi=
 od 3 do 30 GWh rocznie =E2=80=93 g=C5=82=C3=B3wnie z bran=C5=BC takich j=
ak przemys=C5=82, logistyka, handel, automotive, IT i data center.

Ch=C4=99tnie przygotujemy bezp=C5=82atn=C4=85 wycen=C4=99 i indywidualn=C4=
=85 propozycj=C4=99 kontraktu, dostosowan=C4=85 do profilu zu=C5=BCycia e=
nergii w Pa=C5=84stwa firmie.

Je=C5=9Bli temat jest dla Pa=C5=84stwa interesuj=C4=85cy, z przyjemno=C5=9B=
ci=C4=85 przeka=C5=BC=C4=99 wi=C4=99cej informacji lub um=C3=B3wi=C4=99 s=
potkanie z naszym specjalist=C4=85.


Z wyrazami szacunku.
Grzegorz Sutor

