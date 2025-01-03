Return-Path: <linux-integrity+bounces-4510-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7EA009E0
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 14:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8ED3A3CC1
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26821F943A;
	Fri,  3 Jan 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+n5jMQx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFB1F9425
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jan 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910669; cv=none; b=ErBy5op5RCy8OCB2gFxskbGyNofR4r5c5ejPTzW8/mLCW5wYfHbnsa6nWU3zCEZbEsK2gk7CreFlT+7y1CC0opiG+g/GdIgbU2sQ9QRW2+uPmkzdFriVQrsHvLT8wO1xX2C/kbtWRF5H3/nnqhOpCGp9RP6SgtJtNtAuDQR0TX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910669; c=relaxed/simple;
	bh=G/mBDgS7K2kN6FLFpLRxXpPWce/6bAJGnYYverz4e58=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VEOPV4q6NxToQiWmhEm6ZLChX3fGtiKQdOlzJWP5S+fc+PjspDPArapvlvmAlWLKW0cqHQ7oxwgOBR2vD0HYWf4R4VrdaozgD8r4ZN+QpLl/IMiG0MjA9VhabCjVYJsFCnha9o0FR//iNPICq4i1TUzibp5U/x+BYVemtjkT/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+n5jMQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF814C4CECE;
	Fri,  3 Jan 2025 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735910666;
	bh=G/mBDgS7K2kN6FLFpLRxXpPWce/6bAJGnYYverz4e58=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=R+n5jMQxHfnsnCnde7QfMNJuUDr3sDzHKFdLZ0YXfoin7Yeh4jNvmEyRQIyIiTRW7
	 LG95PN/HZ53fnTlbywbcCac5fvVGQfmfQ42704VEjh+n/ep5MSCwbnSCHXe/StO0wm
	 oPtH5ljK1TbeB6PHo/Y2E575MQJmosboGdZ6IVebE1rGyHAjnzNYK+2M2nCPyQCcI3
	 5z9CA6oo4tyN/L29mS3d6m1eP6LRQHmiIa+QwLYq6P6sGVPIOC7QuIk5cWPfu+5jrS
	 aIEbtpOYpXBKsmRvGXj7XkxSE/pQdWErlBjoTOp0qOiHmIkY81PI0ROvT7c9FBCUzY
	 OwpczGmMU+1bg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jan 2025 15:24:21 +0200
Message-Id: <D6SGZ0MLUC5J.3FQOUC5KVKLV3@kernel.org>
Cc: "Petr Vorel" <pvorel@suse.cz>
Subject: Re: [PATCH] ima: ignore suffixed policy rule comments
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241230142333.1309623-1-zohar@linux.ibm.com>
In-Reply-To: <20241230142333.1309623-1-zohar@linux.ibm.com>

On Mon Dec 30, 2024 at 4:23 PM EET, Mimi Zohar wrote:
> Lines beginning with '#' in the IMA policy are comments and are ignored.
> Instead of placing the rule and comment on separate lines, allow the
> comment to be suffixed to the IMA policy rule.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 23bbe2c405f0..128fab897930 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1432,7 +1432,7 @@ static int ima_parse_rule(char *rule, struct ima_ru=
le_entry *entry)
>  		int token;
>  		unsigned long lnum;
> =20
> -		if (result < 0)
> +		if (result < 0 || *p =3D=3D '#')  /* ignore suffixed comment */
                                                 skip?

Not that relevant but skipping those lines is the actual action taken
in order to reach the state of ignorance ;-)

>  			break;
>  		if ((*p =3D=3D '\0') || (*p =3D=3D ' ') || (*p =3D=3D '\t'))
>  			continue;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

