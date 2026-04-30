Return-Path: <linux-integrity+bounces-9390-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNpeKHQo82mwxgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9390-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 12:01:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1F4A06A7
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C163C305DF4E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8F3FF896;
	Thu, 30 Apr 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eFo/K5gM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A73E8C49;
	Thu, 30 Apr 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542538; cv=none; b=YEFGM04iaaQXvKVDkflsgz5lBBcgp2BckuN5kXPKkWdgKpA/VDXeGv4nKFje+fzPCIxNWF6u5bH3keyoNhXPIeRfOTZa8hvy2zglXomdCL6WwkTFGWaMtO38z/gwkQeQnNoC452g4iYXtInuBXtb0h5pWKntM21gFAHZos/paJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542538; c=relaxed/simple;
	bh=rzcIYj7NzzucogeiuQ/ByvTxcKuN8A1oBUxuhPjfH7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMFvbeHlH6mJnAh2VIU+zdLfALZvzHxizRYD+lhm4rUrS61bzzx1hQ20nYPgyGv9OZJZvm9IJaXzeeozlNGTys44emQ+bOqzIy7ZgbUBvbEi/h9UEMWutSmlh4E9jK+ec42zpft9BRLIR7P5cfFv2TNbBe7gsrf7FovZ5wuyu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eFo/K5gM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CA21A9A;
	Thu, 30 Apr 2026 02:48:51 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D953F7B4;
	Thu, 30 Apr 2026 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777542536; bh=rzcIYj7NzzucogeiuQ/ByvTxcKuN8A1oBUxuhPjfH7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFo/K5gMt2O/K0ixr+Iw6rFpXaEcpWJ2+qHc0kYzzPm3RfnEds4QfonFkGRBTdRUK
	 OoLeIkr69ulpGR6jATyx4HSrGhATKhOjwOB3/hbIEsPdNqT7J0tLJCgyz/jMo4ohK5
	 xJudtOZDygy6ZlDmbe0Yjhj8s/FiZ6ovsxkoVlds=
Date: Thu, 30 Apr 2026 10:48:50 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Message-ID: <afMlgstqahnZg68h@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 15B1F4A06A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9390-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,e129823.arm.com:mid]

Hi Mimi,

Thanks to share the testing code and please see the below:

> With this "[RFC PATCH v3 0/4] Fix IMA + TPM initialisation ordering
> issue" patch set, how many records would be missing if IMA
> initialization is deferred to late_initcall_sync [1]?
>
> [1]https://lore.kernel.org/linux-integrity/cover.1777036497.git.noodles@meta.com/
> ---
> Jonathan, Yeoreum, others -
>
> By going into TPM-bypass mode, we can see how many measurements are actually
> missing when deferring IMA initialization to late_initcall_sync. As this is
> system/TPM dependent, I'd appreciate your checking. Please use the boot command
> line option "ima_policy=tcb|critical_data".
>
> thanks, Mimi
>
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_init.c |  6 ++++++
>  security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 01aae19ed365..9a1117112fb2 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -286,6 +286,7 @@ extern bool ima_canonical_fmt;
>
>  /* Internal IMA function definitions */
>  int ima_init_core(bool late);
> +int ima_init_debug(bool late);
>  int ima_fs_init(void);
>  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5f335834a9bb..edd063b99685 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -122,6 +122,12 @@ void __init ima_load_x509(void)
>  }
>  #endif
>
> +int __init ima_init_debug(bool late)
> +{
> +	ima_add_boot_aggregate(late); /* just add an additional record */
> +	return 0;
> +}
> +
>  int __init ima_init_core(bool late)
>  {
>  	int rc;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 42099bfe7e43..23e669be54fc 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1254,6 +1254,7 @@ static int ima_kernel_module_request(char *kmod_name)
>
>  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
>
> +#define TESTING 1
>  static int __init init_ima(bool late)
>  {
>  	int error;
> @@ -1264,6 +1265,23 @@ static int __init init_ima(bool late)
>  		return 0;
>  	}
>
> +#ifdef TESTING
> +	/*
> +	 * Initialize early, even if it means going into TPM-bypass mode,
> +	 * but add an additional boot_aggregrate message for the
> +	 * late_initcall_sync.
> +	 *
> +	 * If measurement list records exist between the boot_aggregate
> +	 * and the boot_aggregate_late records, these records would be
> +	 * missing when IMA initializion is deferred to late_initcall_sync.
> +	 */
> +	if (ima_tpm_chip) {

I believe this should be:
  if (late) {
     ...
  }

> +		ima_init_debug(late); /* Add an additional record */
> +		return 0;
> +	}
> +
> +	ima_tpm_chip = tpm_default_chip();
> +#elif
>  	/*
>  	 * If we found the TPM during our first attempt, or we know there's no
>  	 * TPM, nothing further to do
> @@ -1276,6 +1294,7 @@ static int __init init_ima(bool late)
>  		pr_debug("TPM not available, will try later\n");
>  		return -EPROBE_DEFER;
>  	}
> +#endif
>
>  	if (!ima_tpm_chip)
>  		pr_info("No TPM chip found, activating TPM-bypass!\n");
> --
> 2.53.0

With above change I confirmed there is no meaurement log
between boot_aggregate and boot_aggregate_late except "kernel_version"
But this is ignorable since this UTS measurement is done in
"ima_init_core() (old: ima_init())" and it is part of ima initialisation.

1. ima_policy=tcb

  # cat /sys/kernel/security/ima/ascii_runtime_measurements
  10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
  10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late
  10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
  10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013e9768d9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aarch64.so.1
  10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62bcfb2fcf1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc.so.3.0.0
  10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b4f6927bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so.2
  10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442de5d31c3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
  10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146b6dd32b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
  10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698fe0a6862050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
  10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b57e8234c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.1.1.0
  10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414ec0355fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.1.1.0
  10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
  10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ffe2b30e5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
  10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d699442cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
  10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a710989b43222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
  10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f28772f71715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
  10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615df9f2012b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
  ...

2. ima_policy=critical_data

  # cat /sys/kernel/security/ima/ascii_runtime_measurements
  10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
  10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
  10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late

Therefore, init_ima() could move into late_initcall_sync like v1 did:
  - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@arm.com/

Thanks.

--
Sincerely,
Yeoreum Yun

