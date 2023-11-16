Return-Path: <linux-integrity+bounces-72-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD67EE6EC
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430561C209D1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D563A4;
	Thu, 16 Nov 2023 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FiKuO3OL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53ED4B
	for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so1150330276.0
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700160119; x=1700764919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=FiKuO3OLOxYWZbRS088GinMafw6uUbhXXcBbEO20j/tWQcRp1dAjcGC0q3VWHbhB8V
         IgOhkXjX93b/sNUO11ZBFkEvwNedL7qnxmRNq8+Lmtak4Wd6vU5oIh1nxChlzyB+777c
         KI1VVHgBL/FMURxjzqKp3C3+hk9kEhvXW3AiIvxLuE5pB6IqQK8J94ziLaRyh7TlZwcy
         XEXAeZJLLmUmWPxXxIxvhKJoYOJqX6l4aSIxzHCYGROeaNIN00/61kWhXRRKenbdbhvr
         SbI7Ogm+/7Ecr9H04YvmeQ1LocZQhDT8hDsVbn9v+TBniRbj7i1FKZU+ECrpXWudRxPr
         7wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160119; x=1700764919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=qoTwtS6lKYTHVfQfkPRTsUOgL2qBRGomM5UlcHGhXx3QTqcREev0//4qmoUiPdEhTv
         TZlagD1oIfaEb4as5SgQ9UZsd7fMLSKDzlvEauUFV65o36V0TuuhrxKUWJlNYU1ZmFE/
         +XHxeHAUxmxp4Gg+yZzHEVOH5+lCazw/rDns0XwsS63HUbELWwavlyGVd/1sJTY3c46i
         v3VXtOIBwNc5b5BuiCR0dOPdJrSdow0qyvSmJfmfNNcJaJdPqZMeCZqaa/CV/ZfcgqC/
         u9Y40IQ5uUTlqJ5iXQc61tupD57UGAO61ErrGuuqC/qTJqpFSSnD4K8hIUSIoqLK4xyP
         c7+w==
X-Gm-Message-State: AOJu0Yxa6aL81GuFBRGKJ+pR//9Ne/pA5w93tLF9meUF3W10yktKZ1/p
	JZBoTG9D5/W2hL0sSaj3wD/rfs1VE1sSO7eLqSN2
X-Google-Smtp-Source: AGHT+IFrNERH99etoRYFFGcfGckM9eZr5jAdvP3Cqsg4T2YPSq7MZRtVHGkbsnW80wNaWxVnmZXI59XcmNXo2maxlb0=
X-Received: by 2002:a25:7688:0:b0:d9b:e043:96fa with SMTP id
 r130-20020a257688000000b00d9be04396famr15091479ybc.22.1700160118675; Thu, 16
 Nov 2023 10:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
 <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com> <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
In-Reply-To: <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 13:41:47 -0500
Message-ID: <CAHC9VhR29VEybYHsx65E=-YYNLuLHOVm6BF2H==bEcrcHU7Ksg@mail.gmail.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 4:47=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > In preparation for moving IMA and EVM to the LSM infrastructure, intr=
oduce
> > > the file_pre_free_security hook.
> > >
> > > IMA calculates at file close the new digest of the file content and w=
rites
> > > it to security.ima, so that appraisal at next file access succeeds.
> > >
> > > LSMs could also take some action before the last reference of a file =
is
> > > released.
> > >
> > > The new hook cannot return an error and cannot cause the operation to=
 be
> > > reverted.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  fs/file_table.c               |  1 +
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  4 ++++
> > >  security/security.c           | 11 +++++++++++
> > >  4 files changed, 17 insertions(+)
> > >
> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index de4a2915bfd4..64ed74555e64 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -385,6 +385,7 @@ static void __fput(struct file *file)
> > >     eventpoll_release(file);
> > >     locks_remove_file(file);
> > >
> > > +   security_file_pre_free(file);
> >
> > I worry that security_file_pre_free() is a misleading name as "free"
> > tends to imply memory management tasks, which isn't the main focus of
> > this hook.  What do you think of security_file_release() or
> > security_file_put() instead?
>
> security_file_release() would be fine for me.

Okay, assuming no objections for anyone else let's go with that.
Thanks for indulging my naming nitpick :)

--=20
paul-moore.com

