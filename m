Return-Path: <linux-integrity+bounces-3481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EB96F009
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA421F27965
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495641C871C;
	Fri,  6 Sep 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CclR5XKV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181161CB145;
	Fri,  6 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615907; cv=none; b=Nvr6nxYjT2pTeNeYJd+j1aG/uBMw1a+61K5LATfRAtGq9DgQWMC2a6D3gyd319QKkKgGHJK4fTnVKZ094YKREe3bPQI2D8Y97RiR54syIp7hXuWoxPj0Bi6ThenbkBbFIrBQyoqZSaD5LxZie9Kr4Blh4cW8qA49mhWBJkO4KBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615907; c=relaxed/simple;
	bh=h6tMVK3hUBDyNHoKcfua8I1SEiAjO/LajNuZV1loc14=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C8ZENN9fpUAuascFQ8xrFTE7dA7Hgpv1jJ61YmVGDzpMmW554L1+6S11mlomGQvwlYiYCWqJMnhYyszk408Zs3w4sIvTtAYQkSs1kSHnifCdDtWJCYHNw9YXq6xCtS0h8TvyHm+FUgTIeuEbZ+ttSc3B9zKV885hZE4v1q49urs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CclR5XKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254B1C4CEC8;
	Fri,  6 Sep 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725615906;
	bh=h6tMVK3hUBDyNHoKcfua8I1SEiAjO/LajNuZV1loc14=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CclR5XKVX+vY89v50ULWz36stcErhdsU39M/DOohlVC/ZsSaSe+y3L2IVBJjbPScH
	 GXOn0glHUhAT0iOZk62N3cY7PkUOSJGILlYDN3lY0iTk6LWbYD1GnbNXI9pmF9EGgg
	 sJTAp9ln8Jydc29cP4RJop1LNuwYibdDa7bWNnnddaUZQgkULn/SRTob/OB5uoQAfX
	 cq01Mi6KkHOKwteAKlxrlMmy8JD+h7QtHwgu8P4aSfXTaLlzvo9JK7hDejHRlEoBGU
	 8ALB9zWGb77EYUlbWUzVdRneP+6mUMRKEOgAT6Jg2OtKa8mBMNQ6XKTr40zW9OWwyL
	 8W+OTBBNXxt0Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 12:45:02 +0300
Message-Id: <D3Z3S9Z6B4BC.2OSFJZYTZOPZD@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <wufan@linux.microsoft.com>, <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>,
 <hch@lst.de>, <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>,
 <jannh@google.com>, <dhowells@redhat.com>, <jikos@kernel.org>,
 <mkoutny@suse.com>, <ppavlu@suse.com>, <petr.vorel@gmail.com>,
 <mzerqung@0pointer.de>, <kgold@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v3 04/10] ima: Add digest_cache_measure/appraise
 boot-time built-in policies
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
 <serge@hallyn.com>
X-Mailer: aerc 0.18.2
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
 <20240905152512.3781098-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240905152512.3781098-5-roberto.sassu@huaweicloud.com>

On Thu Sep 5, 2024 at 6:25 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=3D' =
in
> the kernel command line to add the following rule at the beginning of the
> IMA policy, before other rules:
>
> measure func=3DDIGEST_LIST_CHECK pcr=3D12
>
> which will measure digest lists into PCR 12 (or the value in
> CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).
>
> Specify 'digest_cache_appraise' to add the following rule at the beginnin=
g,
> before other rules:
>
> appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
>
> which will appraise digest lists with IMA signatures or module-style
> appended signatures.
>
> Adding those rule at the beginning rather than at the end is necessary to
> ensure that digest lists are measured and appraised in the initial ram
> disk, which would be otherwise prevented by the dont_ rules.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 +++++-
>  security/integrity/ima/Kconfig                | 10 ++++++
>  security/integrity/ima/ima_policy.c           | 35 +++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..afaaf125a237 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2077,7 +2077,8 @@
>  	ima_policy=3D	[IMA]
>  			The builtin policies to load during IMA setup.
>  			Format: "tcb | appraise_tcb | secure_boot |
> -				 fail_securely | critical_data"
> +				 fail_securely | critical_data |
> +				 digest_cache_measure | digest_cache_appraise"
> =20
>  			The "tcb" policy measures all programs exec'd, files
>  			mmap'd for exec, and all files opened with the read
> @@ -2099,6 +2100,13 @@
>  			The "critical_data" policy measures kernel integrity
>  			critical data.
> =20
> +			The "digest_cache_measure" policy measures digest lists
> +			into PCR 12 (can be changed with kernel config).
> +
> +			The "digest_cache_appraise" policy appraises digest
> +			lists with IMA signatures or module-style appended
> +			signatures.
> +
>  	ima_tcb		[IMA] Deprecated.  Use ima_policy=3D instead.
>  			Load a policy which meets the needs of the Trusted
>  			Computing Base.  This means IMA will measure all

Must be updated as a separate commit as kernel-parameters.txt not
part of IMA. Consider it as a different subsystem in this context.

BR, Jarkko

