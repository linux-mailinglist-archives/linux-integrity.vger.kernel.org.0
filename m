Return-Path: <linux-integrity+bounces-8131-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D6CD64E6
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 15:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2791C3002508
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1127E1C5;
	Mon, 22 Dec 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gCeAHzhj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2A274B32
	for <linux-integrity@vger.kernel.org>; Mon, 22 Dec 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412110; cv=none; b=S+Fy5++UkDiIHGPWOzo8S0q4UEaGxaLNmSdGtjZLUQ1Ru4uhu5xFL9XTvO+4VAZ+leV8UuyZwDzBJjFgwT3oalAPvgtpjSy/pHg949kR0vnnh9wRLdpNq2+Az5bwukvMMQ96eejP3LNOhRJoOzVB5yLfB+Liw6JG5+cZvDoHD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412110; c=relaxed/simple;
	bh=QC2Lbtx+uJn5cxBOLYy17gL1BJd0jRS5Y6oJHSaQIFw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hyYoW1nhPR5UYsQBWw/vME7IGKZ7dmsIN+zGX1ippBwK51LCYOU6C6kb+dFBv9A6CYmvkRqlUIczrjMDqhbP2W+YJ/+IN7ndlZkQ35ycJ49Ih/LhaH1D08Frpi7VCo4jK8v03AHyvnbcxe9bmboMqrgei9KkomcnjUxZawyiEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gCeAHzhj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMA2IQ0030307;
	Mon, 22 Dec 2025 14:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9JvHL/
	+7Gr3PG/M18e4Z7WiTSh3Q7Uhw99A4hRxMeqY=; b=gCeAHzhj3HXAptfhSzDOtR
	VE6NQMypNdU0Vz6d4Di6ibTPwVd5nIb6A1Loi6OZImBl8/w+Y9uvz/9/iKqdZRH1
	fD4Qj2XhWJzbxfey/OzXbuGsWrgVObcOfDRpP3gzmZ7yFnEPEuzgsIQYeEy6j0+n
	ymv5A12csiKvvLOcpA1qeOdE2pjygR/95IjHcRdT8FrSjf3eF9uzd4CqhmJVyFsM
	qtaAdQiLucCGQsjnP4IxFtImqZ/6oXmcQpXkYH5s0muGN6NoFmixV3X9+vAKq64v
	4Xn/OQR2EP9/euY1PPPlPWAs8wn6/vJM5kYBUlu5gWW8GwEeHUx9dCJwk88jRYVA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh48c18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 14:01:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMDhHAE028507;
	Mon, 22 Dec 2025 14:01:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh48c16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 14:01:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMAb1gw032254;
	Mon, 22 Dec 2025 14:01:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u0x3wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 14:01:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BME1Hqh20447992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 14:01:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F2D58054;
	Mon, 22 Dec 2025 14:01:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ABC958050;
	Mon, 22 Dec 2025 14:01:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.184.103])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Dec 2025 14:01:16 +0000 (GMT)
Message-ID: <1878eed2d61b7fe3879c6d911ae709ef08089f16.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2 2/2] ima: measure buffer sent to securityfs
 policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20251216165620.683529-3-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <20251216165620.683529-3-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Dec 2025 09:01:15 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=69494f2f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=8P8x6tqlGFiShmWzd2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DkgUPkdQdlhU9WQiIpjaTi3aXPQcK39-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEyNSBTYWx0ZWRfX/Mubj8YV8KkL
 kvc6vo+O4ePvLEk3fuOINt2b4QPdNXewUAME85kcM1CK+PVcuq0zkwjRjQStY6AYqz3ASUllrOO
 sbXYB+J6htHBBrEWKo71C/otJ8SwnAjHFZsYnfui1tEbXO1Y7jXfjpSxmiwmcB6coXXCCJttPcM
 pbgW3eOTjmlxgPoqkclHN3/FKA6ZLvJc99/0e5gRBJUSFzWQ7NjPemz4bU/9WZs9LLrMlDRbaoS
 Kg7iNddwg2Yi4XyrbHHs2eP2YnfrwFtCw+eZPdIT6o0zjEPoVDyOH9bMbQlvuUwLR+7FBEu6Pr3
 62GZZzE9P8HRGmTSSZaw+oqpNjZSHJh4W/SwYQGlE4j2IVH++BQ0m85xG+aVi7caxnrxtkBCr9e
 JGZ5Rn6kp0RabPmtfmZN8+UPDwPcD6wnefhr6qKKRvBj0hTeL5AKE9jzpzx0+e1BBbKMakrLY6u
 cBwMvrrs9LpOPXzBVbw==
X-Proofpoint-GUID: Ge8g5l1C58zsk1aPSxY6j2-o4rQC6Sa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220125

Hi Enrico,

On Tue, 2025-12-16 at 17:56 +0100, Enrico Bravi wrote:
> When signed a policy is not mandatory, it is possile to write the IMA
> policy directly on the corresponding securityfs file:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy
>=20
> Add input buffer measurement that can be caught when 'measure
> func=3DPOLICY_CHECK' is enabled (e.g., ima_policy=3Dtcb).
>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> ---
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_fs.c   |  1 +
>  security/integrity/ima/ima_main.c | 38 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index ca7b96663623..3b00c298355b 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -426,6 +426,7 @@ void *ima_policy_next(struct seq_file *m, void *v, lo=
ff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
>  void ima_measure_loaded_policy(void);
> +int ima_measure_policy_write(char *buf, size_t size);
> =20
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 89946d803d44..f1a5edd060ad 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -362,6 +362,7 @@ static ssize_t ima_write_policy(struct file *file, co=
nst char __user *buf,
>  				    1, 0);
>  		result =3D -EACCES;
>  	} else {
> +		ima_measure_policy_write(data, datalen);
>  		result =3D ima_parse_add_rule(data);
>  	}
>  	mutex_unlock(&ima_write_mutex);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cdd225f65a62..6a8ad4714881 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
>  #include <linux/crash_dump.h>
> +#include <linux/shmem_fs.h>
> =20
>  #include "ima.h"
> =20
> @@ -986,6 +987,43 @@ static int ima_post_load_data(char *buf, loff_t size=
,
>  	return 0;
>  }
> =20
> +/**
> + * ima_measure_policy_write - Measure the policy write buffer
> + * @buf: pointer to the buffer containing the policy write data
> + * @size: size of the buffer
> + *
> + * Measure the buffer sent to the IMA policy securityfs file.
> + *
> + * Return 0 on success, a negative value otherwise.
> + */
> +int ima_measure_policy_write(char *buf, size_t size0
> +{
> +	static const char op[] =3D "measure_ima_policy_write";
> +	const char *file_name =3D "ima_write_policy_buffer";
> +	static char *audit_cause =3D "ENOMEM";
> +	struct file *policy_file =3D NULL;
> +	struct lsm_prop prop;
> +	int ret =3D 0;
> +
> +	policy_file =3D shmem_kernel_file_setup(file_name, 0, 0);
> +	if (IS_ERR(policy_file)) {
> +		ret =3D PTR_ERR(policy_file);
> +		audit_cause =3D "alloc_file";
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, "ima_policy_write",
> +				    op, audit_cause, ret, 1);
> +		goto out;
> +	}
> +
> +	security_current_getlsmprop_subj(&prop);
> +
> +	ret =3D process_measurement(policy_file, current_cred(), &prop, buf, si=
ze,
> +				  MAY_READ, POLICY_CHECK);

The purpose of this patch is to measure IMA policy rules as they're written=
 to
the <securityfs> IMA policy file, based on the IMA "measure func=3DPOLICY_C=
HECK"
policy rule.

Like critical data, it should be calling process_buffer_measurement(), not
process_measurement().

The functions ima_match_rules() and ima_match_rule_data() need to be update=
d to
support POLICY_CHECK.

This function naming is off and should be renamed to ima_measure_policy_buf=
().

Please update the patch description accordingly.

Mimi

> +	fput(policy_file);
> +
> +out:
> +	return ret;
> +}
> +
>  /**
>   * process_buffer_measurement - Measure the buffer or the buffer data ha=
sh
>   * @idmap: idmap of the mount the inode was found from


