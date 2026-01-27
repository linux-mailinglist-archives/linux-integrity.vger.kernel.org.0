Return-Path: <linux-integrity+bounces-8326-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJYPEESDeGmqqgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8326-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:20:04 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE5919B3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7D43032F68
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B42D7DED;
	Tue, 27 Jan 2026 09:15:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD2D6E55;
	Tue, 27 Jan 2026 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505320; cv=none; b=bE53pVUB5tGvK8T5XEouKevtLvJnNypOm5GoXNwWe3mK53e9Bwp9pf8yfo8+WHetNCh2dfT4VvFCTY8eSuWTSxu7aM9EHrpjXyTQ0sYsNt1F3Eu1KKsFzovxM81H8YIIVm+CNjm4/OPiAkOSy2NGlC8b5bVsGyTEVgqOZJHcTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505320; c=relaxed/simple;
	bh=8AKpzUsCakD51J6TH8RHf35RspQgGppypEY0UlXF7XA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJHWUA0UM79GxIGvNFkPlerJTBHKe784hrPZBE0h7y4rCLL8LEDYvO75CrnDIgdMM2ji2Gn8AaxkglfIjxUkl1Lmq0D1t/qPP74oNbOJMkJZZNk0HZZDlv3uxERqWx6udYSzyo00Q0Y/KxFyv8dhsVCqtRKHsAQvvYL0YDk/xfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f0fnG6Zmkz1HDP2;
	Tue, 27 Jan 2026 17:12:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 34DDE4056A;
	Tue, 27 Jan 2026 17:15:09 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAX4WsTgnhpNbC0Ag--.9631S2;
	Tue, 27 Jan 2026 10:15:08 +0100 (CET)
Message-ID: <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
Subject: Re: [PATCH] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dima@arista.com, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Silvia Sisinni <silvia.sisinni@polito.it>, Enrico Bravi
 <enrico.bravi@polito.it>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 27 Jan 2026 10:14:55 +0100
In-Reply-To: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAX4WsTgnhpNbC0Ag--.9631S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47Gry5Xry5tF1fCF18uFg_yoWrArWfpF
	Z8WFyxCr4kJFy7GrnrAa43Gr4rJrWUC3WUJrn5Jr10y3W7G3WkXr1DCF1UCr98Wry5AF12
	qwsrXr4Yyr4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGl4LxwKcgAAsa
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8326-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[arista.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,polito.it:email]
X-Rspamd-Queue-Id: 77BE5919B3
X-Rspamd-Action: no action

On Tue, 2026-01-27 at 03:05 +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
>=20
> ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm

Algorithm.

> from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> It seems avoid adding the unsupported algorithm to ima_algo_array will
> break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).
>=20
> Grepping HASH_ALGO__LAST in security/integrity/ima/ shows that is
> the check other logic relies on, so make
> create_securityfs_measurement_lists() ignore unknown algorithms.
>=20
> On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists=
+0x396/0x440
> > Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
> >=20
> > CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x61/0x90
> >  print_report+0xc4/0x580
> >  ? kasan_addr_to_slab+0x26/0x80
> >  ? create_securityfs_measurement_lists+0x396/0x440
> >  kasan_report+0xc2/0x100
> >  ? create_securityfs_measurement_lists+0x396/0x440
> >  create_securityfs_measurement_lists+0x396/0x440
> >  ima_fs_init+0xa3/0x300
> >  ima_init+0x7d/0xd0
> >  init_ima+0x28/0x100
> >  do_one_initcall+0xa6/0x3e0
> >  kernel_init_freeable+0x455/0x740
> >  kernel_init+0x24/0x1d0
> >  ret_from_fork+0x38/0x80
> >  ret_from_fork_asm+0x11/0x20
> >  </TASK>
> >=20
> > The buggy address belongs to the variable:
> >  hash_algo_name+0xb8/0x420
> >=20
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10=
7ce18
> > flags: 0x8000000000002000(reserved|zone=3D2)
> > raw: 8000000000002000 ffffea0041f38608 ffffea0041f38608 000000000000000=
0
> > raw: 0000000000000000 0000000000000000 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >=20
> > Memory state around the buggy address:
> >  ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
> >  ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
> >                                         ^
> >  ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
> >  ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Seems like the TPM chip supports sha3_256, which isn't yet in
> tpm_algorithms:
> > tpm tpm0: TPM with unsupported bank algorithm 0x0027
>=20
> Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash a=
lgorithm")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Cc: Enrico Bravi <enrico.bravi@polito.it>
> Cc: Silvia Sisinni <silvia.sisinni@polito.it>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_fs.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 012a58959ff0..e9283229acea 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -404,6 +404,9 @@ static int __init create_securityfs_measurement_lists=
(void)
>  		char file_name[NAME_MAX + 1];
>  		struct dentry *dentry;
> =20
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			continue;
> +
>  		sprintf(file_name, "ascii_runtime_measurements_%s",
>  			hash_algo_name[algo]);

Thanks, but I think we can also print the unsupported digests, since
they are there. Since we don't have the algorithm name, we can make
ours like tpm_<algo hex>.

Once this is fixed, you can try to make SHA3_256 supported. Add the
TPM_ALG_SHA3_256 definition in tpm.h and the mapping in tpm2-cmd.c
(array tpm2_hash_map).

Thanks

Roberto

>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>=20
> ---
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> change-id: 20260127-ima-oob-9fa83a634d7b
>=20
> Best regards,


