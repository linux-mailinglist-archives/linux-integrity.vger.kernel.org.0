Return-Path: <linux-integrity+bounces-7439-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF5CBE45D1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5FC4E2148
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14D20E011;
	Thu, 16 Oct 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHrTfU2C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF334DCD2
	for <linux-integrity@vger.kernel.org>; Thu, 16 Oct 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630038; cv=none; b=UPxdq/xEooQnEhPTvWSScb65kLa+Ua9/DWA91TIN13/9Hxlea97RuiMD4WHaIA7g/ShpEkNuj+pUxlYuG1EAQyieQIh1SdYapR39H649s/nVBYONIUhKZwTpcqQ1z0SW2Ej+fWtSHzbhxEBBta+0JpjnwleD1j4e6o+Mpvc1vj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630038; c=relaxed/simple;
	bh=Go0MNDIavsjINpoT06GnTmz2rdEorOkOlbUztzacQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqUdj6Woa/W8/beIf2llyRMqarZwTc167N5/xLu9x6hTIDuu9i1VbqnncTZ9vb5JyOxLMGDzq8owl3aCnR2BK8/5akMz3AQE1nqw8BLNaQRF3nZcmjMkul126jdUN+g4jUePPuBpgq+4CJN7tyY7sb7hV48GN8gvapNLsBNRVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHrTfU2C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso11047a12.0
        for <linux-integrity@vger.kernel.org>; Thu, 16 Oct 2025 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760630035; x=1761234835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2evuexxKw25LtXcesE7/iGA+MJZ+f8Dq3GZy6Z3Oglg=;
        b=PHrTfU2CG/eC855j7PFhsjYHMXFhu7moCfWkCr+/J1mbmXHcUfZ70U3YxiWXcZyQmr
         9yXI2qJbHxa7GqWcYEg/3t8SmyuP0VI2xNksHnTDliRgCdVV7Zgm0hTqvWKewXwx9Khm
         M0i8gfTUraa+mdlhrH5OC7bNnk4+zihJ32iGFxaey9H8axX7g+g10XUxKSXw1ebpLWqT
         h8EQfdslIUgDuMxDaxFOJEFaxE15MM4lk5KnA1nnYYvanKkHun3M9MmZTyfSUroTv5Q0
         QqFH8bM14dIa12FRnhyvYCDNKLQEgs4zROFWMznucMgfv8unfOI415b+dAVYssLAwEok
         t2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630035; x=1761234835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2evuexxKw25LtXcesE7/iGA+MJZ+f8Dq3GZy6Z3Oglg=;
        b=RudxoSbtIYWxoFIFiVw8pDHks6C6BdSViDO5c3wzX3Wuh+IOAf3nS6vNFefV22jA2V
         NBi0bP0IWi8zL9mkCRmcF5vbqj4/+BZ1gvZfyZ5tRTIbxvasUuuYJ57jQ58nQTdau/o0
         m5nvU3chdeY7UDgs+6TxdUmeo2ELaSJduYEaKy2eQ1az1+t/WfWuxOXW4zYCVBdDe3MA
         ol/0AH8nnVdZFxa6YCDFzyieC+HZ6FIie8Cb10trwrvf0pGh5IpVOo6ue59OBG5ZAam1
         ePRG0KvNy5hFqqvxx+IZtDw9fhIRn3i/XlMtRtdubSpcRnU8Kwo+4t7W31kVmk5/v5Qy
         IL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/vA4wQx+YY8x6OmRfL+LcA57Mgi9WT/N223EJy5wWyxqwe+HXb7DtHjjlEXi5gaTSfvfLjNKzAp+CBa4XKlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrThambF0e9T4UBJgB+OpaKUhAiRXrocElB9Jp7+UhbXl++L8
	fBae9wvVLtbQckQrHy9LgvDVgTmUhGLwATZpQ2MVuTjp33O5n4VHps34/5mgtygbp/3L5AkKX+9
	keJLwyuuxsXWmKzfbGdoKpG81xqj3j8uqCsRSBfRk
X-Gm-Gg: ASbGnctW4qdIp3mNzd3k3E0Ztj4yq3SOR51oELQYHgzp9B+G2NE3Ae7cIlioVO1SOEh
	IT7Of/oYJCPE7kj5LPmTtpaQR9EbuGpf1jcd3yHOH2C/q8MOkWTZz1wngbL/puZCrXH7k5EQTb4
	owXQYBMenzvf0rPvm9I1C7IhSjFxgUVztgoo5bKovO5rp9dZPMX0oI3WHsCBpcCF8nMgXUvWAp+
	oR4UeNR3i7SLSHgV9OqSF1FDFMEgqnEQepJka3Ua0wqhXIsumgJsQEatzCFgJwerA4nRDoRPssc
	mxGM7ZsQo8Y9XaQ=
X-Google-Smtp-Source: AGHT+IEaURDwO36zJ9ZAjPzX6vspjnrbQ8+1gdePow1SHb0Bsir7kBqLrBvlJHDfnx7sZwxVY9S6IenpSusczCqN5wI=
X-Received: by 2002:a05:6402:2346:b0:634:909c:d3c with SMTP id
 4fb4d7f45d1cf-63bebf9d4c8mr292671a12.2.1760630035029; Thu, 16 Oct 2025
 08:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
 <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
 <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com> <73d071ece8b1773740d494868f552abdd99decc6.camel@linux.ibm.com>
In-Reply-To: <73d071ece8b1773740d494868f552abdd99decc6.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Oct 2025 17:53:17 +0200
X-Gm-Features: AS18NWAl36TmonZE4Tq_j7rbgF1yH0UJgkJ0unTwaL53hFz4Z23PSJGH9lVf4ig
Message-ID: <CAG48ez2dT+TCoUvx8QOTJKvHY5cxW3sT1H0W1CwPf6Fxd0E-5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:52=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-30 at 16:26 +0200, Jann Horn wrote:
> > On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > > > This series adds a "dont_audit" action that cancels out following
> > > > "audit" actions (as we already have for other action types), and al=
so
> > > > adds an "fs_subtype" that can be used to distinguish between FUSE
> > > > filesystems.
> > > >
> > > > With these two patches applied, as a toy example, you can use the
> > > > following policy:
> > > > ```
> > > > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > > > audit func=3DBPRM_CHECK fsname=3Dfuse
> > > > ```
> > > >
> > > > I have tested that with this policy, executing a binary from a
> > > > "fuse-zip" FUSE filesystem results in an audit log entry:
> > > > ```
> > > > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zi=
pmount/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > > > ```
> > > > while executing a binary from an "sshfs" FUSE filesystem does not
> > > > generate any audit log entries.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > >
> > >
> > > Thanks, Jann.  The patches look fine.  Assuming the "toy" test progra=
m creates
> > > and mounts the fuse filesystems, not just loads the IMA policy rules,=
 could you
> > > share it?
> >
> > Thanks for the quick review! To clarify, by "toy example" I meant that
> > while I was using real FUSE filesystems, the policy I was using is not
> > very sensible.
> >
> > I used real FUSE filesystems for this since I figured that would be
> > the easiest way to test, https://github.com/libfuse/sshfs and
> > https://bitbucket.org/agalanin/fuse-zip. These are packaged in distros
> > like Debian (as "sshfs" and "fuse-zip"). I mounted sshfs with these
> > commands (mounting the home directory over ssh at ~/mnt/ssh):
> >
> > user@vm:~$ cp /usr/bin/echo ~/ima/
> > user@vm:~$ sshfs localhost: ~/mnt/ssh
> >
> > and mounted fuse-zip with:
> >
> > user@vm:~/ima$ zip -rD echo.zip /usr/bin/echo
> >   adding: usr/bin/echo (deflated 62%)
> > user@vm:~/ima$ mkdir zipmount
> > user@vm:~/ima$ fuse-zip echo.zip zipmount/
> >
> > I then ran the executables ~/ima/zipmount/usr/bin/echo and ~/mnt/ssh/im=
a/echo.
>
> Thank you for the instructions.  Due to the holidays, there was a delay. =
The
> patches are now queued in next-integrity for 6.19.

Thanks a lot!

