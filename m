Return-Path: <linux-integrity+bounces-7941-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435ECBA2C8
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 03:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C332308181D
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C283238C23;
	Sat, 13 Dec 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NSEeFOTK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB021B192
	for <linux-integrity@vger.kernel.org>; Sat, 13 Dec 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765591624; cv=none; b=HsVuvy3pMSYXXiULeZYkBLDInobXkkgE7dCKSsOen4Cy2zBgxKJLwnCgN/jf9q0qg/YQS7A7QqbzT1D5hOYusgEyFX3cvfSWJ/hJM6sSr29XxY9nZwVzGU5OQ9UITjbqBoZ1zFmx0EoiKoTMT+4x0Wh3gegpzNGHMpo77ea6vZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765591624; c=relaxed/simple;
	bh=o78EE0CBwAKtaBx4p+s0991PHX7BOfT9hDlkZYWgMa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJOtdfThCInAgfCNddOmk0cR7yInjZdDoRQZFH3T+6Xom7mIgk7F9C1RCFmMU4k0/NcesBMFMWJzh5Ve6z9xv8L5jsu47mxi1hwCqrZHrEKihnDqTEBDcfi7toan8AdebgB+MPbvcSRUd4WhzOw/cIfRqTfQHHOyq4Ug/5CVyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NSEeFOTK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34b75fba315so987508a91.3
        for <linux-integrity@vger.kernel.org>; Fri, 12 Dec 2025 18:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765591622; x=1766196422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6SUXJgzM946cTzA9BUg6hytN3ta/g/U54KdX40MWDQ=;
        b=NSEeFOTKc2sqnxxtM8QakKTHAChnmvFiX+gE73O0iphll7go4ZLx3tuNaYiYVeWABY
         vx6aAQYqpWZDGLOF811Pp2JiypDr1+SD5wX63iq7gvMHQeWmdZsQ+G9/HKqijh1m++I2
         ArAWgfKeZugRvVLHJU75dGhRq4WJX1g2ueIyytZrhyNEilYXX491Qk+GdGISIF2CQw5T
         h66FZj5whgp7KVSho7REIdI620zUvTY5W1Mh2CLY3xNSG/ns7/KEoC68Wzns8NqV5fdh
         CvQsyazwpAq7fVHshxTUsKnBvtA7LqWh2pCph83QLuUk3jGuAom4rXgZtUvNe0hqbza+
         jqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765591622; x=1766196422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6SUXJgzM946cTzA9BUg6hytN3ta/g/U54KdX40MWDQ=;
        b=B9qeeshRQqo612M3IfJJXf586JhNHl6yTZbrv2XmVXyVzsVc0ki2zjSFrSFuXPHxc9
         OkoTMs/C4z3sEmI1DbL+7awMgjCV+nTKKeN10AAH070HWaooQpuzMAWkjrLpMZSiieWf
         ckKY9flY6LeBBn5em1Hzmg9dzZn6UhU/ccm/jYhgxhj4aZCxZpIjzKwUKU6ml4HjYWMo
         i7bGxaVFMN+a0dlWjmTD8F50ZtzdRDULev+FVUZYMHKBk7+3w9Qf52Z93SPdev9/mnHZ
         KFbOJTWTeeuoaawN2YkHHZgJ93jcAf90+0P9dz1KCEPMOT5yrDaJ1KizXdJm/7hOXQar
         8Fvw==
X-Forwarded-Encrypted: i=1; AJvYcCW03llNaY8EoJWze8yYZA3LTp7kBrR2THTyV2LTDgEXEsBQM5WGW9JyEm0KCl6YMzI85yy9rcMVhm57zVsgqXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWn04K1HoszIcfsAPIIIOeCh8utgC53n7jGXP7FQyGZdHHYoL
	gysfu3p0IoD8+H8zkL+UAF3kds3+a1nt+j71kyPyh17SyuxMllHo0cYs1a0SrWcfKFGbvurDeTi
	g+R1HaoA/nroYEpD8xXV8mcQ3uuH/V+Er6KOtOgAr
X-Gm-Gg: AY/fxX5f+fOp385CjyYoX5LsQNXaJf9ysOULW8lt+9xNIfKDG3UjyrnLke7mcpNhiV1
	QHhxQFkBbkO6PsfHOU3iyacQqsYpp+1LLx//mxtoFd6p+2WO7IxHxRvewjSDy4ZAVnc92ExbJGO
	OxpWvtgviaWUQaY+rItnZUXG3FCvoqhB47zFC9Em0IqwHz1RO043c6Gu4tEIaSUnHksyFb+8XhC
	tEcyUOaV7cfoCoOZ4go/lVE6wYuCkmBTXLgF4ghCtS266jmdu7wyPfn321HxlF13Y+NhvY=
X-Google-Smtp-Source: AGHT+IGnwX71Z86N1z70pd7ITefWX/huSwRq2VYVRFVs/VS6a87brv9E91o16xh3yBqd0EXaLvFoopy9BQrXtAiOIYk=
X-Received: by 2002:a17:90b:350d:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-34abe40ea73mr3314646a91.15.1765591621526; Fri, 12 Dec 2025
 18:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Dec 2025 21:06:50 -0500
X-Gm-Features: AQt7F2pSRiV5S0YmuydrmAf_bv4hOXVpZCzrNYqlNN_g3-DMC6uEP2lNoe8lzrs
Message-ID: <CAHC9VhRUQxayj=XcdfbfHka-=N+B8cNk7Grg3QWGOTOz3BKfgw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 12:19=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the ability of staging the entire (or a portion of the) IMA
> measurement list for deletion. Staging means moving the current content o=
f
> the measurement list to a separate location, and allowing users to read a=
nd
> delete it. This causes the measurement list to be atomically truncated
> before new measurements can be added. Staging can be done only once at a
> time. In the event of kexec(), staging is reverted and staged entries wil=
l
> be carried over to the new kernel.
>
> User space is responsible to concatenate the staged IMA measurements list
> portions following the temporal order in which the operations were done,
> together with the current measurement list. Then, it can send the collect=
ed
> data to the remote verifiers.
>
> Also introduce the ability of trimming N measurements entries from the IM=
A
> measurements list, provided that user space has already read them. Trimmi=
ng
> combines staging and deletion in one operation.
>
> The benefit of these solutions is the ability to free precious kernel
> memory, in exchange of delegating user space to reconstruct the full
> measurement list from the chunks. No trust needs to be given to user spac=
e,
> since the integrity of the measurement list is protected by the TPM.
>
> By default, staging/trimming the measurements list does not alter the has=
h
> table. When staging/trimming are done, IMA is still able to detect
> collisions on the staged and later deleted measurement entries, by keepin=
g
> the entry digests (only template data are freed).
>
> However, since during the measurements list serialization only the SHA1
> digest is passed, and since there are no template data to recalculate the
> other digests from, the hash table is currently not populated with digest=
s
> from staged/deleted entries after kexec().
>
> Introduce the new kernel option ima_flush_htable to decide whether or not
> the digests of staged measurement entries are flushed from the hash table=
.
>
> Then, introduce ascii_runtime_measurements_staged_<algo> and
> binary_runtime_measurement_staged_<algo> interfaces to stage/trim/delete
> the measurements. Use 'echo A > <IMA interface>' and
> 'echo D > <IMA interface>' to respectively stage and delete the entire
> measurements list. Use 'echo N > <IMA interface>', with N between 1 and
> LONG_MAX, to stage the selected portion of the measurements list, and
> 'echo -N > <IMA interface>' to trim N measurements entries.

In an effort to help preserve the sanity of admins, I might suggest
avoiding commands that start with a dash/'-'.  I'd probably also
simplify the commands a bit and drop all/'A' since the measurement
list could change at any time, stick with an explicit number and just
let the admin go over, e.g. write LONG_MAX, which effectively becomes
'A'.  I think you could do everything you need with just two commands:

  <NUM>: stage <NUM> entries
      D: delete staged entries

I intentionally left out the trim/'T' command, because I'm not sure it
is really necessary if you are going to implement the phased
stage/delete process.  Yes, you have to do two operations (stage and
delete) as opposed to just the trim, but I'd probably take the
simplicity of just supporting a single approach over the trivial
necessity of having to do two operations in userspace.

Staging also has the benefit of having a sane way of handling two
tasks racing to stage the measurement list.  I could see cases where
multiple tasks race to trim the list and end up trimming more than was
intended since they both hit in sequence.

If you did want to take a trim approach over a stage/delete approach,
I could see something like this working:

 1. process opens the measurement list
 2. process reads from the measurement list, keeps the fd open
 3. process does whatever it wants to preserve the list
 4. process writes <NUM> to the measurement list, kernel trims <NUM> entrie=
s
 5. process closes fd

... error handling shouldn't be too bad.  The process only writes
<NUM> to the fd if it has already finished whatever it needs to do to
preserve the list outside the kernel, think of it as a "commit"
operation on a transaction.  If the fd is closed for some reason
(error, interruption, killed) before the process writes <NUM> to the
fd then IMA does nothing - no trim takes place.

Multiple process racing can easily be solved when the log is opened;
only one open(O_RDWR) is allowed at a time, other racing processes
will get EBUSY.  Yes, one process could block others from trimming by
holding the fd open for an extended period of time, but I would expect
that CAP_SYS_ADMIN and root fs perms would be required to open the log
read/write (not to mention any LSM access rights in place).

I know I mentioned this basic idea to someone at some point, but there
have been various discussion threads and multiple people over a fairly
lengthy time that I've lost track of where it was mentioned.  If it
was already discussed on-list and rejected for a good reason you can
simply ignore the above approach ... although I still think the
stage/delete API could be simplified as described :)

[UPDATE: as I'm reading Steven's replies it looks like he has proposed
something very similar to the above]

--=20
paul-moore.com

