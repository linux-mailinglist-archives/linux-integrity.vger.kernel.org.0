Return-Path: <linux-integrity+bounces-9279-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLlpK+0D6Wl5SgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9279-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 19:22:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9D449423
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 19:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABAD300D45C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8E37DE81;
	Wed, 22 Apr 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PzuBisQq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82E2D8385;
	Wed, 22 Apr 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878457; cv=none; b=fARBfGXZb8WxhXevxbgVKnJtrSg+mtGhnDARnYRDkfdBYynjEFNbJEkIplSxoThrO/uZO350rGbUcZk6npz2pKEXnR9eaVm9k7J5om4vlAvlXU5l3OrdyoZLQPMlBH3HnEOilX8fQPYg14daU13Vv78mGxS8Y+oQ3g2WxbmNJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878457; c=relaxed/simple;
	bh=KfLCLDNyjoEz2/tnv/7s3BguMcvTARr3XCeYWoSuSNc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=inyHT1Aq/QfPVTh/V62bUbvG1J/TTcrb8cymiybogvq0cULPUBXB4Vrr8I+O1rwrmebN2EiUFNjk+qT6+MGHCqBO7Vv/963eQDZqee8dXO0N8CfOf1KLQL+tDJI7trZCSmEN0D0ccUGRpHh1jt4vObl0/3lUPwEVJPeZ71XTXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PzuBisQq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMP4j3944342;
	Wed, 22 Apr 2026 17:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yB86/j
	5x0oID9OAuiOSWB0cFe99ptfju0bw+/5qhsNo=; b=PzuBisQqYPGD3FJvNpR6Y4
	a7byOxAvAKkt1X1Of9dMXKVhN99ncrpA8jVRue19jISkdLHkwZC8mx1A9/20lk8O
	mVB3aXZAWYkwHXXXPskLhWONW+WZPOZ5RNWulENU/q0tL09BPg8XmivmGwyd1xQj
	SFC0IlGYEvYEbdkBZcCboeu4D9yeX+j2njm6iYhH2YfMZhu1H579TdEAE9DIc774
	W/3+Ao6GtAgZktUgAsBfSmeErrTROATB++q220bqRJkforYKJgJqv2Tym9g5o5XM
	901q2Uu31NinCG+uJ1X/uplN3bxe+k5rKmEx9go/3IC9va1cfRyTat/sOKyBRYKA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3mc61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 17:20:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MHKMhj032686;
	Wed, 22 Apr 2026 17:20:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky35n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 17:20:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MHKLi833292892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 17:20:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92EF458057;
	Wed, 22 Apr 2026 17:20:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E6A458059;
	Wed, 22 Apr 2026 17:20:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.20.159])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 17:20:20 +0000 (GMT)
Message-ID: <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <20260422162449.1814615-2-yeoreum.yun@arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
	 <20260422162449.1814615-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 13:20:19 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5MrY4HzXpH9kJzANuY8u4SALKlPo3g-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE2NyBTYWx0ZWRfX9OJxhZVf8yjQ
 bqd4JwxRgYfckTRds+nbREPL22Oga9iZbgq6Bf24XBygIE0yDkUHLwiQeMLM+kle2ppoJ3rqCNh
 BHaOFh1aMdbTRfDk79AR9+9uN8kaNO6huC4plDdfT7RXyY0kek4SXxrlBWAledk+MTvMcJnkc7c
 pTosDwXDpj/BjzltfSo0zk/Vfr70PxYmdmh6YpgvaRckg9k9BhuzKxRcBUB0C7pBd/Q4wlIa8J1
 HOE+I24OimtLA+IJZLQJCzt4h/r2pTNXKHDHJUqsMWuiQ+P73ABX5L5tMZ5gv/+ptVUgT+FkuIt
 TZfPzfyjFsA4SX4TIwedQh/AaJDkoa3YDHOBY06jASWduuZmbG5oazykYg28dED5qqGmJlZuQQ7
 prOZbdVDW58QGnFQq6lkQzokD7x0VKFXpGCXud3X7wDNt4oB14alRg7NwRwnNejF9ixIQfaUYXt
 CtmbOHNRdcMSv29MsLQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e90357 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7CQSdrXTAAAA:8
 a=VYP3cj3PSWgvmTbEyuwA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: RuTEPM5HB4gjQrLJdcAEDD4IjWAhJyBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220167
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9279-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3BA9D449423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> To generate the boot_aggregate log in the IMA subsystem with TPM PCR valu=
es,
> the TPM driver must be built as built-in and
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
>    1. The corresponding ffa_device must be registered,
>       which is done via ffa_init().
>=20
>    2. The tpm_crb_driver must successfully probe this device via
>       tpm_crb_ffa_init().
>=20
>    3. The tpm_crb driver using CRB over FF-A can then
>       be probed successfully. (See crb_acpi_add() and
>       tpm_crb_ffa_init() for reference.)
>=20
> Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()=
 are
> all registered with device_initcall, which means crb_acpi_driver_init() m=
ay
> be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>=20
> When this occurs, probing the TPM device is deferred.
> However, the deferred probe can happen after the IMA subsystem
> has already been initialized, since IMA initialization is performed
> during late_initcall, and deferred_probe_initcall() is performed
> at the same level.
>=20
> To resolve this, call ima_init() again at late_inicall_sync level
> so that let IMA not miss TPM PCR value when generating boot_aggregate
> log though TPM device presents in the system.
>=20
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

A lot of change for just detecting whether ima_init() is being called on
late_initcall or late_initcall_sync(), without any explanation for all the =
other
changes (e.g. ima_init_core).

Please just limit the change to just calling ima_init() twice.

Mimi


> ---
>  include/linux/lsm_hooks.h           |  2 +
>  security/integrity/ima/ima.h        |  4 +-
>  security/integrity/ima/ima_init.c   | 10 +++-
>  security/integrity/ima/ima_main.c   | 76 +++++++++++++++++++++++------
>  security/integrity/ima/ima_policy.c |  3 ++
>  security/lsm_init.c                 | 13 ++++-
>  6 files changed, 87 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d48bf0ad26f4..88fe105b7f00 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -166,6 +166,7 @@ enum lsm_order {
>   * @initcall_fs: LSM callback for fs_initcall setup, optional
>   * @initcall_device: LSM callback for device_initcall() setup, optional
>   * @initcall_late: LSM callback for late_initcall() setup, optional
> + * @initcall_late_sync: LSM callback for late_initcall_sync() setup, opt=
ional
>   */
>  struct lsm_info {
>  	const struct lsm_id *id;
> @@ -181,6 +182,7 @@ struct lsm_info {
>  	int (*initcall_fs)(void);
>  	int (*initcall_device)(void);
>  	int (*initcall_late)(void);
> +	int (*initcall_late_sync)(void);
>  };
>=20
>  #define DEFINE_LSM(lsm)							\
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 89ebe98ffc5e..75ee7ad184d0 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -62,6 +62,8 @@ extern int ima_hash_algo_idx __ro_after_init;
>  extern int ima_extra_slots __ro_after_init;
>  extern struct ima_algo_desc *ima_algo_array __ro_after_init;
>=20
> +extern bool ima_initialised __ro_after_init;
> +
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  extern const char boot_aggregate_name[];
> @@ -257,7 +259,7 @@ static inline void ima_measure_kexec_event(const char=
 *event_name) {}
>  extern bool ima_canonical_fmt;
>=20
>  /* Internal IMA function definitions */
> -int ima_init(void);
> +int ima_init(bool late);
>  int ima_fs_init(void);
>  int ima_add_template_entry(struct ima_template_entry *entry, int violati=
on,
>  			   const char *op, struct inode *inode,
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/i=
ma_init.c
> index a2f34f2d8ad7..c28c71090ad2 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -115,13 +115,19 @@ void __init ima_load_x509(void)
>  }
>  #endif
>=20
> -int __init ima_init(void)
> +int __init ima_init(bool late)
>  {
>  	int rc;
>=20
>  	ima_tpm_chip =3D tpm_default_chip();
> -	if (!ima_tpm_chip)
> +	if (!ima_tpm_chip) {
> +		if (!late) {
> +			pr_info("Defer initialisation to the late_initcall_sync stage.\n");
> +			return -EPROBE_DEFER;
> +		}
> +
>  		pr_info("No TPM chip found, activating TPM-bypass!\n");
> +	}
>=20
>  	rc =3D integrity_init_keyring(INTEGRITY_KEYRING_IMA);
>  	if (rc)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 1d6229b156fb..ac444ee600e2 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,6 +38,7 @@ int ima_appraise;
>  #endif
>=20
>  int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
> +bool ima_initialised __ro_after_init =3D false;
>  static int hash_setup_done;
>  static int ima_disabled __ro_after_init;
>=20
> @@ -1237,6 +1238,35 @@ static int ima_kernel_module_request(char *kmod_na=
me)
>=20
>  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
>=20
> +static int __init init_ima_core(bool late)
> +{
> +	int err;
> +
> +	if (ima_initialised)
> +		return 0;
> +
> +	err =3D ima_init(late);
> +	if (err =3D=3D -EPROBE_DEFER)
> +		return 0;
> +
> +	if (err && strcmp(hash_algo_name[ima_hash_algo],
> +			  CONFIG_IMA_DEFAULT_HASH) !=3D 0) {
> +		pr_info("Allocating %s failed, going to use default hash algorithm %s\=
n",
> +			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
> +		hash_setup_done =3D 0;
> +		hash_setup(CONFIG_IMA_DEFAULT_HASH);
> +		err =3D ima_init(late);
> +	}
> +
> +	if (!err) {
> +		ima_update_policy_flags();
> +		ima_initialised =3D true;
> +	} else
> +		ima_disabled =3D 1;
> +
> +	return err;
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> @@ -1250,30 +1280,42 @@ static int __init init_ima(void)
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> -	error =3D ima_init();
> -
> -	if (error && strcmp(hash_algo_name[ima_hash_algo],
> -			    CONFIG_IMA_DEFAULT_HASH) !=3D 0) {
> -		pr_info("Allocating %s failed, going to use default hash algorithm %s\=
n",
> -			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
> -		hash_setup_done =3D 0;
> -		hash_setup(CONFIG_IMA_DEFAULT_HASH);
> -		error =3D ima_init();
> -	}
> -
> -	if (error)
> -		return error;
>=20
>  	error =3D register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> -	if (error)
> +	if (error) {
>  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> +		goto disable_ima;
> +	}
>=20
> -	if (!error)
> -		ima_update_policy_flags();
> +	error =3D init_ima_core(false);
> +	if (error) {
> +		unregister_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> +		goto disable_ima;
> +	}
> +
> +	return 0;
>=20
> +disable_ima:
> +	ima_disabled =3D 1;
>  	return error;
>  }
>=20
> +static int __init late_init_ima(void)
> +{
> +	int err;
> +
> +	if (ima_disabled)
> +		return 0;
> +
> +	err =3D init_ima_core(true);
> +	if (err) {
> +		unregister_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> +		ima_disabled =3D 1;
> +	}
> +
> +	return err;
> +}
> +
>  static struct security_hook_list ima_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
>  	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
> @@ -1321,4 +1363,6 @@ DEFINE_LSM(ima) =3D {
>  	.blobs =3D &ima_blob_sizes,
>  	/* Start IMA after the TPM is available */
>  	.initcall_late =3D init_ima,
> +	/* Start IMA late in case of probing TPM is deferred. */
> +	.initcall_late_sync =3D late_init_ima,
>  };
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index bf2d7ba4c14a..c3bcc3521c81 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -501,6 +501,9 @@ static void ima_lsm_update_rules(void)
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event=
,
>  			  void *lsm_data)
>  {
> +	if (!ima_initialised)
> +		return NOTIFY_DONE;
> +
>  	if (event !=3D LSM_POLICY_CHANGE)
>  		return NOTIFY_DONE;
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 573e2a7250c4..4e5c59beb82a 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
>   * security_initcall_late - Run the LSM late initcalls
>   */
>  static int __init security_initcall_late(void)
> +{
> +	return lsm_initcall(late);
> +}
> +late_initcall(security_initcall_late);
> +
> +/**
> + * security_initcall_late_sync - Run the LSM late initcalls sync
> + */
> +static int __init security_initcall_late_sync(void)
>  {
>  	int rc;
>=20
> -	rc =3D lsm_initcall(late);
> +	rc =3D lsm_initcall(late_sync);
>  	lsm_pr_dbg("all enabled LSMs fully activated\n");
>  	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
>=20
>  	return rc;
>  }
> -late_initcall(security_initcall_late);
> +late_initcall_sync(security_initcall_late_sync);
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

