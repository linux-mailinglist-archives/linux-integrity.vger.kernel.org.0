Return-Path: <linux-integrity+bounces-5332-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDDA69E8E
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 04:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EF41712F4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6D1C5F2C;
	Thu, 20 Mar 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D9DKFHrA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942D1DED6F;
	Thu, 20 Mar 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439607; cv=none; b=q4UFuskwJGtbgWrW69cVXZfvoTlco1Ltkl1fpBM+xK0z9M7qk7H9zsQJPu8uCJ5546Hd6fYQzlFBdjU2c4H2g5xGsYZvV307KOIjBNJdusMq1B9x66bbUwbcub88eJKqP5p6TkPKTDVGbCn2uxZi/N77YmaqSP1o6W+JzET410A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439607; c=relaxed/simple;
	bh=0tMcn90nXpNrF+wnJFsQ2RKTGzWK1rEIUGnEZMD941k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnEyhLHkBOLEIHBQ3gno0xg7fV06u4csLMU4oNsuHrH+LcSTPdGJ4MbETy5f1bIpqgzi+PQUPWpyn+jpuLtN+BwbRu42F+qiDyH8AtABIBM1F03Avk4a9J8RU5WJuBKTxkQ8dEaOOv/AJPeq5Qffgg47u39Mns5V2f2kKNKI5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D9DKFHrA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JKd7TK001130;
	Thu, 20 Mar 2025 02:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LNhhX/
	CgDi0qBK0BP9R6tvQ/WfRmgtAiEN7um8QRxls=; b=D9DKFHrAS9QgxKvuqMCXC0
	+zjqQNFMhCkL1ATkDT0rPDVg8dmZHBlLb7sIvl7QyYVSNwkWQ0dVoEHEYp/7hcYf
	F4jXUVpTuZzjQ0bnjalCF6RC67eyqqBBvS+oSMpPDd4rk6IQ7n83IxybAfH0wctF
	nTt1ePcABjfelGMAp2yVvfyfi32tEQU/PWcEVAflAzYgJIwltIPqZOIhl5h7E03E
	SD6yGB/kaJ4oUTeFMjQRrL2MnJEACyeQK2gvz9fxOUkMeSP1IUwv2FAeVmPHpJIt
	GDx6ZCdRylA/FEUq27j60cMBKht32g343iTTNfRv7kGb+TRRDBBT7ql/IyUVs+Hg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5501g7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:59:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K01Prh005579;
	Thu, 20 Mar 2025 02:59:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm905mfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:59:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K2xaeC28901890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 02:59:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13B15805A;
	Thu, 20 Mar 2025 02:59:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C627758052;
	Thu, 20 Mar 2025 02:59:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.179])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 02:59:35 +0000 (GMT)
Message-ID: <b61fda41ec01e1fea80a8c09f2259df6821d620e.camel@linux.ibm.com>
Subject: Re: [PATCH v10 8/8] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 19 Mar 2025 22:59:35 -0400
In-Reply-To: <20250318010448.954-9-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-9-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: bXN4nZxZh-k-1-NowEygZ_-OLiFH2GOt
X-Proofpoint-ORIG-GUID: bXN4nZxZh-k-1-NowEygZ_-OLiFH2GOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200018

On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  Th=
e
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
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
>=20
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash require=
s=20
> calculating the hash of the decoded ascii string. =20
>=20
> For example, to verify the 'kexec_load' data hash:
>=20
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements=
=20
> > grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
>=20
> To verify the 'kexec_execute' data hash:
>=20
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements=
=20
> > grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h       |  6 ++++++
>  security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>  security/integrity/ima/ima_queue.c |  5 +++++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..34815baf5e21 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyri=
ng, struct key *key,
>  				   unsigned long flags, bool create);
>  #endif
> =20
> +#ifdef CONFIG_IMA_KEXEC
> +void ima_measure_kexec_event(const char *event_name);
> +#else
> +static inline void ima_measure_kexec_event(const char *event_name) {}
> +#endif
> +
>  /*
>   * The default binary_runtime_measurements list format is defined as the
>   * platform native format.  The canonical format is defined as little-en=
dian.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 0f214e41dd33..43223eb99046 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>  #include "ima.h"
> =20
>  #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>  static bool ima_kexec_update_registered;
>  static struct seq_file ima_kexec_file;
>  static size_t kexec_segment_size;
> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *s=
f)
>  	ima_reset_kexec_file(sf);
>  }
> =20
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size =3D 0;
> +	long len;
> +	int n;
> +
> +	buf_size =3D ima_get_binary_runtime_size();
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> +		      "ima_runtime_measurements_count=3D%ld;",
> +		      kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, =
false, NULL, 0);
> +}
> +
>  static int ima_alloc_kexec_file_buf(size_t segment_size)
>  {
>  	/*
> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size=
)
>  out:
>  	ima_kexec_file.read_pos =3D 0;
>  	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved spac=
e */
> +	ima_measure_kexec_event("kexec_load");
> =20
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 83d53824aa98..590637e81ad1 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block=
 *nb,
>  			       unsigned long action,
>  			       void *data)
>  {
> +#ifdef CONFIG_IMA_KEXEC
> +	if (action =3D=3D SYS_RESTART && data && !strcmp(data, "kexec reboot"))
> +		ima_measure_kexec_event("kexec_execute");
> +#endif

After a kexec execute, the measurement list does not verify properly and th=
e
"kexec_execute" critical data does not appear in the measurement list.  Thi=
s
makes me think the critical data IS being extended into the TPM, but the
measurement list is being copied before the "kexec_execute" critical data i=
s
called.

This actually makes sense since the reboot notifier ima_update_kexec_buffer=
()
priority is higher than ima_reboot_notifier().

INT_MIN: runs the callback late
INT_MAX: runs the callback early

Either reverse the callback priorities or revert moving the "kexec_execute"
critical data to ima_reboot_notifier().

thanks,

Mimi

> +
>  	ima_measurements_suspend();
> =20
>  	return NOTIFY_DONE;


