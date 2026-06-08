Return-Path: <linux-integrity+bounces-9779-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHWrN7UGJ2qTqQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9779-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 20:15:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC82659986
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 20:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=GzCzCDAz;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9779-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9779-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E06308698C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C3330D22;
	Mon,  8 Jun 2026 17:40:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6431F995;
	Mon,  8 Jun 2026 17:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940423; cv=none; b=KATs2c/eIxvbJKyTyftNCqOwO2nArK0eKAvwAo98Kfh9l52Fg95h3845XbW6F/rlVst0rP128WPtfcHSgALFc2k7baZm4OTPhvX/rngX3wAMv12VJSV+YHfCOaAJZSY6mGN4TamQDzgadhJrXkl8uNoh85VMHRSmIdmfKa+UaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940423; c=relaxed/simple;
	bh=amE4mYJyOaDR7piXPHVkNFUVc8/8FmDUujBg/5JhRvY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pmSd/7ojtMCHIhc/eqoSJSPusXFwR/SFopStOnCB9gopu9k4715+KovYZKNlbYdgmZlbvwVHA9yStrN5gJ6tszAGF+oVX3/u8EVC5IH2YDNc0vuzlRvk0iFCX2BVTVZlqUoEJ6jl16lC7kk1jnDDHfUhWUV637Om6/9dRS/WzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GzCzCDAz; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587UTYe1082778;
	Mon, 8 Jun 2026 17:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GuoBiP
	LQ5nY/QchX7WFJNH5SfJNcq3YnQ7Wa6N8TvcQ=; b=GzCzCDAzl84i+C2tonY4xA
	a5K+jpJoPqSGS7ZRDzBhs5Mp/WRnDrzCUTLHZE+uKlI778Mz+R7UQ2J/DM1+yA3t
	ZRt26HxoFdWHek6PkD0OAy8gMFUQOJhYpTf+EX4qq3BuKvaNeFOEB4HQiprGKT0C
	BmIR69H98DJnEKAQakHo6/eNG4via4zOS9MyCEXTEhksPAkBYAV4gQof1qK5XeIC
	IHIBFoAZ4+sJUJvo5e22guC7+bsTaOj0WXbRcZntlKPYe8780YpqmP9L56/EggrE
	FHKCHzdyXZG7/imgxaFxg4ZtwQWvTDwZrDP8KNmPlGPN7p+OTLGx4XFhd/UXVTDg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qgh1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:40:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HYhTO007536;
	Mon, 8 Jun 2026 17:40:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpxk23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:40:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658He28B31589080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:40:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A984C58052;
	Mon,  8 Jun 2026 17:40:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56EBC58054;
	Mon,  8 Jun 2026 17:40:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.149.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 17:40:01 +0000 (GMT)
Message-ID: <f135eab04611432040e4ba66cef2786424af8cc8.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/4] security: ima: introduce IMA_INIT_LATE_SYNC
 option
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com, roberto.sassu@huaweicloud.com, noodles@earth.li,
        jarkko@kernel.org, sudeep.holla@kernel.org, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jgg@ziepe.ca
In-Reply-To: <20260605144325.434436-3-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
	 <20260605144325.434436-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:40:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26fe74 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=cGq7qwWoCFQYfdG-PqAA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: RTovSRstaUayDiLyJmSdo5PvICS7uDBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NiBTYWx0ZWRfX0hep7lleAto8
 HRKlJmfo/UtF77HoUJsT/0YYxCPRAaXudbPwE+eDA0UQO3q6hpmSH1GtZEbrWZ2qEbJQ93SsN5f
 CTIJg1nkoLbGMratPjU0PBO9493rZaJ+fBJ5VtFcnBwFW35dDItbNlXQ6mUNSVKiVMOr0br29Uf
 F98iZNxODLUudeLWbuX2I+DFlBRJQ5y+DrdgeR0cKKcTfMcGbhRsfgvOL7WNF2W9IOgtYJqHkem
 UiFe1vKWgdCYH0xQn+gI5FvVGOk1XPt+5AvjoGluLohZoBy6POivC8Ts9jZfGvOlJlPAjz3Ps1K
 xHT55TmNcQ+NX0w3zASl01501EO3ezewMOD3FjHYIIHDHRNMjsvEtxwNtFpeJuVjXTQ5YI2ijAD
 CrLCMaajnScCYwJ5rUXrBy7Vc3bxwYBQMjs/Za2SkalhI4mAjtqkcQr456kKx5AA73ASUdfwfGW
 e9r3znJaipRzrCzVmiA==
X-Proofpoint-ORIG-GUID: 94HQelZm-M5ktJRmk8xKPj7M7b1lspvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080166
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9779-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,arm.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EC82659986

On Fri, 2026-06-05 at 15:43 +0100, Yeoreum Yun wrote:
> To generate the boot_aggregate log in the IMA subsystem with
> TPM PCR values, the TPM driver must be built as built-in and
> must be probed before the IMA subsystem is initialized.
>=20
> However, when the TPM device operates over the FF-A protocol using
> the CRB interface, probing fails and returns -EPROBE_DEFER if
> the tpm_crb_ffa device =E2=80=94 an FF-A device that provides the communi=
cation
> interface to the tpm_crb driver =E2=80=94 has not yet been probed.
>=20
> To ensure the TPM device operating over the FF-A protocol with
> the CRB interface is probed before IMA initialization,
> the following conditions must be met:
>=20
> 1. The corresponding ffa_device must be registered,
>    which is done via ffa_init().
>=20
> 2. The tpm_crb_driver must successfully probe this device via
>    tpm_crb_ffa_init().
>=20
> 3. The tpm_crb driver using CRB over FF-A can then
>    be probed successfully. (See crb_acpi_add() and
>    tpm_crb_ffa_init() for reference.)
>=20
> Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()
> are all registered with device_initcall, which means
> crb_acpi_driver_init() may be invoked before ffa_init() and
> tpm_crb_ffa_init() are completed.
>=20
> When this occurs, probing the TPM device is deferred.
> However, the deferred probe can happen after the IMA subsystem
> has already been initialized, since IMA initialization is performed
> during late_initcall, and deferred_probe_initcall() is performed
> at the same level.
>=20
> And the similar situation is reported on TPM devices attached on SPI
> bus[0].
>=20
> To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
> IMA at late_inicall_sync so that IMA is initialized with the TPM
> device probed deferred.
>=20
> When this option is enabled, modules that access files in the
> initramfs through usermode helper calls such as request_module()
> during initcall must not be built-in. Otherwise, IMA may miss
> measuring those files [1].
>=20
> Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9a=
e.camel@linux.ibm.com/ [1]
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  security/integrity/ima/Kconfig    | 10 ++++++++++
>  security/integrity/ima/ima_main.c |  4 ++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 862fbee2b174..75f71401fba3 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -332,4 +332,14 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
>  	  If set to the default value of 0, an extra half page of memory for th=
ose
>  	  additional measurements will be allocated.
> =20
> +config IMA_INIT_LATE_SYNC
> +	bool "Initialise IMA at late_initcall_sync"
> +	default n
> +	help
> +	  This option initialises IMA at late_initcall_sync for platforms
> +	  where TPM device probing is deferred.
> +	  When this option is enabled, modules that access files in the
> +	  initramfs through usermode helper calls such as request_module()
> +	  during initcall must not be built-in. Otherwise, IMA may miss
> +	  file measurements for them.
>  endif

I fixed the merge conflict with the "ima: Exporting and deleting IMA measur=
ement
records from kernel memory" patch set.  These patches are now queued in nex=
t-
integrity-testing awaiting Paul's Ack.

Mimi


> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5cea53fc36df..1cfae4b83dc5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1337,5 +1337,9 @@ DEFINE_LSM(ima) =3D {
>  	.order =3D LSM_ORDER_LAST,
>  	.blobs =3D &ima_blob_sizes,
>  	/* Start IMA after the TPM is available */
> +#ifndef CONFIG_IMA_INIT_LATE_SYNC
>  	.initcall_late =3D init_ima,
> +#else
> +	.initcall_late_sync =3D init_ima,
> +#endif
>  };

