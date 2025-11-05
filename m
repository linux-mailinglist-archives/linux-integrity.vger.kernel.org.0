Return-Path: <linux-integrity+bounces-7567-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A9C33CDB
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1164E39B5
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67623BF9F;
	Wed,  5 Nov 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZaG3Cm7O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBC2D7BF
	for <linux-integrity@vger.kernel.org>; Wed,  5 Nov 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310882; cv=none; b=EQ6w5YU8i0ucw/gFDgBfnkBW0KTVwamMUGc+7JEjxx7BKe4uFoSnQd7CVZyefdDWFvZp0LDwCHKRIfVo3hXAzf4ph5bwIr5HyDcKOs94G0doqHr65FroYhXKDVuKPlFvTTCFO2e1DEDDfb6iNpinm9UYssViQVZ5W75xHmfym8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310882; c=relaxed/simple;
	bh=rXf5u+fnVQB8ijTEi6AvLLG2mpb9BXOpnmRrCXsI4IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ8rWIL4F+oFrIwhgiMvwN4axKK78Xc2bVrM1yZ+XZ1vxxOPztoj60lGp10Pqv6r0kWMijv+RwrJvuy0Q8YFPu0s5eNpFQwOFvw5/KN7fyQi9eudC2eClMM+eb/YA+5BMI4SZx3y3d/Rl6oRdA28VhCW6H77dKWfbiMyX1Q42e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZaG3Cm7O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34188ba5801so1055051a91.3
        for <linux-integrity@vger.kernel.org>; Tue, 04 Nov 2025 18:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762310880; x=1762915680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPz8gud/XQUy5E/Kke8SRPmK6elIY9QqlM3PyIOa7cg=;
        b=ZaG3Cm7OrmjG/OhloobS5j6vdVxLdh/BqI7vYnBpwloUHWwgXXLlHNm3tQGpfRnLHv
         uAH57DuVh1Sn+IN+MbM7VNPtepOfv0SRChFbMELp4OHuXQUSpt9NdB+rT6jm752i5Zi/
         hOG3lBO6F8BEz0xI1kSK5zpYeucdC4LSYbToKeErX/40epxRy0eNjk4dshiLmp1u4dNA
         zjeExBGZre2EXqfIcBc91Od4GYqjdMloc/wUPtv3PrJpC7PvdbqvJTSJAMKfWOrK9cFp
         vjpXi4Xy9OfulLClsSWbAcYn03P+5LFyd825GIikIQ/U93SFvazVLUiNw3ma4P759uwt
         vI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310880; x=1762915680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPz8gud/XQUy5E/Kke8SRPmK6elIY9QqlM3PyIOa7cg=;
        b=fBvcGD4mEm77Zg1O4BaWqUl2dZk18o2uYJniI3wDF3tV7oI9ogUpmfr0bKUAYZXQVl
         X7IOrihW3DL0ICYeLNFkydMpoJSQmbiOT/kTZvu06RvDGAxLv1YLT3/FqN16VrqDt72z
         D8IEUHGZYzT0OFCrKrKoNi8KwGsQppEY9fBOSJuqf6RfqG2y8YvyWG744hwp9U10bsM8
         CYkI5slEQq9aArN/aJ0uxS0tp+Nepl8exKQIym97jynG8rN7b/pWhZsPqIh/shOzTkEl
         mNq7EJipb8Kbsy/BVmhej4Fnb/JJr1Xxw/mA2u8ah0ymrUSRRIdOAC1W14D3iJkLhQZi
         bMEg==
X-Forwarded-Encrypted: i=1; AJvYcCUWWsJK2puJXkMSOMuSexDN8JTFs3d1EoZ51EmqOtKF5ng3Av7FLAnCvAS9tm/X1GNQDKvZl73yhCa573YSmm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zM4KytGcF9PCz9SngFM2dh+qhu82p/oqm+ZuIvwvNmmN533g
	VdBCoetpAe5eRhpfQ4toBRVIgs2Xcpu6wSNvJRbbDxcxZK/Qma7cGGO2vW84yMc5Y/b7sxhhBAl
	a4axxah/nxyJDrO8Pfi/57z+aoCDTu1iOmQklVZqL
X-Gm-Gg: ASbGnctl1ndkYuZtbtrgeOZMhCTXN/NqHNu6ZWOU3suK5fW0LqflOyQaJh1WORgoTSN
	2E4hhBeNnW6a5GT1DpM0x+SwryFwlR6jVDHw5DNc6kDNLeLRSc+k1BXv2sbxey72b3dQlHGw0Kt
	yW7n72r19yj0ux8S2oDlpALW6u5iVMtFuoAfQEelybqXEiWXnfXlWeqVZ8AQz/DFGpdTs/W9W16
	wwMP1JYSIcmq3MqbSUa/ipZBRTZJsz16Bh2bf7o9qV1yAyPgrvS6W6WkGO98Gl1uSOob4c=
X-Google-Smtp-Source: AGHT+IHnGx5CgEm/MoaWGt7F0FraTPi7R2fwUIX+qrXMRXnUPf+Tvb9LSvI/zqrUqWZwt/+nFfWSXcwZLQy2U8AshrU=
X-Received: by 2002:a17:90b:28c3:b0:341:88ba:c6d3 with SMTP id
 98e67ed59e1d1-341a6ddf6ffmr1643542a91.23.1762310879615; Tue, 04 Nov 2025
 18:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928030358.3873311-1-coxu@redhat.com> <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com> <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
In-Reply-To: <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Nov 2025 21:47:48 -0500
X-Gm-Features: AWmQ_blM1ev6BHzNyFPCCcGHeIapF6epj6-cnjfP4sh6gT-6Ml3ReEvCTyOT9dA
Message-ID: <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file
 to access decompressed kernel module
To: Coiby Xu <coxu@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:19=E2=80=AFPM Coiby Xu <coxu@redhat.com> wrote:
> On Sun, Nov 02, 2025 at 10:43:04AM -0500, Paul Moore wrote:
> >On Sun, Nov 2, 2025 at 10:06=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> >> On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
> >> > On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> w=
rote:
> >> > >
> >> > > Currently, when in-kernel module decompression (CONFIG_MODULE_DECO=
MPRESS)
> >> > > is enabled, IMA has no way to verify the appended module signature=
 as it
> >> > > can't decompress the module.
> >> > >
> >> > > Define a new LSM hook security_kernel_module_read_file which will =
be
> >> > > called after kernel module decompression is done so IMA can access=
 the
> >> > > decompressed kernel module to verify the appended signature.
> >> > >
> >> > > Since IMA can access both xattr and appended kernel module signatu=
re
> >> > > with the new LSM hook, it no longer uses the security_kernel_post_=
read_file
> >> > > LSM hook for kernel module loading.
> >> > >
> >> > > Before enabling in-kernel module decompression, a kernel module in
> >> > > initramfs can still be loaded with ima_policy=3Dsecure_boot. So ad=
just the
> >> > > kernel module rule in secure_boot policy to allow either an IMA
> >> > > signature OR an appended signature i.e. to use
> >> > > "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
> >> > >
> >> > > Reported-by: Karel Srot <ksrot@redhat.com>
> >> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> >> > > ---
> >> > > v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311=
-1-coxu@redhat.com/
> >> > >
> >> > >  include/linux/lsm_hook_defs.h       |  2 ++
> >> > >  include/linux/security.h            |  7 +++++++
> >> > >  kernel/module/main.c                | 10 +++++++++-
> >> > >  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++=
++
> >> > >  security/integrity/ima/ima_policy.c |  2 +-
> >> > >  security/security.c                 | 17 +++++++++++++++++
> >> > >  6 files changed, 62 insertions(+), 2 deletions(-)
> >> >
> >> > We don't really need a new LSM hook for this do we?  Can't we just
> >> > define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
> >> > another call to security_kernel_post_read_file() after the module is
> >> > unpacked?  Something like the snippet below ...
> >>
> >> Yes, this is similar to my suggestion based on defining multiple enume=
rations:
> >> READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_MO=
DULE.
> >> With this solution, IMA would need to make an exception in the post ke=
rnel
> >> module read for the READING_COMPRESSED_MODULE case, since the kernel m=
odule has
> >> not yet been decompressed.
> >>
> >> Coiby suggested further simplification by moving the call later.  At w=
hich point
> >> either there is or isn't an appended signature for non-compressed and
> >> decompressed kernel modules.
> >>
> >> As long as you don't have a problem calling the security_kernel_post_r=
ead_file()
> >> hook again, could we move the call later and pass READING_MODULE_UNCOM=
PRESSED?
> >
> >It isn't clear from these comments if you are talking about moving
> >only the second security_kernel_post_read_file() call that was
> >proposed for init_module_from_file() to later in the function, leaving
> >the call in kernel_read_file() intact, or something else?
>
> Hi Paul and Mimi,
>
> Thanks for sharing your feedback! Yes, you are right, there is no need
> for a new LSM hook. Actually by not introducing a new LSM hook, we can
> have a much simpler solution!
>
> >
> >I think we want to leave the hook calls in kernel_read_file() intact,
> >in which case I'm not certain what advantage there is in moving the
> >security_kernel_post_read_file() call to a location where it is called
> >in init_module_from_file() regardless of if the module is compressed
> >or not.  In the uncompressed case you are calling the hook twice for
> >no real benefit?  It may be helpful to submit a patch with your
> >proposal as a patch can be worth a thousand words ;)
> >
> >
> >> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> >> > index c66b26184936..f127000d2e0a 100644
> >> > --- a/kernel/module/main.c
> >> > +++ b/kernel/module/main.c
> >> > @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file =
*f, const ch
> >> > ar __user * uargs, int
> >> >                        mod_stat_add_long(len, &invalid_decompress_by=
tes);
> >> >                        return err;
> >> >                }
> >> > +
> >> > +               err =3D security_kernel_post_read_file(f,
> >> > +                                                    (char *)info.hd=
r, info.len,
> >> > +                                                    READING_MODULE_=
DECOMPRESS);
> >> > +               if (err) {
> >> > +                       mod_stat_inc(&failed_kreads);
> >> > +                       return err;
> >> > +               }
> >> >        } else {
> >> >                info.hdr =3D buf;
> >> >                info.len =3D len;
> >>
> >> =3D=3D defer security_kernel_post_read_file() call to here =3D=3D
>
> By moving security_kernel_post_read_file, I think what Mimi means is to
> move security_kernel_post_read_file in init_module_from_file() to later
> in the function,
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362a..66725e53fef0c1 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3678,6 +3678,7 @@ static int init_module_from_file(struct file *f, co=
nst char __user * uargs, int
>         struct load_info info =3D { };
>         void *buf =3D NULL;
>         int len;
> +       int err;
>
>         len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODUL=
E);
>         if (len < 0) {
> @@ -3686,7 +3687,7 @@ static int init_module_from_file(struct file *f, co=
nst char __user * uargs, int
>         }
>
>         if (flags & MODULE_INIT_COMPRESSED_FILE) {
> -               int err =3D module_decompress(&info, buf, len);
> +               err =3D module_decompress(&info, buf, len);
>                 vfree(buf); /* compressed data is no longer needed */
>                 if (err) {
>                         mod_stat_inc(&failed_decompress);
> @@ -3698,6 +3699,14 @@ static int init_module_from_file(struct file *f, c=
onst char __user * uargs, int
>                 info.len =3D len;
>         }
>
> +       err =3D security_kernel_post_read_file(f, (char *)info.hdr, info.=
len,
> +                                            READING_MODULE);
> +       if (err) {
> +               mod_stat_inc(&failed_kreads);
> +               free_copy(&info, flags);
> +               return err;
> +       }
> +
>         return load_module(&info, uargs, flags);
>   }
>
> If we only call security_kernel_post_read_file the 2nd time for a
> decompressed kernel module, IMA won't be sure what to do when
> security_kernel_post_read_file is called for the 1st time because it
> can't distinguish between a compressed module with appended signature or
> a uncompressed module without appended signature. If it permits 1st
> calling security_kernel_post_read_file, a uncompressed module without
> appended signature can be loaded. If it doesn't permit 1st calling
> security_kernel_post_read_file, there is no change to call
> security_kernel_post_read_file again for decompressed module.
>
> And you are right, there is no need to call
> security_kernel_post_read_file twice. And from the perspective of IMA,
> it simplifies reasoning if it is guaranteed that IMA will always access
> uncompressed kernel module regardless regardless of its original
> compression state.
>
> So I think a better solution is to stop calling
> security_kernel_post_read_file in kernel_read_file for READING_MODULE.
> This can also avoiding introducing an unnecessary
> READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration and
> can make the solution even simpler,
>
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index de32c95d823dbd..7c78e84def6ec7 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -107,7 +107,12 @@ ssize_t kernel_read_file(struct file *file, loff_t o=
ffset, void **buf,
>                         goto out_free;
>                 }
>
> -               ret =3D security_kernel_post_read_file(file, *buf, i_size=
, id);
> +               /*
> +                * security_kernel_post_read_file will be called later af=
ter
> +                * a read kernel module is truly decompressed
> +                */
> +               if (id !=3D READING_MODULE)
> +                       ret =3D security_kernel_post_read_file(file, *buf=
, i_size, id);
>         }

Assuming I'm understanding the problem correctly, I think you're
making this harder than it needs to be.  I believe something like this
should solve the problem without having to add more conditionals
around the hooks in kernel_read_file(), and limiting the multiple
security_kernel_post_read_file() calls to just the compressed case ...
and honestly in each of the _post_read_file() calls in the compressed
case, the buffer contents have changed so it somewhat makes sense.

Given the code below, IMA could simply ignore the
READING_MODULE_COMPRESSED case (or whatever it is the IMA needs to do
in that case) and focus on the READING_MODULE case as it does today.
I expect the associated IMA patch would be both trivial and small.

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..b435c498ec01 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3675,17 +3675,19 @@ static int idempotent_wait_for_completion(struct id=
empot
ent *u)

static int init_module_from_file(struct file *f, const char __user * uargs,=
 int
flags)
{
+       bool compressed =3D !!(flags & MODULE_INIT_COMPRESSED_FILE);
       struct load_info info =3D { };
       void *buf =3D NULL;
       int len;

-       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE)=
;
+       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL,
+                              compressed ? READING_MODULE_COMPRESSED : REA=
DING_
MODULE);
       if (len < 0) {
               mod_stat_inc(&failed_kreads);
               return len;
       }

-       if (flags & MODULE_INIT_COMPRESSED_FILE) {
+       if (compressed) {
               int err =3D module_decompress(&info, buf, len);
               vfree(buf); /* compressed data is no longer needed */
               if (err) {
@@ -3693,6 +3695,14 @@ static int init_module_from_file(struct file *f, con=
st ch
ar __user * uargs, int
                       mod_stat_add_long(len, &invalid_decompress_bytes);
                       return err;
               }
+
+               err =3D security_kernel_post_read_file(f,
+                                                    (char *)info.hdr, info=
.len,
+                                                    READING_MODULE);
+               if (err) {
+                       mod_stat_inc(&failed_kreads);
+                       return err;
+               }
       } else {
               info.hdr =3D buf;
               info.len =3D len;

--=20
paul-moore.com

