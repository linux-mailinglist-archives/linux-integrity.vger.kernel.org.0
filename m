Return-Path: <linux-integrity+bounces-7794-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BECA300D
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95B27301EFC9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7733506A;
	Thu,  4 Dec 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiErZhOh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D491917FB
	for <linux-integrity@vger.kernel.org>; Thu,  4 Dec 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840737; cv=none; b=InktB9Kvso1xSgg7TX23Bj5Kc+vlKNrDCn6kiqI0aIlHzSti9TgXLof12/OPL8mMxgoyISCRpt1CuBdEgbc3J+Y9Kr2b6yaLPOewJQZO2aZIK/n7Gn6OP3ujPVsXC3eqQmA5tjxPclS6brLWlXc/6yoH8AXthEdyQbXnt+CqOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840737; c=relaxed/simple;
	bh=7KDSP+eJnIgbODlTxSo2m0C89a6pRbVbkfcbCzde8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFESXaIMrbYBZgLSsC/jnbI/tOThlugUJQW2nAEQwsm6krYx3BCFhuo81YU3x9/pZzWnnd9hGeQdbwdNT4SXKrpOeJ5LEpWO8gPLjkx9NE8jPScvLypzhqX7gCddWpp443Ysivxpc4omhokrtPi6LhIRmYcP2PyEKKjqO4bCbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiErZhOh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b38693c4dso304187f8f.3
        for <linux-integrity@vger.kernel.org>; Thu, 04 Dec 2025 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764840734; x=1765445534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9pe+wJENeZc5IcOvHk937NmwKikq+O3BvHjwpbysZ0=;
        b=KiErZhOhZY8yDuUXrrd4zP5DgXNsChXXR8AEJ5y0LV2jtZM2sJ+GgXZxIHDSLJ8kqv
         t44/5lQBDSqO1nzX1gXjajizaf9DBRiBc4XkHgIgKH+Xja0RyniP3P61D8gVRTSiLt+6
         8Z7/WeZqNU2wuaBxW/cUiUScO/UwTSuwzGMNpQLEUMcdAXzEv35UUekmSeJHLB9V+jKt
         fowJSb/fb0YCwM8/cTvus4tpzgzrIs3NCZix7EnxiyB75sW/tZGp5Dbg3c/WKf2g6LMs
         RLWLTfrZMikaP1W1EOHIRYkvwupCRhiBZrQhZ4toQBCEr2kiXWIwNNcI8e0F0dSNEuqr
         RQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764840734; x=1765445534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9pe+wJENeZc5IcOvHk937NmwKikq+O3BvHjwpbysZ0=;
        b=tvm1fw91FnnH7/pYh68F5J8kb5AvkcdM1gEH9/z7RA0770wfBEJ1bD2qC2l4jAoO3h
         EltqJ3SRxZ5uIEQxi2gweNwZsOnOP03Ycs2NLjUowoRsdVraItQeS8qUBAc2cFKS4Mnu
         LXk7bYzzXihVr/pAlHYdDnoq8evRgPGfuNACFMpdEFlCDWoYsJKINI5smxoQ6aSiWg1E
         bAd/39zhmLfWxiNtTe6yEgYhHSFGCt8hoG8vkrPwka1sTWajDwovg1Hjhq0jF5pN/jAR
         tOU8DiwOt8+WJrGMXkQtlUSD6FyXbiG6yknRx5XqR23ecXekwbUv3RL+gPx+HDkMis1W
         8NEg==
X-Forwarded-Encrypted: i=1; AJvYcCWvoXAnnagBxFLN8po3gKaX9CtM9fHAacN6cbCuYpx4V0I3rADNAxXPkj8IPhm45wNWdgThHsKSQhmJvv4HJ4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysVWh/Oh1vfFZ+mLsWcaTraAid4RtJ5yr3fxdVbu2KqjDipN+
	4IBzNPI0sF6zNupDevBCzpVFxzQ5liupw6cmXBYMHhRhS112aZTVzgZk
X-Gm-Gg: ASbGnctQW24+dq6pi+BRLGxLtBKBkHPuflh61UNhQmEplz4IrU/JhKb7lDumdQMmhFz
	+74F8cysLoGm2dUj1joTinjL+viNAgWR9C58jSbDr9wMppRjDwhm3fI0FAj7P275bE3J3E5q4ON
	YGgguT0nri/52fAxAdeo7jbffDtHaE01pS6rPhU9hCRNUeJVoShpBqEzaf6Fqsqb1rlbvHH/pzd
	LcieQH7suJqqS85yxkge1iNTJskpKjCJfIPEtO+W2Pb8eYCeZUQHVqPh9AJ+mMGEi7x7iwrJ0bX
	b5UbmhE3Mhwj4+Gr0q+TairGPi3aNawMy+bBuLfHTVyKcspD8/jMxEMKADSRpRXIB17Rvu6uq4E
	sTIG1Gd0g6X/9yBPk+bb5gnoZO3SckxXBmX15u6Q6ByvSEmgjC4npOw1uYH2LHyUxZjVBx7A9B2
	V/ElkXldxuUY9wJDgNRInXCctePkrW2nETfmTOvbvEpa1BtOr8hnbY
X-Google-Smtp-Source: AGHT+IEpeLb5DzDFyyRRjLJBycEA8/oon798RLVjm4cwDE2uj2+226ExQ98mf5m0TZ5rx0eulXU/Nw==
X-Received: by 2002:a05:6000:2dc4:b0:429:d725:4125 with SMTP id ffacd0b85a97d-42f7987519fmr2415263f8f.54.1764840733805;
        Thu, 04 Dec 2025 01:32:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm2182928f8f.27.2025.12.04.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:32:12 -0800 (PST)
Date: Thu, 4 Dec 2025 09:32:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Bernd Edlinger <bernd.edlinger@hotmail.de>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Serge
 Hallyn <serge@hallyn.com>, James Morris <jamorris@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller
 <deller@gmx.de>, Adrian Reber <areber@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov
 <ast@kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, tiozhang
 <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Frederic Weisbecker <frederic@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>, Chao Yu
 <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, Jeff Layton
 <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
 <david@redhat.com>, Dave Chinner <dchinner@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, David
 Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Ard
 Biesheuvel <ardb@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang
 <superman.xpt@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Cyrill Gorcunov
 <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 zohar@linux.ibm.com, linux-integrity@vger.kernel.org, Ryan Lee
 <ryan.lee@canonical.com>, apparmor <apparmor@lists.ubuntu.com>
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
Message-ID: <20251204093209.706f30a6@pumpkin>
In-Reply-To: <20251204054915.GI1712166@ZenIV>
References: <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
	<6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
	<87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
	<dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
	<87ms42rq3t.fsf@email.froward.int.ebiederm.org>
	<GV2PPF74270EBEE90CDCD964F69E806EF58E4D9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<20251204054915.GI1712166@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Dec 2025 05:49:15 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Dec 03, 2025 at 02:16:29PM +0100, Bernd Edlinger wrote:
> 
> > Hmm, yes, that looks like an issue.
> > 
> > I would have expected the security engine to look at bprm->filenanme
> > especially in the case, when bprm->interp != bprm->filename,
> > and check that it is not a sym-link with write-access for the
> > current user and of course also that the bprm->file is not a regular file
> > which is writable by the current user, if that is the case I would have expected
> > the secuity engine to enforce non-new-privs on a SUID executable somehow.  
> 
> Check that _what_ is not a symlink?  And while we are at it, what do write
> permissions to any symlinks have to do with anything whatsoever?
> 

You'd need to check for write permissions to all the directories in the
full path of the symlink and in all the directories traversed by the symlink.
(and that may not be enough....)

Passing the shell (or whatever) /dev/fd/n doesn't seem (to me) any different
from what happens when the elf interpreter runs a suid program.
You might want to check for non-owner write permissions to the /dev/fd/n entry,
but that is true for any suid executable, not just scripts.

FWIW the SYSV shells normally set the effective uid back the real uid.
So making a script suid didn't work unless the script started "#!/bin/sh -p".
Whether that improved security (rather than being annoying) is another matter.

	David

