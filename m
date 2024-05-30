Return-Path: <linux-integrity+bounces-2713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7608D4502
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 07:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD741F22FF7
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE34143739;
	Thu, 30 May 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFJkj3go"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69814372C;
	Thu, 30 May 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048443; cv=none; b=AFK53xYcdjl+7PsqHKE7xedq9rMQ6+RPCW4BKvFNC0vKGsn6u6itm1oikCMeRsoGPvRWxCpH7q0dfdtldgFJr7zsrPVOrCqH1MwX5OWSj2zpPDp47rFtPabyANlkHQXPksc4hoNEiy69DqkXtatqaTMa557K5go0DwENIopdIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048443; c=relaxed/simple;
	bh=zp259wkXtPz3aX+KSbUFsvWtLVHM6TCoCks217es0Ug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M8D7DdZ7pRIj9Rm6KixSZHyogvJgq9qqTPRW6WkvJOuPJFNFHdw0nohAZFogSttNSVndV+zN08tnn0DW2uLEbjRztkKksNSjcCPeO+n6V/hbTfBgFTo699BFOhNm4CbnMO3G1i5q5Dg1Uv0WYT5WWrjn+kVe95YPs4IIuLVu7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFJkj3go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCF8C3277B;
	Thu, 30 May 2024 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717048443;
	bh=zp259wkXtPz3aX+KSbUFsvWtLVHM6TCoCks217es0Ug=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IFJkj3goNCaD9gPedH2gZcpYRMcRbXdj71GqNXNmvj1VJ+a+IF6L9vw6KqI8YRxjT
	 Yc0lEqwByVrurvRKzz4dumjKDl95MRzjIksFNrSP33V1+drP8O8nI+wxPxBzZdLweS
	 24ocRbOfxerOUnJ0c55KmJFahoBp3V0XyxZX5QihR+MDOptwxv+KFKw4Od7Lat7dBp
	 9HpIYfdN3lNwhx2VlHlL7q1ayRplEiA/xFGz9UFY8VwLw2H0h2lkr9Jyca7CtEUWE1
	 eVdaaH09MqaSIlXQjXTxwUuUPXvRD86fJtOpMz/y/3Q+JrJVqNVesuEUZKg7nqaRRP
	 +54JM5f9YqwGg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 08:53:52 +0300
Message-Id: <D1MQVCEITGPS.2HU8JUF2MAYQ7@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 13/20] ipe: add support for dm-verity as a trust
 provider
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, "Paul Moore"
 <paul@paul-moore.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <mpatocka@redhat.com>, <eparis@redhat.com>
X-Mailer: aerc 0.17.0
References: <1716583609-21790-14-git-send-email-wufan@linux.microsoft.com>
 <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>
 <67da2ff3-e0c4-4552-93dd-cf9cb04d0d78@linux.microsoft.com>
In-Reply-To: <67da2ff3-e0c4-4552-93dd-cf9cb04d0d78@linux.microsoft.com>

On Thu May 30, 2024 at 6:58 AM EEST, Fan Wu wrote:
>
>
> On 5/29/2024 6:44 PM, Paul Moore wrote:
> > On May 24, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>
> >> Allows author of IPE policy to indicate trust for a singular dm-verity
> >> volume, identified by roothash, through "dmverity_roothash" and all
> >> signed and validated dm-verity volumes, through "dmverity_signature".
> >>
> >> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >> ---
> >> v2:
> >>    + No Changes
> >>
> >> v3:
> >>    + No changes
> >>
> >> v4:
> >>    + No changes
> >>
> >> v5:
> >>    + No changes
> >>
> >> v6:
> >>    + Fix an improper cleanup that can result in
> >>      a leak
> >>
> >> v7:
> >>    + Squash patch 08/12, 10/12 to [11/16]
> >>
> >> v8:
> >>    + Undo squash of 08/12, 10/12 - separating drivers/md/ from securit=
y/
> >>      & block/
> >>    + Use common-audit function for dmverity_signature.
> >>    + Change implementation for storing the dm-verity digest to use the
> >>      newly introduced dm_verity_digest structure introduced in patch
> >>      14/20.
> >>
> >> v9:
> >>    + Adapt to the new parser
> >>
> >> v10:
> >>    + Select the Kconfig when all dependencies are enabled
> >>
> >> v11:
> >>    + No changes
> >>
> >> v12:
> >>    + Refactor to use struct digest_info* instead of void*
> >>    + Correct audit format
> >>
> >> v13:
> >>    + Remove the CONFIG_IPE_PROP_DM_VERITY dependency inside the parser
> >>      to make the policy grammar independent of the kernel config.
> >>
> >> v14:
> >>    + No changes
> >>
> >> v15:
> >>    + Fix one grammar issue in KCONFIG
> >>    + Switch to use security_bdev_setintegrity() hook
> >>
> >> v16:
> >>    + Refactor for enum integrity type
> >>
> >> v17:
> >>    + Add years to license header
> >>    + Fix code and documentation style issues
> >>    + Return -EINVAL in ipe_bdev_setintegrity when passed type is not
> >>      supported
> >>    + Use new enum name LSM_INT_DMVERITY_SIG_VALID
> >>
> >> v18:
> >>    + Add Kconfig IPE_PROP_DM_VERITY_SIGNATURE and make both DM_VERITY
> >>      config auto-selected
> >>
> >> v19:
> >>    + No changes
> >> ---
> >>   security/ipe/Kconfig         |  27 ++++++++
> >>   security/ipe/Makefile        |   1 +
> >>   security/ipe/audit.c         |  29 ++++++++-
> >>   security/ipe/digest.c        | 118 +++++++++++++++++++++++++++++++++=
++
> >>   security/ipe/digest.h        |  26 ++++++++
> >>   security/ipe/eval.c          |  93 ++++++++++++++++++++++++++-
> >>   security/ipe/eval.h          |  12 ++++
> >>   security/ipe/hooks.c         |  93 +++++++++++++++++++++++++++
> >>   security/ipe/hooks.h         |   8 +++
> >>   security/ipe/ipe.c           |  15 +++++
> >>   security/ipe/ipe.h           |   4 ++
> >>   security/ipe/policy.h        |   3 +
> >>   security/ipe/policy_parser.c |  24 ++++++-
> >>   13 files changed, 449 insertions(+), 4 deletions(-)
> >>   create mode 100644 security/ipe/digest.c
> >>   create mode 100644 security/ipe/digest.h
> >=20
> > ...
> >=20
> >> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> >> index b68719bf44fb..51f1e63c295c 100644
> >> --- a/security/ipe/hooks.c
> >> +++ b/security/ipe/hooks.c
> >> @@ -191,3 +193,94 @@ void ipe_unpack_initramfs(void)
> >>   {
> >>   	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs =3D true;
> >>   }
> >> +
> >> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> >> +/**
> >> + * ipe_bdev_free_security() - Free IPE's LSM blob of block_devices.
> >> + * @bdev: Supplies a pointer to a block_device that contains the stru=
cture
> >> + *	  to free.
> >> + */
> >> +void ipe_bdev_free_security(struct block_device *bdev)
> >> +{
> >> +	struct ipe_bdev *blob =3D ipe_bdev(bdev);
> >> +
> >> +	ipe_digest_free(blob->root_hash);
> >> +}
> >> +
> >> +#ifdef CONFIG_IPE_PROP_DM_VERITY_SIGNATURE
> >> +static void ipe_set_dmverity_signature(struct ipe_bdev *blob,
> >> +				       const void *value,
> >> +				       size_t size)
> >> +{
> >> +	blob->dm_verity_signed =3D size > 0 && value;
> >> +}
> >> +#else
> >> +static inline void ipe_set_dmverity_signature(struct ipe_bdev *blob,
> >> +					      const void *value,
> >> +					      size_t size)
> >> +{
> >> +}
> >> +#endif /* CONFIG_IPE_PROP_DM_VERITY_SIGNATURE */
> >> +
> >> +/**
> >> + * ipe_bdev_setintegrity() - Save integrity data from a bdev to IPE's=
 LSM blob.
> >> + * @bdev: Supplies a pointer to a block_device that contains the LSM =
blob.
> >> + * @type: Supplies the integrity type.
> >> + * @value: Supplies the value to store.
> >> + * @size: The size of @value.
> >> + *
> >> + * This hook is currently used to save dm-verity's root hash or the e=
xistence
> >> + * of a validated signed dm-verity root hash into LSM blob.
> >> + *
> >> + * Return: %0 on success. If an error occurs, the function will retur=
n the
> >> + * -errno.
> >> + */
> >> +int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integri=
ty_type type,
> >> +			  const void *value, size_t size)
> >> +{
> >> +	const struct dm_verity_digest *digest =3D NULL;
> >> +	struct ipe_bdev *blob =3D ipe_bdev(bdev);
> >> +	struct digest_info *info =3D NULL;
> >> +
> >> +	if (type =3D=3D LSM_INT_DMVERITY_ROOTHASH) {
> >> +		if (!value) {
> >> +			ipe_digest_free(blob->root_hash);
> >> +			blob->root_hash =3D NULL;
> >> +
> >> +			return 0;
> >> +		}
> >> +		digest =3D value;
> >> +
> >> +		info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> >> +		if (!info)
> >> +			return -ENOMEM;
> >> +
> >> +		info->digest =3D kmemdup(digest->digest, digest->digest_len,
> >> +				       GFP_KERNEL);
> >> +		if (!info->digest)
> >> +			goto dmv_roothash_err;
> >> +
> >> +		info->alg =3D kstrdup(digest->alg, GFP_KERNEL);
> >> +		if (!info->alg)
> >> +			goto dmv_roothash_err;
> >> +
> >> +		info->digest_len =3D digest->digest_len;
> >> +
> >> +		if (blob->root_hash)
> >> +			ipe_digest_free(blob->root_hash);
> >=20
> > The above if/free looks like a new addition from v18 and I'm not quite
> > sure why the `blob->root_hash` NULL check is necessary as
> > ipe_digest_free() does a IS_ERR_OR_NULL() check right at the top.
> >=20
> > Likely harmless and doubtful to have any noticable performance impact,
> > but I wanted to mention it just in case ...
> >=20
>
> Yes directly call ipe_digest_free() should be enough.
>
> Also this new free is introduced because the mapped device with an=20
> existing dm-verity target can be suspended and associated with a new=20
> dm-verity target. In this case, the root hash associated with the=20
> security blob will be stale and needs to be freed before setting the new=
=20
> data.
>
> -Fan
>
> >> +		blob->root_hash =3D info;
> >> +
> >> +		return 0;
> >> +dmv_roothash_err:

Just a nitpick but 9/10 'err' is a prefix...

Also now this patch set uses 'err'' ambiguously given the use
as name of the variable to store a return code. Similar naming
pattern would do miracles.

> >> +		ipe_digest_free(info);
> >> +
> >> +		return -ENOMEM;
> >> +	} else if (type =3D=3D LSM_INT_DMVERITY_SIG_VALID) {
> >> +		ipe_set_dmverity_signature(blob, value, size);
> >> +
> >> +		return 0;
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> >=20
> > --
> > paul-moore.com


BR, Jarkko

