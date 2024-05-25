Return-Path: <linux-integrity+bounces-2646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7388CEFB9
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2734B1C2092F
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5077A140;
	Sat, 25 May 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtdhsD21"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941661429E;
	Sat, 25 May 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716650148; cv=none; b=c8MZVi74P9VKe+kr1Sse76+VawtyL+5i0cMStXKvQ8mKPv2dANDk7WLxU9hUU9IZLYJtzyyQNsz7/x0pxHoMlMOlMLkK8IMfqY6yUd6dOfWXLiBasI6F3p1vv+hx12y5zIPtV2KlUdt4eFeyZsFvtf1By8oRfr6XO/0D8H5aRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716650148; c=relaxed/simple;
	bh=wa6xP9S3uLlfg3n05vhFPt+ult4CTmP8SbHN1IB6x8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KyD95gB5RCbXHB85BuOfwDBFCKWhDdeqYso2dpsGt9gH7j52ey2Fr9KVjWECY4y54EUjh/SxgmYKVK95urEirwLjGoRYn/lUS7n+kptEkIgef+pG4fUFsIHdPu99N+p2YcqIoC9qTYLNU0nl9G7s8PDDO5rj5yqrtt6ARqm1jUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtdhsD21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E0DC2BD11;
	Sat, 25 May 2024 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716650148;
	bh=wa6xP9S3uLlfg3n05vhFPt+ult4CTmP8SbHN1IB6x8k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EtdhsD21R6oyJ+uqt0hQcgFgh0snb4v+N6wSvwXT2XYlgYogoAL/13xwlDlzxDJag
	 LpH3cjRPZmTOpgBEmYl4pz4O+Nf+jyJ0fj+cVfIy8L5/MgWQwK4j99+mKrGw00Qu28
	 EN6pNZfN06ZXmKry8u67XOiHwUL5TtCf24E5LIQTYVcEYHHveRYlFbyVbyWkY9WiNh
	 Mt/lt56vD/IRJpQnhEs5iDLz9M7KRtUTidg3vj43D0I6G1ao1AkA5v3gFXq5+JSUrZ
	 fUn1c2MNp7rkVqciE5C+qucjVuDphhB8UGM1oqRAOy1m4xTtLLPHse+lrcGKOsiadI
	 Zsl3XjysNN09w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 May 2024 18:15:43 +0300
Message-Id: <D1ITOT1F26RK.S2V3FRMXPAPD@kernel.org>
Cc: <keyrings@vger.kernel.org>, <stable@vger.kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted_tpm2: Only check options->keyhandle for
 ASN.1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240525123634.3396-1-jarkko@kernel.org>
 <b1ac7ec116c871294d856185da44ae1e9fc02fe7.camel@HansenPartnership.com>
In-Reply-To: <b1ac7ec116c871294d856185da44ae1e9fc02fe7.camel@HansenPartnership.com>

On Sat May 25, 2024 at 4:42 PM EEST, James Bottomley wrote:
> On Sat, 2024-05-25 at 15:36 +0300, Jarkko Sakkinen wrote:
> > tpm2_load_cmd incorrectly checks options->keyhandle also for the
> > legacy format, as also implied by the inline comment. Check
> > options->keyhandle when ASN.1 is loaded.
>
> No that's not right.  keyhandle must be specified for the old format,
> because it's just the two private/public blobs and doesn't know it's
> parent. Since tpm2_key_decode() always places the ASN.1 parent into
> options->keyhandle, the proposed new code is fully redundant (options-
> >keyhandle must be non zero if the ASN.1 parsed correctly) but it loses
> the check that the loader must specify it for the old format.
>
> What the comment above the code you removed means is that the keyhandle
> must be non zero here, either extracted from the ASN.1 for the new
> format or specified on the command line for the old.

My code change was plain direct to the word interpreation of the
comment.

So I just take the last paragraph of yours and instead fix the
misleading comment:

/*
 * Keyhandle must be non zero here, either extracted from the ASN.1 for
 * the new format or specified on the command line for the old.
 */

BR, Jarkko

