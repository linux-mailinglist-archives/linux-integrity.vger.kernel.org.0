Return-Path: <linux-integrity+bounces-5821-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945BCA85191
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B128C4E66
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786D27BF8E;
	Fri, 11 Apr 2025 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eMmAg41s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92E27BF83
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338518; cv=none; b=VudbHBe81ezOe6mlqIBJqcyl/izM8jLRSl2fFR24BoytOSF0wbQh2/n6t6y+cIyaThDALgodLBraTR+AO6UV0zYGQzdIUTH5akq2N/RTp3xPmNPM4MmW/P9toaYAErK8UjBjEXnbuvIJJ7XiIQsV68tChSABi67DwSWE91my4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338518; c=relaxed/simple;
	bh=icjBLFY56UHJrggxVGEqEhmJgnElvi6Hulw/BacZfJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n21dXRBm0kBBj3RmZDRSJlPrMiDLMMrNI+329X1gohiHPgyBAljpMGrQFldPYVEZk1lobdlMYp3lr/3jfhZtx+nme8GRfUKyQrzPo26zqCT0AQH03iOWFoS+q1gHzSxhWup4ZbpPkvrUJ8vNg5I4BBq8ZAAe+youS2c7IYxpv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eMmAg41s; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so1369254276.0
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744338516; x=1744943316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZEtF/pCU0xjSpnJWvxPICK3BcguIOKOxPbIc47ziq8=;
        b=eMmAg41sE9oc3tkTSqCSfNC7pNmyBAGLZvMWUkLbnDP6l5O//v75Cv5SckX+Fbjcql
         A5tdLcDPdbq9lop0N6Z3eKYtfHaXvEduAbf38G9vu9OgD1CdinpG0qnt29/MULMI6tdU
         tKvgRPZbfLq674HXX3ecTwLzhFhn5z1e3/mI9BHMEQxzR+IoSK6iVNtmOrTN/HNNJjLF
         Pqpmq1NRLDyoiJbH3XFOiN8XpHeCS/Vch0iBxKRTuawWNuvfPSkVSodHRa1aN3FxOS4c
         hn9nOQ3T2POWeqreiDq4QsplZOrY3ymQ+dTg5PcITzOrA4HkW0wKcOryQLawuZA+TCOh
         BagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338516; x=1744943316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZEtF/pCU0xjSpnJWvxPICK3BcguIOKOxPbIc47ziq8=;
        b=HlVX4+Mu8E4pS//zafLaErh+MYK9IjV55b5Yi+M4JDu67+yLC/i6Xzu+sbf1Gae8kT
         yJYWG4J8MVVOTJjwU7kYUdP/zJfm43wWxsAU8XELLpbXKsmgMbSrnMgGAtoAU9rvrNib
         owSZuPCRTw4S3VLvITiteb8uzIH3fCKj24nRWJeYIcLIGz8yDQSgbG3276UlvW8wuWzk
         mYPFRoPB0yR03zclmk0VPVMZFOBJNKIzajYKPwudkzTwQ0YNjZriXzQWjTlrf6BvcCVj
         uByhFRha0pCDLNOD+zAD3q6q+nd/daEe3nSs4eHwxuJTmFVHP8NK1727OiOSCN5giI1K
         FH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVdRO0Q/+DeVCischn10pWennqx666oGGevrXs3Aul66k5a95NBY1hHoIdWeOqkPH4dbXaFwkOUWWEiB47ZFCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkLQZFc1i6wqQn3l/ifCAOq/TPF2tdxEmpOzgUnbuudaBKayP
	Xyn23wLDWHbGDdfFhD9KxT9ErWDuyDj/cyOGe8xFun0WyzU1aFQQm/XbyzxOholLRjLTPrqha6Z
	zRuJ7irL543W6H0n7JuQL7GypKe3cO/krxFdP
X-Gm-Gg: ASbGncvB+g1JKZIKU1+qMvRmZXnf7qym3qhBzqsgfnSp4SfILPl/IYyCnKDZnE0dh9O
	MNZMrYfZ1oE73FREKLZeZcjR42riOHxQder0unFERJ4RBZLpr8rF3s85oAr7DN7k1OIA4Ao6SQp
	GyjI2Hh8rJL4YzaFUUZ2euBYPRkWJyGWHC
X-Google-Smtp-Source: AGHT+IFdWXV2emA43f6xmM+9Cj7EAvrjlWdR0Rugh3hZ9aV3RgG2k+YBMLUiynWoHmvvgOrlv02InaGJ/HXSr/8W4tA=
X-Received: by 2002:a05:6902:1b8a:b0:e6e:195d:406b with SMTP id
 3f1490d57ef6-e704df6d71cmr2252687276.28.1744338516006; Thu, 10 Apr 2025
 19:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
In-Reply-To: <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:28:24 -0400
X-Gm-Features: ATxdqUH4GZXGi9EZedguqE9quan7dOI0mPbGtxlvbQ_Q1bZXzlWCNGq98rj3Gx4
Message-ID: <CAHC9VhQznX3GphP6X47Mr7ZsD9c=UnmrZPrspsFY0+v4uu2vNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/29] Rework the LSM initialization
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:13=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/9/2025 11:49 AM, Paul Moore wrote:

...

> General comments:
>
> Adjacent patches with no more commit message than "cleanup" should
> be combined, as that message is telling me "these aren't the changes
> you're looking for".

Things have been shuffled around quite a bit since this posting, and I
expect there will likely be a few more adjustments before a v2 is
posted.

> And about that. I believe that missing or uninformative commit messages
> are on your list of things that displease you. You will need to improve
> them to get them past yourself. :)

You'll notice that I highlighted the garbage commit messages in the
list of things that made this a RFC patch.  I'm well aware that this
is a big problem in this patchset, but I know there are individuals on
the LSM mailing list who have been anxiously awaiting a peek at this
work, so I made a decision to post a very crude revision to satisfy
that curiosity.  If you can't appreciate that decision, I hope that
you can at least understand it ;)

While I hope to never post a proper (read "non RFC") patchset with
such trash for commit messages, if I do, I would hope and expect that
all of you wouldn't hesitate to chastise me!

> There's a lot of churn here due to unnecessary name changes. I can't
> say they're unjustified, but the patch set is bigger than it needs to
> be, and more disruptive.

Perhaps, but there was some pretty awful code, with some pretty awful
names, in the initialization routines and if I was going to spend the
time to clean it all up I felt the renames were justified.  If I'm
ever going to pull a "maintainer's privilege" card, it would probably
be over stuff like this; I know it's trivial, and churns the code, but
I can't tell you how much it bothers me when I keep reading/reviewing
code with awful names.  That's probably why one of my chief nitpicks
with a lot of patches comes back to naming.

> I haven't tested it, but I don't see any substantial problems so far.

I appreciate the review, I know it's not an easy patchset to look at.
The next revision should be cleaner.

--=20
paul-moore.com

