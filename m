Return-Path: <linux-integrity+bounces-1212-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D352855478
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 22:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7569CB216A8
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4613EFE1;
	Wed, 14 Feb 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XMsWoffT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8F54649
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944491; cv=none; b=pdGJrZUQwnVHM20LsIJggVA5v/bbqUlmSAEsdQ5KpFNKlB/r04OTerBvGL/be+IgzoKk1azcDrN4HGyxnu4MLmq9Pp2BujfIN3LhTU+IBxroLU79OIARo6VZJAJzSIR9ksxs/9pPl3t2ZP357UuoDrPFiMfQWMv9DRWZyOyxuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944491; c=relaxed/simple;
	bh=xZ8xlExA/ND3EaZNksixmHxVDBs012T9rzX9qlx5kCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgZ613WLglXQaArtRWm7/BQHXk0YWWd0q3YbDaW4+XLEMvll/v3NuQSowx3hWBGKHV0GP2NmgALlxTSFriQ04DlkvsLHDJtn9m5HnLeumYF13dVWuqcVwR3yNfXwVuBVLl6gs4QDkOne6DhlbrOnVALYsJOKv0RXPuH8G4owSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XMsWoffT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EKx71b014909;
	Wed, 14 Feb 2024 21:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aHeadgQKNccTAu26YZGebZuAVjlAvSQSzZGROeYGOUM=;
 b=XMsWoffTeHef80Jpzx4Zu9/g3hAfadO1ir6gVt5BA1OxiRyY6PzYvsBljVsKLp69Fclw
 ZR+yc4tzncKaXFEdPBusdNbxUXjyfY5Cw5vtVJbzZRmKaP0J+eNnlsGR6astSZcwBcRf
 mVd1CEJ7WdrW33gXxwIWV1fWTpdZb8Kh3d8Xbe05DQhIAImY5QRe5HhGqPDUualdpTYG
 YlvdN8/NTRqPLF1kLEzc8AXwgpIQMDrFF7mfXasIu68meLzuUFUYhjxAO0sB3Cy0d4J8
 nzyU/5TwvC12cLJ9wmYM1ztiShEP6Hn8rnxU/D19dZojQ2D/F88Xi+svnVlIdxO5LqN3 YA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w94skgdej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 21:01:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJB26m016207;
	Wed, 14 Feb 2024 21:01:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymrcn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 21:01:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EL0xvF47382886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 21:01:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6B758059;
	Wed, 14 Feb 2024 21:00:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE0785805E;
	Wed, 14 Feb 2024 21:00:57 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 21:00:57 +0000 (GMT)
Message-ID: <803ac44d-1d08-46f3-a41c-01f113a21c11@linux.ibm.com>
Date: Wed, 14 Feb 2024 16:00:56 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nho3momrQtKhw2XyHWoJyOiG4lPTdmGl
X-Proofpoint-GUID: Nho3momrQtKhw2XyHWoJyOiG4lPTdmGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140163



On 2/14/24 10:38, Tushar Sugandhi wrote:
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
> reboot, and not a cold-boot.  And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 34 +++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 50903d4ce880..31495a043959 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>   static struct seq_file ima_kexec_file;
>   static void *ima_kexec_buffer;
>   static size_t kexec_segment_size;
> @@ -38,6 +40,10 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size;
> +	long len;
> +
>   	/*
>   	 * kexec 'load' may be called multiple times.
>   	 * Free and realloc the buffer only if the segment_size is
> @@ -47,7 +53,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   	    ima_kexec_file.size == segment_size &&
>   	    ima_kexec_file.read_pos == 0 &&
>   	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
> -		return 0;
> +		goto out;
>   
>   	ima_free_kexec_file_buf(&ima_kexec_file);
>   
> @@ -60,6 +66,18 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>   
> +out:
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		  "ima_runtime_measurements_count=%ld;",
> +		  segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
> +				  strlen(ima_kexec_event), false, NULL, 0);
> +
>   	return 0;
>   }
>   
> @@ -186,10 +204,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>   static int ima_update_kexec_buffer(struct notifier_block *self,
>   				   unsigned long action, void *data)
>   {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>   	void *buf = NULL;
>   	size_t buf_size;
>   	int ret = NOTIFY_OK;
>   	bool resume = false;
> +	long len;
>   
>   	if (!kexec_in_progress) {
>   		pr_info("%s: No kexec in progress.\n", __func__);
> @@ -201,6 +221,18 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   		return ret;
>   	}
>   
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		  "ima_runtime_measurements_count=%ld;",
> +		  kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
> +				  ima_kexec_event, strlen(ima_kexec_event),
> +				  false, NULL, 0);
> +
>   	ima_measurements_suspend();
>   
>   	ret = ima_dump_measurement_list(&buf_size, &buf,

It's twice the same code almost in the same file. You could move it into 
a function.

