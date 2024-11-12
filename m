Return-Path: <linux-integrity+bounces-4097-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C34109C6559
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B736E1F265C2
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 23:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCFF21C17F;
	Tue, 12 Nov 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AjcCniZt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA001CDFBD;
	Tue, 12 Nov 2024 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454971; cv=none; b=e52Rrzd/FrSfm3XimiZGv4l5z4XfbJVaZJKEWBZwix9fL7HQ6Q+NILHdJcMjpxwXwOh7ySzlttwk4fLZO5kQ/g/et+tUmIZlwwaFD+O+BA1sh33olytHmEHAxJiUO3b8rPCpP/M57ihj13for/m1Px/xoqnrDkrEyZAv4V0Gdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454971; c=relaxed/simple;
	bh=bngcx8E46pXAYEW/nzLFS8bwIVlyJ/PB4DXxK3alk6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8kCA5C2By/nfELkIlguVrCByWSazZ1wzIs2BLmN2hjt/JzP7R8BgbG9HbtAatyvfe5UUqUl5VkODWObtyg/EWU1ghT353bU2Z8qhUhlfiSATBX/zWU9xs3O02GuoOP1lUE44MUII5Wf94iwYUH+AL1mXJ58x/RfR8x4GYJXRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AjcCniZt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN42eK016243;
	Tue, 12 Nov 2024 23:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AoX7VK
	OxUfCE/FQHkf1ZqG+QeBVf038rL4Hjur1YlOc=; b=AjcCniZtvN2AmhvF5JuzHN
	gfA5NU8/iucnXWrsgOCFOcCFo/RlRNaerJQG3R0KKOr8QhtBM48dHxzT1D8NPMEI
	XbY/9Kk6HRlBl17wBLwedUo5j8G02BaK2mhVshtfcZUJng7bpLdnV4h3MrOzL7w/
	4A6ClMvTR+aPwquY9cJZFmohQ19LDvHrrssdPpHmFuHHhdYCC3Rt/oIqcgfm/kOu
	2trhHc/HKiyHVPQvHJzR1l+mi8s1lriK8LWSmmtfR5eEqVr9G9SjJ8mo5EALzAAx
	wSdtpXnJvcRR4m5Gm5xTeP7D/QpQpwfnucCmslcpfrxfcaPSdK1DyjE0eLLellqw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcerpn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 23:42:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACHxOmF004153;
	Tue, 12 Nov 2024 23:42:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms1519n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 23:42:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACNgcBs52822298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:42:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494C758056;
	Tue, 12 Nov 2024 23:42:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD51E58052;
	Tue, 12 Nov 2024 23:42:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 23:42:37 +0000 (GMT)
Message-ID: <a616939fa13b9e01b9cb6be68246152772944a76.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Suspend PCR extends and log appends when
 rebooting
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>
Date: Tue, 12 Nov 2024 18:42:37 -0500
In-Reply-To: <20241112165206.756351-1-stefanb@linux.ibm.com>
References: <20241112165206.756351-1-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: 5oRZ73ko05kSNpFhzW35IhY35kJduxkJ
X-Proofpoint-ORIG-GUID: 5oRZ73ko05kSNpFhzW35IhY35kJduxkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120190

On Tue, 2024-11-12 at 11:52 -0500, Stefan Berger wrote:
> To avoid the following types of error messages due to a failure by the TP=
M
> driver to use the TPM, suspend TPM PCR extensions and the appending of
> entries to the IMA log once IMA's reboot notifier has been called. This
> avoids trying to use the TPM after the TPM subsystem has been shut down.
>=20
> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
>=20
> This error could be observed on a ppc64 machine running SuSE Linux where
> processes are still accessing files after devices have been shut down.
>=20
> Suspending the IMA log and PCR extensions shortly before reboot does not
> seem to open a significant measurement gap since neither TPM quoting woul=
d
> work for attestation nor that new log entries could be written to anywher=
e
> after devices have been shut down. However, there's a time window between
> the invocation of the reboot notifier and the shutdown of devices in
> kernel_restart_prepare() where __usermodehelper_disable() waits for all
> running_helpers to exit. During this time window IMA could now miss log
> entries even though attestation would still work. The reboot of the syste=
m
> shortly after may make this small gap insignificant.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.  The patch looks good.  Based on the updated patch descript=
ion,
I'm wondering if we should be testing the "system_state" instead of registe=
ring
a reboot notifier?

>=20
> ---
>  v2:
>   - followed Mimi's suggestions
>=20
> ---
>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_init.c  |  2 ++
>  security/integrity/ima/ima_queue.c | 43 ++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3c323ca213d4..3f1a82b7cd71 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -278,6 +278,7 @@ unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
>  int __init ima_init_digests(void);
> +void __init ima_init_reboot_notifier(void);
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event=
,
>  			  void *lsm_data);
> =20
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/i=
ma_init.c
> index 4e208239a40e..a2f34f2d8ad7 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -152,6 +152,8 @@ int __init ima_init(void)
> =20
>  	ima_init_key_queue();
> =20
> +	ima_init_reboot_notifier();
> +
>  	ima_measure_critical_data("kernel_info", "kernel_version",
>  				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>  				  NULL, 0);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 532da87ce519..9b3c9587313f 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -16,6 +16,7 @@
>   */
> =20
>  #include <linux/rculist.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include "ima.h"
> =20
> @@ -44,6 +45,12 @@ struct ima_h_table ima_htable =3D {
>   */
>  static DEFINE_MUTEX(ima_extend_list_mutex);
> =20
> +/*
> + * Used internally by the kernel to suspend measurements.
> + * Protected by ima_extend_list_mutex.
> + */
> +static bool ima_measurements_suspended;
> +
>  /* lookup up the digest value in the hash table, and return the entry */
>  static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  						       int pcr)
> @@ -176,6 +183,17 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  		}
>  	}
> =20
> +	/*
> +	 * ima_measurements_suspended will be set before the TPM subsystem has
> +	 * been shut down.
> +	 */

The comment should indicate that the system itself is being shut down/reboo=
ted
as well.

Mimi

> +	if (ima_measurements_suspended) {
> +		audit_cause =3D "measurements_suspended";
> +		audit_info =3D 0;
> +		result =3D -ENODEV;
> +		goto out;
> +	}
> +
>  	result =3D ima_add_digest_entry(entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {
> @@ -211,6 +229,31 @@ int ima_restore_measurement_entry(struct ima_templat=
e_entry *entry)
>  	return result;
>  }
> =20
> +static void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	ima_measurements_suspended =3D true;
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
> +static int ima_reboot_notifier(struct notifier_block *nb,
> +			       unsigned long action,
> +			       void *data)
> +{
> +	ima_measurements_suspend();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ima_reboot_nb =3D {
> +	.notifier_call =3D ima_reboot_notifier,
> +};
> +
> +void __init ima_init_reboot_notifier(void)
> +{
> +	register_reboot_notifier(&ima_reboot_nb);
> +}
> +
>  int __init ima_init_digests(void)
>  {
>  	u16 digest_size;


