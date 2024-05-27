Return-Path: <linux-integrity+bounces-2665-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3958D1097
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 01:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9226A283174
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6113D29E;
	Mon, 27 May 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LfLWhYiZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PsAJcFYL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBB45C14;
	Mon, 27 May 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853483; cv=none; b=quslUQOja8EzGXdgd2l3g0eR9OyEPwkAi15YE7NsRkK7QC6nZPibSNJ7MPfH1+P/Vb29v0tuqcEhEBNkD6CMVEoa/Lq/DsAcCcKFMe2yKh237M6tiQSUEi9tVAz/M5XngryT2rGyKbq1wJqFXgytpAM3zoW9LZ8EVFS7EdHRWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853483; c=relaxed/simple;
	bh=EdBpJBA58UcDomxKHuYzuX9Ow/+7jqpFZIh974Rr9ZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gecd9PS9xp8UfYALVexZkMbnU1+mmsqdrYHVzD4xMZ2tip71S1nwC6iOI1gSJxpD5SE2D5NNY1OugZAz+as4elRVd67NHBr10XGQS0i1Hl34almrwdQKwaWkxuMrIC/6soV1izOBvW5MzLwDZaqlaglzOR6jE7nt6UHM2MYxpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LfLWhYiZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=PsAJcFYL; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716853481;
	bh=EdBpJBA58UcDomxKHuYzuX9Ow/+7jqpFZIh974Rr9ZQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LfLWhYiZXlMHZ/97dfDfPTo6UdmMq8D7jX7cZxYHuIQC35snsYIoSAyIW+Q8Ar6Y0
	 /oMDhlLJSlfnhgHNkRorcUfNsrwk5U4VFOCN4fxWdcvQbOkYh2zVI6jAomQalGJluV
	 XCYD8NKEBCoGLUdh/0VuMkORCvcxN5TDoklhmnQs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 263001286C7A;
	Mon, 27 May 2024 19:44:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id z9z6VeenUfAD; Mon, 27 May 2024 19:44:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716853480;
	bh=EdBpJBA58UcDomxKHuYzuX9Ow/+7jqpFZIh974Rr9ZQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PsAJcFYL58leUIBRjUDZOYXixrtVw6qx4tLzqK7De4ddlx+gfZr/MAE5rdH7rxvv+
	 D4VTWU+BRSZm034erdkHkdAGRhm81Omowp8zCgCI1NrlVErQbdxAjZ5akO4YIe0Pon
	 vnQbK/zphsepj1tf73k3qm6xBG2bzh1xmS2/Z8lY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EA9B312869EC;
	Mon, 27 May 2024 19:44:39 -0400 (EDT)
Message-ID: <439c3a66a995429f6c8603640477580e17d03104.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Vitor Soares <ivitro@gmail.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 27 May 2024 19:44:38 -0400
In-Reply-To: <D1KT71LIUIPC.33KKNF1H2SX94@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
	 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
	 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
	 <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
	 <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>
	 <D1KIFPNBNGKH.IJKFRXH8WINU@kernel.org>
	 <D1KINAE5E2MH.729CM4ABV5VN@kernel.org>
	 <D1KIV2Q682XH.1GCPYWMFZ8B6J@kernel.org>
	 <D1KJBXOPFWT7.1F14BWQJO29FC@kernel.org>
	 <ddbeb8111f48a8ddb0b8fca248dff6cc9d7079b2.camel@HansenPartnership.com>
	 <D1KOUVENRY80.2NXQW3P1K6Z2R@kernel.org>
	 <6e326fa73968839199378694d4e7cc2544326fa6.camel@HansenPartnership.com>
	 <D1KT71LIUIPC.33KKNF1H2SX94@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-28 at 02:17 +0300, Jarkko Sakkinen wrote:
> On Tue May 28, 2024 at 12:36 AM EEST, James Bottomley wrote:
> > On Mon, 2024-05-27 at 22:53 +0300, Jarkko Sakkinen wrote:
> > > On Mon May 27, 2024 at 8:57 PM EEST, James Bottomley wrote:
> > > > On Mon, 2024-05-27 at 18:34 +0300, Jarkko Sakkinen wrote:
> > [...]
> > > > > While looking at code I started to wanted what was the
> > > > > reasoning for adding *undocumented* "TPM2_OA_TMPL" in
> > > > > include/linux/tpm.h.It should really be in tpm2-sessions.c
> > > > > and named something like TPM2_NULL_KEY_OA or similar.
> > > > 
> > > > Well, because you asked for it. I originally had all the flags
> > > > spelled out and I'm not a fan of this obscurity, but you have
> > > > to do stuff like this to get patches accepted:
> > > > 
> > > > https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero/
> > > 
> > > I still think the constant does make sense.
> > 
> > I'm not so sure.  The TCG simply defines it as a collection of
> > flags and every TPM tool set I've seen simply uses a list of flags
> > as well.  The original design was that the template would be in
> > this one place and everything else would call into it.  I think the
> > reason all template construction looks similar is for ease of
> > auditing (it's easy to get things, particularly the flags, wrong).
> > 
> > If it only has one use case, it should be spelled out but if
> > someone else would use it then it should be in the tpm.h shared
> > header.
> 
> It is used only in tpm2-sessions.c and for the null key so there it
> should be. And it is also lacking the associated documentation. Now
> both name and context it is used is lost.

The comment above the whole thing says what it is and where it comes
from:

	/*
	 * create the template.  Note: in order for userspace to
	 * verify the security of the system, it will have to create
	 * and certify this NULL primary, meaning all the template
	 * parameters will have to be identical, so conform exactly to
	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
	 * key H template (H has zero size unique points)
	 */

If we put the broken out flags back it's all fully documented.

James


