Return-Path: <linux-integrity+bounces-4080-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B59C45B5
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B07FB2841C
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97511AA1CA;
	Mon, 11 Nov 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snNG1GWe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521B1AB6EB;
	Mon, 11 Nov 2024 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352344; cv=none; b=j5Les+gaAxvFXc+vyPF4RfpVGjGXvZnrXpheJQWedM5TZXRoDHcSjYNuqF/gxQ+BSUjgwTK9UVqBDYOnub7fVb5xcXg2XB2HqXyRv8GhP5DV5mr+DnF9F6T8jGjgb4DaMzRf0eXKnR5GxA89e+wKDgC8HxmzIJhdGdKDze+EWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352344; c=relaxed/simple;
	bh=IZc/E43DZuxHSv7IWU524y8l2UZ+In8MU2dQR2LV2c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J79X5WROTrCU5fbHWdeLxBs+92IMmViXdk6iuCm+8iY10AyzEmKaukkfAiFkFZCpvsZVGK4Lk1li5Qf/DfJludXhvIMwLF7zy726Jdm5HkOXxTwaXlE6LYvRiKo5xx/0sJPUQsS3zh9pOGnnMP26i6n3VKXTd/MQu/tfzwbiig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snNG1GWe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABIeDvw007739;
	Mon, 11 Nov 2024 19:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FUTeFv
	TTJcfuHgqmvdOMhd7j6g2HNrW0Yp2+VxRnmRc=; b=snNG1GWeEJx2C8HGfH/t/5
	mHk8exV8kJ88+IRUKmyvgSkrhpz0/u/Qv6IPydzaJBAFBndGRsK9RmKeUpJ9Kt92
	pkeYQsSjvElpFkL/KDzkFzCl2VDhcWPxiUoKOazjuYplZceMSJXgUpN4k+LVXGQI
	6VjMa5UKERwW36qO2qdqalo0HORwmiPjcQqq9Ch9opzImc3r9ydQtpCr6/Vtq6w5
	89ieZSx5vNMzHqmWkrIZOg/FRx30G0xVOoISsOZGIGELVvwwextVHjEtOABmgkx+
	/PaMdtLzmYOO0mOkJb85O1MCAwtqveAmai/YZ5fQ3ljd0gbQxGYtUg9Jyt1lzHxA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uqdb83d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:12:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABIrcav002761;
	Mon, 11 Nov 2024 19:12:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms12qje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:12:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ABJCCih29033182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 19:12:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A011E5805E;
	Mon, 11 Nov 2024 19:12:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD1058043;
	Mon, 11 Nov 2024 19:12:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Nov 2024 19:12:12 +0000 (GMT)
Message-ID: <6a8b48e600e0fd294619b5dfa97b5c796eb2ea2f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Suspend PCR extends and log appends when rebooting
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>
Date: Mon, 11 Nov 2024 14:12:11 -0500
In-Reply-To: <20241011150522.2697216-1-stefanb@linux.ibm.com>
References: <20241011150522.2697216-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QFuWBJCemRiAXVNja5tx3nb7XWfGom7w
X-Proofpoint-GUID: QFuWBJCemRiAXVNja5tx3nb7XWfGom7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110150

On Fri, 2024-10-11 at 11:05 -0400, Stefan Berger wrote:


> To avoid the following types of error messages from the TPM driver, suspe=
nd
> PCR extends once the reboot notifier has been called.  This avoids trying=
 to
> use the TPM after the TPM subsystem has been shut down.
>=20
> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
>=20
> This error could be observed on a ppc64 machine running SuSE Linux.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

No need to send a separate post about the patch.  Any comments not part of =
the
patch description belong here.

>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_init.c  | 16 ++++++++++++++++
>  security/integrity/ima/ima_queue.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c51e24d24d1e..d3f46232b8b9 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_templat=
e_desc *ima_template);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> +void ima_measurements_suspend(void);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/i=
ma_init.c
> index 4e208239a40e..ac630d8d3049 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/ima.h>
> +#include <linux/reboot.h>
>  #include <generated/utsrelease.h>
> =20
>  #include "ima.h"
> @@ -115,6 +116,19 @@ void __init ima_load_x509(void)
>  }
>  #endif
> =20
> +static int ima_reboot_notify(struct notifier_block *nb,
> +                      unsigned long action,
> +                      void *data)
> +{
> +	ima_measurements_suspend();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ima_reboot_notifier =3D {
> +	.notifier_call =3D ima_reboot_notify,
> +};
> +
>  int __init ima_init(void)
>  {
>  	int rc;
> @@ -152,6 +166,8 @@ int __init ima_init(void)
> =20
>  	ima_init_key_queue();
> =20
> +	register_reboot_notifier(&ima_reboot_notifier);
> +
>  	ima_measure_critical_data("kernel_info", "kernel_version",
>  				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>  				  NULL, 0);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 532da87ce519..b8613b6c1a39 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -44,6 +44,12 @@ struct ima_h_table ima_htable =3D {
>   */
>  static DEFINE_MUTEX(ima_extend_list_mutex);
> =20
> +/*
> + * Used internally by the kernel to suspend-resume ima measurements.
> + * Protected by ima_extend_list_mutex.
> + */

Tushar's original patch incorrectly provided both a function to suspend and
resume appending records to the IMA measurement list and extending the TPM =
PCR.
This patch only suspends appending records to the IMA measurement list and
extending the TPM PCR.  Please replace the word "suspend-resume" in the com=
ment
above with just "suspend".

> +static bool suspend_ima_measurements;
> +
>  /* lookup up the digest value in the hash table, and return the entry */
>  static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  						       int pcr)
> @@ -148,6 +154,13 @@ static int ima_pcr_extend(struct tpm_digest *digests=
_arg, int pcr)
>  	return result;
>  }
> =20
> +void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	suspend_ima_measurements =3D true;
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
>  /*
>   * Add template entry to the measurement list and hash table, and
>   * extend the pcr.
> @@ -176,6 +189,20 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  		}
>  	}
> =20
> +	/*
> +	 * suspend_ima_measurements will be set if the system is
> +	 * undergoing kexec soft boot to a new kernel.
> +	 * suspending measurements in this short window ensures the
> +	 * consistency of the IMA measurement list during copying
> +	 * of the kexec buffer.
> +	 */

Tushar's patch did not register a reboot notifier.  Please update the above
comment accordingly.

> +	if (suspend_ima_measurements) {
> +		audit_cause =3D "measurements_suspended";
> +		audit_info =3D 0;
> +		result =3D -ENODEV;
> +		goto out;
> +	}
> +
>  	result =3D ima_add_digest_entry(entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {

thanks,

Mimi

