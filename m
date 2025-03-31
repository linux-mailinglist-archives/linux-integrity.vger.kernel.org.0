Return-Path: <linux-integrity+bounces-5535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74DA770D8
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Apr 2025 00:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41033A713F
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 22:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91E21C9E4;
	Mon, 31 Mar 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUBxx51s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04521CA03
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743459802; cv=none; b=fwhXT/ZDU8ehnDBTHv9oCqBn/ErpulbIZqqJ8dmzjGr9Atu9GQwlg4qwwIvOvVXiQ/AhnhTTsHj8m6vbNHdjAhrtkVgDtDVCPASdTmSAQEp2AJdtxsnQzp41YBk8WdtpRuorwKiJI/RfFRaZ8vSfA0MTVL/dzieJ55H93sBpRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743459802; c=relaxed/simple;
	bh=4PgTmaMk5ogvFcIREugLBrsHV37djLsMSD7buWsbe98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPvPdTf4j4SEpE2WQGEGZSxLHgEAf1Aftpp/R5AQqQFda1arNE7Kyx8G/1u8OfedsRSlHFKF+G1b+LjIENED1MEG7ii4WQsnD7tS3g7Wg7v1Dcov5poHCkeNCq53dEivoaHTYhW7J3J0Lqdkg+WxGnSEg9uOCD5zAmqP/ZnSupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUBxx51s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so7411190a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743459798; x=1744064598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PgTmaMk5ogvFcIREugLBrsHV37djLsMSD7buWsbe98=;
        b=dUBxx51sYO8jjWrYYxpmQqh/UTVmB45bSyxrkhrmCLG1dfI5o/iki1sOkL/MzFDAnj
         MsCRfICv+uB/wNAAiJxG5MgNLypwJLG8ZSG/kVNLcXXMa0AUIr6LbGVR2TgR/5Vc22n5
         6QcwfntF8635wDFnIrIiDs3YgRcop45BiLP5JT747K7akcD7tEII5RBnKQUtGa5zVt9V
         EJKiftlggThP1pPo/zwkkJ4ox1nLgN9l7sNbZ6p0kEtnXUvmiq3MhDe+7Btxk4rp253H
         MJV+DEe+00YN7aYhtHDmc1XE3C8xIEu6loBzXkEtNUFfplEpRJYz30iMLFuAMtIAz1M9
         DL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743459798; x=1744064598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PgTmaMk5ogvFcIREugLBrsHV37djLsMSD7buWsbe98=;
        b=NxiAI7fE9pmzFG2iuLHjfWnDeqa0OGsxAirzXqcLRJ6ajL5FmTSy40O7ssKtbrXqbY
         TOsAzSbEaARA8C4XGjE1y6NVwPuS6n1OF886B4KdoevltZnVgUh6dkUfeMwHcB6KJ2wa
         DRK+WXbLixnNKf3OrA/fFG9AHJkRWfji1pRpsBHZZCKef8j1uybXwRYmMWR9DWBcF+j+
         9PgdgypnypCeJ1wwl8WB2CaECQ2qi4bUbglMfKobdBD1uN4YEe6Rd4qRuv4g1FoyaJ6y
         b/53PRruEEmk4Ia9wz0eOFiMJDqsoeYpG9dhf4VJnZB9ud7nCnO913LuXnO6BPdrOy6Q
         Q2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV2D7eKZNlWFufRcfcd55Z8tF4LJhoRTR0Das4PJvPe9IlB40nvpTn8w8pEr1GN+t+/Xx8Vj91Ng5RdtZhsvho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdS/qfOXjiHdvnpPJI0XKiZFyDEt4g5hTdT5E6zTm5DjqatMi
	kuATN06m5nVcg2qwL5r1coWhjvwbYVozY142XuSj0dooWupWSKE/4iCyKnnSdabC82d1+zmJLud
	8V/CnxS8eFZR6bTtD/RRKLGEuzSs/CPVyvP1l
X-Gm-Gg: ASbGncuDq6qugv0k4lhQeoINkuQ3iepiVLTYASHZhE0T7CINzBipTLgSIvp+LAt0BZx
	lggHjNnSET45hiBPNGQ75InGmH39sLlTyGy77h3ufgOofPLZDObZrOjsTxril9DRwEVxcLEXmqB
	Nzr3a61x6igJOPP1fDF+4xTnYdgn3t/3gxk2Q=
X-Google-Smtp-Source: AGHT+IFHMx1yE7gHW582wXMuvOh7tHgTZivr88kXV0aPgVkLgrM9yfWRJOM2hQFiPDsaHWm4esXlGziN0BjlWvQIYQc=
X-Received: by 2002:a17:907:2cc6:b0:ac3:9587:f2a1 with SMTP id
 a640c23a62f3a-ac7389d8dfemr885055566b.20.1743459797781; Mon, 31 Mar 2025
 15:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331103900.92701-1-sgarzare@redhat.com> <20250331103900.92701-4-sgarzare@redhat.com>
 <Z-rSMi2uCvShLbLS@kernel.org> <CAAH4kHY-Orjr_+rcYNemuWrAOOtyrCMD5s6KsOrkX740AARXiA@mail.gmail.com>
 <02190762dd82104070ff1a2942a7be703f4ff53d.camel@HansenPartnership.com>
In-Reply-To: <02190762dd82104070ff1a2942a7be703f4ff53d.camel@HansenPartnership.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 31 Mar 2025 15:23:05 -0700
X-Gm-Features: AQ5f1JqX-yW5Je-QNs6buiWjeJcb2hXA7Vjgj8fcMn8wzx6HtqYBhlJtZrCDaIw
Message-ID: <CAAH4kHYwDgnYsMhJ8zZWn1uU4tqqnSXOLKEJNMb-3OCNrM7Z9A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tpm: add SNP SVSM vTPM driver
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, 
	Peter Huewe <peterhuewe@gmx.de>, Ingo Molnar <mingo@redhat.com>, linux-coco@lists.linux.dev, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <jroedel@suse.de>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 2:26=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-03-31 at 13:56 -0700, Dionna Amalie Glaze wrote:
> [...]
> > I might be unclear on how I should be testing this, but I do see
> > /dev/tpm0 and /dev/tpmrm0 when I build with CONFIG_TCG_SVSM=3Dy, but I
> > don't see the event log in securityfs. What am I missing?
>
> The vtpm driver for EDK2/OVMF I suspect ... without that the UEFI won't
> lay down and event log for the kernel to pick up.

This test is with Oliver's PR https://github.com/tianocore/edk2/pull/6527

>
> Regards,
>
> James
>
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

