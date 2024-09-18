Return-Path: <linux-integrity+bounces-3638-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60897C0EB
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BF21F22673
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C601CA69A;
	Wed, 18 Sep 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+ByRvPh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD214B94A;
	Wed, 18 Sep 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691933; cv=none; b=VRrusPmc8fHiQsQ/4xUqpM8/D761DC3lMtcDdnuc976VyHx6DDmRY8UP/c2/4TPiu+CAHvwqQ5Kk8kjYP4Rq3OUNsr40cNfplG9C+IODyYCD3KY7Odt74EsSy6jkCXfhB51temB87wSSFc4SSq31F7UKqcfkBW6EnfYuRfGIQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691933; c=relaxed/simple;
	bh=boUgcIfKgwAPas8q5f7eAfrRLxFQ2JNLZrh82hZUHdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Mz3QT0uR/LJRjX8pyv9Sod2VIv/aeHQxnY6XK47KTwr9/YFJ3Slcz+HgjEwFkpG+M7x+6jK5ITrFfRx8VgtXo7/ndjkE/03cHJkDFL6CchV9XkWxsUsgfGOLcXscDOIRokZLQOUvgpus1ZuUF4Ej8F0Y5Rro9VQdpSWycmAVcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+ByRvPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB5C4CEC7;
	Wed, 18 Sep 2024 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691933;
	bh=boUgcIfKgwAPas8q5f7eAfrRLxFQ2JNLZrh82hZUHdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+ByRvPhXKW0rwxwIHG40X8E525AzfIehe78XuaCUlI/fdfD0RFPTl1wC1G8WM+gH
	 U6SxfXdsuhqnCQ6G7Ud1xpYFGsZFyKNh6CN37LFREmzBEd/D/gawl/a9hV9TU7rXvT
	 L9uN3++f3UzEqG7e43bMzYJgk71GxXZKgasZkpyxCBYjXVj+eZnp9URG7I6z4FtrKh
	 x8HwQ/LopRUtft3OAqYT1sSI6Vz4IHfLLOo/4cLNIo1W4istSfu6VMQ4uOnJ2hYkIF
	 rUh0Qtt+hm5Fjw8KITUD1OPltNg/2CRao31wegMTQSWYCm0Zcb6GFo22xvwUvAhuL1
	 7Y9hCsz1G/1JA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 23:38:49 +0300
Message-Id: <D49P7DT1HDLG.15LBU78Q192XB@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Pengyu Ma" <mapengyu@gmail.com>
Cc: <linux-integrity@vger.kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <roberto.sassu@huawei.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] Lazy flush for the auth session
X-Mailer: aerc 0.18.2
References: <20240917154444.702370-1-jarkko@kernel.org>
 <CALSz7m0EvuDmRQHCbmwA=ED-bt7x8mhCS=X69f+yx60SYq7VgA@mail.gmail.com>
In-Reply-To: <CALSz7m0EvuDmRQHCbmwA=ED-bt7x8mhCS=X69f+yx60SYq7VgA@mail.gmail.com>

On Wed Sep 18, 2024 at 9:47 AM EEST, Pengyu Ma wrote:
> Hi Jarkko,
>
> After applied this patchset, the boot time become 8.9 secondes, it's
> more reasonable.

Great! I have some ideas how to further optimize but within context of
the bug I think we are now in reasonable figures :-)

>
> But this patchset can't be clean applied to upstream 6.11 kernel.
> looks like file tpm2-sessions.c is changed in your code base.

Thanks for the feedback. I decided to drop the couple of "cleanup"
patches and relabel performance fixes also as bug fixes because I
really think we should backport these to v6.10 and v6.11 trees.

I sent v4 which should be easy to apply on top of v6.11.

>
> Tested-by: Pengyu Ma <mapengyu@gmail.com>

Thank you!
>
> Thanks,
> Pengyu

BR, Jarkko
>
> On Tue, Sep 17, 2024 at 11:44=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> >
> > For the sake of:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> >
> > v2:
> > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko=
@kernel.org/
> > v1:
> > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko=
@kernel.org/
> >
> > Jarkko Sakkinen (7):
> >   tpm: Remove the top-level documentation tpm2-sessions.c
> >   tpm: Return on tpm2_create_null_primary() failure
> >   tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
> >   tpm: flush the null key only when /dev/tpm0 is accessed
> >   tpm: Allocate chip->auth in tpm2_start_auth_session()
> >   tpm: flush the auth session only when /dev/tpm0 is open
> >   tpm: open code tpm2_create_null_primary()
> >
> >  drivers/char/tpm/tpm-chip.c       |  14 +++
> >  drivers/char/tpm/tpm-dev-common.c |   8 ++
> >  drivers/char/tpm/tpm-interface.c  |  10 +-
> >  drivers/char/tpm/tpm2-cmd.c       |   3 +
> >  drivers/char/tpm/tpm2-sessions.c  | 196 +++++++++++-------------------
> >  include/linux/tpm.h               |   2 +
> >  6 files changed, 109 insertions(+), 124 deletions(-)
> >
> > --
> > 2.46.0
> >


