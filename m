Return-Path: <linux-integrity+bounces-5941-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F3A94456
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D027189EEA9
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AB1DE4EF;
	Sat, 19 Apr 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afzw0S5U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF142900;
	Sat, 19 Apr 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078338; cv=none; b=ld/PaTp6DnvapFkJ4WNccnVvkOWHFKsn/4jja9BGatZR92q7SEsODaffc9vcBoEr5FZD06gPyN4rfSr6kYruC2JJ6PzwjWALo4II72ZCEZc4ZBKFhI6p7yOyFvNJMRKWNuEfXQ65ntAFWZSdT6AZLA9u0uLufL/cEKzWFISU0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078338; c=relaxed/simple;
	bh=ZIsY/svZXedF+7gdMFbltFTDVcHpQ4x5ZlpxTXXAbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLC2xSAiuYwnqtVWbBHOIVOY0HnUZD3bReyW3k7pA7/LzOcecNBzzlccfz1iVMc1ILB247etfu+87XW1iyMwzD+kYo+xL4A0ZgojPjZEp1Azbu9VmLosAdesldrFEZiyfe712dtpzrAxU+Z6L1oT/Pl5G1OW91nMJt7snJLqkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afzw0S5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71318C4CEEE;
	Sat, 19 Apr 2025 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745078336;
	bh=ZIsY/svZXedF+7gdMFbltFTDVcHpQ4x5ZlpxTXXAbhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=afzw0S5UzVrAD42ZSm6V3kbMAPfKhPAm1uEWMdzb0u8xDzaCEjXSpLp4tMfwEB2nK
	 mbskOKmnnbO2kRGgDi2bzPue2AfPoJwKgDUjd9219NaXpuIlelOCvhFWaA0l8JDJXA
	 h04vQ9PVQvu/JrvrUo+CtALrOkvW7dcj17p8nYCwBRj24DD7n3savvFaQ8GuVjxGxG
	 R4T4bfdaVLe7cB5B7ETmzoTR/upb44N7qmqD6zEvwKQApxLMqKHr9y1BDkGgujT7ih
	 msES0aVsSnmFdUoh/aSGfvfRJLF7XsQGRZIvCdX5QRAQEFZs5hsXR2F3GzaSStShw7
	 4qnlQTXz3uqJQ==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e589c258663so2265525276.1;
        Sat, 19 Apr 2025 08:58:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSa09MiMxCL568oegH/ap8yOCb1bElFfB1C6bSckGMImZlXuqCKffrUKYg0pRLFPjuzDs/DqqygWAWx0sGAik=@vger.kernel.org, AJvYcCX9i2bExEutVlFrAzEJC6vBvGE6rpcAEVu0X0U+du40VygBfc/DtCWqHdpoJyYsIUjrw2xtAnF8moPyTk7vE5VyDJ+kFxhT@vger.kernel.org, AJvYcCXTmQ2dp4f5/yesS6/OVCypIHgc3tpLH4SHYvqyBvpCW5399PlHTYDuwn1axTMdJojhsjoBDWCIiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wSBrtdtZqJ3+BA/PVgjvPF++jErJkAhfA5TbgH/zUDMkhl/I
	FfqoH65fuMZRk5F9o9p/W3DqRcAD9FPYPCXn46jEf1GtVSfPUfrSihQPS0kvCbLVpF8wjaDr44I
	FH/YN9SxQLu3R3qy900Kv3QSP2f0=
X-Google-Smtp-Source: AGHT+IE9FRlOqqNuenWj+eKlXMKN+BfGgq8XfQpkDtiApC9mUsncTCY13xIBxWvYQ9sa3pwPir8Bjf2BCiCuVCzxDRs=
X-Received: by 2002:a05:6902:1021:b0:e6d:d996:d8e2 with SMTP id
 3f1490d57ef6-e7297dca9bamr9031390276.14.1745078335761; Sat, 19 Apr 2025
 08:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-41-paul@paul-moore.com>
 <CAKtyLkEzie5dg2sVETdZ6NZwwN0Ni7SY4Za5mDCMWRJkUtYh=w@mail.gmail.com> <202504182252.64ED7AA4F@keescook>
In-Reply-To: <202504182252.64ED7AA4F@keescook>
From: Fan Wu <wufan@kernel.org>
Date: Sat, 19 Apr 2025 08:58:44 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHvHswvM+E3DyMr7N7rxHORqR=Rdy0=N2oLWjR4_FzmJg@mail.gmail.com>
X-Gm-Features: ATxdqUGydYk_tE3Q8oEXD8nwy2RFAxMAh4eG3VwRt-oicTs-T4iV3rAk_8m1wms
Message-ID: <CAKtyLkHvHswvM+E3DyMr7N7rxHORqR=Rdy0=N2oLWjR4_FzmJg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
To: Kees Cook <kees@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 10:53=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Apr 18, 2025 at 07:42:52PM -0700, Fan Wu wrote:
> > On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > Convert the lsm_blob_size fields to unsigned integers as there is no
> > > current need for them to be negative, change "lsm_set_blob_size()" to
> > > "lsm_blob_size_update()" to better reflect reality, and perform some
> > > other minor cleanups to the associated code.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
...
> >
> > Can we use size_t here?
>
> These blobs are relatively small -- size_t would double the memory usage =
here.
>
Thanks for the insight. The memory usage consideration makes sense to me.

-Fan

