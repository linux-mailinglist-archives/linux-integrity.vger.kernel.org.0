Return-Path: <linux-integrity+bounces-3761-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFF997053
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F61F23A1B
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834291F708E;
	Wed,  9 Oct 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VGlkuqiU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26B1F7086
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488238; cv=none; b=ejUMUclrm40F2AL11DrZRpInOiZM5YcWreB/j09WdBCIeju0euitWPIHGcgKTLnXhFKyJNq7XXV0UhW7eoif/amct5oTsH3PFcb3lt+77Mffo8dDEkNvYKwkxcjqaDngXIUOKrmJnwbvDbnjfzPsqOeTAtSU+d1C4AIKTrI2N+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488238; c=relaxed/simple;
	bh=La4KVBvoExKm9pO09UAsxMsz2f1GjMBJB04Ukn3GBBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbfQ79HCNUSLNQHm3OHV8vUSNk04ijq1+OPRmkfKltTAdutq3F/I9W6vD9Wt+nsNYyu/o6Z9GlPUy6rPD3HdCgR8nwQgjOpkUr6RWNTLHnRcuKLY7DNHm7l3GJIWuqBlD9sJHx5sAc/Cp5xUhUVb5LWBBTzUkOraaNoqKyxvSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VGlkuqiU; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fa2fccc2dso675247241.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Oct 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488236; x=1729093036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=VGlkuqiUsB0pWWkcZ3G0Zj5BDzVCtgiQCy283PDBNf3/M0aBDd3r+YxGncj7lg3CyJ
         2yaYH4Tg9TyACyW2XOp+Rb4dcCfr3eOGPL4JFIx9zY5fzKgqH6Wh+OXWasXIn0GFuh7t
         U5aakPSJyibwjoQeIBRXwqFnufHi4ZcxlF4CrK0gL9Y3Mn4ne4tB71SOzrNQTPfdhVkJ
         Uf/OwTuU3Ju+0wIc25QX2ZtyzL46dx0R3Yh0sqh4/mWW5bu54Qsh4Etzp4EzonDGt443
         JEDxfZsRR2/CGo5GB2sOpLAOxq9rwkhp/GexxnA1Ws8eYu4IWdgr7ZMmOcJixiMaQK4s
         0kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488236; x=1729093036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=Wv2qKjH4K1f53U5+ViDJARWL2T79bQE69Gb6Yqe/y2+VRDog8X3ed5bXZRzndtDiVD
         DRdaizi7hCxkNedwn2NKPFISZxDv4cZeLnpE78vUxy7nMWTkTYh+8QxQL/Tz68Z+H96G
         P8Dr3KMwckRBGwfScbc0UMa0hKTuAWWY1B2W/sCY/UrEsTEFSEYRA5chnbAepGrSOBRJ
         RT0tMCwcUxFOJv22JWpCLVCChD6Yg562zXxdQrI5N472Dz5S/FUr5/evuGtk+nCk78EO
         WE0mmKrYT5pI/Y7x8YP+AnoFgXB9RunfA4nrKnWcF6dddmt1yVuKu1Won95rihYQPwPn
         ITow==
X-Forwarded-Encrypted: i=1; AJvYcCWVIj6aNZNsGTkGIbcALnUlF3+B2K4vr4JYAAwZE2BkyCx6N0vSjg5hP50coERt4fVTLc9Cgzb8IhO9jOp2LUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwLq22CcfcCpVLzOQDofFCQcxZFyy+eUBrhnSTkWDNq+WvYts
	1dx9Zna+T0H+vV7UvmiuQZO0W2IhOI76Cb23MKqj7b2i8CNS7GgSNOT12yt/LMGf86Fd3Vy7xP9
	IkXHF06ONmjkDaV2ka25Zq/hGLPTypFXgiB83
X-Google-Smtp-Source: AGHT+IEu5xzMzhH/wgeDgjEGKWpciv4mCxSojd55huo7SKv5IrO0ylLHZx0Mi5aaHn5HxWNAJbzCfGMT+FuD46vf8r4=
X-Received: by 2002:a05:6122:3126:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50cf0c7e54dmr2055501e0c.10.1728488235831; Wed, 09 Oct 2024
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com> <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:37:05 -0400
Message-ID: <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Move out the mutex in the ima_iint_cache structure to a new structure
> > called ima_iint_cache_lock, so that a lock can be taken regardless of
> > whether or not inode integrity metadata are stored in the inode.
> >
> > Introduce ima_inode_security() to simplify accessing the new structure =
in
> > the inode security blob.
> >
> > Move the mutex initialization and annotation in the new function
> > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > ima_iint_unlock() to respectively lock and unlock the mutex.
> >
> > Finally, expand the critical region in process_measurement() guarded by
> > iint->mutex up to where the inode was locked, use only one iint lock in
> > __ima_inode_hash(), since the mutex is now in the inode security blob, =
and
> > replace the inode_lock()/inode_unlock() calls in ima_check_last_writer(=
).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima.h      | 26 ++++++++---
> >  security/integrity/ima/ima_api.c  |  4 +-
> >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
> >  security/integrity/ima/ima_main.c | 39 +++++++---------
> >  4 files changed, 104 insertions(+), 42 deletions(-)
>
> I'm not an IMA expert, but it looks reasonable to me, although
> shouldn't this carry a stable CC in the patch metadata?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Sorry, one more thing ... did you verify this patchset resolves the
syzbot problem?  I saw at least one reproducer.

--=20
paul-moore.com

