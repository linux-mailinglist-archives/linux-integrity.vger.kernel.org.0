Return-Path: <linux-integrity+bounces-8973-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDOsI8A6sWkLswIAu9opvQ
	(envelope-from <linux-integrity+bounces-8973-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 10:49:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBD261332
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A311430517C1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B513B7B61;
	Wed, 11 Mar 2026 09:44:14 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B373BB9F8;
	Wed, 11 Mar 2026 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222254; cv=none; b=VC6LCWY0mc86IAMwX774jporPRLqjHKytqoH1/8N4TyIGodZSiIr8Q2qgbpuSh29itf3nLWuLWlMFSUO7y97opQRrpmLQJhCninrCXoz3zZ1dQ1Dam2br0Y/7LTtufKGmPsOA9AVD78psrG1QC+wjc74gj4ZzyA8vMT5cqkSgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222254; c=relaxed/simple;
	bh=dMJ0WYxVwU8JPx3mZhjtAyZ4NMen1YwJaxznarSJXl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssyzAp2BJyYAxZ69v0+regOfOKCUYp+ag2WqJMiHSNc/2MMrsf4hioUm33C3BCW+QcyoVKnv8kFCF0N6LISbaxaRf4pNAhht1bpSWwDyh13DrehK1p4VuKGkiZ6bMpOnywRmmlW1Mz5fCdjfT6+Xj8cJ4rv6gs3I9eCuUtH8ZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fW4yM0N3kzpVFd;
	Wed, 11 Mar 2026 17:22:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4F03D40567;
	Wed, 11 Mar 2026 17:25:32 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnxYL9NLFpLnFBAA--.37707S2;
	Wed, 11 Mar 2026 10:25:31 +0100 (CET)
Message-ID: <5b373d176ec1ba4a149e58b7c20c9a029c358eef.camel@huaweicloud.com>
Subject: Re: [PATCH v6] ima_fs: Correctly create securityfs files for
 unsupported hash algos
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dima@arista.com, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Silvia Sisinni <silvia.sisinni@polito.it>, Enrico Bravi
 <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 11 Mar 2026 10:25:15 +0100
In-Reply-To: <20260310-ima-oob-v6-1-dc111c846ff4@arista.com>
References: <20260310-ima-oob-v6-1-dc111c846ff4@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnxYL9NLFpLnFBAA--.37707S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy5XFWfXryUXF4rAFyDGFg_yoWxWF4xpa
	97WryxCr4kJrWxJFn7G3W3ur4rC3yYk3WUGrn5Jw1UA3WDWw1qkrnakr1Y9rWq9r90yFy2
	qw17tr43tw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGmw1qwCoAAAsO
X-Rspamd-Queue-Id: 79BBD261332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8973-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[arista.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.652];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arista.com:email,polito.it:email,huaweicloud.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 17:40 +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
>=20
> ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> are places relying on the algorithm to be valid because it is accessed
> by hash_algo_name[].
>=20
> On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists=
+0x396/0x440
>   Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
>=20
>   CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x61/0x90
>    print_report+0xc4/0x580
>    ? kasan_addr_to_slab+0x26/0x80
>    ? create_securityfs_measurement_lists+0x396/0x440
>    kasan_report+0xc2/0x100
>    ? create_securityfs_measurement_lists+0x396/0x440
>    create_securityfs_measurement_lists+0x396/0x440
>    ima_fs_init+0xa3/0x300
>    ima_init+0x7d/0xd0
>    init_ima+0x28/0x100
>    do_one_initcall+0xa6/0x3e0
>    kernel_init_freeable+0x455/0x740
>    kernel_init+0x24/0x1d0
>    ret_from_fork+0x38/0x80
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>=20
>   The buggy address belongs to the variable:
>    hash_algo_name+0xb8/0x420
>=20
>   Memory state around the buggy address:
>    ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
>    ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
>                                           ^
>    ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
>    ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Seems like the TPM chip supports sha3_256, which isn't yet in
> tpm_algorithms:
>   tpm tpm0: TPM with unsupported bank algorithm 0x0027
>=20
> That's TPM_ALG_SHA3_256 =3D=3D 0x0027 from "Trusted Platform Module 2.0
> Library Part 2: Structures", page 51 [1].
> See also the related U-Boot algorithms update [2].
>=20
> Thus solve the problem by creating a file name with "_tpm_alg_<ID>"
> postfix if the crypto algorithm isn't initialized.
>=20
> This is how it looks on the test machine (patch ported to v6.12 release):
>   # ls -1 /sys/kernel/security/ima/
>   ascii_runtime_measurements
>   ascii_runtime_measurements_tpm_alg_27
>   ascii_runtime_measurements_sha1
>   ascii_runtime_measurements_sha256
>   binary_runtime_measurements
>   binary_runtime_measurements_tpm_alg_27
>   binary_runtime_measurements_sha1
>   binary_runtime_measurements_sha256
>   policy
>   runtime_measurements_count
>   violations
>=20
> [1]: https://trustedcomputinggroup.org/wp-content/uploads/Trusted-Platfor=
m-Module-2.0-Library-Part-2-Version-184_pub.pdf
> [2]: https://lists.denx.de/pipermail/u-boot/2024-July/558835.html
>=20
> Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash a=
lgorithm")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Cc: Enrico Bravi <enrico.bravi@polito.it>
> Cc: Silvia Sisinni <silvia.sisinni@polito.it>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Tested-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
> Changes in v6:
> - Change subject now that securityfs files are created (Mimi Zohar)
> - Added a link to TCG document and the related U-Boot changes
> - Link to v5: https://lore.kernel.org/r/20260223-ima-oob-v5-1-91cc1064e76=
7@arista.com
>=20
> Changes in v5:
> - Use lower-case for sysfs file name (as suggested-by Jonathan and Robert=
o)
> - Don't use email quotes for patch description (Roberto)
> - Re-word the patch description (suggested-by Roberto)
> - Link to v4: https://lore.kernel.org/r/20260127-ima-oob-v4-1-bf0cd7f9b4d=
4@arista.com
>=20
> Changes in v4:
> - Use ima_tpm_chip->allocated_banks[algo_idx].digest_size instead of hash=
_digest_size[algo]
>   (Roberto Sassu)
> - Link to v3: https://lore.kernel.org/r/20260127-ima-oob-v3-1-1dd09f4c2a6=
a@arista.com
> Testing note: I test it on v6.12.40 kernel backport, which slightly diffe=
rs as
> lookup_template_data_hash_algo() was yet present.
>=20
> Changes in v3:
> - Now fix the spelling *for real* (sorry, messed it up in v2)
> - Link to v2: https://lore.kernel.org/r/20260127-ima-oob-v2-1-f38a18c850c=
f@arista.com
>=20
> Changes in v2:
> - Instead of skipping unknown algorithms, add files under their TPM_ALG_I=
D (Roberto Sassu)
> - Fix spelling (Roberto Sassu)
> - Copy @stable on the fix
> - Link to v1: https://lore.kernel.org/r/20260127-ima-oob-v1-1-2d42f3418e5=
7@arista.com
> ---
>  security/integrity/ima/ima_fs.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 23d3a14b8ce3..ca4931a95098 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -398,16 +398,24 @@ static int __init create_securityfs_measurement_lis=
ts(void)
>  		char file_name[NAME_MAX + 1];
>  		struct dentry *dentry;
> =20
> -		sprintf(file_name, "ascii_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);
> +		else
> +			sprintf(file_name, "ascii_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_ascii_measurements_ops);
>  		if (IS_ERR(dentry))
>  			return PTR_ERR(dentry);
> =20
> -		sprintf(file_name, "binary_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);
> +		else
> +			sprintf(file_name, "binary_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_measurements_ops);
>=20
> ---
> base-commit: 343f51842f4ed7143872f3aa116a214a5619a4b9
> change-id: 20260127-ima-oob-9fa83a634d7b
>=20
> Best regards,


