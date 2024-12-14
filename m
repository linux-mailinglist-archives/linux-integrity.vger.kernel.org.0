Return-Path: <linux-integrity+bounces-4393-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510F9F1C75
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Dec 2024 04:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AED2165C9C
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Dec 2024 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096017BA0;
	Sat, 14 Dec 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUnRPZ04"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FC10E9;
	Sat, 14 Dec 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148301; cv=none; b=r36sh1L6f/tDcYu1T1nQplYkBGOkLINA/qc7d8wangQllNemM7sfcuBjSZYHgNgETKC0bM2KIMFPEIo2TU0KSFMpWIqvNpvFzeE7k/g5vIsLdZJ8XypGCNrpFq9JdFXO9tOYLpoWZUp3A4T51SPd1tm2+j70U5Jgw5/q1PtEAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148301; c=relaxed/simple;
	bh=0pmaogiLIEikg2yJTULUG0Sx3vz2zGE3K9hqF0I2Yc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qd1C0xaVGyPBSYS3v6fOuAQrqDb2X7H/cdS+LU88bqJ2O3MDOO+12oqM9OgD93OKBaWrZhV/Kkv2J9zfBiyRoqZNbuU3yu6AGEQFLTy+V02QkSQEJGJESro7JhvC58azFHHi3PMXWvHF2a2AAt1Fo8a7TAp6XC4T3RvDFTqOnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUnRPZ04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72328C4CED1;
	Sat, 14 Dec 2024 03:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734148300;
	bh=0pmaogiLIEikg2yJTULUG0Sx3vz2zGE3K9hqF0I2Yc0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=kUnRPZ04Ym5w6eYz0dSr2jZjFV4KTbsaXzXRBKvZSkP6BTZ9mn1MaOTGUGgwsnBIi
	 rvrADzK67xJ4YcszoM2uxSvZD1MojOqmqibnXIWjFYYiMPoWbpcXe4p+8y166IvdyS
	 ppemb+Cxh99R9OWYgjSE7eTImqcjRP5YWe6/EC3Rz1kQ2vkCftz11eTp6LYEhZmlGf
	 QaRZ+5UcjnN2X8lNQDu57GiJgzVaMJUOR5Rb6FKzxbvLF1ekwEmMb+FJyc+DNtNnhs
	 Etl44xCYzJTWv3e1PqfvzQxIxLD1CxBdPdr0d5gGarL3gXSbL8gR7/Nt2ngfzaekIS
	 oJOWoVVzkoGvw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Dec 2024 05:51:36 +0200
Message-Id: <D6B49LBSZXN4.3V519030X0YCG@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>,
 "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] tpm/eventlog: Limit memory allocations for event logs
 with excessive size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241210222608.598424-1-stefanb@linux.ibm.com>
In-Reply-To: <20241210222608.598424-1-stefanb@linux.ibm.com>

On Wed Dec 11, 2024 at 12:26 AM EET, Stefan Berger wrote:
> The TPM2 ACPI BIOS eventlog of a particular machine indicates that the
> length of the log is 4MB, even though the actual length of its useful dat=
a,
> when dumped, are only 69kb. To avoid allocating excessive amounts of memo=
ry
> for the event log, limit the size of any eventlog to 128kb. This should b=
e
> sufficient memory and also not unnecessarily truncate event logs on any
> other machine.
>
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog=
/acpi.c
> index 69533d0bfb51..701fd7d4cc28 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -26,6 +26,8 @@
>  #include "../tpm.h"
>  #include "common.h"
> =20
> +#define MAX_TPM_LOG_LEN		(128 * 1024)

Instead, to common.h:

/*=20
 * Cap the log size to the given number of bytes. Applied to the TPM2
 * ACPI logs.
 */
#define TPM_MAX_LOG_SIZE (128 * 1024)

>
> +
>  struct acpi_tcpa {
>  	struct acpi_table_header hdr;
>  	u16 platform_class;
> @@ -135,6 +137,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  		return -EIO;
>  	}
> =20
> +	if (len > MAX_TPM_LOG_LEN) {
> +		dev_warn(&chip->dev, "Excessive TCPA log len %llu truncated to %u byte=
s\n",
> +			 len, MAX_TPM_LOG_LEN);
> +		len =3D MAX_TPM_LOG_LEN;
> +	}

First, you are changing also TPM1 code path. Also in the case of
TPM2 code path the log message is incorrect as TCPA does not exist.

Second, this does not make sense as the log ends up to be corrupted
(i.e. not complete).

Instead, in the TPM2 code path:

		start =3D tpm2_phy->log_area_start_address;
		if (!start || !len) {
			acpi_put_table((struct acpi_table_header *)tbl);
			return -ENODEV;
		}

		if (len > TPM_MAX_LOG_SIZE) {
			dev_warn(&chip->dev, "Excessive TPM2 log size of %llu bytes (> %u)\n",
				 len, MAX_TPM_LOG_LEN);
			log->bios_event_log =3D start;
			chip->flags |=3D TPM_CHIP_FLAG_TPM2_ACPI;
			return 0;
		}

This can then be used in tpm2.c to create a "slow path" in tpm2.c for
parsing TPM2 ACPI log directly by mapping IO memory.

BR, Jarkko

