Return-Path: <linux-integrity+bounces-7263-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36425B98900
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C7B1880333
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D84C98;
	Wed, 24 Sep 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ozwt7j4D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767B2750FB
	for <linux-integrity@vger.kernel.org>; Wed, 24 Sep 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699290; cv=none; b=FOeCvDYk2zOkyhYba+p8NyjjfbsLmJDy4vf93lu4AqDXsIeP5CQayR9Owds0GTM3d3iiUFiuOoB+V4SbIElBu/eR4chYhYhQa8YsJg4TEv+Vb05EMbIHNvoGuhXGA+SthnTphsDT8o93CWMWL0hgccYsi2ZQ3GmnuAbsfCCQqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699290; c=relaxed/simple;
	bh=S7+HWrEclhZ4RpGf/ALCUUwVWfJy12RZwePgN6weEYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDLgBlEf7WLFYZklt+Rnc4AueYXdMsuhNk1KjXQqK74JtA1/oc9lk/RiWj8zzsxcvikY6arOEwkJFCxGex7mmLIskl3Y9kfsC4TQOiUEPME8+iLqb7z4uf5oMJl4cbTZa4wXuYzp/TlnVm+5F2Y7MGBDBxlOUulwa+bm5RBGxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ozwt7j4D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7IOOEdL9lE37yIKDkXyAxr3Ap+gTJr/kOzXeUkzEqI=;
	b=Ozwt7j4DZlm1aBRyxAGikR3Hf/EbtbUUuDmb1mKUZag9MolEvk09OHjNtw7CBHx733IHJG
	IUZ/bcgxLT9TuGpV+tqm1BG4WcGq6brnYpkQFQWuNet3MrfeAbFPYq3utcuIba4b7BYBIG
	nti++7GRIkzzgxqumNRASRgWRxK9E98=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Nou1d5NXP52aS7yV0gBfBQ-1; Wed, 24 Sep 2025 03:34:46 -0400
X-MC-Unique: Nou1d5NXP52aS7yV0gBfBQ-1
X-Mimecast-MFC-AGG-ID: Nou1d5NXP52aS7yV0gBfBQ_1758699285
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7341cfed3ffso101902117b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 24 Sep 2025 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699285; x=1759304085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7IOOEdL9lE37yIKDkXyAxr3Ap+gTJr/kOzXeUkzEqI=;
        b=vNuhf24aCeKqjTNZNgl3DPyPui/NYgGnl1h5b4U0+PPilwq7Z0MjX3ao3HjTftpTut
         gIAFG/5Y1tIr+/jVRosX15u4Lq40ionKRWPgNan9WxmR+JSEq4d8yjfB2wOufjKIrPQi
         WjUxheiw3o/WUtY623vcqSW13ZZTKz2JYXr/uP7goVECvSH4hOszs8fbdXjFX9WdBriN
         jiYOzja2oiDbqcRfYwKebzawyJOtqc5YroySgdgDXoeyp9Q/P75vm+ILWw5e05g+ZSrp
         KOrPuTMwxG7ljW6gxBZh4LjByCsvCM1L0+QEITXuIKhd3KQLwLWDoge5BH8FXec0aIh1
         RYVA==
X-Forwarded-Encrypted: i=1; AJvYcCUmt1NEiNVSwSRPYJ9SDNIWf8I5mUDFB5RLNC0vL9L5PnzthIm6X/wEVE4iruWvupG7ebYT6a0hvSgaOcTc+cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNpPVooc10YJDeH4Mf25H42M0iO7yCxnhgxxnSk+mykVgMV+H
	vfmxxW563h7Cj0JMiviIF2SaMLAXujaHvLljIz8GqutN0XM+V3bUuNk+MVAJ/v1cqUEnSl3iJxC
	30S8ATO2obFo0cFMfCjGs1jPnw/2B1C4ZLvKtp/+aMGrfQu5ma2tqOWLyvvM6GZG2D/2wDgDwm8
	vtu68UIFmSEZi64u18qJS2lc+mUpro6Bel/4xmvi4jW3UZ
X-Gm-Gg: ASbGncuNV13oLDW5cK/oPrjtWzust/AWEnKQB3QDA5w+90O5rSipaigjEFtZalb8b35
	68CIPhS130tL3Xr+fTz4QV+c7hVmWmogauRQQdqPaatJgDDsrFBOUgO3vWtSCz81N4zUzuRmovN
	k116nYPMW4Tf4Eut6SvkBqSQ==
X-Received: by 2002:a05:690c:6a86:b0:748:c4bd:79d4 with SMTP id 00721157ae682-758a5f1f36fmr44114647b3.49.1758699285176;
        Wed, 24 Sep 2025 00:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuMsVMokzAhdcvXC/ABwdBe3KKxb+omFRNh4xiqQwm2vUF927G2SUuvhm28A38wUWjOry3T8IskHGUSg+ve5w=
X-Received: by 2002:a05:690c:6a86:b0:748:c4bd:79d4 with SMTP id
 00721157ae682-758a5f1f36fmr44114467b3.49.1758699284705; Wed, 24 Sep 2025
 00:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915210829.6661-1-daleksan@redhat.com> <20250923200748.GA3355497@ax162>
 <aNNB7w3x2ZoekCML@kernel.org> <aNNmFCl0OsfeImK3@kernel.org> <aNNnZ8iW7gYPkhhu@kernel.org>
In-Reply-To: <aNNnZ8iW7gYPkhhu@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Wed, 24 Sep 2025 03:34:33 -0400
X-Gm-Features: AS18NWC4YnRLi-LYc3YSwT8IlxP60zMy8ElVG5nFDf0-kNdhIFePyuqvO1ElwQo
Message-ID: <CAG+gbFcAJ7ppMbcyHsRFj=ZMteNV7GoUh5qkb+7iG2n4D5ONGg@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:37=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Wed, Sep 24, 2025 at 06:31:37AM +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 24, 2025 at 03:57:23AM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 23, 2025 at 01:07:48PM -0700, Nathan Chancellor wrote:
> > > > Hi Denis,
> > > >
> > > > On Mon, Sep 15, 2025 at 05:08:29PM -0400, Denis Aleksandrov wrote:
> > > > > Reads on tpm/tpm0/ppi/*operations can become very long on
> > > > > misconfigured systems. Reading the TPM is a blocking operation,
> > > > > thus a user could effectively trigger a DOS.
> > > > >
> > > > > Resolve this by caching the results and avoiding the blocking
> > > > > operations after the first read.
> > > > >
> > > > > Reported-by: Jan Stancek <jstancek@redhat.com>
> > > > > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> > > > > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > >
> > > > > Changes in v5:
> > > > >         - Unlocks the tpm_ppi_lock if cache_ppi_operations() retu=
rns and
> > > > >           error.
> > > > >
> > > > >  drivers/char/tpm/tpm_ppi.c | 89 ++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 66 insertions(+), 23 deletions(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_pp=
i.c
> > > > > index d53fce1c9d6f..47655407fea5 100644
> > > > > --- a/drivers/char/tpm/tpm_ppi.c
> > > > > +++ b/drivers/char/tpm/tpm_ppi.c
> > > > > @@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =3D
> > > > >         GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> > > > >                   0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53)=
;
> > > > >
> > > > > +static const char * const tpm_ppi_info[] =3D {
> > > > > +       "Not implemented",
> > > > > +       "BIOS only",
> > > > > +       "Blocked for OS by system firmware",
> > > > > +       "User required",
> > > > > +       "User not required",
> > > > > +};
> > > > > +
> > > > > +/* A spinlock to protect access to the cache from concurrent rea=
ds */
> > > > > +static DEFINE_SPINLOCK(tpm_ppi_lock);
> > > > > +
> > > > > +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> > > > > +static bool ppi_cache_populated;
> > > > > +
> > > > >  static bool tpm_ppi_req_has_parameter(u64 req)
> > > > >  {
> > > > >         return req =3D=3D 23;
> > > > > @@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct d=
evice *dev,
> > > > >         return status;
> > > > >  }
> > > > >
> > > > > -static ssize_t show_ppi_operations(acpi_handle dev_handle, char =
*buf, u32 start,
> > > > > -                                  u32 end)
> > > > > +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char=
 *buf)
> > > > >  {
> > > > >         int i;
> > > > >         u32 ret;
> > > > > @@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_han=
dle dev_handle, char *buf, u32 start,
> > > > >         union acpi_object *obj, tmp;
> > > > >         union acpi_object argv =3D ACPI_INIT_DSM_ARGV4(1, &tmp);
> > > > >
> > > > > -       static char *info[] =3D {
> > > > > -               "Not implemented",
> > > > > -               "BIOS only",
> > > > > -               "Blocked for OS by BIOS",
> > > > > -               "User required",
> > > > > -               "User not required",
> > > > > -       };
> > > > > -
> > > > >         if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_RE=
VISION_ID_1,
> > > > >                             1 << TPM_PPI_FN_GETOPR))
> > > > >                 return -EPERM;
> > > > >
> > > > >         tmp.integer.type =3D ACPI_TYPE_INTEGER;
> > > > > -       for (i =3D start; i <=3D end; i++) {
> > > > > +       for (i =3D 0; i <=3D PPI_VS_REQ_END; i++) {
> > > > >                 tmp.integer.value =3D i;
> > > > >                 obj =3D tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOP=
R,
> > > > >                                    ACPI_TYPE_INTEGER, &argv,
> > > > >                                    TPM_PPI_REVISION_ID_1);
> > > > > -               if (!obj) {
> > > > > +               if (!obj)
> > > > >                         return -ENOMEM;
> > > > > -               } else {
> > > > > -                       ret =3D obj->integer.value;
> > > > > -                       ACPI_FREE(obj);
> > > > > -               }
> > > > >
> > > > > -               if (ret > 0 && ret < ARRAY_SIZE(info))
> > > > > -                       len +=3D sysfs_emit_at(buf, len, "%d %d: =
%s\n",
> > > > > -                                            i, ret, info[ret]);
> > > > > +               ret =3D obj->integer.value;
> > > > > +               ppi_operations_cache[i] =3D ret;
> > > > > +               ACPI_FREE(obj);
> > > > >         }
> > > > >
> > > > >         return len;
> > > > > @@ -324,9 +325,30 @@ static ssize_t tpm_show_ppi_tcg_operations(s=
truct device *dev,
> > > > >                                            char *buf)
> > > > >  {
> > > > >         struct tpm_chip *chip =3D to_tpm_chip(dev);
> > > > > +       ssize_t len =3D 0;
> > > > > +       u32 ret;
> > > > > +       int i;
> > > > > +
> > > > > +       spin_lock(&tpm_ppi_lock);
> > > > > +       if (!ppi_cache_populated) {
> > > > > +               len =3D cache_ppi_operations(chip->acpi_dev_handl=
e, buf);
> > > > > +               if (len < 0) {
> > > > > +                       spin_unlock(&tpm_ppi_lock);
> > > > > +                       return len;
> > > > > +               }
> > > > >
> > > > > -       return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> > > > > -                                  PPI_TPM_REQ_MAX);
> > > > > +               ppi_cache_populated =3D true;
> > > > > +       }
> > > > > +
> > > > > +       for (i =3D 0; i <=3D PPI_TPM_REQ_MAX; i++) {
> > > > > +               ret =3D ppi_operations_cache[i];
> > > > > +               if (ret >=3D 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > > > > +                       len +=3D sysfs_emit_at(buf, len, "%d %d: =
%s\n",
> > > > > +                                                       i, ret, t=
pm_ppi_info[ret]);
> > > > > +       }
> > > > > +       spin_unlock(&tpm_ppi_lock);
> > > > > +
> > > > > +       return len;
> > > > >  }
> > > > >
> > > > >  static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> > > > > @@ -334,9 +356,30 @@ static ssize_t tpm_show_ppi_vs_operations(st=
ruct device *dev,
> > > > >                                           char *buf)
> > > > >  {
> > > > >         struct tpm_chip *chip =3D to_tpm_chip(dev);
> > > > > +       ssize_t len =3D 0;
> > > > > +       u32 ret;
> > > > > +       int i;
> > > > >
> > > > > -       return show_ppi_operations(chip->acpi_dev_handle, buf, PP=
I_VS_REQ_START,
> > > > > -                                  PPI_VS_REQ_END);
> > > > > +       spin_lock(&tpm_ppi_lock);
> > > > > +       if (!ppi_cache_populated) {
> > > > > +               len =3D cache_ppi_operations(chip->acpi_dev_handl=
e, buf);
> > > > > +               if (len < 0) {
> > > > > +                       spin_unlock(&tpm_ppi_lock);
> > > > > +                       return len;
> > > > > +               }
> > > > > +
> > > > > +               ppi_cache_populated =3D true;
> > > > > +       }
> > > > > +
> > > > > +       for (i =3D PPI_VS_REQ_START; i <=3D PPI_VS_REQ_END; i++) =
{
> > > > > +               ret =3D ppi_operations_cache[i];
> > > > > +               if (ret >=3D 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > > > > +                       len +=3D sysfs_emit_at(buf, len, "%d %d: =
%s\n",
> > > > > +                                                       i, ret, t=
pm_ppi_info[ret]);
> > > > > +       }
> > > > > +       spin_unlock(&tpm_ppi_lock);
> > > > > +
> > > > > +       return len;
> > > > >  }
> > > > >
> > > > >  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL)=
;
> > > > > --
> > > > > 2.48.1
> > > > >
> > > >
> > > > I am seeing a "scheduling while atomic" splat in -next when running
> > > > LTP's read_all testcase against /proc and /sys that I bisected to t=
his
> > > > change (bisect log at the end of the message). It is still reproduc=
ible
> > > > with the most recent sha in Jarkko's tree, c4a211c65878 ("tpm: Prev=
ent
> > > > local DOS via tpm/tpm0/ppi/*operations"), where there is no differe=
nce
> > > > in the code as far as I can tell.
> > > >
> > > >   $ curl -LSs https://github.com/nathanchance/env/raw/014a117384fb9=
121cf5c81ab30aa4de935246c17/bin/x86_64/read_all | install -m755 /dev/stdin =
read_all
> > > >
> > > >   $ sudo sh -c "$PWD/read_all -d /proc && $PWD/read_all -d /sys && =
dmesg"
> > > >   ...
> > > >   [  103.605352] BUG: scheduling while atomic: read_all/2907/0x0000=
0002
> > > >   [  103.605357] Modules linked in: ...
> > > >   [  103.605401]  ...
> > > >   [  103.605454] CPU: 0 UID: 0 PID: 2907 Comm: read_all Not tainted=
 6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  ccfbb8e489d66d10720=
5aa22f3b6242dd3605b88
> > > >   [  103.605457] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05=
/12/2024
> > > >   [  103.605459] Call Trace:
> > > >   [  103.605461]  <TASK>
> > > >   [  103.605465]  dump_stack_lvl+0x5d/0x80
> > > >   [  103.605471]  __schedule_bug.cold+0x42/0x4e
> > > >   [  103.605473]  __schedule+0x1083/0x1330
> > > >   [  103.605478]  ? acpi_ex_field_datum_io+0xe8/0x4f0
> > > >   [  103.605482]  ? acpi_os_release_object+0xe/0x20
> > > >   [  103.605486]  schedule+0x27/0xd0
> > > >   [  103.605487]  schedule_timeout+0xbd/0x100
> > > >   [  103.605491]  __down_common+0x137/0x2d0
> > > >   [  103.605493]  down_timeout+0x67/0x70
> > > >   [  103.605495]  acpi_os_wait_semaphore+0x68/0x180
> > > >   [  103.605498]  acpi_ut_acquire_mutex+0x97/0x250
> > > >   [  103.605500]  acpi_ns_delete_namespace_subtree+0x48/0x110
> > > >   [  103.605503]  acpi_ds_terminate_control_method+0x1c8/0x200
> > > >   [  103.605505]  acpi_ps_parse_aml+0x1ae/0x5d0
> > > >   [  103.605508]  acpi_ps_execute_method+0x171/0x3e0
> > > >   [  103.605511]  acpi_ns_evaluate+0x196/0x5c0
> > > >   [  103.605513]  acpi_evaluate_object+0x1ce/0x450
> > > >   [  103.605515]  acpi_evaluate_dsm+0xcb/0x150
> > > >   [  103.605519]  cache_ppi_operations.isra.0+0xc2/0x110
> > > >   [  103.605522]  tpm_show_ppi_tcg_operations+0x99/0xb0
> > > >   [  103.605523]  dev_attr_show+0x1c/0x50
> > > >   [  103.605526]  sysfs_kf_seq_show+0xc9/0x120
> > > >   [  103.605530]  seq_read_iter+0x125/0x480
> > > >   [  103.605532]  ? rw_verify_area+0x56/0x180
> > > >   [  103.605534]  vfs_read+0x265/0x390
> > > >   [  103.605538]  ksys_read+0x73/0xf0
> > > >   [  103.605540]  do_syscall_64+0x81/0x970
> > > >   [  103.605542]  ? ksys_read+0x73/0xf0
> > > >   [  103.605545]  ? refill_obj_stock+0x12e/0x240
> > > >   [  103.605547]  ? xas_load+0xd/0xd0
> > > >   [  103.605549]  ? xa_load+0x76/0xb0
> > > >   [  103.605552]  ? refill_obj_stock+0x12e/0x240
> > > >   [  103.605553]  ? __memcg_slab_free_hook+0xf4/0x140
> > > >   [  103.605555]  ? kmem_cache_free+0x490/0x4d0
> > > >   [  103.605557]  ? __x64_sys_close+0x3d/0x80
> > > >   [  103.605560]  ? __x64_sys_close+0x3d/0x80
> > > >   [  103.605562]  ? do_syscall_64+0x81/0x970
> > > >   [  103.605563]  ? do_syscall_64+0x81/0x970
> > > >   [  103.605564]  ? do_syscall_64+0x81/0x970
> > > >   [  103.605565]  ? do_syscall_64+0x81/0x970
> > > >   [  103.605566]  ? __irq_exit_rcu+0x4c/0xf0
> > > >   [  103.605569]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >   [  103.605571] RIP: 0033:0x4243b8
> > > >   [  103.605597] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f=
 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca=
 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
> > > >   [  103.605598] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000000
> > > >   [  103.605601] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 0=
0000000004243b8
> > > >   [  103.605602] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0=
000000000000003
> > > >   [  103.605603] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0=
000000000000000
> > > >   [  103.605603] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007fb294164000
> > > >   [  103.605604] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0=
000000000000003
> > > >   [  103.605606]  </TASK>
> > > >   [  103.652735] BUG: scheduling while atomic: read_all/2907/0x0000=
0000
> > > >   [  103.652739] Modules linked in: ...
> > > >   [  103.652775]  ...
> > > >   [  103.652825] CPU: 0 UID: 0 PID: 2907 Comm: read_all Tainted: G =
       W           6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  c=
cfbb8e489d66d107205aa22f3b6242dd3605b88
> > > >   [  103.652828] Tainted: [W]=3DWARN
> > > >   [  103.652829] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05=
/12/2024
> > > >   [  103.652830] Call Trace:
> > > >   [  103.652830]  <TASK>
> > > >   [  103.652831]  dump_stack_lvl+0x5d/0x80
> > > >   [  103.652835]  __schedule_bug.cold+0x42/0x4e
> > > >   [  103.652837]  __schedule+0x1083/0x1330
> > > >   [  103.652840]  ? get_nohz_timer_target+0x2f/0x150
> > > >   [  103.652843]  ? timerqueue_add+0x73/0xd0
> > > >   [  103.652845]  schedule+0x27/0xd0
> > > >   [  103.652847]  schedule_hrtimeout_range_clock+0xd8/0x120
> > > >   [  103.652850]  ? __pfx_hrtimer_wakeup+0x10/0x10
> > > >   [  103.652853]  usleep_range_state+0x6c/0xa0
> > > >   [  103.652855]  crb_wait_for_reg_32.constprop.0+0x40/0x80
> > > >   [  103.652858]  crb_request_locality+0x3d/0x50
> > > >   [  103.652860]  tpm_chip_start+0x6c/0xe0
> > > >   [  103.652862]  tpm_try_get_ops+0x89/0xb0
> > > >   [  103.652863]  tpm_find_get_ops+0x1b/0x70
> > > >   [  103.652865]  tpm_pcr_read+0x1b/0x70
> > > >   [  103.652866]  pcr_value_show+0xcc/0x140
> > > >   [  103.652869]  dev_attr_show+0x1c/0x50
> > > >   [  103.652871]  sysfs_kf_seq_show+0xc9/0x120
> > > >   [  103.652873]  seq_read_iter+0x125/0x480
> > > >   [  103.652875]  ? rw_verify_area+0x56/0x180
> > > >   [  103.652877]  vfs_read+0x265/0x390
> > > >   [  103.652880]  ksys_read+0x73/0xf0
> > > >   [  103.652882]  do_syscall_64+0x81/0x970
> > > >   [  103.652883]  ? do_syscall_64+0x81/0x970
> > > >   [  103.652884]  ? __irq_exit_rcu+0x4c/0xf0
> > > >   [  103.652887]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >   [  103.652889] RIP: 0033:0x4243b8
> > > >   [  103.652903] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f=
 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca=
 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
> > > >   [  103.652905] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000000
> > > >   [  103.652906] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 0=
0000000004243b8
> > > >   [  103.652907] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0=
000000000000003
> > > >   [  103.652908] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0=
000000000000000
> > > >   [  103.652909] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007fb294164000
> > > >   [  103.652910] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0=
000000000000003
> > > >   [  103.652912]  </TASK>
> > > >
> > > > If there is any other information I can provide or patches I can te=
st, I
> > > > am more than happy to do so.

Hi Nathan, thank you so much for the catch!

> > >
> > > Thanks a lot! And I have not rushed with my 6.18 pull request.
> > >
> > > It took me less than 30 seconds to locate the bug: it's spin
> > > lock and sleeing operations.
> > >
> > > E.g., acpi_evaluate_dsm_typed can lead to kzalloc() and stuff
> > > like that. I don't know how I could I have possibly missed this
> > > detail and this is embarrasing but luckily this should be easy
> > > to fix with major hurdle :-)
> > >
> > > What I suggest is that I'll simply repeal and replace the lock
> > > type (i.e. tweak the patch), as it does not feel worth of trouble
> > > to do a review round. Then we should be seeing better results.
> > >
> > > Thanks again for spotting this. Yeah, and definitely not blaming
> > > original author for this. It's all on me tbh. The patch itself
> > > was great and I should have been able to address this...
> >
> >
> > So I guess the fix is exactly this:
> >
> > ~/work/kernel.org/jarkko/linux-tpmdd master* =E2=87=A1=E2=87=A3
> > =E2=9D=AF sed -i 's/DEFINE_SPINLOCK/DEFINE_MUTEX/g' drivers/char/tpm/tp=
m_ppi.c
> >
> > ~/work/kernel.org/jarkko/linux-tpmdd master* =E2=87=A1=E2=87=A3
> > =E2=9D=AF sed -i 's/spin_/mutex_/g' drivers/char/tpm/tpm_ppi.c
> >
> > ~/work/kernel.org/jarkko/linux-tpmdd master* =E2=87=A1=E2=87=A3
> > =E2=9D=AF git -P diff
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index 47655407fea5..c9793a3d986d 100644
> > --- a/drivers/char/tpm/tpm_ppi.c
> > +++ b/drivers/char/tpm/tpm_ppi.c
> > @@ -42,7 +42,7 @@ static const char * const tpm_ppi_info[] =3D {
> >  };
> >
> >  /* A spinlock to protect access to the cache from concurrent reads */

Hi Jarkko, this comment should be updated if it's not too late.

> > -static DEFINE_SPINLOCK(tpm_ppi_lock);
> > +static DEFINE_MUTEX(tpm_ppi_lock);
> >
> >  static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> >  static bool ppi_cache_populated;
> > @@ -329,11 +329,11 @@ static ssize_t tpm_show_ppi_tcg_operations(struct=
 device *dev,
> >         u32 ret;
> >         int i;
> >
> > -       spin_lock(&tpm_ppi_lock);
> > +       mutex_lock(&tpm_ppi_lock);
> >         if (!ppi_cache_populated) {
> >                 len =3D cache_ppi_operations(chip->acpi_dev_handle, buf=
);
> >                 if (len < 0) {
> > -                       spin_unlock(&tpm_ppi_lock);
> > +                       mutex_unlock(&tpm_ppi_lock);
> >                         return len;
> >                 }
> >
> > @@ -346,7 +346,7 @@ static ssize_t tpm_show_ppi_tcg_operations(struct d=
evice *dev,
> >                         len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> >                                                         i, ret, tpm_ppi=
_info[ret]);
> >         }
> > -       spin_unlock(&tpm_ppi_lock);
> > +       mutex_unlock(&tpm_ppi_lock);
> >
> >         return len;
> >  }
> > @@ -360,11 +360,11 @@ static ssize_t tpm_show_ppi_vs_operations(struct =
device *dev,
> >         u32 ret;
> >         int i;
> >
> > -       spin_lock(&tpm_ppi_lock);
> > +       mutex_lock(&tpm_ppi_lock);
> >         if (!ppi_cache_populated) {
> >                 len =3D cache_ppi_operations(chip->acpi_dev_handle, buf=
);
> >                 if (len < 0) {
> > -                       spin_unlock(&tpm_ppi_lock);
> > +                       mutex_unlock(&tpm_ppi_lock);
> >                         return len;
> >                 }
> >
> > @@ -377,7 +377,7 @@ static ssize_t tpm_show_ppi_vs_operations(struct de=
vice *dev,
> >                         len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> >                                                         i, ret, tpm_ppi=
_info[ret]);
> >         }
> > -       spin_unlock(&tpm_ppi_lock);
> > +       mutex_unlock(&tpm_ppi_lock);
> >
> >         return len;
> >  }
> >
> > I'll just push it to next as it does not make things worse and
> > right at the moment I don't have time to do conclusive testing
> > (and it is high certainty the correct fix).
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/co=
mmit/?h=3Dnext&id=3D7e93fe26caa9c010d438b267616793026db363b7

Many thanks for the quick fix! I also should have seen this ahead of time.

>
> BR, Jarkko
>

Best,
Denis


