Return-Path: <linux-integrity+bounces-3672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D690F984549
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FB81C20C88
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434919F417;
	Tue, 24 Sep 2024 11:56:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76838127E37;
	Tue, 24 Sep 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179013; cv=none; b=s/+ol8Hh5+P4kWIVDdl5xiMh0Qln0L3kOfF18K+Mu9lkq0Oyehy4dR0u0FzwvM/nAaNiWCWzbzX4buiCxZUECmOQnILsZBQff3J+1kOLfAfsNG9H+yjXxPZEo18ASb6kfVjYm7MKQlaPo+kObv7IQ5xY9Dbq+dXly4flZUaU72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179013; c=relaxed/simple;
	bh=rFVftdtkQDplhGIoAKaghKd1YHB9m6fXZoIJoeahTYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLBUSlrXW/uAJh/NWiTXf641J9RfpiiTTeImoqwjm9f2qN+7L/IXB294rNI37iqS6osXHPM4CPxXwoDSY9nK4WTvYdwrn0M8rwEazClG8i9lc08a6kfbskp4ByX3YQZ8rBs78X2T/IGV+L/6oNetUbxjsaXx/jHBpUysb7x1bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XCd9z6vfpz9v7NF;
	Tue, 24 Sep 2024 19:36:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C80CE140392;
	Tue, 24 Sep 2024 19:56:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3hy_qqPJmpyWLAQ--.19651S2;
	Tue, 24 Sep 2024 12:56:33 +0100 (CET)
Message-ID: <d31e3e0e9e35523bb40b5dbbb29790c874e7627d.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: stop avoidably reading i_writecount in
 evm_file_release
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 24 Sep 2024 13:56:23 +0200
In-Reply-To: <CAGudoHGBTRJqKAE6Db3PyVne6rrJR4vsF2MNH2qKMy-44XReZw@mail.gmail.com>
References: <20240806133607.869394-1-mjguzik@gmail.com>
	 <3cd8019f03dae99c4e43b7613df869499ec72e66.camel@huaweicloud.com>
	 <CAGudoHGBTRJqKAE6Db3PyVne6rrJR4vsF2MNH2qKMy-44XReZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD3hy_qqPJmpyWLAQ--.19651S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45ZrWUCFWrGr48GrWfXwb_yoW5Jr4fpF
	Wxta1DJF1vqry7CF97t3ZxuFyF93y0qr1UZas5XF12vF90yr93tF40qr1j9as09rZ5CF1F
	v3yI9a43Aw1DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGbyIHwF5wAAs8

On Mon, 2024-09-23 at 07:26 +0200, Mateusz Guzik wrote:
> On Fri, Aug 16, 2024 at 1:53=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > On Tue, 2024-08-06 at 15:36 +0200, Mateusz Guzik wrote:
> > > The EVM_NEW_FILE flag is unset if the file already existed at the tim=
e
> > > of open and this can be checked without looking at i_writecount.
> >=20
> > Agreed. EVM_NEW_FILE is not going to be set during the open(), only
> > before, in evm_post_path_mknod().
> >=20
> > Looks good to me.
> >=20
> > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Thanks
>=20
> thanks for the review
>=20
> are there plans to pick this up for this merge window?

Welcome! Sorry, Mimi wants to do few more checks. It is more likely
that we will pick this for the next version.

Roberto

> >=20
> > Roberto
> >=20
> > > Not accessing it reduces traffic on the cacheline during parallel ope=
n
> > > of the same file and drop the evm_file_release routine from second pl=
ace
> > > to bottom of the profile.
> > >=20
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> > >=20
> > > The context is that I'm writing a patch which removes one lockref
> > > get/put cycle on parallel open. An operational WIP reduces ping-pong =
in
> > > that area and made do_dentry_open skyrocket along with evm_file_relea=
se,
> > > due to i_writecount access. With the patch they go down again and
> > > apparmor takes the rightful first place.
> > >=20
> > > The patch accounts for about 5% speed up at 20 cores running open3 fr=
om
> > > will-it-scale on top of the above wip. (the apparmor + lockref thing
> > > really don't scale, that's next)
> > >=20
> > > I would provide better measurements, but the wip is not ready (as the
> > > description suggests) and I need evm out of the way for the actual
> > > patch.
> > >=20
> > >  security/integrity/evm/evm_main.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/e=
vm/evm_main.c
> > > index 62fe66dd53ce..309630f319e2 100644
> > > --- a/security/integrity/evm/evm_main.c
> > > +++ b/security/integrity/evm/evm_main.c
> > > @@ -1084,7 +1084,8 @@ static void evm_file_release(struct file *file)
> > >       if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
> > >               return;
> > >=20
> > > -     if (iint && atomic_read(&inode->i_writecount) =3D=3D 1)
> > > +     if (iint && iint->flags & EVM_NEW_FILE &&
> > > +         atomic_read(&inode->i_writecount) =3D=3D 1)
> > >               iint->flags &=3D ~EVM_NEW_FILE;
> > >  }
> > >=20
> >=20
>=20
>=20


