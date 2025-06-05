Return-Path: <linux-integrity+bounces-6365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EAACEB3E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78EF3A459B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57B1FF7B4;
	Thu,  5 Jun 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTPPh3gQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624011FECB4
	for <linux-integrity@vger.kernel.org>; Thu,  5 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110086; cv=none; b=oLeofVzme3xQeFFiq/0pBNYSU7g3w26rzzniAxSJi48246CMl3HT8yqOf8bsu9zKxSDcGPsZLYNUiHJm4iUoRZMYSZdGgf6DSk+UcOgs5brHuo9VjNK4KxRoP1JdpE1y3wtaMXSUgq7Y6DT8d9psZ2Fmb7NUYxGzGy95EJQW/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110086; c=relaxed/simple;
	bh=NNFSE2fFzpiSASQWnZwDpNqWAbQXEhYo1W4bEKJ2yGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYzslWMUmshJY278GQnDRTnZGIto+1y37q6KYqOU12zUKvx8emn0I+6qYF9fT6HeGFWy5BgcfcmkYBT2l8xNGUFLsyQKT46i9NDVqAlrl6Ip9+veNHF4AEQHuX8NjJ2rUfF6GjCMRCWIpuB/ws58Gej/S0AsEPW/3RAtIYSuujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTPPh3gQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749110083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsWFMFas7O2Lvk4gjiHkVtt4n83KeM8DN/r9KQDAJpg=;
	b=MTPPh3gQR8aKTm01kPJ5h6JxFHhTXoYLqZlJ7I//3iDtOxd+D+p+Hb1DaFui51Qcp6zEmy
	K1bw1+3mq+FvEY2y3JVpqUxJJcekND6iXZj3hv+zQ5KIl0K95jP7cs0YF3MOm7X/9ycgCp
	C5Wi+h2qor16sJWGJvyhtnW64JHLiLc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-bnrmPSXaMuu6hxnSc71VoA-1; Thu, 05 Jun 2025 03:54:41 -0400
X-MC-Unique: bnrmPSXaMuu6hxnSc71VoA-1
X-Mimecast-MFC-AGG-ID: bnrmPSXaMuu6hxnSc71VoA_1749110080
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450787c8626so3391305e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jun 2025 00:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110080; x=1749714880;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsWFMFas7O2Lvk4gjiHkVtt4n83KeM8DN/r9KQDAJpg=;
        b=iUBW74bmdM8mXYu5GILn+Yct2HVznhjKZUzxPwlP2IcjCPFWDZzB3pIoQklMWOODGc
         7anp5ue7i2xdHCsuwhp5+pdQxlB+NtoKhvgR4gm3tltR2bHcI2RDGF4g3zYR8SKWCWqb
         ugMbYsABjc/6y+CtjTj1w9+nlF/Z49yfPbcmoy0XoPRHEBmaf+C3u5oqYcDneBN/Cnnl
         4lhlAd5Rg2vPxoJSJT/rQ2gcoOGd9LeuPBUBWcSDF4Rd0CGCcrI1ndvGCPxApCROjZ+U
         mkbUvUUefkUYscfNUQ1NmVpsEuqoroBZ4H2m4ucHsFCASgi2tb+t9KBX+hgUamAPiI7y
         aZIw==
X-Forwarded-Encrypted: i=1; AJvYcCU147r57CoK7fFMdOv+JII+ZUT3OR2qznX3YwU+UaAf18CK+2adjOYwA5j1plbumELBhQ/ucy4blEkkqhXAPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7hpp1UlVmay8evRrBzRlO3NzEFQFc1DtILHSFoyasn/K+DpQ
	2ysCLbFru5ckVkoli1zE39tj5TmtXEu1y4lyDg1QN9DSIsjeOiYKX2qqqWaOSFg90PbMXQoKEA7
	i22J5rXctj9tzfQ7+UlxrPAcAIg1m0roNDLginVmXlCnYcjIogI/0hfrKDgoHpLTGTzpk/w==
X-Gm-Gg: ASbGncuZkRzpgWJzVG5GZIDcczhJw5eiZMZVfSgjeo2STVxgWaLriN452kLdUnmmCqb
	UdyWjqKcpjF/6oDXtQLxefWI2Nxqm7bqSGl+B086x04z4EatXvLfDLDz+XPtzhPjy91zO6xswCz
	1zb82mriyj+aY3YHR6b+S6vBCb8pAiuKeiaL3f1ZPhyMpdUisV4azmMdrToTzzfHvAVNwQ9hpKc
	NETOqIp7Wb2JPUOmet3VVMud3WA+W3cIGMYGZty5VsYj1Ru56HxVdGFeGS0VhfZmzO8SALHIKmg
	5H5Fznc=
X-Received: by 2002:a05:600c:1382:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-451f0a5fe0amr51092075e9.5.1749110080158;
        Thu, 05 Jun 2025 00:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1SRbImSlbGm32npkuOoSxiRgAXup0UEUY8LHi/iQ53+IYu08XHv+Q7OLZVb45/K6v+57Beg==
X-Received: by 2002:a05:600c:1382:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-451f0a5fe0amr51091785e9.5.1749110079698;
        Thu, 05 Jun 2025 00:54:39 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f97f85casm16199575e9.4.2025.06.05.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:54:38 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert
 Holmes <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
Date: Thu, 05 Jun 2025 09:54:37 +0200
Message-ID: <87zfemoc76.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Wed, 2025-06-04 at 17:01 +0000, Eric Snowberg wrote:
>> > On Jun 2, 2025, at 7:25=E2=80=AFAM, Vitaly Kuznetsov <vkuznets@redhat.=
com>=20
>> > The use-case: virtualized and cloud infrastructure generally
>> > provide an ability to customize SecureBoot variables, in
>> > particular, it is possible to bring your own SecureBoot 'db'. This
>> > may come handy when a user wants to load a third party kernel
>> > module (self built or provided by a third party vendor) while still
>> > using a distro provided kernel. Generally, distro provided kernels
>> > sign modules with an ephemeral key and discard the private part
>> > during the build. While MOK can sometimes be used to sign something
>> > out-of-tree, it is a tedious process requiring either a manual
>> > intervention with shim or a 'certmule' (see
>> > https://blogs.oracle.com/linux/post/the-machine-keyring). In
>> > contrast, the beauty of using SecureBoot 'db' in this scenario is
>> > that for public clouds and virtualized infrastructure it is
>> > normally a property of the OS image (or the whole
>> > infrastructure/host) and not an individual instance; this means
>> > that all instances created from the same template will have 'db'
>> > keys in '.platform' by default.
>>=20
>> Hasn=E2=80=99t this approach been rejected multiple times in the past?
>
> Well not rejected, just we always thought that people (like me) who
> take control of their secure boot systems are a tiny minority who can
> cope with being different.  I have to say the embedding of all the
> variable manipulations in shim made it quite hard.  However you can use
> the efitools KeyTool to get a graphical method for adding MoK keys even
> in the absence of shim.
>
> The question is, is there a growing use case for db users beyond the
> exceptions who own their own keys on their laptop, in which case we
> should reconsider this.

Yes, exactly; I may had missed some of the discussions but what I found
gave me the impression that the idea was never implemented just because
'db' was normally considered to be outside of user's control ("just a few
evil certs from MS"). This may still be true for bare metal but over the
last few years things have changed in a way that major cloud providers
started moving towards offering UEFI booted instances by default (or, in
some cases, UEFI-only instances). At least the three major hyperscalers
(AWS, GCP, Azure) offer fairly straightforward ways to customize 'db'
for SecureBoot; it is also possible to have a custom UEFI setup with
KVM/QEMU+OVMF based infrastructures.=20

'certwrapper' offers _a_ solution which is great. It may, however, not
be very convenient to use when a user wants to re-use the same OS image
(e.g. provided by the distro vendor) for various different use-cases as
proper 'certwrapper' binary needs to be placed on the ESP (and thus
we'll end up with a bunch of images instead of one). 'db' is different
because it normally lives outside of the OS disk so it is possible to
register the exact same OS image with different properties (e.g. with
and without a custom cert which allows to load third party modules).

One additional consideration is the fact that we already trust 'db' for
dm-verity (since 6fce1f40e951) and kexec (since 278311e417be) and
especially the later gives someone who is able to control 'db' access to
CPL0; a 'db'-signed module (IMO) wouldn't change much.

--=20
Vitaly


