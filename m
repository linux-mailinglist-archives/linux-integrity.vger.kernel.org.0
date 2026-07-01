Return-Path: <linux-integrity+bounces-9860-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wM30AdiJRGo/wgoAu9opvQ
	(envelope-from <linux-integrity+bounces-9860-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:30:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D28E6E97A0
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Hr6h4hZC;
	dkim=pass header.d=redhat.com header.s=google header.b=beiLZrEZ;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9860-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9860-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09B23301EB79
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B7313E1B;
	Wed,  1 Jul 2026 03:30:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDA17A30A
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 03:30:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876628; cv=pass; b=tOhfAqioB6SgtWrYcrI3KdnMI/NwfxwkuCetdDdtElxA/nChde+XPH2X59K2DzjcKNApYTjgayvXywbdgbik5P0muVde+Yc7ZIT29//zMnlk4D0q88rzTIe5DqTaCYLYxCaBi4obHOwWvLW340vModNHsd4DbWJP+eML28RQG6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876628; c=relaxed/simple;
	bh=vSfkh+IUcZCNdgLgxn72uyzlv/Jyk6r1qgP/5dUbo60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHxnBXJoNLVY/pekikiZziVbnM3Z5cxcZOAg2ofXwkODgvOTpgMpHvtM31jarHOjpclnCEMyJ01fVzMTFoPZLg5Qhfn2HPFXZHxMZzt+rUli/wVjM8SwfD3sEMSF+PbSokUt4nx6WbVQlR8fEN48aQe5Xzax1yDP74ALk5bGfsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hr6h4hZC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=beiLZrEZ; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782876626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
	b=Hr6h4hZC38QkoCQQ31vMEMKuwFQwzuWHRSMnaofauBpJhlcNwmnM4LycSbpPfysmdISteW
	a4ngr7fjl08whH4LxwbeHsirGSYM1qfDprlCiQpMKH+WQspxvxZQD7ED19bMjDBhePz56u
	xCn81YQrQkJXd5FwKt8r9j3VKP4n3cg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-bMZYHCuzMKiCWFFtSEz9gA-1; Tue, 30 Jun 2026 23:30:24 -0400
X-MC-Unique: bMZYHCuzMKiCWFFtSEz9gA-1
X-Mimecast-MFC-AGG-ID: bMZYHCuzMKiCWFFtSEz9gA_1782876624
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so3037476d6.2
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 20:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782876624; cv=none;
        d=google.com; s=arc-20260327;
        b=dLLXIkL3tpFgNVAx6gUMTcn4hRbjFOVwoR81isijc+S80ejYAAx8DMZztsfC0uZgGT
         gqwGf5sw2QxD3RBxxGI/E/FFBRdqYMJ2eVQozyDY1fcg2Q+DluJpnOJ1Tq64zciWLc6r
         g1JyUIZLVmmaczreNcE9IeIRRqx9WmQhaYrFmlquCYnPYCD96yZN70nyPqrjFQW5HWm8
         VB79TXdOy1l9enJ1icSZT6dGCQOzz3+oY00da+ITpJfhg61081c7wHPaXzCctehx6o1Z
         eKF0BS7GOJNb7XddgtqjKXn/RZBZ4IlHjpiPVkcNXTZ+r7B7M6pO+NWBdtEv09GNBSqP
         iQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
        fh=A7I1Av/pElbombxcmHo+5det1p4wRiMwONjRCqXGo/8=;
        b=ftYz9yg/kK6rnmNMn1ORdpsM473bE/SYksv4rn6Ui/IWeYQWnBnQpwDRyIj0FIEmrI
         tTe+GNL3RW3N4VBzwK0RrBzMZBqiqpTiwuZI6oZyOWtobELEgIbRGs3QUVGRq6601t9q
         27AMg7rCDnXyE2oXKUR0++H0ZAnduxFW9Lqa6bGtqP28j8FwfLa3MP+Dt3Uqzc2NMYkf
         Aoy1Y9pZ6GjuW+u6g2r9HmB3d6MRXdFl3C/s8dyYSgUATWkxJLSGusKvBBXYFAQrtzws
         YgaMF2Ue7jTKk4MBmwvs+Sw8PD3Edl6OrPrBlWP91ucUA4L9JHklKekibMnJMxlDGXIR
         NiYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782876624; x=1783481424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
        b=beiLZrEZ3TcE/oMSnqc6fDaemNdjabudzUGulWhi5pOclTSk5pjlQD+LyadQJGurp9
         dZKtkwBQB9ZvtRWbSQEKOGs7TVuYaQM/HtvyuwhzUPCGxYn6UfbUrsK91XZNBTj9ZFXh
         BHIPJQwGAMqw5YETqL6AC/EwXsB7ZAj3SzhlfytI92DWooh4EjyxVXcEaQDmUnHUF26d
         j6ecE+SwhOhOVo6fD75rTmC6WOpWm+ijqgF9aul1YGXL4eYG8tPjg9yrfsJ5sUgzwskt
         zloViCWfguZauKmjc9K1eMX2An7NtTcjtc/UDUiBMDtfUeFo7kLMwfpUJSwwbEuuTY2c
         +BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876624; x=1783481424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoMJdx5zn+YGKPIJdZfuaw6N0IusaD8A3j1a7ig86wQ=;
        b=rEOPWw9kESF+a1yCEeX+kpnnI/Ktfj/0TsNUkSmk31Q5xXWA61mMrETKBQp/L/Lrza
         tKL9Mdoy67mhOLZMpqsuqDRVOxVeCuwd2Q3fRU04NchaurVSoVzVAhzq07nYolhN/2r7
         MGYASodmNfEQJsUTc7GVAlNzC+c5K5PG6Cb43uEaZ5tNZwmmCdUQazS1D+3a1IZ5t1Lk
         GfI/pskdj9EBx5BJOtRs7jaBRDQ6aoL4FiwNfu4fGa2vV4x23L02Q+htxfAERgN2sn6I
         jNrh7nn/eR6066bAT8dI/WnPyt50VEdAT/PW5eFz+CgmfaJAbQwAfsk46dH6ahaSpp+W
         Q6KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ae1eIT8h1NUNGlGETHzfGcqYrMcwfGPXFpE5k5X2BpkJDB2XaVIaFu5yVw8zwh7v+wq+r3V7enN29DR7aGDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+B7STxJRL3MEDSvzcliC+HcW70vjBL2ZB9XLtGhlWlr+gLO8
	t1gd+GMykkxjysYrBDvSUbiW/F+wc7nsyVN5Y8nDL3wYkI+OTAntIzNLCzEksrKjn6dWTzS6iXC
	5B/BkdRcKD3torlz0tekeptx4qUoq9emwgZovCtNhJtRncyyVlubrE/0kCWcYU+ODo7K0dlEOn5
	LLNu7AQOvNBCwDfgXIEvjh6hEq/scE4o1D4r2vUMtB6xffDMdsuEsXV8w=
X-Gm-Gg: AfdE7cllGqELrZCt+VX4bL3rvprg6uh6hcbwPD2fgThBJ7bBJ/q7EIBmJG+ms3lbUC0
	++b6cN+i0XR+92jIsMG288GGhGT288n4MP00ybE7UVouft3TQ9RMMh1ENldfBIc4xw5f9/aDQw0
	+gBSG0d6rdcYDB9DZ8T+5N1mgVRFQRfghhcquI+EmuoKhyZfbe6tA2rEjxSHYkQrOQFw==
X-Received: by 2002:a05:622a:1491:b0:51b:ec5a:ec0f with SMTP id d75a77b69052e-51c26a78b2cmr68431cf.27.1782876623670;
        Tue, 30 Jun 2026 20:30:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1491:b0:51b:ec5a:ec0f with SMTP id
 d75a77b69052e-51c26a78b2cmr68181cf.27.1782876623221; Tue, 30 Jun 2026
 20:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529032739.13264-2-ltao@redhat.com> <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
 <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com> <2vxzh5mlk3bd.fsf@kernel.org>
In-Reply-To: <2vxzh5mlk3bd.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 1 Jul 2026 15:29:44 +1200
X-Gm-Features: AVVi8CdKF1AKTpYGlqKLlXqBd2QuDG30_C7t77l5Ewf9c6uDhUVIB40R85nEe14
Message-ID: <CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	linux-integrity@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9860-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pratyush@kernel.org,m:bhe@redhat.com,m:kexec@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,lists.infradead.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linux.ibm.com,huawei.com,gmail.com,oracle.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D28E6E97A0

Hi Pratyush,

On Mon, Jun 29, 2026 at 11:13=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> +Cc IMA maintainers
>
> On Fri, Jun 26 2026, Baoquan He wrote:
>
> > Add kexec ML to CC.
> >
> > On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote=
:
> >>
> >> Kindly ping, any comments?
> >>
> >> Thanks,
> >> Tao Liu
> >>
> >> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrot=
e:
> >> >
> >> > A NULL pointer reference issue is noticed in riscv's machine_kexec_p=
repare,
> >> > where image->segment[i].buf might be NULL and copied unchecked.
> >> >
> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> >> > but kbuf.buffer is NULL.
> >> >
> >> > Fix this by simply adding a check before copy.
> >> >
> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
> >> > ---
> >> >  arch/riscv/kernel/machine_kexec.c | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/m=
achine_kexec.c
> >> > index 2306ce3e5f22..d81d576f9cb5 100644
> >> > --- a/arch/riscv/kernel/machine_kexec.c
> >> > +++ b/arch/riscv/kernel/machine_kexec.c
> >> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
> >> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
> >> >                         continue;
> >> >
> >> > +               if (image->segment[i].buf =3D=3D NULL)
> >> > +                       continue;
> >> > +
> >
> > This is a good fix, maybe we can add code comments to explain it as
> > below, just for reference.
> >
> >                /*
> >                 * Some segments (e.g. IMA) reserve space but have no bu=
ffer
> >                 * loaded yet. Skip them as they cannot contain an FDT.
> >                 */
> > And is there any other place where the similar issue exists? e.g on Loo=
ngArch?
> >
> > Other than above concerns, this patch looks good to me:
> >
> > Acked-by: Baoquan He <bhe@redhat.com>
>
> Yeah, the patch LGTM to me too.
>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>
> Although I think IMA can make this a bit easier to understand. First, in
> ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
> to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
> which are initialized to NULL and 0, but never updated. Using the
> variables here adds an extra level of indirection.
>
> Also, perhaps we should add a comment in ima_add_kexec_buffer() about
> how this all works, since where the IMA buffer lives and where it gets
> updated it fairly complicated and took me some time to piece together.

Thanks for your patch review and suggestions! I agree with your point
on the IMA part, I was confused by the code too, e.g in
ima_add_kexec_buffer():

void *kexec_buffer =3D NULL;
kbuf.buffer =3D kexec_buffer;
ret =3D kexec_add_buffer(&kbuf);
if (ret) {
    pr_err("Error passing over kexec measurement buffer.\n");
    vfree(kexec_buffer);
    return;
}

Do we need to vfree(kexec_buffer)? When kexec_buffer is NULL and seems
never get updated.

I'm not familiar with IMA code, maybe there is a reason which I'm unaware o=
f...

Thanks,
Tao Liu



>
> --
> Regards,
> Pratyush Yadav
>


