Return-Path: <linux-integrity+bounces-3158-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E285D933C3B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48125B210B1
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BD17F4E3;
	Wed, 17 Jul 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GY1DDEI4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E85BA4B;
	Wed, 17 Jul 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215574; cv=pass; b=a9gkcYt1v/6NDfn+6r4v3o/OSY3ojzi0LVeYXyEGPgqSS0zYBZBy6kh/NKtWwS2C5gIus4eKJNjUEAX38AGf0VpIYpC5lGgnNh+DAKo/ofADPn4ghA1NsOpDJ7Deh+OeUoIhxCDs3tKu1Q0Fi3zB7EY0mNfr+vNiaYxIaA+4C2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215574; c=relaxed/simple;
	bh=BgrFoB9w5SHmjr56pRK2AZvm2yWV9syg3VUiunxUTcM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NI1nr/cSNJNSoTogAR/FQ9ebjygdB/A+7nm/dkUb423TW5FTU+GbLvBxt3zTOycE1hUCX1XLlVpcjWBcoWPwyoYvFRbYtTG8jlA7IpZY96oXlDYjVZsgBOXQ205C8ijfcQu9ZcFXpehJ7K+pshXbOG468izq1/BYzwLuvdtzJMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GY1DDEI4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WPDCP3yGfzyTx;
	Wed, 17 Jul 2024 14:26:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1721215569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgrFoB9w5SHmjr56pRK2AZvm2yWV9syg3VUiunxUTcM=;
	b=GY1DDEI497h2F9sH4aB05l7dcb0hLJqUfwyxtQ0CXFOMzJVFwnL7RtjxWUmGDgiSDyP/x9
	9T4qKdHAB5c4oyWWHdSBeReImozmYgFnAvExc6mB16g9FLfA0s4X35rtRISqmkJmxzK1K3
	f4tPkbDKvORaKqsiDkXlGPT6pIAXJGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1721215569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgrFoB9w5SHmjr56pRK2AZvm2yWV9syg3VUiunxUTcM=;
	b=CvIFgZQIOLMEqHgsN3ZDxWC1UXc/Y48/rldlwRk5KoNDHlcioLP6GytitFju0QjHHy5STC
	xfAPWOpOni2NcffXca0LJSvio3eTARq2dQlCrxrLA1NK61v32xcx5enjxJDlj4PdROet0z
	vmChLfN5jdkyl5IlQJksWahUofn+SsY=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1721215569; a=rsa-sha256; cv=none;
	b=Luh3xaD24Y3TKQr0ezXyfG1O3lapMU88hc7zMNsoZ2QSPxGzH8fjrMu2zQ3woiz2axPzFu
	9sJvHqa5rsV1Ttx0g1P1lRCoVOmuglhxxkFg6Ylp6XBu3CBzB1r6XxT8hm+1bY/seqEUDK
	wF2u+OsRO8Z3JHZU4qHhpPy3G5LKSTc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 14:26:09 +0300
Message-Id: <D2RRZWLG2VS6.200QD0IS373W2@iki.fi>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "kernel test robot" <lkp@intel.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length
 assignment
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Richard Weinberger" <richard@sigma-star.at>, "David Gstir"
 <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Richard Weinberger" <richard@nod.at>,
 <upstream@sigma-star.at>
X-Mailer: aerc 0.17.0
References: <20240703125353.46115-1-david@sigma-star.at>
 <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org> <2351895.22IY78Rhhi@somecomputer>
In-Reply-To: <2351895.22IY78Rhhi@somecomputer>

On Wed Jul 17, 2024 at 1:19 PM EEST, Richard Weinberger wrote:
> Am Mittwoch, 17. Juli 2024, 12:07:58 CEST schrieb Jarkko Sakkinen:
> > On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> > > The DCP trusted key type uses the wrong helper function to store
> > > the blob's payload length which can lead to the wrong byte order
> > > being used in case this would ever run on big endian architectures.
> > >
> > > Fix by using correct helper function.
> > >
> > > Signed-off-by: David Gstir <david@sigma-star.at>
> > > Suggested-by: Richard Weinberger <richard@nod.at>
> >=20
> > You cannot suggest a change that you author yourself.
>
> Well, I suggested the change, not David.
> So, I think you're implying that David's s-o-b cannot be before
> the Suggested-by tag but after?

I have dyslexia, I actually read it incorrectly so thanks
for pointing this ;-)

So keeping the tag is fine just reorder the tags, and the fix
will be fine.

Don't expect fast response, I'm on holiday still this and next
week. Just shuffling through inbox weekly basis.

BR, Jarkko

