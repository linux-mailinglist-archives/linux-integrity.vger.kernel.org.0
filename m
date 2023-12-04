Return-Path: <linux-integrity+bounces-330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4674802A5F
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E891280C5C
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849471C2F;
	Mon,  4 Dec 2023 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqWUdAgh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680841C06
	for <linux-integrity@vger.kernel.org>; Mon,  4 Dec 2023 02:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE94C433C7;
	Mon,  4 Dec 2023 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701657630;
	bh=+1h7orpNR6s8aU7j2WouWuvwhoBP56nu407wmiCjx6o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sqWUdAghbTGgJmbgMKCZNEYQLXSRx8zdfcx1nDdIJqXu+okcOeYaOIg/8c30Q6Kjv
	 upHpZS/ldRcH3EASHRlREI3D4FKPti1iHTYJsYcBbGj7XRSHMDNaYYai9laZbyds7s
	 t2cxOLLWckmgK/D7yFCHaVeR1dMsExdzTyg5+TPgPVbbq1oBH0z7Oi9CjlsAOyDCYt
	 qHIKdpX5M4SrCvntX1kV3zkdHREgQclWKGvdGIgYsxfwTRnaL2V9MS32TfVaofsIa1
	 3z+TeriMuScbayosVDhERIhhVn+2zWATcGcjKb1eOyvPVmZ4VOjeI23S+zCIGid4yk
	 11SnCC11JKZsg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Dec 2023 04:40:24 +0200
Message-Id: <CXF7A8PSEKNX.SM7LV367AYHW@suppilovahvero>
Subject: Re: [PATCH v6 4/8] tpm: Update struct tpm_buf documentation
 comments
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Jerry Snitselaar"
 <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231124020237.27116-1-jarkko@kernel.org>
 <20231124020237.27116-5-jarkko@kernel.org>
 <ba84a7c1-f397-45f3-b76c-7faed89a005d@linux.ibm.com>
In-Reply-To: <ba84a7c1-f397-45f3-b76c-7faed89a005d@linux.ibm.com>

On Mon Nov 27, 2023 at 10:41 PM EET, Stefan Berger wrote:
>
>
> On 11/23/23 21:02, Jarkko Sakkinen wrote:
> > Remove deprecated portions and document enum values.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v1 [2023-11-21]: A new patch.
> > v2 [2023-11-24]: Refined the commit message a bit.
> > ---
> >   include/linux/tpm.h | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index bb0e8718a432..0a8c1351adc2 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -297,15 +297,14 @@ struct tpm_header {
> >   	};
> >   } __packed;
> >  =20
> > -/* A string buffer type for constructing TPM commands. This is based o=
n the
> > - * ideas of string buffer code in security/keys/trusted.h but is heap =
based
> > - * in order to keep the stack usage minimal.
> > - */
> > -
> >   enum tpm_buf_flags {
> > +	/* the capacity exceeded: */
>
> was exceeded

+1, agreed a better form :-)

>
> >   	TPM_BUF_OVERFLOW	=3D BIT(0),
> >   };
> >  =20
> > +/*
> > + * A string buffer type for constructing TPM commands.
> > + */
> >   struct tpm_buf {
> >   	unsigned int flags;
> >   	u8 *data;
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

If possible give this to the James' patch set, thank you for the review.

BR, Jarkko

