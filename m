Return-Path: <linux-integrity+bounces-774-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1282CEDE
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96382828AD
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350F16435;
	Sat, 13 Jan 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKBlo2vb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD116426;
	Sat, 13 Jan 2024 21:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C153C433C7;
	Sat, 13 Jan 2024 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705182935;
	bh=QVi4awp+o3VBGJySTsyvHAV+yg1wZCWyTzuEQ6e0Uls=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CKBlo2vbCG1rhbl6d1kGpVev8puDysBKTEAeHe9nRTSbkZe5jinf48bg9jdMjNrIF
	 HBIbtUNpWYvfEXZvNDVGP3NN4ihgZ50bSy491Ag1ChrrYkHKHLO/TOFI+7M8K7ep9o
	 TxTYQs2zK4O5FMul3dm3dkbJffYdqcJmPN2W457TvOlJKAlVMTUK8L7g7rO5rSeAq1
	 x2UXAtq9JZ3KuwPOuWLt9k+aAxucuc+4t+N7A97Z5mTXa6VV3jOxNxkPkqc56+MrPa
	 i4qUfj9i1YV7sCAofSSMHLp/AmPAbb76/r3RG1mMJFD4I0UCXOXbdBB/48FBXDxwQt
	 rxtNYYtDG94tA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 23:55:32 +0200
Message-Id: <CYDWWGW2QW9K.FLB67MSI9YQR@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 4/4] tpm: tis_i2c: Add compatible string
 nuvoton,npct75x
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.16.0
References: <cover.1705140898.git.lukas@wunner.de>
 <6ec711056f5d87d8504f033a404ed14a2e449331.1705140898.git.lukas@wunner.de>
In-Reply-To: <6ec711056f5d87d8504f033a404ed14a2e449331.1705140898.git.lukas@wunner.de>

On Sat Jan 13, 2024 at 7:10 PM EET, Lukas Wunner wrote:
> Add "nuvoton,npct75x" as well as the fallback compatible string
> "tcg,tpm-tis-i2c" to the TPM TIS I=C2=B2C driver.  They're used by:
>
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
>
> And by all accounts, NPCT75x is supported by the driver:
>
>   https://lore.kernel.org/all/60e23fd0f0ff4d1f8954034237ae8865@NTILML02.n=
uvoton.com/
>   https://lore.kernel.org/all/20220808220839.1006341-8-peter@pjd.dev/
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index a897402..9511c0d 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -383,6 +383,8 @@ static void tpm_tis_i2c_remove(struct i2c_client *cli=
ent)
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] =3D {
>  	{ .compatible =3D "infineon,slb9673", },
> +	{ .compatible =3D "nuvoton,npct75x", },
> +	{ .compatible =3D "tcg,tpm-tis-i2c", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

