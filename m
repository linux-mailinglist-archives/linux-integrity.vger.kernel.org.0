Return-Path: <linux-integrity+bounces-554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6F81A7B7
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8EFB22D8B
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BF1DA29;
	Wed, 20 Dec 2023 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WOI74b/2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6601DA49
	for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2023 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKJLaJo002707;
	Wed, 20 Dec 2023 20:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=T93vEvWuWCv0q5ZYcBTMqIW/8+mV3l9hKuEhkSmmacY=;
 b=WOI74b/20FkOn9CqkzY7B786Yb4Il+qH08f36Mvnh77yYPOfYB2yXODstiUvwusO/4PP
 GnBN50x2HjEAqEsLfVzazDibtb2uZwmuGjlYnsHDIDYhcPBdmoIpeacYxiiCROLGME0W
 W5dFgAFfGDjDldCAZEUQ6IFUKCUVTnEd1sF0p4eT6vXKE20ukGkxqeCQ/GMpauSdzeWt
 vnZKCOllYG+ViEesD2wFLDz2UZcrbCSa6l/UrN9aC9mOIBwO/2HOPodNlM7h9XepyTjs
 b1PB59LF/5GEPa/bRsPf42+GabBwscl4AGVaSYnLmA3TaL1CF9yaagTBm1C1Ku/5kwRj Iw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v441rx9fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:41:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKJ4Oqr029801;
	Wed, 20 Dec 2023 20:41:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7ss2c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:41:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKKfPo815663870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 20:41:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6468858056;
	Wed, 20 Dec 2023 20:41:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB52E58052;
	Wed, 20 Dec 2023 20:41:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 20:41:24 +0000 (GMT)
Message-ID: <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 20 Dec 2023 15:41:24 -0500
In-Reply-To: <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mKUePe8h_PNzcJPOfNVMAbApsAIAC1Uj
X-Proofpoint-ORIG-GUID: mKUePe8h_PNzcJPOfNVMAbApsAIAC1Uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200145

On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> There could be a potential mismatch between IMA measurements and TPM PCR
> quotes caused by the indeterminate interval between kexec 'load' and
> 'execute'.  Memory allocated at kexec 'load' for IMA log buffer may run
> out. It can lead to missing events in the IMA log after a soft reboot to
> the new Kernel, resulting in TPM PCR quotes mismatch and remote
> attestation failures.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
> measured as critical data at kexec 'load' and 'execute' respectively.
> 
> These events serve as markers in the IMA log to verify the IMA events are
> captured between kexec 'load' and 'execute' window.  The presence of a
> 'kexec_load' event in between the last two 'boot_aggregate' events in the
> IMA log implies this is a kexec soft reboot, and not a cold-boot. And the
> absence of 'kexec_execute' event after kexec soft reboot implies missing
> events in that window which results in inconsistency with TPM PCR quotes,
> necessitating a cold boot for further successful remote attestation.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 063da9c834a0..47da41a66dcc 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 128
> +
>  struct seq_file ima_kexec_file;
>  static void *ima_kexec_buffer;
>  static size_t kexec_segment_size;
> @@ -33,6 +35,8 @@ void ima_free_kexec_file_buf(struct seq_file *sf)
>  
>  static int ima_alloc_kexec_file_buf(size_t segment_size)
>  {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +
>  	/*
>  	 * kexec 'load' may be called multiple times.
>  	 * Free and realloc the buffer only if the segment_size is
> @@ -42,7 +46,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>  	    ima_kexec_file.size == segment_size &&
>  	    ima_kexec_file.read_pos == 0 &&
>  	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
> -		return 0;
> +		goto out;
>  
>  	ima_free_kexec_file_buf(&ima_kexec_file);
>  
> @@ -55,6 +59,13 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>  	ima_kexec_file.read_pos = 0;
>  	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>  
> +out:
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;", segment_size);
> +
> +	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
> +				  strlen(ima_kexec_event), false, NULL, 0);
> +
>  	return 0;
>  }
>  
> @@ -179,6 +190,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  static int ima_update_kexec_buffer(struct notifier_block *self,
>  				   unsigned long action, void *data)
>  {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>  	void *buf = NULL;
>  	size_t buf_size;
>  	bool resume = false;
> @@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>  		return ret;
>  	}
>  
> +	buf_size = ima_get_binary_runtime_size();
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
> +		  kexec_segment_size, buf_size);
> +
> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
> +				  ima_kexec_event, strlen(ima_kexec_event),
> +				  false, NULL, 0);
> +

Please consider including the number of measurement records as well.

>  	ima_measurements_suspend();
>  
>  	ret = ima_dump_measurement_list(&buf_size, &buf,

-- 
thanks,

Mimi


