Return-Path: <linux-integrity+bounces-4744-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719CA2C6A6
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903D21887C44
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FE0238D59;
	Fri,  7 Feb 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cDnX4KEZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1604A1A;
	Fri,  7 Feb 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941404; cv=none; b=qOInvlyjKBzYdmuE/CKn2jRXd7ZFmTiilSiieCD0jPyCYi09tl2VP+QsTBKyqkk62+9NATAF3gkPV/ZVi0om208O1CpG/bqf4ow1JDTzotj/YKwxO6kFk/zWz3k5S5fi0zFKOKW3yHZyIASo9SDS16cWHfImOixBVIz5DA76Wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941404; c=relaxed/simple;
	bh=STVLK4/uc5Q8B1kLKI4AT+0I2EICiAVb6GGS+j2/+0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tF98RHg5LO+vzeELo6x6aU1sD3vCrcAOaWtu6EYIMmS0x6S7odh6S/UyGY7PcQw924SvX7rW6/VvJQR0gJ4SNIkgaTHe4XJlsUCwRtDI37NbMWz0Oi36dOFgCndLYlb64x9c5wymB3i5h6YYbIyVofHmsG68VR7OPyU93+mLRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cDnX4KEZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517ECPua027772;
	Fri, 7 Feb 2025 15:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bvv+C2
	S+HfCmRHdGBlwkwlon1bQ1BEA6avgMHj66Kyg=; b=cDnX4KEZrEz8gtWyLF7EZG
	J1lE9pQhuZFO6qmKgfD8jVdktkiXGsIALMIuVd4aXW/ToVvxy2R0Pl0apHjo2Edm
	QKS0iDbFi35Mutiz91RI7CUN+KckzxLL0MkMqAFP4gTbFqyjrRn5KhQ1X2Hw480D
	GdKGA3bAmOpAJB/xl2yeLMyQ1YOwEXTbIHpriGpljU6R5oXZSuFt2M01ZUkCNrrB
	fwGtNbjw/1mSbWc2uodlqv5FN2gEiqnr0FLXgtvLPaR+0MWUsLO5wWt7a9ccWdae
	xO3t50glTkRHXhKEXFfR8FG/Gam+aaXvi9JCtH0MyChPblGX2lfQJbnL2sx14YCQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910bcej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 15:16:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517BPNBL024635;
	Fri, 7 Feb 2025 15:16:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnm429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 15:16:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517FGDCR18744016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 15:16:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD6C58056;
	Fri,  7 Feb 2025 15:16:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3077F58063;
	Fri,  7 Feb 2025 15:16:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.150.111])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 15:16:12 +0000 (GMT)
Message-ID: <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
Subject: Re: [PATCH v7 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 10:16:11 -0500
In-Reply-To: <20250203232033.64123-9-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-9-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bvWS2oA6QncdRQC_jDFMQVZrnEdHSfxp
X-Proofpoint-GUID: bvWS2oA6QncdRQC_jDFMQVZrnEdHSfxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070114

On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.=C2=
=A0 The
> indeterminate interval between kexec 'load' and 'execute' could exacerbat=
e
> this problem.
>=20
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be=20
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
>=20
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.=C2=A0 The presence of a 'kexec_load' event in between the last tw=
o
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.

As a reminder, please include directions for verifying the buffer data hash=
 against
the buffer data.  The directions would be similar to those in commit 6b4da8=
c0e7f
("IMA: Define a new template field buf").

>=20
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
> =C2=A01 file changed, 23 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index c9c916f69ca7..0342ddfa9342 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
> =C2=A0#include "ima.h"
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
> =C2=A0static struct seq_file ima_kexec_file;
> =C2=A0static void *ima_kexec_buffer;
> =C2=A0static size_t kexec_segment_size;
> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *s=
f)
> =C2=A0	ima_reset_kexec_file(sf);
> =C2=A0}
> =C2=A0
> +static void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size =3D 0;
> +	long len;
> +
> +	buf_size =3D ima_get_binary_runtime_size();
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +			"kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> +			"ima_runtime_measurements_count=3D%ld;",
> +				kexec_segment_size, buf_size, len);

From scripts/checkpatch.pl, "Alignment should match open parenthesis".=20

> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
> +					strlen(ima_kexec_event), false, NULL, 0);

From the kernel-doc scnprintf(), returns the number of bytes.  There should=
 be no
need to calculate it using strlen().

> +}
> +
> =C2=A0static int ima_alloc_kexec_file_buf(size_t segment_size)
> =C2=A0{
> =C2=A0	/*
> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size=
)
> =C2=A0out:
> =C2=A0	ima_kexec_file.read_pos =3D 0;
> =C2=A0	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved=
 space
> */
> +	ima_measure_kexec_event("kexec_load");
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct notifier_bl=
ock *self,
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	ima_measure_kexec_event("kexec_execute");
> +
> =C2=A0	ret =3D ima_dump_measurement_list(&buf_size, &buf,
> =C2=A0					kexec_segment_size);
> =C2=A0

After fixing up and applying this patch set to 6.14.0-rc1, I'm not seeing t=
he
"kexec_execute".  Even after changing the default extra memory, I'm still n=
ot seeing
the measurement.

Mimi



