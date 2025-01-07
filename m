Return-Path: <linux-integrity+bounces-4529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E966A049D6
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8B71887FD7
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5231B412A;
	Tue,  7 Jan 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uveJsk6I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236A2594BF;
	Tue,  7 Jan 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276731; cv=none; b=usZNYpNLErW3KjIkl7CPZcihV+rtCzEF6l9uUJRL8wWijudA5A51hwYaFIvZemfAI1SQMHilpW2l/d+Kdb7Wq7edb+adP3F6Pn6kDk/fKZKawZXTrDIJCcZ8rfUelO233CaAU6RjVZfuI16EQB5DB2ODGx5kdkLRpXru1PyUb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276731; c=relaxed/simple;
	bh=j+oXqJx5eLcqaXhILfxvzIn+piN48Cdqimv2PLRjz9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=txAbN/rJ7wxLyDOp+8YlXRtj6vJlXxEfLy5O9fsiZj3J/AE5OMZRVrFJ/lGvR7RXYHSuE3Rf6u/NkGDIKxWxi0zIziuuLxjPqUCUVrJYrRSOKSYriu5gnU6lp6VaDiJibyIOfrw/TKfuIh7gH7+ABq1Z3zInIGFnQ/NTKmZ1T6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uveJsk6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C0DC4CED6;
	Tue,  7 Jan 2025 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736276730;
	bh=j+oXqJx5eLcqaXhILfxvzIn+piN48Cdqimv2PLRjz9M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uveJsk6IyEzFp6F/+63iLj9uRWU5JNf15TkwU31K5Nspo0VXmJYD2vmIBN9O37B6Y
	 VwxGdtkew/29hlzKIooVOZ82Ub95+OuBoiIqqtS2c/iLeGVmMCZ0A5D5LBcvUbYOMl
	 RV/wVe749aQtiJh1XxuA1T27W/CcfOb8XEu2uNh2hhgekHvZYgyewEyf9Bq6wKhUAD
	 jHz/X7zt3I0HflZDpsSWdD3qpYYVclnw/dkyekhQOpHLpcrs2FmwaW5J4As1ZF+K03
	 Cm8g1gf1/BUxVk21By/tX34844UpVO2LpGXWB+rNGIa1chUqB2pabdl7jo/MwUU7W0
	 CuUtdlOp1mwog==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jan 2025 21:05:25 +0200
Message-Id: <D6W2QCDWF7DN.UN4NFTJ0ESS5@kernel.org>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: dcp: fix improper sg use with
 CONFIG_VMAP_STACK=y
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley" <jejb@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.18.2
References: <20241113212754.12758-1-david@sigma-star.at>
 <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>
In-Reply-To: <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>

On Tue Jan 7, 2025 at 2:56 PM EET, David Gstir wrote:
>
> > On 13.11.2024, at 22:27, David Gstir <david@sigma-star.at> wrote:
> >=20
> > With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=3Dy) DCP truste=
d
> > keys can crash during en- and decryption of the blob encryption key via
> > the DCP crypto driver. This is caused by improperly using sg_init_one()
> > with vmalloc'd stack buffers (plain_key_blob).
> >=20
> > Fix this by always using kmalloc() for buffers we give to the DCP crypt=
o
> > driver.
> >=20
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption k=
ey")
> > Signed-off-by: David Gstir <david@sigma-star.at>
>
> gentle ping.

It's done, thanks for reminding, and don't hesitate to do it earlier
if this ever happens again.

>
> Thanks!
> - David

BR, Jarkko

