Return-Path: <linux-integrity+bounces-3322-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A46953ACC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2024 21:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E23286E5E
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220D78C9D;
	Thu, 15 Aug 2024 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U5APwX8E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8FBA53
	for <linux-integrity@vger.kernel.org>; Thu, 15 Aug 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749575; cv=none; b=vA5wAnqm70x8ad6/SkwmeagP33Bu9tL0EUS1+DK/opotAz/7vRxEwlVl9FW2nowcFz2SRzCryCKSk+uHbXxDr+j/AhIHBcYPcGTQE/cFqffqgdxevntj8bXOyDpjk9Oi+K0Jvsv4COHZxe6WVXRBrBuGJ3b/tUwSx/zrVqcSRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749575; c=relaxed/simple;
	bh=SbZHk1oE4YjfHvEGvCc6lxbgHJVuoZ7v5vaCTK8aF8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVfJjYcr7MojzQLUHWs3ne5zgu9YJXBrIynsi2IMFZMJ9pkLFaN4cqskc2kyo90wmThbUe6K61uxMFyMUsS9ypUuQpC00iWyc7/7PatW+LxgdTP3syMigcKMATu2RS5/q7MHnBsRzVqnEHgJ8cw25+VKoZVWoLElBB3kP/jt5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U5APwX8E; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso1213906276.1
        for <linux-integrity@vger.kernel.org>; Thu, 15 Aug 2024 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723749571; x=1724354371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmJ/U6oso6NBeJGhn3TIkS50+Qahr6/dljLdoPN7uPY=;
        b=U5APwX8E/azTdFyT9kJzOkgw/gSKztknJ3zUB0xirfG7gjhWUmWYqZ6v/x93jbuOg3
         1Df/nHDpJMAdeMNBLPcawYn2+X8M4OqS/VWSNPO8nWwZMuqCmbWIM3v9Xytn0DH1Y36V
         sBBANvtauD3f2sQEMMl4/8sri4bUiEgL4jPEEUlXu3LCs9yUkfXozWegUWMrCQgGxaGP
         Hqxz5hJLjlJ702rjQLvDOHVEvdo6sYfBWn6xJY30iUmP5kh3zcZEJ+xkhhcpkuUo8WCx
         Gki23R2o3xZVklrWrSKwfcYspU0GrQ+LYx8NCKf+PwaxvHt692HM9z5mqfbCXT1NwXqL
         OXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749571; x=1724354371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmJ/U6oso6NBeJGhn3TIkS50+Qahr6/dljLdoPN7uPY=;
        b=T65TFNGcKiP97/wCZXTNw08lDnVL3LPGDTV2jNCI++rZQfT/BmkrRdUmifi6ZadNaN
         FiFce1a55TBuTN7RWYG9xPh6gkUYISz6jr6XmU1EHFviqgk6BTUtqmGuByjdoL+0RLvU
         AXQdXushNZk8bIlOxS3VU7uscHNlSYzA005NlDvb9YZ+tNcRNBbw+W0HV2CmrTJlW5PB
         jwCuRjsFEIz4eN8Ym234wBFXbyoPdobDOhdHVECXe+EF/7vOBmeIFg34KXsM2T3t072F
         OrOS19Rj0r70XBOsqpzmjTN94mJ6V1mR1GfXiHhsF4qbqSLoMFs1h4hQfILt/7zwFM+a
         DHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWxh+/lZc/z7hkeyleeXIndcUFXVM7X+xkqyAh0SSs91H4j0AWHaG6p7Dii9AVmLhjiaPe0WbRHIkiLZuGKi53jRuFPpJFbTIMgYbWmKut7
X-Gm-Message-State: AOJu0YxpSeWO5C67JA+2wzbJYvLb5cw4gX3RSRpkhuhYCdoI7Ad0wRLe
	aUCAOKt/KYffRu/iqIvo3ZcMjsc8x5rxzX9wYu+5/Se216njTrai1qcuhObv1Mql7hWpkhk5PWR
	7Ul5u8p4hiJ2aUCoY0YXXwUGDyFPqE2/GU+G/
X-Google-Smtp-Source: AGHT+IFRYVjjf2rtsZ0DyXa1m00KXA39o8EICR0pfI/3jm6Xtm5EJ6DWPa9xtJ2UUS6AmdDcjWbNeaxbcw/BVpXnv5o=
X-Received: by 2002:a05:6902:240a:b0:e11:7e70:a9b2 with SMTP id
 3f1490d57ef6-e1180fa47bbmr989460276.42.1723749571251; Thu, 15 Aug 2024
 12:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com> <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
In-Reply-To: <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Aug 2024 15:19:20 -0400
Message-ID: <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and
 signature data to LSMs
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Alasdair Kergon <agk@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:38=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> Hi Mikulas,
>
> I hope you=E2=80=99re doing well. I wanted to thank you again for your th=
orough
> review for the last version. I=E2=80=99ve since made some minor updates f=
or this
> version, including adding more comments and refactoring the way the hash
> algorithm name is obtained due to recent changes in dm-verity.
>
> Would you mind if we keep the Review-by tag on the latest version since
> the changes are minor? Your feedback is greatly valued, and I=E2=80=99d
> appreciate it if you could take a quick look when you have a moment.

To add a bit more to this, this patchset now looks like it is in a
state where we would like to merge it into the LSM tree for the
upcoming merge window, but I would really like to make sure that the
device-mapper folks are okay with these changes; an
Acked-by/Reviewed-by on this patch would be appreciated, assuming you
are still okay with this patch.

For those who may be missing the context, the full patchset can be
found on lore at the link below:

https://lore.kernel.org/linux-security-module/1722665314-21156-1-git-send-e=
mail-wufan@linux.microsoft.com

> On 8/2/2024 11:08 PM, Fan Wu wrote:
> > From: Deven Bowers <deven.desai@linux.microsoft.com>
> >
> > dm-verity provides a strong guarantee of a block device's integrity. As
> > a generic way to check the integrity of a block device, it provides
> > those integrity guarantees to its higher layers, including the filesyst=
em
> > level.
> >
> > However, critical security metadata like the dm-verity roothash and its
> > signing information are not easily accessible to the LSMs.
> > To address this limitation, this patch introduces a mechanism to store
> > and manage these essential security details within a newly added LSM bl=
ob
> > in the block_device structure.
> >
> > This addition allows LSMs to make access control decisions on the integ=
rity
> > data stored within the block_device, enabling more flexible security
> > policies. For instance, LSMs can now revoke access to dm-verity devices
> > based on their roothashes, ensuring that only authorized and verified
> > content is accessible. Additionally, LSMs can enforce policies to only
> > allow files from dm-verity devices that have a valid digital signature =
to
> > execute, effectively blocking any unsigned files from execution, thus
> > enhancing security against unauthorized modifications.
> >
> > The patch includes new hook calls, `security_bdev_setintegrity()`, in
> > dm-verity to expose the dm-verity roothash and the roothash signature t=
o
> > LSMs via preresume() callback. By using the preresume() callback, it
> > ensures that the security metadata is consistently in sync with the
> > metadata of the dm-verity target in the current active mapping table.
> > The hook calls are depended on CONFIG_SECURITY.
> >
> > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > ---
> ...
> >
> > v20:
> >    + Adding more documentation regarding the new setintegrity hook call
> >    + Update the code for getting hash algorithm from either v->ahash_tf=
m
> >      or v->shash_tfm
> > ---
> >   drivers/md/dm-verity-target.c | 118 +++++++++++++++++++++++++++++++++=
+
> >   drivers/md/dm-verity.h        |   6 ++
> >   include/linux/security.h      |   9 ++-
> >   3 files changed, 132 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-targe=
t.c
> > index cf659c8feb29..24ba9a10444c 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -22,6 +22,7 @@
> >   #include <linux/scatterlist.h>
> >   #include <linux/string.h>
> >   #include <linux/jump_label.h>
> > +#include <linux/security.h>
> >
> >   #define DM_MSG_PREFIX                       "verity"
> >
> > @@ -930,6 +931,41 @@ static void verity_io_hints(struct dm_target *ti, =
struct queue_limits *limits)
> >       limits->dma_alignment =3D limits->logical_block_size - 1;
> >   }
> >
> > +#ifdef CONFIG_SECURITY
> > +
> > +static int verity_init_sig(struct dm_verity *v, const void *sig,
> > +                        size_t sig_size)
> > +{
> > +     v->sig_size =3D sig_size;
> > +
> > +     if (sig) {
> > +             v->root_digest_sig =3D kmemdup(sig, v->sig_size, GFP_KERN=
EL);
> > +             if (!v->root_digest_sig)
> > +                     return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void verity_free_sig(struct dm_verity *v)
> > +{
> > +     kfree(v->root_digest_sig);
> > +}
> > +
> > +#else
> > +
> > +static inline int verity_init_sig(struct dm_verity *v, const void *sig=
,
> > +                               size_t sig_size)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void verity_free_sig(struct dm_verity *v)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_SECURITY */
> > +
> >   static void verity_dtr(struct dm_target *ti)
> >   {
> >       struct dm_verity *v =3D ti->private;
> > @@ -949,6 +985,7 @@ static void verity_dtr(struct dm_target *ti)
> >       kfree(v->initial_hashstate);
> >       kfree(v->root_digest);
> >       kfree(v->zero_digest);
> > +     verity_free_sig(v);
> >
> >       if (v->ahash_tfm) {
> >               static_branch_dec(&ahash_enabled);
> > @@ -1418,6 +1455,13 @@ static int verity_ctr(struct dm_target *ti, unsi=
gned int argc, char **argv)
> >               ti->error =3D "Root hash verification failed";
> >               goto bad;
> >       }
> > +
> > +     r =3D verity_init_sig(v, verify_args.sig, verify_args.sig_size);
> > +     if (r < 0) {
> > +             ti->error =3D "Cannot allocate root digest signature";
> > +             goto bad;
> > +     }
> > +
> >       v->hash_per_block_bits =3D
> >               __fls((1 << v->hash_dev_block_bits) / v->digest_size);
> >
> > @@ -1559,8 +1603,79 @@ int dm_verity_get_root_digest(struct dm_target *=
ti, u8 **root_digest, unsigned i
> >       return 0;
> >   }
> >
> > +#ifdef CONFIG_SECURITY
> > +
> > +#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
> > +
> > +static int verity_security_set_signature(struct block_device *bdev,
> > +                                      struct dm_verity *v)
> > +{
> > +     /*
> > +      * if the dm-verity target is unsigned, v->root_digest_sig will
> > +      * be NULL, and the hook call is still required to let LSMs mark
> > +      * the device as unsigned. This information is crucial for LSMs t=
o
> > +      * block operations such as execution on unsigned files
> > +      */
> > +     return security_bdev_setintegrity(bdev,
> > +                                       LSM_INT_DMVERITY_SIG_VALID,
> > +                                       v->root_digest_sig,
> > +                                       v->sig_size);
> > +}
> > +
> > +#else
> > +
> > +static inline int verity_security_set_signature(struct block_device *b=
dev,
> > +                                             struct dm_verity *v)
> > +{
> > +     return 0;
> > +}
> > +
> > +#endif /* CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG */
> > +
> > +/*
> > + * Expose verity target's root hash and signature data to LSMs before =
resume.
> > + *
> > + * Returns 0 on success, or -ENOMEM if the system is out of memory.
> > + */
> > +static int verity_preresume(struct dm_target *ti)
> > +{
> > +     struct block_device *bdev;
> > +     struct dm_verity_digest root_digest;
> > +     struct dm_verity *v;
> > +     int r;
> > +
> > +     v =3D ti->private;
> > +     bdev =3D dm_disk(dm_table_get_md(ti->table))->part0;
> > +     root_digest.digest =3D v->root_digest;
> > +     root_digest.digest_len =3D v->digest_size;
> > +     if (static_branch_unlikely(&ahash_enabled) && !v->shash_tfm)
> > +             root_digest.alg =3D crypto_ahash_alg_name(v->ahash_tfm);
> > +     else
> > +             root_digest.alg =3D crypto_shash_alg_name(v->shash_tfm);
> > +
> > +     r =3D security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH,=
 &root_digest,
> > +                                    sizeof(root_digest));
> > +     if (r)
> > +             return r;
> > +
> > +     r =3D  verity_security_set_signature(bdev, v);
> > +     if (r)
> > +             goto bad;
> > +
> > +     return 0;
> > +
> > +bad:
> > +
> > +     security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL,=
 0);
> > +
> > +     return r;
> > +}
> > +
> > +#endif /* CONFIG_SECURITY */
> > +
> >   static struct target_type verity_target =3D {
> >       .name           =3D "verity",
> > +/* Note: the LSMs depend on the singleton and immutable features */
> >       .features       =3D DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> >       .version        =3D {1, 10, 0},
> >       .module         =3D THIS_MODULE,
> > @@ -1571,6 +1686,9 @@ static struct target_type verity_target =3D {
> >       .prepare_ioctl  =3D verity_prepare_ioctl,
> >       .iterate_devices =3D verity_iterate_devices,
> >       .io_hints       =3D verity_io_hints,
> > +#ifdef CONFIG_SECURITY
> > +     .preresume      =3D verity_preresume,
> > +#endif /* CONFIG_SECURITY */
> >   };
> >   module_dm(verity);
> >
> > diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> > index aac3a1b1d94a..ea2da450f173 100644
> > --- a/drivers/md/dm-verity.h
> > +++ b/drivers/md/dm-verity.h
> > @@ -45,6 +45,9 @@ struct dm_verity {
> >       u8 *salt;               /* salt: its size is salt_size */
> >       u8 *initial_hashstate;  /* salted initial state, if shash_tfm is =
set */
> >       u8 *zero_digest;        /* digest for a zero block */
> > +#ifdef CONFIG_SECURITY
> > +     u8 *root_digest_sig;    /* signature of the root digest */
> > +#endif /* CONFIG_SECURITY */
> >       unsigned int salt_size;
> >       sector_t data_start;    /* data offset in 512-byte sectors */
> >       sector_t hash_start;    /* hash start in blocks */
> > @@ -58,6 +61,9 @@ struct dm_verity {
> >       bool hash_failed:1;     /* set if hash of any block failed */
> >       bool use_bh_wq:1;       /* try to verify in BH wq before normal w=
ork-queue */
> >       unsigned int digest_size;       /* digest size for the current ha=
sh algorithm */
> > +#ifdef CONFIG_SECURITY
> > +     unsigned int sig_size;  /* root digest signature size */
> > +#endif /* CONFIG_SECURITY */
> >       unsigned int hash_reqsize; /* the size of temporary space for cry=
pto */
> >       enum verity_mode mode;  /* mode for handling verification errors =
*/
> >       unsigned int corrupted_errs;/* Number of errors for corrupted blo=
cks */
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 39aec1c96d6a..0604893f2f9e 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -83,8 +83,15 @@ enum lsm_event {
> >       LSM_POLICY_CHANGE,
> >   };
> >
> > +struct dm_verity_digest {
> > +     const char *alg;
> > +     const u8 *digest;
> > +     size_t digest_len;
> > +};
> > +
> >   enum lsm_integrity_type {
> > -     __LSM_INT_MAX
> > +     LSM_INT_DMVERITY_SIG_VALID,
> > +     LSM_INT_DMVERITY_ROOTHASH,
> >   };
> >
> >   /*



--=20
paul-moore.com

