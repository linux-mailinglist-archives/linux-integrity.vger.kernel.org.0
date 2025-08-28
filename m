Return-Path: <linux-integrity+bounces-6946-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A791B3AB7C
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA577B975C
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 20:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484F28641C;
	Thu, 28 Aug 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mIB1n8hL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA12848BB
	for <linux-integrity@vger.kernel.org>; Thu, 28 Aug 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412281; cv=none; b=rwrS5fR3kDmcNf8zLgUXUI9NH3S2JqaqVjms6Ot5Bi02rndglZQmufVEoi/w1hQlnm4kyszwiHy9j7Iq4+m9v+ogfyMILIYR/33aTAbPpvD3dLwq3NfM5wXz4D6OC2VrSQRaWJXXiOwIZaTz2sTIugEC+hUA1Afr4x5BhIhML8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412281; c=relaxed/simple;
	bh=fwMu4V9Q3WqapDL7tIyizhCPh6GFdknTswMuvUppL4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2dAximaTALq0IjJhcenOZpG2fdt6IOe7q62i/c1CDu7Cp8yYR6kA+ZvErak/4UR6Rf6TPkwtHG6dwpy2f9N1vap71+eOihSIXjTICVidqza1Cc8sh3d1zItHjeHGPUuOHz7A892N8bw6wiLUr3M7Qs6HirBetOBfuBIqr4YYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mIB1n8hL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b7895e9so215674a12.3
        for <linux-integrity@vger.kernel.org>; Thu, 28 Aug 2025 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756412277; x=1757017077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ePZgtiHOPodLjgfM5UTPjnnd5iFKMsXyVJQSH87i1w=;
        b=mIB1n8hLSqkxsv/TZqmDVZD/oTZrkL7iaorO+ld4jlaOyBaKGzFS4Np6esccK4zT2j
         gjSZhd0FsPPZFEuFPc263txs541JiTCsny5xzR7wCuG+/qBmZ7uadukuEBrE3aPQcT7g
         +707/Mn2697f1fvKYD/tgN8LaA77H3H89NAMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412277; x=1757017077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ePZgtiHOPodLjgfM5UTPjnnd5iFKMsXyVJQSH87i1w=;
        b=J5IzHpdq6KPVeNu1+0mV8LUUH8X/rB7wom6OfTnQiVZ8Fdun5QtPrLtL0MU7JxtSDt
         WYqyuvS5QjLMiYZRLKkdWe72gjA0ukIAGIEccU2dNG/TDkKfqz9Mm9dXpuq/XLTLYWhe
         P1aM9eaLCu4FQUiDMcGRY8hh4hbeyx3GTbonhXWaMtl93XXwuvC5ux+oadBMfU8DVHU1
         J1AkRqBy34OXKRqXM6b3u8rJWUcYCBZPhVoz2Hq3W6SNV3otnRhobHvMer8jmGhM5GYf
         yy8tVfDfPXysMKlBO9n/x5sw6vLsYk7UNaaG3+bodOzTRjBl2gYbv3MtYSDvMmO6a/Le
         d9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW5lNw4kYnzcjjhs/NBCSRNRgzHBprQ1/0f8ukp+H4hlRQLuF9WI+ra6hKXmL4zBzkA1IAoO9RAOGwqDkP3PFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyceMwx6o/t7feAbbueBfr+7pKREwqZRPTidI8LtxsaGWlL5hs+
	Of/964CEzBki/1yL22ps7BHX8p1VDFfnkAUhahLCPv1Ca2Xk76LP5Ek0zOW+MjcdrSsp7GpAhZD
	rLtyuCr/2ZG7yoMazI7UIbKB1+0MfnI/MXyamG3sq
X-Gm-Gg: ASbGncv5AakGCb7jIHi8h/QHbt0nFWvDtRlHcHrxk6AzGOnK2tmSfZT1BhmLh1Qaie+
	j916Dk8uB7YCylj5ihga2UD43l/MGqtYpvwoGAYRebDRlZ+JkIarHblRi2BQcBpkxrruo8Y10Wl
	pnJjq8lJTWUqMrEVKfLNzQqMeqiwnf/uvIhm0KF6Z0wlZ1abMSGM9zuDy57jxdQVRF8Tu7DT9+T
	g2raT5rjQ3HJiXjJ0YpHyjz+0DH2xza08+YVyiQiUc3fnBUrIQ=
X-Google-Smtp-Source: AGHT+IE64d1WWE8kcq3TRbS70wrOGI1tKonG+bfd4KXXEWkgnBXYalFyybrk7xruzzNjFZLWMOhENjx6cCeacRzVtmk=
X-Received: by 2002:a05:6402:440a:b0:61c:cfb2:b2ce with SMTP id
 4fb4d7f45d1cf-61ccfc1f690mr1973394a12.7.1756412276638; Thu, 28 Aug 2025
 13:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net> <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
 <20250826.eWi6chuayae4@digikod.net> <CABi2SkUJ1PDm_uri=4o+C13o5wFQD=xA7zVKU-we+unsEDm3dw@mail.gmail.com>
 <20250827.ieRaeNg4pah3@digikod.net>
In-Reply-To: <20250827.ieRaeNg4pah3@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 28 Aug 2025 13:17:42 -0700
X-Gm-Features: Ac12FXz7g15EGZQbQ__Nog7bDAptHr9NyXQh1X7xQPtUT8FxbZ8Ao8bCFm7NIZ0
Message-ID: <CABi2SkX6RFq349yn0to2FO0UJfpQxmvFsnQyL4mbg6NoJt2bUg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl

On Wed, Aug 27, 2025 at 1:19=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Aug 26, 2025 at 01:29:55PM -0700, Jeff Xu wrote:
> > Hi Micka=C3=ABl
> >
> > On Tue, Aug 26, 2025 at 5:39=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Mon, Aug 25, 2025 at 10:57:57AM -0700, Jeff Xu wrote:
> > > > Hi Micka=C3=ABl
> > > >
> > > > On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > > > > > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > > > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=
=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > > Add a new O_DENY_WRITE flag usable at open time and on op=
ened file (e.g.
> > > > > > > > > passed file descriptors).  This changes the state of the =
opened file by
> > > > > > > > > making it read-only until it is closed.  The main use cas=
e is for script
> > > > > > > > > interpreters to get the guarantee that script' content ca=
nnot be altered
> > > > > > > > > while being read and interpreted.  This is useful for gen=
eric distros
> > > > > > > > > that may not have a write-xor-execute policy.  See commit=
 a5874fde3c08
> > > > > > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > > > > > >
> > > > > > > > > Both execve(2) and the IOCTL to enable fsverity can alrea=
dy set this
> > > > > > > > > property on files with deny_write_access().  This new O_D=
ENY_WRITE make
> > > > > > > >
> > > > > > > > The kernel actually tried to get rid of this behavior on ex=
ecve() in
> > > > > > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly=
 that had
> > > > > > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78=
f79e3d
> > > > > > > > because it broke userspace assumptions.
> > > > > > >
> > > > > > > Oh, good to know.
> > > > > > >
> > > > > > > >
> > > > > > > > > it widely available.  This is similar to what other OSs m=
ay provide
> > > > > > > > > e.g., opening a file with only FILE_SHARE_READ on Windows=
.
> > > > > > > >
> > > > > > > > We used to have the analogous mmap() flag MAP_DENYWRITE, an=
d that was
> > > > > > > > removed for security reasons; as
> > > > > > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > > > > > >
> > > > > > > > |        MAP_DENYWRITE
> > > > > > > > |               This flag is ignored.  (Long ago=E2=80=94Li=
nux 2.0 and earlier=E2=80=94it
> > > > > > > > |               signaled that attempts to write to the unde=
rlying file
> > > > > > > > |               should fail with ETXTBSY.  But this was a s=
ource of denial-
> > > > > > > > |               of-service attacks.)"
> > > > > > > >
> > > > > > > > It seems to me that the same issue applies to your patch - =
it would
> > > > > > > > allow unprivileged processes to essentially lock files such=
 that other
> > > > > > > > processes can't write to them anymore. This might allow unp=
rivileged
> > > > > > > > users to prevent root from updating config files or stuff l=
ike that if
> > > > > > > > they're updated in-place.
> > > > > > >
> > > > > > > Yes, I agree, but since it is the case for executed files I t=
hough it
> > > > > > > was worth starting a discussion on this topic.  This new flag=
 could be
> > > > > > > restricted to executable files, but we should avoid system-wi=
de locks
> > > > > > > like this.  I'm not sure how Windows handle these issues thou=
gh.
> > > > > > >
> > > > > > > Anyway, we should rely on the access control policy to contro=
l write and
> > > > > > > execute access in a consistent way (e.g. write-xor-execute). =
 Thanks for
> > > > > > > the references and the background!
> > > > > >
> > > > > > I'm confused.  I understand that there are many contexts in whi=
ch one
> > > > > > would want to prevent execution of unapproved content, which mi=
ght
> > > > > > include preventing a given process from modifying some code and=
 then
> > > > > > executing it.
> > > > > >
> > > > > > I don't understand what these deny-write features have to do wi=
th it.
> > > > > > These features merely prevent someone from modifying code *that=
 is
> > > > > > currently in use*, which is not at all the same thing as preven=
ting
> > > > > > modifying code that might get executed -- one can often modify
> > > > > > contents *before* executing those contents.
> > > > >
> > > > > The order of checks would be:
> > > > > 1. open script with O_DENY_WRITE
> > > > > 2. check executability with AT_EXECVE_CHECK
> > > > > 3. read the content and interpret it
> > > > >
> > > > I'm not sure about the O_DENY_WRITE approach, but the problem is wo=
rth solving.
> > > >
> > > > AT_EXECVE_CHECK is not just for scripting languages. It could also
> > > > work with bytecodes like Java, for example. If we let the Java runt=
ime
> > > > call AT_EXECVE_CHECK before loading the bytecode, the LSM could
> > > > develop a policy based on that.
> > >
> > > Sure, I'm using "script" to make it simple, but this applies to other
> > > use cases.
> > >
> > That makes sense.
> >
> > > >
> > > > > The deny-write feature was to guarantee that there is no race con=
dition
> > > > > between step 2 and 3.  All these checks are supposed to be done b=
y a
> > > > > trusted interpreter (which is allowed to be executed).  The
> > > > > AT_EXECVE_CHECK call enables the caller to know if the kernel (an=
d
> > > > > associated security policies) allowed the *current* content of th=
e file
> > > > > to be executed.  Whatever happen before or after that (wrt.
> > > > > O_DENY_WRITE) should be covered by the security policy.
> > > > >
> > > > Agree, the race problem needs to be solved in order for AT_EXECVE_C=
HECK.
> > > >
> > > > Enforcing non-write for the path that stores scripts or bytecodes c=
an
> > > > be challenging due to historical or backward compatibility reasons.
> > > > Since AT_EXECVE_CHECK provides a mechanism to check the file right
> > > > before it is used, we can assume it will detect any "problem" that
> > > > happened before that, (e.g. the file was overwritten). However, tha=
t
> > > > also imposes two additional requirements:
> > > > 1> the file doesn't change while AT_EXECVE_CHECK does the check.
> > >
> > > This is already the case, so any kind of LSM checks are good.
> > >
> > May I ask how this is done? some code in do_open_execat() does this ?
> > Apologies if this is a basic question.
>
> do_open_execat() calls exe_file_deny_write_access()
>
Thanks for pointing.
With that, now I read the full history of discussion regarding this :-)

> >
> > > > 2>The file content kept by the process remains unchanged after pass=
ing
> > > > the AT_EXECVE_CHECK.
> > >
> > > The goal of this patch was to avoid such race condition in the case
> > > where executable files can be updated.  But in most cases it should n=
ot
> > > be a security issue (because processes allowed to write to executable
> > > files should be trusted), but this could still lead to bugs (because =
of
> > > inconsistent file content, half-updated).
> > >
> > There is also a time gap between:
> > a> the time of AT_EXECVE_CHECK
> > b> the time that the app opens the file for execution.
> > right ? another potential attack path (though this is not the case I
> > mentioned previously).
>
> As explained in the documentation, to avoid this specific race
> condition, interpreters should open the script once, check the FD with
> AT_EXECVE_CHECK, and then read the content with the same FD.
>
Ya, now I see that in the description of this patch, sorry that I
missed that previously.

> >
> > For the case I mentioned previously, I have to think more if the race
> > condition is a bug or security issue.
> > IIUC, two solutions are discussed so far:
> > 1> the process could write to fs to update the script.  However, for
> > execution, the process still uses the copy that passed the
> > AT_EXECVE_CHECK. (snapshot solution by Andy Lutomirski)
>
> Yes, the snapshot solution would be the best, but I guess it would rely
> on filesystems to support this feature.
>
snapshot seems to be the reasonable direction to go

Is this something related to the VMA ? e.g. preserve the in-memory
copy of the file when the file on fs was updated.

According to man mmap:
       MAP_PRIVATE
              Create a private copy-on-write mapping.  Updates to the
              mapping are not visible to other processes mapping the same
              file, and are not carried through to the underlying file.
              It is unspecified whether changes made to the file after
              the mmap() call are visible in the mapped region.

so the direction here is
the process -> update the vma -> doesn't carry to the file.

What we want is the reverse direction: (the unspecified part in the man pag=
e)
file updated on fs -> doesn't carry to the vma of this process.

> > or 2> the process blocks the write while opening the file as read only
> > and executing the script. (this seems to be the approach of this
> > patch).
>
> Yes, and this is not something we want anymore.
>
right. Thank you for clarifying this.

> >
> > I wonder if there are other ideas.
>
> I don't see other efficient ways to give the same guarantees.
right, me neither.

Thanks and regards,
-Jeff

