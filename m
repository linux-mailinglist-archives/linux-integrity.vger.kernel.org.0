Return-Path: <linux-integrity+bounces-3660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9ED97E59D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 07:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2340F1C208E5
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 05:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE310E9;
	Mon, 23 Sep 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqSzKPXe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541C28EB;
	Mon, 23 Sep 2024 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727069213; cv=none; b=VFW9h5WtZjeu7CiMqAGa8TeKNB30RoLQ5PaQR+90LUKYAJw/ULfFYwWZdIS+bWaw8RVv7f7GCCnVrdozDRqxY8jXexT/6aN23Kogv/N/c2IMbGaX7pUOspMJbklIqGfPkp9kI4IC4fxggDDUtDJHn698Uz+8DwglYpqeMwxNwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727069213; c=relaxed/simple;
	bh=Mm0xlIlIFywQxWRVlrtM9+P05d5rdtF8j07zuxtwgJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTKWBr6iSVhyzMf4tOZYfFr576F1jhpudV0EHYwGtTOINzEHmDnpW3u46wscpmerqh+AKrjGSfRn6eVoLCgcxuDxKEX8FVBgtrNrNnK+e4olSpJVGBvSYor5nnZeSxkcTEyL/kbsCHanTrMXKp1AmPPk+VrYb4kVccrmlgVoGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqSzKPXe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2780524f8f.1;
        Sun, 22 Sep 2024 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727069209; x=1727674009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nptK88eLRGfhziZAyDg/BN+0AF91ctgPhAKjtMLU5QE=;
        b=JqSzKPXewBJIaTtiHQk+VTGONyg43CAp9g5AfSUTBjxH5bDHCd6e/SG+TsrCuoi/8F
         s5RPW3O73qRvXs87iFYIingh5USOsVXMlrFk4bI+iE89K+ungYs/awybFYUvf5IzkZQp
         JM4JE6qq02DmMserhyKMMyKWiUFK5eKy3BaWkDs9v95JUlVuXsT+HUs2IphG+mi4us/o
         4H0HPczIi0bhxkJdipBt/MQIzeF0cJgsh1sy6Ix4s2b59p8dvp73fiwTTNO6skxU/+nB
         nwpLjKU4Nbjd4lDh0qowreJyzuL9vBK8bJ5FiVvc5XiuyNd2QKKBcKc5o2mKnUE95NMw
         F7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727069209; x=1727674009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nptK88eLRGfhziZAyDg/BN+0AF91ctgPhAKjtMLU5QE=;
        b=qEu7cAYHNs74VPuqQnOBBcqOgsEz7N0aRxo9ro5ADRxUD0P4x9OIVSierbNlJQIBP3
         R6YKbkY156JqsxywCBK7D/vpf15Wj3ilE2ZLYzx5XRH//0QqemscTP1rDWiz3VYM+slN
         YdSRkUdMarV7Clr9lZYegp2AASYHBKkJ8NFw0F+Xg7nj5AHGIStw6DWLsRt1gJW2BfvG
         bANiyupW/w4tmD9ZD+NVTzXNeHYD1MscIknTYq3aT6qMtcbCKyEItYZ2sE9YKGkaPYzt
         LC3W0G2jn05r+9/LaI9iUA7q5h5xJLjkRqXP5UQSX2DjHzqOGdqX7XHDRQOZ41D5wA/z
         D2hg==
X-Forwarded-Encrypted: i=1; AJvYcCUsBPriQutjVk0IXrHeVbaVoXIb90pd4NMNw17J1bzCDXHu8o6UvWeuKjB5Qs5EgNeXODHtd2gd+bsJcTV9U6VjnFMPSfDW@vger.kernel.org, AJvYcCUvYtJICGt5GF2YF+7u/DTy/PtMQotbIXSlJVfHziCKV5Fm29slyoqfH78uT50gcSv+F76Jzmx54a0CSXsI@vger.kernel.org, AJvYcCXIu9q4pnIYropFsBMp7OYF3ZsXINwibDgxLCgU6wUMJ43eRSuhQjwzMuZdfJtr5U2n9M1UxOMBVAWLmQGeNW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuWyKs17uOl6vd0DohexJRyo73lxk69nOEBBEYF676DCxYSMI
	TIXg8EWQ0uerLxFJx+f7tzXiBBSdCeRU/IOcf7IZcup1rCUwAZPfWZIyCN4FzI54/HvHl5f5pjY
	EWIycezG/QyhWhjb5OSlwOuustHw=
X-Google-Smtp-Source: AGHT+IGN1Y1wYq62d3/z2azaE1/F6NaWqyN8z33ualFzloo4skejV5DkABiH2mZew0fz798urjCTZkGySs/DKXGrlbw=
X-Received: by 2002:adf:f98f:0:b0:378:7e74:cc25 with SMTP id
 ffacd0b85a97d-37a431ad519mr5364258f8f.39.1727069209381; Sun, 22 Sep 2024
 22:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806133607.869394-1-mjguzik@gmail.com> <3cd8019f03dae99c4e43b7613df869499ec72e66.camel@huaweicloud.com>
In-Reply-To: <3cd8019f03dae99c4e43b7613df869499ec72e66.camel@huaweicloud.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 23 Sep 2024 07:26:37 +0200
Message-ID: <CAGudoHGBTRJqKAE6Db3PyVne6rrJR4vsF2MNH2qKMy-44XReZw@mail.gmail.com>
Subject: Re: [PATCH] evm: stop avoidably reading i_writecount in evm_file_release
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:53=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2024-08-06 at 15:36 +0200, Mateusz Guzik wrote:
> > The EVM_NEW_FILE flag is unset if the file already existed at the time
> > of open and this can be checked without looking at i_writecount.
>
> Agreed. EVM_NEW_FILE is not going to be set during the open(), only
> before, in evm_post_path_mknod().
>
> Looks good to me.
>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Thanks

thanks for the review

are there plans to pick this up for this merge window?

>
> Roberto
>
> > Not accessing it reduces traffic on the cacheline during parallel open
> > of the same file and drop the evm_file_release routine from second plac=
e
> > to bottom of the profile.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > The context is that I'm writing a patch which removes one lockref
> > get/put cycle on parallel open. An operational WIP reduces ping-pong in
> > that area and made do_dentry_open skyrocket along with evm_file_release=
,
> > due to i_writecount access. With the patch they go down again and
> > apparmor takes the rightful first place.
> >
> > The patch accounts for about 5% speed up at 20 cores running open3 from
> > will-it-scale on top of the above wip. (the apparmor + lockref thing
> > really don't scale, that's next)
> >
> > I would provide better measurements, but the wip is not ready (as the
> > description suggests) and I need evm out of the way for the actual
> > patch.
> >
> >  security/integrity/evm/evm_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index 62fe66dd53ce..309630f319e2 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1084,7 +1084,8 @@ static void evm_file_release(struct file *file)
> >       if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
> >               return;
> >
> > -     if (iint && atomic_read(&inode->i_writecount) =3D=3D 1)
> > +     if (iint && iint->flags & EVM_NEW_FILE &&
> > +         atomic_read(&inode->i_writecount) =3D=3D 1)
> >               iint->flags &=3D ~EVM_NEW_FILE;
> >  }
> >
>


--=20
Mateusz Guzik <mjguzik gmail.com>

