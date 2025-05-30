Return-Path: <linux-integrity+bounces-6345-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C3AC873A
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E457D1BC0284
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAD192B90;
	Fri, 30 May 2025 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCZv3pw5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B7199939
	for <linux-integrity@vger.kernel.org>; Fri, 30 May 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748578516; cv=none; b=mbpL+953R+V/1N3NItk9xt6RM6p61CA1hzv3XwvYvbI18RlFKtQLzOp4JP+sjfeAj1jnbknuJ6QbYcSSOa/tYkIbSte9jPSeKZrPSxfDqAdQuWfagkLKJ+SwM5nKVhUwTeg8UQxNzQ9UGWwo2ZqtAvn36q4ekh/O7RGry7rULaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748578516; c=relaxed/simple;
	bh=ME5ccnIAVYQSz3b4RI9mFcQVxdpBwo1MysYq1/2Wgvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnHAoNFbS8Duv8uFhJ2/ZOV+Cd/YsdLfRqHzcROGvg75YEznKO5iaKK2WGZx8067ANo38GArb6B5G+83ObRVsQeFF9sbQlkjK5GPtqeVLb262WU39QVzjc9Jh0AyCuMHiApUHZVS6Qegu3L+ajK3/cu5ruS+LnoBnsVeRKdSgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCZv3pw5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748578511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEb33DDg7DpFW9LjvXELe8JW6iZ+vyGYUAOVA6/mv7c=;
	b=VCZv3pw5AfjzSyPYwp0oAfZC7JEToFiqrq1RluiWr+ghXLAaqNGURdEDx13riFRUlq//1Y
	hm81u5kYdeArXCQ5x24TgjotvIztMZv6zWFGLPeVQP4RF7sjtlEcX8FTlV1XCohp927GBI
	Jc37plCbmCq1q64KwPCxZX8gbAt+Glc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-6qA2-yJPMWyuqEX08Wt5qA-1; Fri, 30 May 2025 00:15:09 -0400
X-MC-Unique: 6qA2-yJPMWyuqEX08Wt5qA-1
X-Mimecast-MFC-AGG-ID: 6qA2-yJPMWyuqEX08Wt5qA_1748578509
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1287290a91.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 21:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748578508; x=1749183308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEb33DDg7DpFW9LjvXELe8JW6iZ+vyGYUAOVA6/mv7c=;
        b=KRtZFslhGG3/b92hJLa31XAQjTwfiiptQOSgLzi3gQu3xfv9DQWiZwR+BCnhIGqBDC
         IlhXpf026lD/5CCS8t1Gy64IQgXcZ/gPlZKZ4UB9mRF5C21aq1bhyzv7WQhONFxYR8bj
         1j4Cz//ZDFbiJ7Oz5dGTpUwVyLSIzCMsnqd3kf2sMCxKhQhMHpJawXgGvVGDtTrRa+D9
         YtMXCHkRW+3kb727yHvWL4qpWT8uiRzpJ63zBreaY3R4F2EkVjMOfjWzRLzcBwYYHjZf
         wdnIqhoYyP+t4AkKK6/QH+W8+s1Sw348+pCbkIulq8Jxoypb0Ixytz50vhZOlbaA/063
         NGyw==
X-Forwarded-Encrypted: i=1; AJvYcCU8F2TEZFNCihY4kthuwYH2ZHu/Ml4SF4q/H2mYt3x3c7g4ky3vPy5VgrDc/tk5cSfHxn90IXgoKcrJvF/X+Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtroeNxD11fzNjzUyP4oMrGWTEWBbJZ1HwQcbvULqS3ulb5zTE
	myi6hkgeS8kIKhHIC9QBpX0TMl/9FGPJuiDfI0StRdEScQHy+Fx7YZOG1kXtVoEZwgXjLky46+W
	CEv64HbZEzRF5wSMpIG5Y53bU2XnS65oaIoPhz/Ks/IszIzH7SDiA2FXdgHCjb117mmtRhAfVtd
	m+5nXwZ3NfIbl0O8nJjpgO2Q2AKncfYfOXXiofgK6zuYY8
X-Gm-Gg: ASbGncudjjsTweQFd4xXMd8oNSFpTrle+EhzvY7HYj7L0d0RYayoGRKE5TPiAlG4XtQ
	ZmYJ2aByWHJvlsw6pyyE5DUhCcSttTLop1zJUs4FUdnH5Kj3iHDfuLQMEUgM91lmD/M5+cw==
X-Received: by 2002:a17:90b:58eb:b0:311:f99e:7f4e with SMTP id 98e67ed59e1d1-3124152f29fmr3271304a91.16.1748578508617;
        Thu, 29 May 2025 21:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdNkL/QOg0pgwhpFjclJbxX9yS+kdBsgXT9/3xp4M+RVHKQ3aStcTn4xx15LUWcuWRLmKhhRfllSzauASBpmg=
X-Received: by 2002:a17:90b:58eb:b0:311:f99e:7f4e with SMTP id
 98e67ed59e1d1-3124152f29fmr3271262a91.16.1748578508205; Thu, 29 May 2025
 21:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515233953.14685-1-bhe@redhat.com> <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv> <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
 <aC86NSypHlER2C3L@MiWiFi-R3L-srv> <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
 <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com> <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
In-Reply-To: <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 30 May 2025 12:14:57 +0800
X-Gm-Features: AX0GCFu-M8N1d-FrbfO4Ax_Xw2IAE_iVpqDIOOmbg0VDp3GzgJjExVn2UQM-Mb0
Message-ID: <CAF+s44TOjC60hfTU2JKQrfiogUin5E=O7XvePb86Lv7jjobJ1Q@mail.gmail.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com, 
	chenste@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 10:32=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Thu, 2025-05-29 at 12:13 +0800, Pingfan Liu wrote:
> > On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >
> > > On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
> > > > > >
> > > > > >
> > > > > > We're trying to close integrity gaps, not add new ones.  Verify=
ing the
> > > > > > UKI's
> > > > > > signature addresses the integrity of the initramfs.  What about=
 the
> > > > > > integrity of
> > > > > > the kdump initramfs (or for that matter the kexec initramfs)?  =
If the
> > > > > > kdump
> > > > > > initramfs was signed, IMA would be able to verify it before the=
 kexec.
> > > >
> > > > IMHO, from the higher level, if there is a requirement on the integ=
rity of
> > > > the
> > > > initramfs, it should take a similar approach as UKI. And the system=
 admin
> > > > can
> > > > choose whether to disable the unsafe format loader or not.
> > >
> > > Yes, that is a possibility, probably a good aim, but in the case of
> > > kexec/kdump
> > > that isn't really necessary.  As filesystem(s) support xattrs, IMA po=
licies
> > > could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to includ=
e the
> > > initramfs.
> > >
> >
> > Just aware that we have such a cool feature. Thanks!
>
> > I checked the code. IIUC, the relevant code has already been in the
> > kernel. And the thing left to do is to install an IMA policy, right?
>
> Correct.  The problem up to now has been that the initramfs was created o=
n the
> fly on the target system, so it was impossible to remotely sign it by the
> distro.
>
> >
> > But there are still two things to be considered.
> > -1.The UEFI partition is FAT format, which can not support xattr
>
> The normal kexec/kdump kernel image and initramfs are stored in /boot, no=
t the
> UEFI partition.  Is that changing?
>
I think that is the case if grub is used as a bootloader.

But officially, only FAT32 is supported in the UEFI specification. So
if a UEFI application (let's say systemd-boot) tries to load kernel
and initramfs, then boots into kernel, it can only expect to read
these files from FAT32 partition.

> e.g. kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`una=
me -
> r`.img --reuse-cmdline
>
> > -2. Just like in the UKI case, the kernel fd content is not necessary
> > for the kernel image itself. The initramfs fd can be used to pass some
> > extra data if we use a temp file as a package. So checking the
> > signatures at the initramfs level will block this usage
>
> Sorry I lost you here.  What exactly is included in the UKI signature?  W=
hat is
> this initramfs fd extra data?  Is it included in the UKI signature?  Can =
you
> point me to some documentation?
>

Sorry for the awkward expression, let me clarify it.

It is a pity that these things are on the fly and there are no documents ye=
t.

With the advent of UKI, which encapsulates the kernel, initramfs, and
cmdline into a single PE file, the original kexec_file_load syscall
schema no longer aligns with this design.

SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
                unsigned long, cmdline_len, const char __user *, cmdline_pt=
r,
                unsigned long, flags)

In particular, the kernel_fd parameter no longer refers to just the
kernel image alone.
And the same thing may happen to initrd_fd.

In essence, it means the redesign or re-explaining of the
kexec_file_load() interface, but for the time being, these things are
on the fly.

Thanks,

Pingfan


