Return-Path: <linux-integrity+bounces-4613-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7DA19A60
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2025 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E716BF5E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2025 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838151C5D7A;
	Wed, 22 Jan 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzjHGbPG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7911C5D64
	for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581397; cv=none; b=KBoIF++dkBo9r5x9HwsiKxb/kdBeD+1E2wysxbm72UuuSjYQTdZ63qhrD34gS/agqUDCR3XYQPqOAaQfpDGQ8kiPRpHXtqmUyzRiGtYQofw1+GX0pXiFDzBGNYc5g1PSY7zTVMmlM7QLuoPSTgOLh95hhImKH7R3HmD3UDusHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581397; c=relaxed/simple;
	bh=zPSSsJeZd9K61Rac126fQ7pKueKdfVs0dP50Mme3eBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIApNbkSqoiR/AIiSNRHqRGI5uthN+7sKbTWqaReuPTwTHm9DPi+SeTwFUTtGGihhI9ZwGnCqmGL1GFu2QvZIeoxEBy1BVxcqVgq1lbUjQ6TyOAoLblaz3J8oc9caR07kCoIS2+3PZQDJ+nC5MB3rkx292703rBTwTF9qsdp9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzjHGbPG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab651f1dd36so54099266b.0
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2025 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737581394; x=1738186194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPSSsJeZd9K61Rac126fQ7pKueKdfVs0dP50Mme3eBk=;
        b=nzjHGbPGruCjrv32TryesWc88rn8uNOLNlsG0u59wP3Ur3qZkWGzWpAlY5PZtzhqwW
         Tc4rveOKdaUqgNfKjgCJ3dNBCrx1BpUppgUnhAeXAJOp26mCNQfH6e+rghQuIBfjr3Aj
         U4a8P54o3MywvI0yiDfLQhnhEfzYUGx79foTQrvp0JQsLcrKvvDym1PAoj6N8e7Rv6eN
         HWXZqb13kb7AL8oyYrjOYijVd0RMhDE4+SsXuck0tW7+GmiuSj3uFB5qXpICQ9eatANU
         B4weJ3CV8pIirRaQUvSpsyWGkxU+AFVV+Y7xR7k+cJhb2Dzn+8+HlTZLts3kWy90rPr3
         OGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737581394; x=1738186194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPSSsJeZd9K61Rac126fQ7pKueKdfVs0dP50Mme3eBk=;
        b=nmRKku+wBe2wJVqHyohl+WnZLGg29q29BosXOtY3qmVEiKvH4w3CfveEgDqswPeuDf
         vP6lnacvZuaaqd3F1DMKfA5b+8sOGYlfxTJ+DPEHIJHysH+qhIKu+B6LDG3fili4rQII
         IkivUqpEPlfBkY5l/Zof88BkcApqPyIQxvJoT4+Q3gzNcqWG9a4w+sWE8Ilt7B+jmyQO
         Zm+B0/vn6tR+RcG4jzy4pABkN5aT0NjZe4Z9NU4xX+At4x02a22uyZ/GfNUyM4TwecDW
         SOg7rZbjcBwItICKLzX/zjcrqeJ/okcHYJXzdQ2G4nh2P0GDcBLsFM7VmqYzu1BHE8D4
         0iNA==
X-Forwarded-Encrypted: i=1; AJvYcCV+afak44xHTaI+sj6zDjI8yoZK8Um++zCZYBVe+Mypejq6BgrIiJ9WE9HFLmYYkuFm6AWBMUtnGZYOimTR8Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/s1XDjKDaUy0gChIC1yLOlFdBgb3e0n7uLwhc7RDCUxSal9n
	RuBC7IsNrpMB0jNru46KSG3ZgcWFLCiDdnHzkKjwNc1zZMJnDz1CAuIpUidNx4QMUQlyEOihX/S
	8AJ8e4CJc2ms1FbroUk6W7bO54bctJ1aTHs2Z
X-Gm-Gg: ASbGncuSUWIn7hgGkRi7Zk6HsusVQ4CLDM7k1hQI/RdVkjYDnr+fvs4iUSJoEacBXgx
	oIwikYiv6DyT9way5jhIfVhewjPIZXnlHIlLv+0XjL33mF4xaUyOa0rv3fjL2zs/kvvExs3Gcst
	PZHg==
X-Google-Smtp-Source: AGHT+IG3800wXK57ZgJEoNJZD9NN8RKbiZQdhoDJpPk0SsgyWjH5F5LmlEVuZc6zBh0UypRcCRSsvwsaI9kjNMi9qgk=
X-Received: by 2002:a17:907:7b9c:b0:aae:ce4c:ca40 with SMTP id
 a640c23a62f3a-ab38b2e737cmr2209361766b.32.1737581393723; Wed, 22 Jan 2025
 13:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca> <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi> <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org> <D725V628UV87.31SUEYVF9IUUC@kernel.org>
 <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
In-Reply-To: <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Wed, 22 Jan 2025 13:29:42 -0800
X-Gm-Features: AbW1kvafwXI9IVMNRZ_87L98h-hcqR15uzBbb_GR-HQyCarswSAe-qgXejxD7HM
Message-ID: <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, 
	Jason Gunthorpe <jgg@ziepe.ca>, James Bottomley <james.bottomley@hansenpartnership.com>, 
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed Jan 15, 2025 at 12:48 AM EET, Jarkko Sakkinen wrote:
> > On Wed Jan 15, 2025 at 12:46 AM EET, Jarkko Sakkinen wrote:
> > > On Tue Jan 14, 2025 at 12:42 PM EET, Stefano Garzarella wrote:
> > > > Hi Jarkko,
> > > >
> > > > On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
> > > > > >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> > > > > >> So to use them directly in sev, we would have to move these de=
finitions
> > > > > >> into include/linux/tpm.h or some other file in inlcude/. Is th=
is
> > > > > >> acceptable for TPM maintainers?
> > > > > >
> > > > > >There's only me.
> > > > > >
> > > > > >I don't know.
> > > > > >
> > > > > >What you want to put to include/linux/tpm.h anyway?
> > > > >
> > > > > At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()
> > > > >
> > > > > >I have not followed this discussion.
> > > > >
> > > > > Let me try to summarize what we are doing: We are writing a small=
 TPM
> > > > > driver to support AMD SEV-SNP SVSM. Basically SVSM defines some s=
ort of
> > > > > hypercalls, which the guest OS can call to talk to the emulated v=
TPM.
> > > > >
> > > > > In the current version of this series, based on James' RFC, we ha=
ve an
> > > > > intermediate module (tpm_platform) and then another small driver
> > > > > (platform_device) in arch/x86/coco/sev/core.c that registers the
> > > > > callback to use.
> > > > >
> > > > > To avoid the intermediate driver (Jason correct me if I misunders=
tood),
> > > > > we want to register the `tpm_chip` with its `tpm_class_ops` direc=
tly in
> > > > > arch/x86/coco/sev/core.c where it's easy to use "SVSM calls" (i.e=
.
> > > > > svsm_perform_call_protocol()).
> > > > >
> > > > > And here I have this problem, so I was proposing to expose these =
APIs.
> > > > > BTW, we do have an alternative though that I proposed in the prev=
ious
> > > > > email that might avoid this.
> > > >
> > > > Any thought on this?
> > >
> > > A redundant super low-quality TPM stack driver implemtation to suppor=
t
> > > only single vendor's vTPM with speculative generalization.
> > >
> > > It's a formula for destruction really.
> > >
> > > I don't know if I event want to comment on this. Figure out a better
> > > solution I guess that works together sound with existing stack.
> > >
> > > If that helps we could make the main TPM driver only Y/N (instead of
> > > tristate).
> >
> > Also e.g. James' hmac encryption: not a single bug fixed by the author,
> > which does further reduce my ability to have any possible trust on this=
.
> >
> > I do care quality over features, sorry.
>
> One more rant.
>
> It's engineering problem to find **a fit** for the existing art. For
> You can set the constraint here as "no two TPM stacks".
>
> I know also almost nothing about SVSM. E.g. I don't understand why a
> vTPM cannot be seen as fTPM by the guest, and why this needs user
> space exported device (please do not answer here, do a better job
> instead).

I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
paper to me, which solves some interesting problems we need to solve
in SVSM too. So thanks for that.

Just to clarify, you're not asking for SVSM to implement the TIS-MMIO
interface instead, but rather to use the fTPM stack, which could make
SVSM calls a TEE device operation?

>
> Even if I wanted to say how this should be changed, I could not
> because it too far away to make any possible sense to begin with.
> And I don't want to take the risk of those words being used as an
> argument later on, when I don't even know what I'm looking.
>
> BR, Jarkko
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

