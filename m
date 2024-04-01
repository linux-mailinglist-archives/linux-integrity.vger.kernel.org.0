Return-Path: <linux-integrity+bounces-1954-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0400E89464F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856BB1F21A53
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 20:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DB5027F;
	Mon,  1 Apr 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDOtkHcr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03042A1BF;
	Mon,  1 Apr 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004872; cv=none; b=ZQtF/v1+6BY2CmCotPMksutGXrBT39i1c9jpfN66VlJ+wx+fcKg20zgV1Xxs5eQkQqbCRN6BFzMjRcsGB5rNjVGKETYOAURMOUTDpSMqGRl8R+3u4Nq9q6wes412WMLYw4wifOL+p6hOqftxeU73COJKeEqT32Wx54FUBtCP+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004872; c=relaxed/simple;
	bh=EyB1g6IKl8JgLkjMLncb8BAezV6qbW4pHoIkmfLikSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OgZ3+NRtJN3WOx95bPQeGaY3zlwUWMOrr5sCTjwHFaAffdFeYOl7/qZzbp5IYvYqCq7Mx1Kc6XS+6pp6fO01I9q9372M+DrbJhkuhfFFefci6YjpIF2nTSZQJVwaCigMe4rTwez6kMVOJfp160xovPD+yRhfpswG9mI7odHdF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDOtkHcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D72C433C7;
	Mon,  1 Apr 2024 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712004872;
	bh=EyB1g6IKl8JgLkjMLncb8BAezV6qbW4pHoIkmfLikSM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HDOtkHcrLsyKJiLycC7iUU7rQRSvTRg5gYWJ9Kfl6PXlBoNEhIoV96HdSYCUKuF/R
	 LarshEMbw3EWUNoMtpS2gBvIeE1OJ1HXUw9AS1crLIWbC+nnPbJ8WlMSB8WQzXYEe4
	 J0sOXmVA6oBUvZ2PxhUmgMGE8WsCcCFDYZafD5iznk06yq9T4sRNOZRpy8zCIvWJX4
	 6QXG62soC5DxJJ7XRFJmQmkigBGEeXU5KWkIuS7WkS6lGxgOGW0sjoYzGTT0SWiZAI
	 yl+sS6T+vyGqIAvYh+UKNG2jnU14h5YnF069XDxOU/QPXEiWM5zJo+/Fjoc37H34bN
	 AOB3QJn4tZ13A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 23:54:28 +0300
Message-Id: <D0932R78GETC.BN1J006Y9WAD@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <ad409aa8834c37d7bfe2666e03520dd777afd288.camel@HansenPartnership.com>
 <b60d9761e6afdb483c35949eb4184330f42b9dcc.camel@HansenPartnership.com>
In-Reply-To: <b60d9761e6afdb483c35949eb4184330f42b9dcc.camel@HansenPartnership.com>

On Mon Apr 1, 2024 at 7:55 PM EEST, James Bottomley wrote:
> On Mon, 2024-04-01 at 10:19 -0400, James Bottomley wrote:
> > So I'm not really sure how to solve this.=C2=A0 At the moment the kerne=
l
> > doesn't use permanent handles for keys, but it should and it should
> > follow what all of the industry is doing for interoperability (i.e.
> > zero size points), which means the NULL primary should also follow
> > it.
>
> Actually, it turns out this is already solved by the TCG.  The template
> we're using is the correct one (zero size points).  Apparently they
> regretted their earlier decision to zero fill and issued this guidance:
>
>    2.2.1.2.2 EK Template
>   =20
>    An EK Template is stored in an NV Index as a TPMT_PUBLIC structure
>    marshaled as described in the TPM 2.0 Library Specification [1]. The
>    default EK Templates are defined in annex B. The EK Template NV Index
>    MUST be Populated if non-default values are used. It SHOULD be Absent
>    if default values are used.
>   =20
>    The EK Template unique field buffer size(s) SHOULD be zero.
>   =20
> But since they can't revoke the previous guidance, we now have two
> templates defined: the L one which has the old n bytes of zeros and the
> new (and recommended) H one which has zero size unique field.
>
> https://trustedcomputinggroup.org/resource/http-trustedcomputinggroup-org=
-wp-content-uploads-tcg-ek-credential-profile-v-2-5-r2_published-pdf/
>
> So in other words, we're doing the later correct thing and there's no
> problem.  I'll update the ASN.1 draft
>
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html

First time I'm seeing this document or URL.

>
> to state that we MUST use the H template to remove any ambiguity
>
> James

BR, Jarkko

