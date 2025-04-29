Return-Path: <linux-integrity+bounces-6059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC781AA1A47
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5999518864FF
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED0252914;
	Tue, 29 Apr 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVUoS7i1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46398240611;
	Tue, 29 Apr 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950752; cv=none; b=JETqHp7x5A3yRiNRGvsU+wFlTviWij2rfhpZ9x7+/a2jyy5wgJNMVjfYZH1gp4Fi/tfH72vW/TudvIQg9pxIy7CU2pLIIZMidR4rRs76tNcIvAs7QNk0zUbUUBScj3hm+HVxK/7J2/sZ9huoTokW4PQlWHR+58ZrT/gyP+D/dmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950752; c=relaxed/simple;
	bh=d0Bc0476DojnmQjuiDy1RhDFzhcFpLA9o7Moy+Z5lwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amRcP8GnuozqbB3IbrJqXVXT+JF4jsFdLNkfNLtWO/dS9yzUaH8xrRvkEm+5ud2NAov/jGqtzmwCIo8/KYsDBhAcXst7d6iI7sNxSh3Weg9pv6Yx65RASsGI9ToI5fVnADHdC4nEMNcoAJojyS8nN65WaiJDf2M4raTItTs/q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVUoS7i1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA4ShA000528;
	Tue, 29 Apr 2025 18:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UwMh+p
	Fsxitu0VIc46oNnCKoAPFDBx3kLVDwDqBe6b0=; b=mVUoS7i1oXR83WrkdxObnK
	eVATcPM2PYAFmKP3oQji3XFwGzM7Uhw6P5H0OBX3RQrliSTegtCdaOY1kFG8qbRJ
	T2kPNZJEuvYvz/m+kHYMlFESjTgGxlxWuDNggNwtBIz54ZvUoxuzJGyDHU6Ojybv
	wfnn4ZCvgsDPV1iK+zXAITvPUB797ph3gYzxiOChNdRr03zV4vHq+1fWM4CZeLES
	aD0YqLAPQVex4Gr4p64Xpl8CNSreCKsNJoG06kx8oqXw0eElaKUkZT30eic5seRa
	3rSGY3ZoPleb2bPbHGcqexv4LZCWKJE97E2KUbI1FXjK/r7Fp0Xpfl4FFUbPkBRw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46avpkab89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:18:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TI1vqX001830;
	Tue, 29 Apr 2025 18:18:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bammct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:18:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TIIcwD53084634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 18:18:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83CEC5805A;
	Tue, 29 Apr 2025 18:18:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 086F65805D;
	Tue, 29 Apr 2025 18:18:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 18:18:39 +0000 (GMT)
Message-ID: <678c762f-e1f9-4a35-a9c3-c88b662001a4@linux.ibm.com>
Date: Tue, 29 Apr 2025 14:18:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 9/9] ima: measure kexec load and exec events as
 critical data
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-10-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-10-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68111803 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=52e223D3gOybuSLWcPIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GV2KzMfb5jEMwKuIbcSmRtEjN6C31epg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzMyBTYWx0ZWRfX9DZy+G/pcGu2 4fhuvNRD/AVhK7ee4oybSV9Eb/n/v7JRJE8mD1odm3Q76GarP0Q0VXjaV5byyjkaZXn1YcIZhiX XE4JSLeirSjkg0P8CRkZs+4C6qFiXaiuztZWo4HBt9/NFjTWvI4g/iyVRJnCXTTcdJT4uFamrh0
 VJpN/e5JFkCv03WFWdZLTqsrG7PZ6i6uSc3shkc/vhDF0lCjpD97NmnYhZ4kMxwVRTN7pZ+dCZ6 zjl/frLBY7eZwhBTM6qj/ChvZWDVQVPYGiooluoPWJPxYSLP2AQqhXZWOSMqtOLzE1a8FFoaeuV +Fj4VvT5OLYh5eB+txYe0+UZ9gA49t1OV3SkTutz1v4RFk3JLJ2Y/cBHjawzJq3KOGMtCZ6en5/
 V5KXuGh8qXjrdk1oJ1PMwOHLw9s1Y+plsT01w5jMpvmLRDh7TFdewm24QRKK/z9HuR+Ta8y6
X-Proofpoint-GUID: GV2KzMfb5jEMwKuIbcSmRtEjN6C31epg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290133



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate
> this problem.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
> 
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
> 
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash requires
> calculating the hash of the decoded ascii string.
> 
> For example, to verify the 'kexec_load' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> | grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> 
> To verify the 'kexec_execute' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> | grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
 > --->   security/integrity/ima/ima.h       |  6 ++++++
>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>   security/integrity/ima/ima_queue.c |  5 +++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..34815baf5e21 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>   				   unsigned long flags, bool create);
>   #endif
>   
> +#ifdef CONFIG_IMA_KEXEC
> +void ima_measure_kexec_event(const char *event_name);
> +#else
> +static inline void ima_measure_kexec_event(const char *event_name) {}
> +#endif
> +
>   /*
>    * The default binary_runtime_measurements list format is defined as the
>    * platform native format.  The canonical format is defined as little-endian.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index d1c9d369ba08..38cb2500f4c3 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>   static bool ima_kexec_update_registered;
>   static struct seq_file ima_kexec_file;
>   static size_t kexec_segment_size;
> @@ -31,6 +33,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   	sf->count = 0;
>   }
>   
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size = 0;
> +	long len;
> +	int n;
> +
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		      "ima_runtime_measurements_count=%ld;",
> +		      kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
> +}
> +
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
>   	/*
> @@ -53,6 +73,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   out:
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +	ima_measure_kexec_event("kexec_load");
>   
>   	return 0;
>   }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 83d53824aa98..590637e81ad1 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>   			       unsigned long action,
>   			       void *data)
>   {
> +#ifdef CONFIG_IMA_KEXEC
> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
> +		ima_measure_kexec_event("kexec_execute");
> +#endif
> +
>   	ima_measurements_suspend();
>   
>   	return NOTIFY_DONE;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


