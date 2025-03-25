Return-Path: <linux-integrity+bounces-5419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59512A70773
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3E5168075
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E425EF9B;
	Tue, 25 Mar 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLito5fT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83E25DB17
	for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921829; cv=none; b=hu7MCl7t9b9E0UGksTu6x/KzgMNEvvemKa55wYc4WzEehlMZoVJcUBHQ+WEKY3DMRopfDZPdWTsEMwUDykGVZJNkqVhe58dwm+A3BmeifkNhDl9q++yS5sChklgsByEhNEYZvNNOS3EH/mLEwRelOe0kRqmo8HoxXPkg59Gm4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921829; c=relaxed/simple;
	bh=DHhaVcWokcmNeyMpAa/XPyVDS1B8ctys936Gog/i6Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhW2MUfDlHETqRpsBZZ5Qvr/iOcMpGMqcJnESkK9VMredQ+b9UfPAq4zblzjbPvADLbH/0JPa66IV5OaYCHjvGfi+bJ9pF0V3zGZKOJnkdakevXEs4gCACklqbSrWcVYwchFKB0a+ZDBQ8dX53KOKIAFEVFfFmP2Nb8rR2s5neE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLito5fT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac3b12e8518so76160266b.0
        for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742921825; x=1743526625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHR6o7AHPoVcL3mifFoOecu+bkyOlN7e6JWMVln9ejU=;
        b=nLito5fTa8Ez+U2us3n+/Pw4/SnLEo6UZRRzoF5onjwviZJt8WNJq4yQZTbHtOEDmk
         bDHoQB0VoOzo8NpFtYr3b2XI3fudcDcRLKSpcW+jji24fNyxA8R2qkbltYMtTgoeGCE/
         N7b3UFVfGh/13utTfComqUHEoK3MgBiJf0P42Sl+Q93v8j9/xdXPuOYP61s9B9dEG1Hl
         2Q4GmgwVSZGYlB+fmocrNzcSBuW/hLdvVzV9vUEZT67L1SHmgJW4C+6wHpzS6nrikx78
         NSSjbrPkQ2OqhlPmwMYo071OUOt5Omfau/3BXTZqRQHRE6y+MTTHKOGncQJYw+ZUdY91
         gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921825; x=1743526625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHR6o7AHPoVcL3mifFoOecu+bkyOlN7e6JWMVln9ejU=;
        b=MGUgJcstinVgX+OYmPCTPG869parXkN4KiK3x2h6RuWWxHrLbwlUUgG+2b3u7kHoOr
         9c8EsOXr0HRURjR+77GS6wWxANRTo9/dlTwTVHVNJ9YYcQ6DK5kjAT6DI/FPVnKYbjhC
         FZGzfz4c3a8jRyu6kW6v0+4IJaldELv/m+eaXC/KMHkQTq287+UkKlR45HSGSv833sjU
         2+Ptja/p5prl52agIN3XsIbSiAkAj6kL/93POVJ9+RwQqQFsX7hNXk5PQrTWr1QRJV1H
         5QpZWxWEpHvMoHFGKzGhrMQji7Rm0kUzTaPpLP3ym6Es+IWgLqxwM1aqKm8gZ1yPU4Uf
         vMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3u/InvgyHpWIPM+wOk7bubSWzLo/Jp5SPzuQpMkItekI5af06WScrRz0wCSu8Ggyc2Ai86QeiFdXZ3T3wmuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrHY6lFC4vtv8RkCT/tWuLIwBG66PauSX7lRgjUEmumCdtkpL
	yQbvMhbAMKrGqorfPFr6zK4t9y4MOnntPdYNgqUp5IEmkZQyNdMsfso/HHqGKTS3h4YBRM5Glre
	p4FVPd6Ec4lK0ILkxhZwu7LRtlF0l7D6FXQcO
X-Gm-Gg: ASbGnctv9Fzj3sTyMQkX7DJpTZGpawAZNHfGsBIMoeczBREqrvi0weOKTFHrMnjRsp9
	phnlgEswmDaL1MDLod+nm+/STdZuo/9u3wzcx6DS6iOKwDKo7T1QxLrYIbhi5Ylu46dAGHx/atb
	V2p+fAGiVNxMmL9hBe6nnOkGU3
X-Google-Smtp-Source: AGHT+IHiunbDy64QKJ1rFHvrWPJFtkT3kS/DMJaMWqheAGqvq3asfLSavmh0zFHfePK2DFNi4vOT1uYNczRGYC1UgDA=
X-Received: by 2002:a17:907:720c:b0:ab7:1012:3ccb with SMTP id
 a640c23a62f3a-ac3f20d2423mr1450323266b.14.1742921825236; Tue, 25 Mar 2025
 09:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324104653.138663-1-sgarzare@redhat.com> <20250324104653.138663-2-sgarzare@redhat.com>
In-Reply-To: <20250324104653.138663-2-sgarzare@redhat.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 25 Mar 2025 09:56:53 -0700
X-Gm-Features: AQ5f1JpVbwWqpNDbKaceDrU7STOlxFC1ra_fhrwK0XiBE_U6_DZfkH_Wo5bMXgQ
Message-ID: <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command functions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-coco@lists.linux.dev, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:47=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> Add two new functions to probe and send commands to the SVSM vTPM.
> They leverage the two calls defined by the AMD SVSM specification [1]
> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
>
> Expose these functions to be used by other modules such as a tpm
> driver.
>
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
>
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - added Tom's R-b
> - added functions documentation [Jarkko]
> - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
> v3:
> - removed link to the spec because those URLs are unstable [Borislav]
> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>   in this one [Borislav]
> - slimmed down snp_svsm_vtpm_probe() [Borislav]
> - removed features check and any print related [Tom]
> ---
>  arch/x86/include/asm/sev.h |  7 +++++
>  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ba7999f66abe..09471d058ce5 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -384,6 +384,10 @@ struct svsm_call {
>  #define SVSM_ATTEST_SERVICES           0
>  #define SVSM_ATTEST_SINGLE_SERVICE     1
>
> +#define SVSM_VTPM_CALL(x)              ((2ULL << 32) | (x))
> +#define SVSM_VTPM_QUERY                        0
> +#define SVSM_VTPM_CMD                  1
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>
>  extern u8 snp_vmpl;
> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_=
req *req,
>                            struct snp_guest_request_ioctl *rio);
>
> +bool snp_svsm_vtpm_probe(void);
> +int snp_svsm_vtpm_send_command(u8 *buffer);
> +

These should be defined static inline with trivial definitions in the
#else case, yes?

>  void __init snp_secure_tsc_prepare(void);
>  void __init snp_secure_tsc_init(void);
>
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..034aab7e76d2 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2628,6 +2628,65 @@ static int snp_issue_guest_request(struct snp_gues=
t_req *req, struct snp_req_dat
>         return ret;
>  }
>
> +/**
> + * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
> + *
> + * This function checks that there is SVSM and that it supports at least
> + * TPM_SEND_COMMAND which is the only request we use so far.
> + *
> + * Return: true if the platform provides a vTPM SVSM device, false other=
wise.
> + */
> +bool snp_svsm_vtpm_probe(void)
> +{
> +       struct svsm_call call =3D {};
> +
> +       /* The vTPM device is available only if a SVSM is present */
> +       if (!snp_vmpl)
> +               return false;
> +
> +       call.caa =3D svsm_get_caa();
> +       call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> +
> +       if (svsm_perform_call_protocol(&call))
> +               return false;
> +
> +       /* Check platform commands contains TPM_SEND_COMMAND - platform c=
ommand 8 */
> +       return call.rcx_out & BIT_ULL(8);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> +
> +/**
> + * snp_svsm_vtpm_send_command() - execute a vTPM operation on SVSM
> + * @buffer: A buffer used to both send the command and receive the respo=
nse.
> + *
> + * This function executes a SVSM_VTPM_CMD call as defined by
> + * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Rev=
ision: 1.00
> + *
> + * All command request/response buffers have a common structure as speci=
fied by
> + * the following table:
> + *     Byte      Size       In/Out    Description
> + *     Offset    (Bytes)
> + *     0x000     4          In        Platform command
> + *                          Out       Platform command response size
> + *
> + * Each command can build upon this common request/response structure to=
 create
> + * a structure specific to the command.
> + * See include/linux/tpm_svsm.h for more details.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int snp_svsm_vtpm_send_command(u8 *buffer)
> +{
> +       struct svsm_call call =3D {};
> +
> +       call.caa =3D svsm_get_caa();
> +       call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +       call.rcx =3D __pa(buffer);
> +
> +       return svsm_perform_call_protocol(&call);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> +
>  static struct platform_device sev_guest_device =3D {
>         .name           =3D "sev-guest",
>         .id             =3D -1,
> --
> 2.49.0
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

