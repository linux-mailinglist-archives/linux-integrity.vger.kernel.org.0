Return-Path: <linux-integrity+bounces-3119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906799323CD
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CC51C20B9E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D031953A8;
	Tue, 16 Jul 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="L9cELZwG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A766AC0;
	Tue, 16 Jul 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125252; cv=pass; b=RmtX1fN9Wynx3I7/Vw8P8O4UiN1Ii1e0tpDxaKVLpGSPWvVw5ywzMRyv1Bonw0Cq/utD/v5COLt3tjLBkTI2Q/iCqm9hQ7FAdnxfXcxeM2ZJ3i4l5xZ7Tjk3WT/ZPigWLARGoRIPHwojuaZuyOEE9eVgZqiVJ0qyQ41AFQ/4MKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125252; c=relaxed/simple;
	bh=xkkChdmkRLKiZKGSsspElQIgwTeWZhu6tOmt+rhM/P4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZmP70kp/kVfmnKMBL/gxSVzHURXbFiRAhjip5Zx1NfUN2OCDM8aU/QqrQTsOYR2ADOc4aPlbD7wffZ3JguSgctKqfpdLMT6aq9rhr+Exypsb0X8IpIfe9lkZo9LXRnSYLCm6rdwJp+tvmMtG/q82TFTPremDgYcGJMSrnby1e9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=L9cELZwG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WNZpR06BbzyS4;
	Tue, 16 Jul 2024 13:20:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1721125247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkkChdmkRLKiZKGSsspElQIgwTeWZhu6tOmt+rhM/P4=;
	b=L9cELZwGq6Sfuy4gjPffNFMDYxvrcIqdB62UJuXnWnauvdBwbebDPTAE9AastBfQ3a3Qr0
	5EyaNYssBANt84GOIucl43Oh+yWDLkx4o57MX3UfqbQmEShG7Zw6+kmy9i7/lYRxnxh6tP
	RI5SpSYPrv6QXf3J9LvLFzz1pDmZ4hs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1721125247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkkChdmkRLKiZKGSsspElQIgwTeWZhu6tOmt+rhM/P4=;
	b=SC4gnkgZXIJPahSjb7Y0NX5osY+m9pOYWsJFUL7hixkwR5SaH3cKP65BIsfxhDskvwFP8f
	EGukVZOLlppr98b1VXkWWe8FwtePf5legdGeAB4cZVTVxIH52ILnBQx3MSS5P5QgmfSVJW
	BjeQ56Il5JlHtWuQbBxFFK7SknP736Q=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1721125247; a=rsa-sha256; cv=none;
	b=CLSLkaC/O+/eroBuPJGwOwmn2TxwfklI1ZgjXGbSDUaH4F6sGzcEVmmiUqXgIA2Y6zxC3F
	KLOj0un+4HgaEV1lAGqh57l9RjpwinZUyIvuju1oVn6c9ICVxhp7quQ/6Msp5cIVcJb5wx
	xRjOjpydn/oXEBLSdK25NrJ3ZZWLyZg=
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
Date: Tue, 16 Jul 2024 13:20:46 +0300
Message-Id: <D2QVZB1Y4DHT.2WFLXMCFYSISM@iki.fi>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Hao Ge" <hao.ge@linux.dev>, "Jarkko Sakkinen" <jarkko@kernel.org>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
 <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
 <593e3ae7-1f8c-218a-a5ce-3d90e3008999@linux.dev>
In-Reply-To: <593e3ae7-1f8c-218a-a5ce-3d90e3008999@linux.dev>

On Tue Jul 16, 2024 at 4:04 AM EEST, Hao Ge wrote:
> Hi Jarkko
>
> Have a nice day.
>
> On 7/15/24 19:25, Jarkko Sakkinen wrote:
> > On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> We shouldn't dereference "auth" until after we have checked that it is
> >> non-NULL.
> >>
> >> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_=
session*()")
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > Also lacking:
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d=
-de2fe4e13ec2@stanley.mountain/T/#u
>
> Regarding this version, I don't think I should add these.
>
> I send this patch on July 9th, 2024.
>
> The following email was sent on July 13th, 2024.
>
> https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2fe4e13=
ec2@stanley.mountain/T/#u
>
> I think these should be included in the subsequent versions (if any).

OK sorry, then you are right.

>
> >
> > What is happening here is that my commit exposed pre-existing bug to
> > static analysis but it did not introduce a new regression. I missed
> > from your patch how did you ended up to your conclusions.
> >
> > Please *do not* ignore the sources next time. Either explain how the bu=
g
> > was found or provide the reporting source. You are essentially taking
> > credit and also blame from the work that you did not accomplish
> > yourself, which is both wrong and dishonest.
> >
> > BR, Jarkko
>
> OK,got it,I'll pay more attention to such details in the future.
>
> I would like to clarify that I did not taking credit and dishonest.

OK, cool, and I do agree, and I'm sorry what I said.

Please just add the necessary details and send v2 then.

BRR, Jarkko

