Return-Path: <linux-integrity+bounces-2711-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC18D44EB
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 07:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158F11C21294
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550BD137937;
	Thu, 30 May 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+2n6QSo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04383142E85;
	Thu, 30 May 2024 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048195; cv=none; b=Oc98hRNaaRc/41TzD56gR7m+E8GR5Lr4wxJlZNG2O8kIK1hLUzK/+uDEIDQmkVQfvxBdV3gaDNUz/4LxZjPLJljkMyrL1n28FNEGkq9h0CSQr6DegGTAj0TkIDAg5vgGH8KI8Jm6rEx+OJIpsGsGYwFIpRiQf0FyyeEfROerQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048195; c=relaxed/simple;
	bh=7+dnG3WUQBWbugvASJZr4RwKum91jLcT2Ms1uQHX6J4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WpUqtcXpWBR5fUv+R3jf7LZi2qBl4CmgSyW0CAFo84Zwz9rRYbe0nPKQaQf+o8fzK3tegEIzAjq3THPVuehtR6iduWBdsBMjzb8IaQt/D8fnKCRE3HmkZZRTuctU+s+R3NHeGNI6EQ4GZ1Tifq0yTcNDRe717/G/L5UYWk/4Ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+2n6QSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BDEC2BBFC;
	Thu, 30 May 2024 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717048194;
	bh=7+dnG3WUQBWbugvASJZr4RwKum91jLcT2Ms1uQHX6J4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Y+2n6QSo/Lzj6UGzj9j6W/lNXVRakSs10UiEg82tlLiBQbLQAOkcxOXL/mdNaXhQ8
	 VJ/anR6Yn0ZhVyPQgzc3OiUOTKTeTr4gzP1PUCQCyy6iyA3C7tmwSXRZgaPVtIp+Uq
	 UGKBdh+Vmd+ySFBE8LP8wgjAylC4VTo9d8TVXZoBxdZqjEBYuCvvUNxKyeWDECIyQY
	 7p5xQNDO9vDuqPBgzVGwiE6j0WzhFoBCdMgJkTibJKhUOHx0DyKw8oSpJGhn5atAQy
	 sOsHOppc4q+gf3wg5R17etd8DmVzK7ky2iIT4+nvx23g+VgoY81mp/amBVHrkB85mR
	 vP7I2yf5Rt4uw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 08:49:43 +0300
Message-Id: <D1MQS61J31B4.26M79HHP1VCQT@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 13/20] ipe: add support for dm-verity as a trust
 provider
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <mpatocka@redhat.com>, <eparis@redhat.com>
X-Mailer: aerc 0.17.0
References: <1716583609-21790-14-git-send-email-wufan@linux.microsoft.com>
 <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>
In-Reply-To: <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>

On Thu May 30, 2024 at 4:44 AM EEST, Paul Moore wrote:
> On May 24, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> > +	if (type =3D=3D LSM_INT_DMVERITY_ROOTHASH) {
> > +		if (!value) {
> > +			ipe_digest_free(blob->root_hash);
> > +			blob->root_hash =3D NULL;
> > +
> > +			return 0;
> > +		}
> > +		digest =3D value;
> > +
> > +		info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > +		if (!info)
> > +			return -ENOMEM;
> > +
> > +		info->digest =3D kmemdup(digest->digest, digest->digest_len,
> > +				       GFP_KERNEL);
> > +		if (!info->digest)
> > +			goto dmv_roothash_err;
> > +
> > +		info->alg =3D kstrdup(digest->alg, GFP_KERNEL);
> > +		if (!info->alg)
> > +			goto dmv_roothash_err;
> > +
> > +		info->digest_len =3D digest->digest_len;
> > +
> > +		if (blob->root_hash)
> > +			ipe_digest_free(blob->root_hash);

I'd restructure this as:

	if (type =3D=3D LSM_INT_DMVERITY_SIG_VALID {
		/* ... */
		return 0;
	}

	if (type !=3D LSM_INT_DMVERITY_ROOTHASH)
		return -EINVAL;

	* ... */

Right? Less packed to the right ;-)

BR, Jarkko

