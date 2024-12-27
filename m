Return-Path: <linux-integrity+bounces-4481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F299FD06C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 06:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F0A16392C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7C12C54B;
	Fri, 27 Dec 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMtRxksG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5D1876;
	Fri, 27 Dec 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735277094; cv=none; b=ovvLOLpQtf3HSvjqmPgFzlq3VkM+1KjQVsWppK4fltLQOSHrG9TIZyqJCXcJbPt2vvcwMcFI1tQf4cl24TyLbLAcUENs5NMMFu4A510lDKoWe5ry8ycFTxII1XVk4uBEP/wpGt3NRgkF/YNsZIxWhNqCsQXs0WFLBXSmd88czTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735277094; c=relaxed/simple;
	bh=Rhyo8S3MqMjjyZc5T8sMlSixsmwlvuXdfg7Q2MEV0xE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MN7z8KjUoafGTCaGVRuJFVo6GP2mVjl0Yj/+3v7KpWNjmovmVBzuuGaZGZ+MHQiLlf+EK4394YisyWl3m9FVTtLUhPR0Md6sQ3J7TeWN8sPU4Qk2aOTmx48GdHL2RvkssBcwWplZlKIUJR7dBnFM80860uGWQ90gBMcCeNH+ReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMtRxksG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45BDC4CED0;
	Fri, 27 Dec 2024 05:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735277094;
	bh=Rhyo8S3MqMjjyZc5T8sMlSixsmwlvuXdfg7Q2MEV0xE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JMtRxksGzAXEfqmj4givykGncR6dInIsWgbfu3QDAKEdVe60ssDmNRTse6Kz5ph22
	 DiuKX++gnlw28SW71cXOwvYaLFgpnL5eyEXgaavUvPSLcVERw+ncibV0UOwUc1DM2i
	 yAR61Ryz9zpQKkyGpc66hYYU99omGONP8fAFZ+BLlBWXQP5eRdOMGH8++pR3fEU95+
	 gKCWTd9GFcDV8toBjDDM4/B+ipW+tPCuG8n02963sMB5rC9uOF3SRzq/ceUAHjwKrj
	 JMm9RB5lMQD3L7s4s/b2khLTguh/H5s55yS9qKNqLQs3NSJ+5YS6vPPB3Z2pC0U7Sp
	 rXuWsR7G9KoMg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 07:24:49 +0200
Message-Id: <D6M8E1PL27QI.21DRRGR1MN8KR@kernel.org>
Cc: "Conor Dooley" <conor+dt@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lukas Wunner"
 <lukas@wunner.de>, "Peter Huewe" <peterhuewe@gmx.de>, "Rob Herring"
 <robh@kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Marek Vasut" <marex@denx.de>, <devicetree@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241226171124.83735-1-marex@denx.de>
 <D6LW9OLX0RGQ.1N4FRX7R7ZYS6@kernel.org>
 <38ac27d2-6c79-452c-8f8d-d55f05519d05@denx.de>
In-Reply-To: <38ac27d2-6c79-452c-8f8d-d55f05519d05@denx.de>

On Thu Dec 26, 2024 at 10:29 PM EET, Marek Vasut wrote:
> On 12/26/24 8:54 PM, Jarkko Sakkinen wrote:
> > On Thu Dec 26, 2024 at 7:10 PM EET, Marek Vasut wrote:
> >> Add the ST chip st33tphf2ei2c to the supported compatible strings of t=
he
> >> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
> >                            ~~~~
> > 			  chip
>
> Fixed, thanks.
>
> >> Profile specification.
> >>
> >> For reference, a databrief is available at:
> >> https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
> >=20
> > Or just this would be enough:
> >=20
> > Link: https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
> I don't think Link: tag should be used for datasheets and other such=20
> stuff, my understanding of the Link: tag is that it is used to point to=
=20
> the patch at lore.k.o once applied ?

Oh, you are right and I did not know this :-) I've never read this page
before (ever) because I did not know it was necessary:

https://www.kernel.org/doc/html/latest/maintainer/configure-git.html

So I've used up until today link-tag for links... I just thought that
"well, I have Git configured"...

BR, Jarkko

