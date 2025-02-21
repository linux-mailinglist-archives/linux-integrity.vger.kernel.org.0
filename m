Return-Path: <linux-integrity+bounces-4955-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262FA3E955
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 01:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE87619C50BA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 00:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDCEEBA;
	Fri, 21 Feb 2025 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PLcDEtrC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33E8493;
	Fri, 21 Feb 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098868; cv=none; b=brKf5Pn7eeSRG682oYmy4460UbGxXd8mtpw8DBZZTX0K57cdUFA439de+lOpwTZ7ioKkFjugoux0qdlPeNZLc1IkCEj43DpFCT+5jqKCZ6S1bhkg+4kI2ZJvbF+xYWO7rpnm2CL+Fy2dR95D2VM12wGQMRRjXkOXl3n/M1/luTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098868; c=relaxed/simple;
	bh=2HMtZYXb898PScROT67M5PzASShQukoG8ys0ZnbaAMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfzPPXhuGoYJVOZmWW/nMVoFMTI082nUjeIHxrEdl48lSdmg+RZFM5UjrdYejINgwr+rqq8Jr3lwu3/DL2w2+oELLcYC/DJMxMR1TY0pm/EvVm8X6dkW/s11VpP11IzDTVT/gQF/G684UQWrMW77ew9JKZM2+n9kop5Qo2NQFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PLcDEtrC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMnlA0030968;
	Fri, 21 Feb 2025 00:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wykm5r
	1tsFHBMeFgrKaNrDpfELg+QxGL9YbH6kLhy0I=; b=PLcDEtrCAFSrhNcqlHD+lh
	Gu7wHg0XARoeIkVZlTwx7kVIRbLdKPUdQN59j9tF4t5aO8GgGa+w/IeqzWaxWB0q
	TUZz/fH11YImC7mZKnDr3Dhj8DGamAX/P0UKnmLqG/2rNezutdaY1Jy94RSEo0Jj
	uelp3otY4FXqlMLozRKXXcPF12q24wvTyCyaG/GIltBCR7sGoyDwmg4HBHhWqKV0
	HtiINDlcCfff1wpdDBg8jMUYByLES4m1xBJriENSqDK3gaLDqrYs+LFuTT07xeOd
	DVsgpvL34kDZlvhlHRGit+cBCptxgnVR81X6NwQDTolI9KutR3/5LuQS5hB26rbw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdharcyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 00:47:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLMURb002343;
	Fri, 21 Feb 2025 00:46:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xd2ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 00:46:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51L0kwh932047766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 00:46:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E2F5805D;
	Fri, 21 Feb 2025 00:46:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A048258043;
	Fri, 21 Feb 2025 00:46:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.174.175])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 00:46:56 +0000 (GMT)
Message-ID: <436c898a39a9bdaa2ab24fc111b50d3c885aa028.camel@linux.ibm.com>
Subject: Re: [PATCH v8 7/7] ima: measure kexec load and exec events as
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
Date: Thu, 20 Feb 2025 19:46:56 -0500
In-Reply-To: <20250218225502.747963-8-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-8-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: 7mdZyCPMIbrmHyDxjegjDVduN8VPvOaO
X-Proofpoint-ORIG-GUID: 7mdZyCPMIbrmHyDxjegjDVduN8VPvOaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210002

On Tue, 2025-02-18 at 14:55 -0800, steven chen wrote:
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
>=20
> The 'kexec_load' event IMA log can be found using the following command:
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
> =C2=A0=C2=A0 grep kexec_load
>=20
> The 'kexec_load' event IMA log can be found using the following command:

-> kexec_execute

> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
> =C2=A0=C2=A0 grep kexec_execute

These critical data events are displayed as hex encoded ascii in the
ascii_runtime_measurement_list.  Verifying the critical data hash requires =
calculating the
hash of the decoded ascii string.  For example:

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | gr=
ep  kexec_load
| cut -d' ' -f 6 | xxd -r -p | sha256sum

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ++++++
> =C2=A0security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
> =C2=A0security/integrity/ima/ima_queue.c |=C2=A0 5 +++++
> =C2=A03 files changed, 32 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 4428fcf42167..1452c98242a4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyri=
ng, struct key
> *key,
> =C2=A0				=C2=A0=C2=A0 unsigned long flags, bool create);
> =C2=A0#endif
> =C2=A0
> +#ifdef CONFIG_IMA_KEXEC
> +void ima_measure_kexec_event(const char *event_name);
> +#else
> +static inline void ima_measure_kexec_event(const char *event_name) {}
> +#endif
> +
> =C2=A0/*
> =C2=A0 * The default binary_runtime_measurements list format is defined a=
s the
> =C2=A0 * platform native format.=C2=A0 The canonical format is defined as=
 little-endian.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 6c8c203ad81e..8d0782e51ffa 100644
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
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size =3D 0;
> +	long len;
> +
> +	buf_size =3D ima_get_binary_runtime_size();
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		=C2=A0 "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> +		 "ima_runtime_measurements_count=3D%ld;",
> +		 kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
> +				=C2=A0 strlen(ima_kexec_event), false, NULL, 0);

As previously mentioned, scnprintf() returns the length.  No need to use st=
rlen() here.

Mimi

> +}
> +
> =C2=A0static int ima_alloc_kexec_file_buf(size_t segment_size)
> =C2=A0{
> =C2=A0	/*
> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size=
)
> =C2=A0out:
> =C2=A0	ima_kexec_file.read_pos =3D 0;
> =C2=A0	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved=
 space */
> +	ima_measure_kexec_event("kexec_load");
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 3dfd178d4292..6afb46989cf6 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block=
 *nb,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long action,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
> =C2=A0{
> +#ifdef CONFIG_IMA_KEXEC
> +	if (action =3D=3D SYS_RESTART && data && !strcmp(data, "kexec reboot"))
> +		ima_measure_kexec_event("kexec_execute");
> +#endif
> +
> =C2=A0	ima_measurements_suspend();
> =C2=A0
> =C2=A0	return NOTIFY_DONE;


