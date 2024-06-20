Return-Path: <linux-integrity+bounces-2884-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33039108E5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708C5B22F7B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00221AE0A5;
	Thu, 20 Jun 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B8xFZOZt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BF1AE08B
	for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894929; cv=none; b=PbzpP3yDc2yxJOePoACdypCD84xNMNEWIolSSlHCQShIErYK5fImYCaAckXpSbjQI1WKwceL+DSAyxJurieepjR9QhoefXI7/roeiiUlhOczWuY4WzReJpd1RX5bNBCOpxYRrd8We7H6jOP0W0U2NNu6gnk+wryEcGcVtZm7JMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894929; c=relaxed/simple;
	bh=ZWkJZNR2bxEM6LA73IvJZfOwKaypUz3ChIAu4T7npaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iodiynNVxBC4xmPJj2UbbfCgifW0ZCIOdTl4Rf+w9t95NemPdtF3rBSwsvr8XrEpDlskqjEkP38WmVh1YL94Vfz6v4F4OGlQl0oJOoujvIlogLNrkhlmTz9rgvDvxscbvSnzjHa31hev/4p6bi+0s+aeiXSBZi9rTeWHf6/5anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B8xFZOZt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-63ba688bdc9so9619627b3.1
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718894927; x=1719499727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2Ix8vRkDYAbIzLofJN03PlLvyWp4g34uNnV/Zr5cQo=;
        b=B8xFZOZt8jPqgy49CCh+db03r8W/X2N/3Hduxw02AQet6Ndo8rbrygpiB3VVOLxYVY
         LVeJ9j71pXht2slK/ht1eJyvN0M1c3bVEPtmr1cfO68+l9eH3etCSrLR34M+UYgkGWax
         dmWIH16RPNPJLHhH5CzWD/qzZTMdOdOhOp3xnfQZVDmE+jTuk0NZAPsFzaJW2zrxrMhm
         lIh3re0UejijpFlzuci5Z7eo3lvzl7LrG9PyKVaRCY6rFkcYXYrdxnzlnF9VQaxzWs4+
         aeVytPtwcm8tXgnGoBdfSpIgwGgenHHfAbopMf57nuLDqft161bwWlbdPTBF9YwA6XMx
         mVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894927; x=1719499727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2Ix8vRkDYAbIzLofJN03PlLvyWp4g34uNnV/Zr5cQo=;
        b=MeprBHfC3lRZpxqJNH2u+qqsQ63XTuaYNOmECO5gzppjkieNz1LzZE9qdvGJordpNL
         28jxo/kWwdUMtXYuaZ/opzSHO/erAqTPGIAQtwsM2tbunHi2WoKdB+0XVyWiGLoy7EAW
         TM+t4mmNhR4hPoFUJlDUP9tf5i73Vp48oKPTpeE1FPKGxEouTiH8LTVr3WHupByKw71b
         oMOXRZYtSmPAN3GWYnDlmdsSwZFWMOSBzYbXf1L+zhamgkJp+5H8lD9FbhLMyB9L9K+p
         njV+6k3kWlo+lmFeEKnV7PxAfx5UDP60bjwRxYWwO0br/6kNnj4IZw0PJC+Xlu8XgMca
         kXDw==
X-Forwarded-Encrypted: i=1; AJvYcCWnMdiOpaSsc36+3n7jZGF/CTfvfjYDfHgePCqCZfGGxgOpYk/nCnuNF+jfWFJREVr4cSW1dmsUGADp4FisyAyUdDqsBfFHRccJPpqU/Bwn
X-Gm-Message-State: AOJu0YwSM0qgTsNpdGalBzEjeWOuFIXei+CpyIlICEwYopXjYGsE/wv4
	Kka4NBB5AmOSoXn2tXjjZPJdT/QyC0dcyFBoFGdAK91nAocM78uxJbkGefWCp0bNzvcU4eaasl7
	CX+96HIuY7isSU7cEpi2MFqSFYyBk1uapblet
X-Google-Smtp-Source: AGHT+IFuiJSlu6ok/X5AbetO8OQ5D7Cz21KHbzk+IA9kRhrNMOU3OFyVB6D+lstQN8v9cNDF9o7/AysNWhm9yCWP10k=
X-Received: by 2002:a0d:e614:0:b0:632:6615:3d67 with SMTP id
 00721157ae682-63a8d25c8e4mr59092877b3.6.1718894927304; Thu, 20 Jun 2024
 07:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com> <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
In-Reply-To: <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 10:48:36 -0400
Message-ID: <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Making it a kernel subsystem would likely mean replicating what the L=
SM
> > > infrastructure is doing, inode (security) blob and being notified abo=
ut
> > > file/directory changes.
> >
> > Just because the LSM framework can be used for something, perhaps it
> > even makes the implementation easier, it doesn't mean the framework
> > should be used for everything.
>
> It is supporting 3 LSMs: IMA, IPE and BPF LSM.
>
> That makes it a clear target for the security subsystem, and as you
> suggested to start for IMA, if other kernel subsystems require them, we
> can make it as an independent subsystem.

Have you discussed the file digest cache functionality with either the
IPE or BPF LSM maintainers?  While digest_cache may support these
LSMs, I don't recall seeing any comments from the other LSM
developers; if you are going to advocate for this as something outside
of IMA, it would be good to see a show of support for the other LSMs.

--=20
paul-moore.com

