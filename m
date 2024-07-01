Return-Path: <linux-integrity+bounces-2958-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78091E662
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A211F245B2
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F916CD1D;
	Mon,  1 Jul 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LoPP4ARM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B31EB2B;
	Mon,  1 Jul 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854195; cv=pass; b=sfzxt7yVy3lspi3FOu0MwNe7QUCRBFFjCjXjeLu5ajSVo2LzNnjr4xywtuHT3Z5BdHTI5NJ2WljOvtkntGf7oOk3R8PkErm0Btndn1rMLXCOfflGYr0Qtj5nrR4u0AOP8od4iwtNiAPJHsrmV+7wvivSP/vmEVHvzCi8xIRFGhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854195; c=relaxed/simple;
	bh=kLCG/Qv6AZ3PdQ+Sh7rpPbMHueokQ2fFIrduBi9CAw0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p4TU01vinY0GnDd8xeC8M1hz8C7tNrr6bM9sN7efILAKXv06XzgvWBOs4bhybwL7tydZUzljKhtvhC0SxzKw8fKKQKIw6JD3Xl9Zc5L+OpeMbIJJ9BUhJTRRoQXkdoiBlx3iz23cjhgvHdoQHVF9SUakCbKMHhHcKkiiHaT+eL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LoPP4ARM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WCXkw1f7lz49PvR;
	Mon,  1 Jul 2024 20:16:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719854184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=engAyJr/L13OdkurE10ZMaUzcfCNHcDUUv4GYMtx5tU=;
	b=LoPP4ARMgEq7MWyXylinOBj89KnKiYnkZHFcAAIKXrJ4Wq1Tfr9vdCV3UyfFR8HYLVlZNP
	YWExjgpG71ovUUZ9UgYvlkVm1j2lUhx4k3y1Z/PYTOnERRwgj7fiZBB7z7SFXrIg/eCHe1
	S+kzrEGmMMH7zopiJ5GZ+uYiWO5m6fgxUJNlWfhkdjWuBMlBhLBYX9R/vJTOy1+Zr0rkEg
	+ZpWcP6RAK8Jqs5SmuxrW1KMz1BUowzEy+hJiF7NVZVxwCM/Ub+qkAcH466jA5JiX/rwhe
	tuPt2361FStZ39GNttUjNdlh5md17guIR/5VYg6IZxZHp6rJ/QNPfe4vYdOxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719854184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=engAyJr/L13OdkurE10ZMaUzcfCNHcDUUv4GYMtx5tU=;
	b=bYMjwkGdaOfty3yTzipUMlUgInMgBphD6exeXlw1GmrORbSlJQ8yF7LVLtote3Gf7VJhYm
	ie8iJUX7UCt8q6rDZla5E+ve3dB/WmV7AdOfCkV5VGVE1IGQCo/MnYu3mefRZVcQsYDnkh
	JcOCmvz0U9gR18GbIak5NcjzF7L8UA6Xp0LQDk6pKlakULvIflHUw8q+XGObFhhtYN3NGl
	vzRvC3loceOrT0Y9v8IRbH5uReFWdGb/w8rzjYCbT0YIbC4YpS5wfIP3B2Tf4MCAPfQhTu
	FNVlQywJSb4/Cv28w0SueXYefJyEoTcqfaCaO5rAbS++bwd+GhvMqd8rnUCPmw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719854184; a=rsa-sha256;
	cv=none;
	b=dYMLmaScpJblHlphNos05yIlywqJATjS92hh83txXjRCgXUvg9IjTgw0D+FW0PDkM/V2uU
	lvWGFnbKuaNxyn5MdO7Ryi83cPD0abRitPv2pdYaaiO5tJLRLIrQRIm94g9p6ITH9cBwcE
	M84+KgKeHyQwazYgZm1kW1udiT9A4Y0klhOUqoeXvTATHeUmRkm86fL99LJbx74PmFBltx
	dSTVd4b9hVwFq0ghOUBiJmE7bytrr8mZkWhtoPboRSJ3ne+4x+8T0yxRUKaBJRNvsDUrlU
	ZVPV46rE0MEFavaQsZFYvhtO9318F5asieFV30G0ea97iR6Jxw2O5CGLNkSdqA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 17:16:23 +0000
Message-Id: <D2EDFCP44XUT.3S3KNTQK1W4XG@iki.fi>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jarkko Sakkinen"
 <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
 <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>
In-Reply-To: <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>

On Mon Jul 1, 2024 at 4:35 PM UTC, Linus Torvalds wrote:
> On Mon, 1 Jul 2024 at 08:51, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Contains couple of bug fixes.
>
> This - and your keys pull - say 6.11-rc1 (and say "next"), but don't
> really look like the usual merge window stuff.

No new features are coming for this release. I had one in progress but
decided to let it mature up until 6.12 [1]. I have one known bug fix
upcoming [2], which I'll send after I've received feedback from Stefan
Berger [3].

The second reason for postponing features is that deploying encrypted
bus is a substantial infrastructural change so it is better to have
bandwidth to fix any possible issues when it ends up to production
kernels.

So yeah, not a usual pull request, but it is still planned unusual one...

>
> Just checking.
>
>             Linus

[1] https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@k=
ernel.org/T/#t
[2] https://lore.kernel.org/linux-integrity/20240701170735.109583-1-jarkko@=
kernel.org/T/#u
[3] https://lore.kernel.org/linux-integrity/9f86a167074d9b522311715c567f1c1=
9b88e3ad4.camel@kernel.org/=20

BR, Jarkko

