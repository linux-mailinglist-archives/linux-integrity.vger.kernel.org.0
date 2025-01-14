Return-Path: <linux-integrity+bounces-4557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2FA10BF3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15085188541E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA9157A55;
	Tue, 14 Jan 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMgDHBqx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F335966;
	Tue, 14 Jan 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871230; cv=none; b=qpWgTeqBCNvH5K0fiWViAiRDdNuLZPNBR+xESZkSkHho6hdbmHvBDwXe8ipJ/hAACl8rfv1t+zHrsz+xJfunaHVpehUFywLK8bNOsz9i+qVIbcSHd01zalKt2pGA5MH7Krj2GBJV8eYtipKHGoFY1cUb/wP2w4zqkgP+9S/Fge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871230; c=relaxed/simple;
	bh=YYVesZPSdgpBrDlyQqG/mUv7oOG7XWzeegOAHXPWCws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ51FXLZjSUXgspl18sniKFbtl5IPEagUPF7TfpKJHjTk5upiFnQSINEKerYVmhEzR5w/kKwlH2FUJpGTKyoHCQhcyR+XDuRVXSLeXwQ162YcPveu9ZWPUfVL9Mfg6zmOyYD9vVH5nMPkLE2DrBgzL0WdlTXmGAlcjSKosNckqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMgDHBqx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeef97ff02so928361466b.1;
        Tue, 14 Jan 2025 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736871227; x=1737476027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REzSH4yhDLO8NjgMwRAvoxIEo8VPLNcaq/DGKubTjh4=;
        b=ZMgDHBqxFQw2MirJyNwNErauUC1DVVXRo5vvi73ZGRU2q9E8+52Q1SCPmCxYP419Jl
         oFQRzC9QV6nDGzycDUN74V0yEZB7Bhb+w1J/PfDOjDqvippqZ777csQOp1X1PhEcY5E9
         aV2UxskHxPMauFUWFqjgBDfTERb60YnY+RvedXLm1D7vhePoDGbvecLufYKxjurTB4FF
         /HR7bQ+HcQ3E+ntXOsXD/YKWg6xOr0C2y+MNfzsNbk8JF1ftdbG/deXb5iLodkNqhndx
         b6bITAb62R9onjKneAGCFzteI/B5goaXLbRFeH3vWXhROqMYSx2dPeZb2EcIZFoG1HuP
         7C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871227; x=1737476027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REzSH4yhDLO8NjgMwRAvoxIEo8VPLNcaq/DGKubTjh4=;
        b=DYlBDN7qx6Fe14t1oUWqIxhrSaUkM9hSLgPch/3mbB74+/I0ZQzgoN5dR+0hyF7Nd+
         hPhwDFFSjxYswHfUGGrw58D0hI35E7W6SD7kEXsDHctKJIy2AV6eaxNcpue6/pQepFv6
         xVMLYRkUBQVzaM4oy7IsuaPu+OOFrCyWb9AgIBQRN2qWTu9Fdh2L1DuR3AgGMoSEx5w3
         LOWkl4Kt7WWuS1EQEmuCf9QAw7JV4ugYTl+c+Q/J0TlgFgsWPA5zIiz1acA3d3sXBgIQ
         s2Ww7qO2f3vpC5gntWEZnD2HfnGPKCi7bdjentUMaIkWhgPTyCvqlV9dHbJVr/U2u+gj
         FIDw==
X-Forwarded-Encrypted: i=1; AJvYcCUIC1wZ1N7IyucpVZx8TdzfsGQpgTfQMOf4AYeGi1LfyOU583+y6WoGntUT5WWQNDbNg40FZOuL4oaKeT+09oU=@vger.kernel.org, AJvYcCXJZwupNNQXcAbIrvvCnx9hiQa8ea5EscUs98HKe3LYrE+0wXxIv/m8R0hmWd4QZ+8pY+HLhfCVMAuSOYPqyZNiiLzPCd2t@vger.kernel.org, AJvYcCXX+uASGFJ6prvfrK7tLJpX7FP6Wc4hm08gwnvWu+1+UM7k2LB64dw6NVpTz9yFY+QbKe3hUmLT26LzK3MB@vger.kernel.org
X-Gm-Message-State: AOJu0YxzuhAKIJagKrS56Au6OlFKMpYvXwrAM3AD14fspTmPYXye+2TV
	CPl3M9Sv7KYtH2105dPoqTqxPQyTqcsNg7Ttxk1LdHs2jSySwebEfsZ5YVW8ZX9TKmocHZV5E6L
	+nJs1GlRaPg0dzgwjIiQsS9v6AdA=
X-Gm-Gg: ASbGncvOtIVh1U8NYBVFy1X99D+itxCsMSU7wVrCJzITxXtOF7FYTL9dwdc7hoWiaFs
	pdojc+03rUJlF27dFiNnSe+gS/vE/YVT6wCwjWT4cNMC48vLx8D2ly/f02XZ8lxwUwAylyBIS
X-Google-Smtp-Source: AGHT+IHfUa2T9hmA+yE2tNUCc5EEsgMa1En9ZeCxdpUYQgtW5NsOqO2EBrDWdKsbAlbD5X5gZ10c+VCpT7pMRMxlQPM=
X-Received: by 2002:a17:906:c110:b0:aa6:3da3:db48 with SMTP id
 a640c23a62f3a-ab2abca061amr2389992366b.53.1736871226609; Tue, 14 Jan 2025
 08:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <20250113.a860b47a11c7@gnoack.org> <d1b05612412a1d4b858662f296b45279c2141aa8.camel@linux.ibm.com>
In-Reply-To: <d1b05612412a1d4b858662f296b45279c2141aa8.camel@linux.ibm.com>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Tue, 14 Jan 2025 21:43:34 +0530
X-Gm-Features: AbW1kvZI6OeEaHe6jrROM7_UZdMN5yodd5GfuQ7LCBF4Zely2GTCiPUb4NEv39U
Message-ID: <CAPdGtUw9Ee7weCmS2ZP-Hi5KwPw9-O1fGRrY_KLKQh-SWgEN5Q@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	mic@digikod.net, gnoack@google.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:49=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Mon, 2025-01-13 at 15:50 +0100, G=C3=BCnther Noack wrote:
> > On Sun, Jan 12, 2025 at 12:59:27PM +0530, Tanya Agarwal wrote:
> > > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > >
> > > Fix typos and spelling errors in security module comments that were
> > > identified using the codespell tool.
> > > No functional changes - documentation only.
> > >
> > > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > > ---
> > > Thanks G=C3=BCnther, for catching this error.
> > > The irony of having a spelling mistake in a patch that fixes spelling
> > > mistakes is not lost on me :)
> > >
> > > I've fixed it in V2 of the patch. Thank you for the careful review!
> > >
> > > V2: fix spelling mistake - s/beeen/been/
> > >
> > >  security/apparmor/apparmorfs.c      | 6 +++---
> > >  security/apparmor/domain.c          | 4 ++--
> > >  security/apparmor/label.c           | 2 +-
> > >  security/apparmor/lsm.c             | 2 +-
> > >  security/apparmor/policy.c          | 4 ++--
> > >  security/integrity/evm/evm_crypto.c | 2 +-
> > >  security/integrity/evm/evm_main.c   | 2 +-
> > >  security/integrity/ima/ima_main.c   | 6 +++---
> > >  security/landlock/ruleset.c         | 2 +-
> > >  security/selinux/avc.c              | 2 +-
> > >  security/smack/smack.h              | 2 +-
> > >  security/smack/smack_access.c       | 4 ++--
> > >  security/smack/smack_lsm.c          | 6 +++---
> > >  security/smack/smackfs.c            | 2 +-
> > >  security/tomoyo/domain.c            | 2 +-
> > >  15 files changed, 24 insertions(+), 24 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/security/integrity/ima/ima_main.c
> > > b/security/integrity/ima/ima_main.c
> > > index 9b87556b03a7..cdb8c7419d7e 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -983,9 +983,9 @@ int process_buffer_measurement(struct mnt_idmap *=
idmap,
> > >     }
> > >
> > >     /*
> > > -    * Both LSM hooks and auxilary based buffer measurements are
> > > -    * based on policy.  To avoid code duplication, differentiate
> > > -    * between the LSM hooks and auxilary buffer measurements,
> > > +    * Both LSM hooks and auxiliary based buffer measurements are
> > > +    * based on policy. To avoid code duplication, differentiate
> >                           ^^^
> >
> > (Small nit:) This change from two-spaces-after-the-dot to a single
> > space looks like it happened accidentally.  The two-space style is
> > dominant in the ima_main.c file.
> >
> > (However, I am not involved in IMA and others have more authority to
> > review this part.  As Paul also said, reviews tend to go smoother when
> > the scope for the patch is a single subsystem - it makes the
> > responsibilities clearer.)
> >
> > > +    * between the LSM hooks and auxiliary buffer measurements,
>
> The spelling mistake being corrected in two places is auxilary -> auxilia=
ry.  Thank
> you for noticing the unnecessary change from two spaces to one space as w=
ell.
>
> FYI, I agree with Paul the patch should be split.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>

Hi All,
Thanks for the review.
Sure, I'll split patches of different security subsystems so, that
they are easy for maintainers to merge.

Regards,
Tanya

