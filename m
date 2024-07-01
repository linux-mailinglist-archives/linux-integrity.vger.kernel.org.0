Return-Path: <linux-integrity+bounces-2950-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABBE91E3E4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0365A28306D
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2D16D329;
	Mon,  1 Jul 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUJIo/e+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAA16C86C
	for <linux-integrity@vger.kernel.org>; Mon,  1 Jul 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847126; cv=none; b=rYj5M6gqRGOZov+fBhvTFdTy/svZn/23wLiOHwv31CLlPvZ9RlKPAEOR+Nj6V1nI0ItrC7XH5t6ggOp7Cr1jE89hKvcIxMonvspExcjmKjy9NBJuuY906Ay20ey9rkGGaQGnoo89Sb9lgl/w5TA7ZPOYwEAHSqLuhrNpXLTZcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847126; c=relaxed/simple;
	bh=VMNm8rdTKT/ub8jFFxhA3Q0Ie3R4vB3kC8Qr2h8AHKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/77gyXBzkC+DfI+uyBlNIfrtaPerlQk8oOcdge0258q29QhXw6NUWYlSrQEP2MaLies5FGEV5eNIcRR72KnJy3b96ctNIX3aVGeRSDop5tD+AOtqwmb6sr6qSq/Z1AQzDn1kQXbbw8RIDEyIU7RBuuUn8mPrVBuI9OS4tkjwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUJIo/e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E509C116B1;
	Mon,  1 Jul 2024 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847125;
	bh=VMNm8rdTKT/ub8jFFxhA3Q0Ie3R4vB3kC8Qr2h8AHKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pUJIo/e+spxQmrn7aSKnUIGdcZgrMNsx5euMJfBS9EKRC6xmO8BImW4mqHu/d6Y46
	 vDdpEw6zaCR2qlieQUCXcN+Ks4WnWyoHze1P/aJdIGFFtOpUO/YtndFSTQujpk0Hza
	 WE+QK6pvMOiZYM7xsGMDoeavm3qzcCUFB3R4Z9BDXd8uECL3dz7xuorggGzhRFTS45
	 EWiBH9+6bWFbDib+MuXXKsCRFfmwOgU4Nal3B3APkOZJlD7eXl0xqFHh0oeveRF6HU
	 96aypLI42cj0MXdqCmYO0AJ5h6rJQ8KXsJC3uR3DAXNyIx4PBqYmePkwPfzeU0WnlR
	 OkY0JcUc8OFiQ==
Message-ID: <8cdc20bb0f3affac70ce84ad7a50f7867d62da64.camel@kernel.org>
Subject: Re: [PATCH v2] char: tpm: Fix possible memory leak in
 tpm_bios_measurements_open()
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, peterhuewe@gmx.de
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Date: Mon, 01 Jul 2024 15:18:42 +0000
In-Reply-To: <20240627063109.1239467-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20240627063109.1239467-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 15:31 +0900, Joe Hattori wrote:
> In tpm_bios_measurements_open(), get_device() is called on the device
> embedded in struct tpm_chip. In the error path, however, put_device() is
> not called. This results in a reference count leak, which prevents the
> device from being properly released. This commit makes sure to call
> put_device() when the seq_open() call fails.
>=20
> Fixes: 9b01b5356629 ("tpm: Move shared eventlog functions to common.c")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes since v1:
> - Keep the code diff minimal.
> - Fix the commit message.
> - Add a Fixes tag.
> ---
> =C2=A0drivers/char/tpm/eventlog/common.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventl=
og/common.c
> index 639c3f395a5a..4c0bbba64ee5 100644
> --- a/drivers/char/tpm/eventlog/common.c
> +++ b/drivers/char/tpm/eventlog/common.c
> @@ -47,6 +47,8 @@ static int tpm_bios_measurements_open(struct inode *ino=
de,
> =C2=A0	if (!err) {
> =C2=A0		seq =3D file->private_data;
> =C2=A0		seq->private =3D chip;
> +	} else {
> +		put_device(&chip->dev);
> =C2=A0	}
> =C2=A0
> =C2=A0	return err;

Thank you. I applied this.

BR, Jarkko

