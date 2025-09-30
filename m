Return-Path: <linux-integrity+bounces-7327-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2484BAD2BA
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B46F7A7D07
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0862FB0A3;
	Tue, 30 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDFLEkY4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6B1684B0
	for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242430; cv=none; b=O9ZDBC575aAVBOzDWmrO7kBUOkNYwK/jVbJfWxNr8S0BlC0aYaOSJQ7e0P0RfJ93qiHcTTp7+yaarGfmsxzhdM9fNwHAdVL7Bj/I45wYjpcIBbJGej4qG0PHEgn/NkapFDgUgXIzL+h5ge76Zl3+dcCvhW0laEe3oV0S2hW+jDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242430; c=relaxed/simple;
	bh=x43Aiv7rPX2GEQZu5NfhE12xepCVe53wujMWizCXNyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gt6q3z/LZnefTYTwyQudppe3s1RS2HSmdxsfgV7aBwwP9AC9dErszpKaOKB5RLG1tO3N8GdXBJ+T0o4eUV3YXsc9MY8SAwpQCyeuDcwt3kG/JMWgItdvQjEfzVHvjwihGJhlpGgklUUuygzi/nXbB9Pa9FwEBkX5nH6BRTDD4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDFLEkY4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so12751a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759242426; x=1759847226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZy9N2kUaCjLFUFTo+cbervBp1DnEnunIQqdJHxh2kY=;
        b=NDFLEkY4z8JrkEuw8KaheOIS8UYL91tMpbVbg9ClcPpU7uZhBUmAIE49cJmiyhvP5y
         mcYSkwJlernQGdBlCr3Uwi86UpJdLbsxHl39ovGqXG/FnIVe5chA749syVD9uxMIFOE9
         XJ/dC95AqYC2X9o6dMZorwbWQpEn7uxyKQzX3fU7kJ7UfHgjwna3xaiHvg6qg0E0v2CT
         S3gbBVTP4ecWcccIdn7QEg8NS7uuVKRRaUVq0hSI3GvpGHRHQ27TY3cHYvrIw7F+/ZqG
         uLTqt1TxwG6+TjD1FzREY7mBQse8XRae/nj1SLFEsxI0vrhYkyZzike3fOBAqYhlVQLU
         Qj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242426; x=1759847226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZy9N2kUaCjLFUFTo+cbervBp1DnEnunIQqdJHxh2kY=;
        b=J1+4UUd8BCfMXhe+XgK2rK1ZhJnVaFUpXlHlA01VyCClzWEmVONyvw1VXxVZJyg3V5
         dqUCiqFiO+Kcd4hCxY31T9L3HRNtjQtYNbv+2f8UTo1RHNnrh48q4vLDO7FOsH4BMGE7
         PYPhlDEiukQ1uro6Chtgm6F3cgly1wmOk8YWxmx2+eca//3yUOGGrTdSKSACnddmSIJ6
         LfbEmI2X6z8c1d2vFqhwJvguQ5d8Q8f+KGzMP2s01ab2vYU7boHRsuoTsQtqR2TKs8rr
         zf9BFPal4Sg9ShnmpT9ZRzTxlstzfV3SpxoQlN3ZL3DzhNmv0vJR8T3hA35W5fRtZ6Ih
         F6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWTYahFL52ctaP0F5u7k673KHMl6RU4C5Axvk+hpwhR1ICqGrk2eamm9/FvId9dt0vADPL+ZIbRGLdJsQ5fdf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFeMmHhzQhS2imKPU5sjLXQlLew3p+bOrjTSNYF635gDAgjrcI
	F4ETUHEReCoBNOLXtrUUuBHZ4F93ksDSHele3rH04YWLb+itewS/6UnX8uh7U6W2adx+H/yNWD+
	seYGTbEwotxv6fJ98WCY9NkNch3OFw4tQU+1nSsvq
X-Gm-Gg: ASbGncvF6hmainiTqvETjT5rI6H9kj2zG6ahQAbTaFUf5ifXcWzzgc6lNola9HExrq1
	xHBCdEBK+iVz1V3aCfUdA+pAuOPEw+oztEzB8ZIv+Xf1syaukSO4hIZEpiOLYAEeKINofZJiuIh
	DT9Ztj6e+X7++cRfB557rmRoaN238WdWqcVUJi9ql2tkTwlBdFdxLZFgJ63Q0bJS15R44rGGU0S
	AoiisYFDCdaR4IBTIWc+lgCDTugBgGyAZZTumaYT/8dzgPadYzvUDC2vZO2X/YKqIpH9/YS9jph
	31FLDA91unJZ
X-Google-Smtp-Source: AGHT+IFvLNEtH2e5/dO5x9kwTjOA1XboZaWBElllxhFQnYr0glf12eW6jY3ATCxllGYkUI6x229ESRphuK+7A9uRrb4=
X-Received: by 2002:a50:9ee6:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-6366271cc53mr92789a12.7.1759242426105; Tue, 30 Sep 2025
 07:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com> <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
In-Reply-To: <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Sep 2025 16:26:28 +0200
X-Gm-Features: AS18NWBrH6EzLSqnkNtObif1pJ0uyYEfSCvr2raYhHSw1EgoC2pdUUiHvV6uX9s
Message-ID: <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > This series adds a "dont_audit" action that cancels out following
> > "audit" actions (as we already have for other action types), and also
> > adds an "fs_subtype" that can be used to distinguish between FUSE
> > filesystems.
> >
> > With these two patches applied, as a toy example, you can use the
> > following policy:
> > ```
> > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > audit func=3DBPRM_CHECK fsname=3Dfuse
> > ```
> >
> > I have tested that with this policy, executing a binary from a
> > "fuse-zip" FUSE filesystem results in an audit log entry:
> > ```
> > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipmou=
nt/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > ```
> > while executing a binary from an "sshfs" FUSE filesystem does not
> > generate any audit log entries.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
>
> Thanks, Jann.  The patches look fine.  Assuming the "toy" test program cr=
eates
> and mounts the fuse filesystems, not just loads the IMA policy rules, cou=
ld you
> share it?

Thanks for the quick review! To clarify, by "toy example" I meant that
while I was using real FUSE filesystems, the policy I was using is not
very sensible.

I used real FUSE filesystems for this since I figured that would be
the easiest way to test, https://github.com/libfuse/sshfs and
https://bitbucket.org/agalanin/fuse-zip. These are packaged in distros
like Debian (as "sshfs" and "fuse-zip"). I mounted sshfs with these
commands (mounting the home directory over ssh at ~/mnt/ssh):

user@vm:~$ cp /usr/bin/echo ~/ima/
user@vm:~$ sshfs localhost: ~/mnt/ssh

and mounted fuse-zip with:

user@vm:~/ima$ zip -rD echo.zip /usr/bin/echo
  adding: usr/bin/echo (deflated 62%)
user@vm:~/ima$ mkdir zipmount
user@vm:~/ima$ fuse-zip echo.zip zipmount/

I then ran the executables ~/ima/zipmount/usr/bin/echo and ~/mnt/ssh/ima/ec=
ho.

