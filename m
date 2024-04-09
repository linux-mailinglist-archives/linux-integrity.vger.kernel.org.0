Return-Path: <linux-integrity+bounces-2040-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B689E43C
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Apr 2024 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FBE2848C1
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Apr 2024 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416F158207;
	Tue,  9 Apr 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZtcfELs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F808562A
	for <linux-integrity@vger.kernel.org>; Tue,  9 Apr 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693699; cv=none; b=KvHLEhBUfoQGwmY+9Bx/bGqXHmNhe9A9rOMG8rDT62U0A9MTonDKhzT5tXZLZxnZ+/YJZ0hs6/9/tqlVK67djsKbNzWJjw38G9rg4YWYMTImgIssHPlhlpT4WR8PVZOFJyqRogx6F79HxgOMfVPNJrcQ5hkA0tgfxGVzrHmnKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693699; c=relaxed/simple;
	bh=2SbgLvgPGkcDv0lCPd1iXo8d7o7QDk5hgPKEFcSWSls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTDs1a2eGglfPtn5WENncj0jn/k2nKMUYwP21GmiibX1J++LkbSAUnwXUK+Ojndx+s8PRB2g5b9ne3qO0av5b527AGmQ4PTM5MUKe3cgs4Awr80CqbQcXTKaDbauDu20B3uotyeQ/Z5Tg1wVYCZL1dT+BjDxKUV9pcPDzn/8Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZtcfELs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5672457276.3
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2024 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712693696; x=1713298496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0YVQ9djY2M33MWph8FPZMPtyUpc6ybsMtuQAt43J/Y=;
        b=PZtcfELsz3rwGgDJAZIoMllf//1Z6O7akXXFVcVivFc3oFY0oUs//r3yGCUL1jyLPe
         pi3Z628Cxz/kqdRFUZRa2QX9cSCgNVGe9wSQMLE/FYv1loD/asr64OhME59V8FzCuDqh
         UOV1QdeJcF1CI0/+UotCzIDkxGMTx6Difn+iSiFwAOxATq1J834JiWLUiSjcWWXayEBn
         Ymco/s4fIncJ5Yb5FDkdJ3ifL81/ldft5G/sqTvRfo8TpwhRz4FOsuFyZk4tA44StKzV
         sQpHSnCT7Jb5iZu2G70tvRBXBRdeB68OEiUXUnMuwatpPcs1GQCwd+9jNDhjmvgzVUah
         rn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693696; x=1713298496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0YVQ9djY2M33MWph8FPZMPtyUpc6ybsMtuQAt43J/Y=;
        b=JCsmA6KpBolI6Eo8fWGPxXkaWpNI2JKNlpdh4rPTA6baWoOcRhkvqmBE6xDXr9OQD2
         /7WAIfPMEGHvp12LPqOei9mgYCe+xNZMuuD46HUTZ9i10yev5wlnsqcwRBPq8Z8UQG8l
         Uf6uD2eercMYR7u3wF2WL5++IQ89oA/fkzL+WTP4l3zTXFgPTxe6SK3j5kqH90SpHQtZ
         mXC5nsHN2pzOOY9ZpNvPFwZDlUaE0LtUxgF33jFvc4xthEvS+vScYYt5odWxynpY5KCu
         B3Kf8ZxAyQfs5iW/TzpQhcvn0Hjlbd1jq4YWNomxI16KuoRFqc+bJYtCxfz0pb+B0hAN
         6YTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmvJLX0OyiI5qfIOk2OE48rUWo4UWYWNriowPcgtTH0vM2ntX6HOjZcZd4zOI6A2x2cIx95XyEyNQU1ED8EzZ16Xft2Hz/xxoGLT73rwzJ
X-Gm-Message-State: AOJu0YwomWsdnf3xCNkk3vTx9VjWMs4Q8JZBJS2SnH566XCYSon7GzYP
	bPqKylaGXVtAmrfWfPT0bG5WqMDh7vsCYJwlJVGQ61Vx/CR+RnwupS/U4CXfsaGZbM9y0bB+9eH
	hCg8TRPU3Nglf4NvLU+u++8EKpmgTVO+t/2Ez
X-Google-Smtp-Source: AGHT+IHOHfb3Vsx0X6ltkSVRZFRT+zreJyCaHp4J4qYazQG9Rm3OCb+u4xunfbpGxaxtGsfS74W6Ks+5hyL3bJx9lHY=
X-Received: by 2002:a05:6902:100b:b0:dc7:423c:b8aa with SMTP id
 w11-20020a056902100b00b00dc7423cb8aamr1106734ybt.12.1712693696380; Tue, 09
 Apr 2024 13:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
 <20240402210035.GI538574@ZenIV> <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
 <87le5mxwry.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87le5mxwry.fsf@email.froward.int.ebiederm.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Apr 2024 16:14:45 -0400
Message-ID: <CAHC9VhTF=-Sh6w4icTPA_=A25-EL55Nt-z=mvyb1-vONoN=5wg@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: linux-security-module@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:38=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > I know it's everyone's favorite hobby to bash the LSM and LSM devs,
> > but it's important to note that we don't add hooks without working
> > with the associated subsystem devs to get approval.
>
> Hah!!!!
>
> > In the cases
> > where we don't get an explicit ACK, there is an on-list approval, or
> > several ignored on-list attempts over weeks/months/years.  We want to
> > be good neighbors.
>
> Hah!!!!
>
> You merged a LSM hook that is only good for breaking chrome's sandbox,
> over my expressed objections.  After I tested and verified that
> is what it does.
>
> I asked for testing. None was done.  It was claimed that no
> security sensitive code would ever fail to check and deal with
> all return codes, so no testing was necessary.  Then later a
> whole bunch of security sensitive code that didn't was found.
>
> The only redeeming grace has been that no-one ever actually uses
> that misbegotten security hook.
>
> P.S.  Sorry for this off topic rant but sheesh.   At least from
> my perspective you deserve plenty of bashing.

Just in case people are reading this email and don't recall the
security_create_user_ns() hook discussions from 2022, I would suggest
reading those old threads and drawing your own conclusions.  A lore
link is below:

https://lore.kernel.org/linux-security-module/?q=3Ds%3Asecurity_create_user=
_ns

--=20
paul-moore.com

