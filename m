Return-Path: <linux-integrity+bounces-1310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EAD85CB37
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E006283E07
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 22:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E7154427;
	Tue, 20 Feb 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RpAGfWLP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0215442B
	for <linux-integrity@vger.kernel.org>; Tue, 20 Feb 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469833; cv=none; b=UZGRtsEwaLYODVur7+s9v3xT3kJF9tqKeaEDF3N4jB10FTAOTURaR/CElQsr3HRLAumyYrhZhkYDMO1VTOq0rKpjBjmNT59LY7KhHU78uJZpf/rDo7tV2dajLch4cCqNYkYWC8xnShcxdz4fIWexdcgC+7riAGyEzxvJ523uAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469833; c=relaxed/simple;
	bh=0YoTDIJcncc26mTV5po/0I8NONU1TIZscyHen9QSqfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7y4LXElWdDVl6nF9liLkjV50Al4kko5y2KJGScZz1rVYWpo5f2qeANb8JHQ2bjjBL9fbn1jsjIj6eUvc42hmlQfU52fX23ZuaYTAe/IdsRnA0MV3atK5t59R86ULM+M0bJD2pax+wYnHWciiXSlH3Pnh0gqZ73dU60osj+Dr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RpAGfWLP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso5733772276.1
        for <linux-integrity@vger.kernel.org>; Tue, 20 Feb 2024 14:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708469831; x=1709074631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=RpAGfWLPPDa5nT1skE2IjquSvPCpH4XDjqXhHemyIuLz/hdLFGrOI1tMaygPMyiCVs
         q1vL4So8FLcrldPFKwFwxHFIOlY3Tn9XtYh0dp0OU9mZt1hPj1KBXbigYV7RhBWQ72m3
         /5oWhtMSkEItzPCnERUndzCdoGbwMpLUX4LwXn+8CwqgLtjgehsJeMbx8stcuhe+DiQq
         9DTWoLBnlupgUmDPko6bERx8iVPqd/o3z4lCax8zyHitOjbWF5QwbAOx1z9SvZjJtvoX
         Va9Q7470lI85S94fjTf32AqcWVxq857I6+nq+RDXXdOmVqQUPU2L2VNe4GAXhWQ8FpVE
         RPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469831; x=1709074631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=ZljSJkPruGvcALfdnrVqqbPrJibC1+KaJTd8KGbFDvZ+ntrWEqIOyg1GjDZqnW9e95
         wIQMPQ7iz6S6I179Z7GYYLYs2JNORU829QkXwGwEAFiIDcFRCyIZSX92DaspIFBwFIK4
         cYmRhcyO3LSta0eLkzc7aYChQ1dJEPwaMR2W48NqU2zuSyN0OrXAAehIOhxqbS77H139
         DCVKOrisO/cijU9/lj/wHEY51UsGUOtVpSpdKk/eIU9fsUpbxqKKuM6ilaA8d/n/5Yky
         I7oLJLI1QdirR+hc3sFyaJ56CYUvHSfT/5KW/Cw9L2VQRgHNOoIU6EbfzZixoaGj/Yoc
         4zAQ==
X-Gm-Message-State: AOJu0YzNZBZ2VvB4gbdw11gJ1bNl5Do6waj/4xvCSm7UWHmtPp04KRAm
	MpKjz/vv1M9kOoNzmDq3958goG5dmJu29NTWQjZs2anSP4APv++9xo9I9O6PtUcJeWbsLpRXA3b
	3djvfxEBtYAxpWsJk4ro51nWv1HfuDEZZO1in
X-Google-Smtp-Source: AGHT+IFHQeTBpph6bd5Wo+fr48nsOpy94ua8Yw9g49gmhGuBFZaV/bAGvI69UADzVdw79h3Ed3LE/pbEkd6/IuyV7L0=
X-Received: by 2002:a25:ef0d:0:b0:dcd:ad52:6927 with SMTP id
 g13-20020a25ef0d000000b00dcdad526927mr16249258ybd.11.1708469831057; Tue, 20
 Feb 2024 14:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-3-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-3-stefanb@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2024 17:57:00 -0500
Message-ID: <CAHC9VhQeJGjm5VCF84W_u2wRZxHtWPMt_Ku-NqJpXUaA53EtVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] security: allow finer granularity in permitting
 copy-up of security xattrs
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, amir73il@gmail.com, brauner@kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/copy_up.c            | 2 +-
>  include/linux/evm.h               | 5 +++--
>  include/linux/lsm_hook_defs.h     | 3 ++-
>  include/linux/security.h          | 4 ++--
>  security/integrity/evm/evm_main.c | 2 +-
>  security/security.c               | 7 ++++---
>  security/selinux/hooks.c          | 2 +-
>  security/smack/smack_lsm.c        | 2 +-
>  8 files changed, 15 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM,SELinux)

--=20
paul-moore.com

