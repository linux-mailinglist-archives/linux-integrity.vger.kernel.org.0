Return-Path: <linux-integrity+bounces-3241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C839437A6
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2024 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2048F1C21C65
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB01607B0;
	Wed, 31 Jul 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwLJ4Sfu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E291BC40;
	Wed, 31 Jul 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460695; cv=none; b=jX0kJIdSEFdcHpr5fLLSRmj/8jwbcl8yOL2ewVCx6u/kS9ae+HJDsxGm62WsuaIEt5991RZmsromBE2fnNKbQOvc3VEzo8J3P7XraJSC7RGOKXCgktg0kqp+BaklfxOE/WHiDobc7k1tfBANa5CBG7A/S9sbajotAIYvVl1AMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460695; c=relaxed/simple;
	bh=Iz5fv2WGX9mZwr+ta4iHBVQHKmHWtOfb0ViE/BWikcQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GCpQJVnGt6ZCZlnVTz5TmL/eZG9Fa/i2hQwjjvU195rPUaeiioZDyAXepZT/iuDNkKrjLgF7qx5vpfmsInbKlywzQPeZlHrBPpl2Z2tfF5tSYlchOECJ965E4vmB5Cr87Yz65quifCrkfw2qzuR6kK81MxneR3pzaxM9wjaJThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwLJ4Sfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70117C116B1;
	Wed, 31 Jul 2024 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722460695;
	bh=Iz5fv2WGX9mZwr+ta4iHBVQHKmHWtOfb0ViE/BWikcQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AwLJ4SfuaWViCPkLovq03bs+6GgDObgFFcwCS7PiyRpvLe/IqWgEDAhl9+CpN8uFK
	 5N/JGUJnBgWxzkjxivgZ+TE3+/0oMbdGwVSYdEuB5iGkJ7v0e94Jz1fogvCrywjKVx
	 JVPvIzZF5Cxpvbmc2+Er4Dy9tmS6Fh7P+xw5+RxLJjSqnkTtLgk+wZncvUB9u+z3Wb
	 2dWqleW3WTevbFWStJoywR/hx1eLJHwz8vbMVhnFFD5Rci2i3Br9iVrBMjLowPVorm
	 B3YxpwimHplu5BDyx6380bD6N9G8F+Oz06cuN/EgRQQjete97Ysv5LQDXQnzOffx4a
	 qFqzGyyVIOY7A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Aug 2024 00:18:11 +0300
Message-Id: <D341CTLTGMK0.1E7P9Z98WM6XT@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <mpe@ellerman.id.au>,
 <naveen.n.rao@linux.ibm.com>, <zohar@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: Call tpm2_sessions_init() to
 initialize session support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.18.0
References: <20240729132934.311136-1-stefanb@linux.ibm.com>
In-Reply-To: <20240729132934.311136-1-stefanb@linux.ibm.com>

On Mon Jul 29, 2024 at 4:29 PM EEST, Stefan Berger wrote:
> Commit d2add27cf2b8 ("tpm: Add NULL primary creation") introduced
> CONFIG_TCG_TPM2_HMAC. When this option is enabled on ppc64 then the
> following message appears in the kernel log due to a missing call to
> tpm2_sessions_init().
>
> [    2.654549] tpm tpm0: auth session is not active
>
> Add the missing call to tpm2_session_init() to the ibmvtpm driver to
> resolve this issue.
>
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtp=
m.c
> index d3989b257f42..1e5b107d1f3b 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev=
,
>  		rc =3D tpm2_get_cc_attrs_tbl(chip);
>  		if (rc)
>  			goto init_irq_cleanup;
> +
> +		rc =3D tpm2_sessions_init(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
>  	}
> =20
>  	return tpm_chip_register(chip);

Cannot get emails working with  my Linux machine given

https://bugzilla.redhat.com/show_bug.cgi?id=3D2302132

I'll try to sort this out first and then do a pull request.

BR, Jarkko

