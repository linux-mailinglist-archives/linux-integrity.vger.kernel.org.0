Return-Path: <linux-integrity+bounces-866-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68081839FB9
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 03:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEED1C22D42
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 02:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF91396;
	Wed, 24 Jan 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Va6uAQlC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1246A5
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064929; cv=none; b=FpHYIBjLVz5hemmvGyRc8dF+9LwKNqb2shYbGVRmWqvTNmDgbW6VdooZvHY5dEK2RSizGXW7g8DARk8Ah9KKKlsB0JOO44HhuhNaLimi4ChBjyC+ZRfkopX5PKfvcvlc5vh/4o/2w9aAbTF9EX3hCchB1L0B3v7kBLXNi3pLxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064929; c=relaxed/simple;
	bh=slQmPlfKC+WovJRPIK8CO7xYCJT6qf/3GLmKlpsbazM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDhFn6UWW4nzO1Cxp/e5ZECii6qc1szGLeJ/5jVq1zeqMxOU7lKRjYLU9O7s6SYYB0djAUsAv0r2SneGh9B/+0vjpysg6EqWlKXevvq5vSYDfBAlgTwegdt3Ef2QG6rc2+YoPf2oZwFclaYshbGxxKoQBp2feouRVPmXiaFC+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Va6uAQlC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O1sR7K017500;
	Wed, 24 Jan 2024 02:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kU9vaPuV9sZr7C46L+4pco1l56+S3XVpFwbbJqqCNO8=;
 b=Va6uAQlCXRdPKPGjkj1TbzJxIngoI9eZXnIIwNx+eWJ/JtRPLZJz4BZmh0yR5j/CG8wA
 kU4RJFXaEU10keWGQdrS0MlzpzaUa98JMS6IdDLighuL/MvSqtpT+8WEYo5HNvwY9Veq
 n2mzmA5uCSDqrCR5G58z5FP7nWx0HwDhdafmKCiYVvJ/RGK4vssXzVRaYO2U5BYTaDrD
 83Xmz39nmWZ/xBol2jiu3ijWZ7+yuxVU9mp+tfFDnRFM/jVH8R3M6u8xk9BkziqJEgqs
 2zbgGQtsElNsbJUmNAX/BIkNcHckYmFEVAbrd57gsPT8AKMweY0Ap5v21xQMBgK29e6J 2Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtpmjvemr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:54:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NNoQhx025892;
	Wed, 24 Jan 2024 02:54:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgp38f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:54:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40O2sWJU32768684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:54:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E02558058;
	Wed, 24 Jan 2024 02:54:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A6F58057;
	Wed, 24 Jan 2024 02:54:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 02:54:31 +0000 (GMT)
Message-ID: <2c4e98bc-8e26-4df1-8567-04d81d2c3963@linux.ibm.com>
Date: Tue, 23 Jan 2024 21:54:30 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GSNmAK5JgD5sk7ljhVAxNwqqei35jbpP
X-Proofpoint-GUID: GSNmAK5JgD5sk7ljhVAxNwqqei35jbpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240020



On 1/22/24 13:37, Tushar Sugandhi wrote:
> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_file_buf() which allocates buffer
> of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
> ima_kexec_file in function ima_dump_measurement_list() as local static to
> the file, so that it can be accessed from ima_alloc_kexec_file_buf().
> Make necessary changes to the function ima_add_kexec_buffer() to call the
> above two functions.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
>   1 file changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..99daac355c70 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,62 +15,93 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf &&
> +	    ima_kexec_file.size == segment_size &&
> +	    ima_kexec_file.read_pos == 0 &&
> +	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
> +		return 0;
> +
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +
> +	return 0;
> +}
> +
>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   				     unsigned long segment_size)
>   {
>   	struct ima_queue_entry *qe;
> -	struct seq_file file;
>   	struct ima_kexec_hdr khdr;
> -	int ret = 0;
>   
> -	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		*buffer_size = 0;
> +		*buffer = NULL;
> +		pr_err("%s: Kexec file buf not allocated\n", __func__);
> +		return -EINVAL;
>   	}
>   
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> -
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
> +
> +	/* Copy as many IMA measurements list records as possible */
>   	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>   			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>   		} else {
> -			ret = -EINVAL;
> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> +			       __func__);
>   			break;
>   		}
>   	}
>   
> -	if (ret < 0)
> -		goto out;
> -
>   	/*
>   	 * fill in reserved space with some buffer details
>   	 * (eg. version, buffer size, number of measurements)
>   	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>   	if (ima_canonical_fmt) {
>   		khdr.version = cpu_to_le16(khdr.version);
>   		khdr.count = cpu_to_le64(khdr.count);
>   		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>   	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>   
>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>   			     true);
>   
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> -out:
> -	if (ret == -EINVAL)
> -		vfree(file.buf);
> -	return ret;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
> +	return 0;
>   }
>   
>   /*
> @@ -108,13 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
>   		pr_err("Not enough memory for the kexec measurement buffer.\n");
>   		return;
>   	}
>   
> +	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> +		       __func__, ret);
> +		return;
> +	}
> +
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;


A dent with this patch when only applying this patch:

Two consecutive kexec loads lead to this here:

[   30.670330] IMA buffer at 0x3fff10000, size = 0xf0000
[   32.519618] ------------[ cut here ]------------
[   32.519669] Trying to vfree() nonexistent vm area (00000000093ae29c)
[   32.519762] WARNING: CPU: 11 PID: 1796 at mm/vmalloc.c:2826 
vfree+0x254/0x340
[   32.519786] Modules linked in: bonding tls rfkill sunrpc 
virtio_console virtio_balloon crct10dif_vpmsum fuse loop zram bochs 
drm_vram_helper drm_kms_helper drm_ttm_helper ttm ibmvscsi 
scsi_transport_srp drm virtio_blk virtio_net vmx_crypto net_failover 
crc32c_vpmsum failover pseries_wdt drm_panel_orientation_quirks 
scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
[   32.519939] CPU: 11 PID: 1796 Comm: kexec Not tainted 6.5.0+ #112
[   32.519953] Hardware name: IBM pSeries (emulated by qemu) POWER8E 
(raw) 0x4b0201 0xf000004 of:SLOF,git-5b4c5a hv:linux,kvm pSeries
[   32.519973] NIP:  c0000000004bd004 LR: c0000000004bd000 CTR: 
c00000000017ef00
[   32.519986] REGS: c00000004593b670 TRAP: 0700   Not tainted  (6.5.0+)
[   32.519999] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
44424842  XER: 00000000
[   32.520023] CFAR: c0000000001515b0 IRQMASK: 0
                GPR00: c0000000004bd000 c00000004593b910 
c000000001e17000 0000000000000038
                GPR04: 00000000ffffbfff c00000004593b6e8 
c00000004593b6e0 00000003f9580000
                GPR08: 0000000000000027 c0000003fb707010 
0000000000000001 0000000044424842
                GPR12: c00000000017ef00 c00000003fff1300 
0000000000000000 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000003 0000000000000004
                GPR24: 00007fffeab0f68f 000000000000004c 
0000000000000000 c00000002bdce400
                GPR28: c000000002bf28f0 0000000000000000 
c008000004770000 0000000000000000
[   32.520180] NIP [c0000000004bd004] vfree+0x254/0x340
[   32.520212] LR [c0000000004bd000] vfree+0x250/0x340
[   32.520225] Call Trace:
[   32.520232] [c00000004593b910] [c0000000004bd000] vfree+0x250/0x340 
(unreliable)
[   32.520250] [c00000004593b990] [c00000000091d590] 
ima_add_kexec_buffer+0xe0/0x3c0
[   32.520296] [c00000004593ba90] [c000000000280968] 
sys_kexec_file_load+0x148/0x9b0
[   32.520333] [c00000004593bb70] [c00000000002ea84] 
system_call_exception+0x174/0x320
[   32.520372] [c00000004593be50] [c00000000000d6a0] 
system_call_common+0x160/0x2c4
[   32.520408] --- interrupt: c00 at 0x7fffa52e7ae4
[   32.520420] NIP:  00007fffa52e7ae4 LR: 0000000108481d8c CTR: 
0000000000000000
[   32.520452] REGS: c00000004593be80 TRAP: 0c00   Not tainted  (6.5.0+)
[   32.520483] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
24424202  XER: 00000000
[   32.520507] IRQMASK: 0
                GPR00: 000000000000017e 00007fffeab09470 
00007fffa53f6f00 0000000000000003
                GPR04: 0000000000000004 000000000000004c 
00007fffeab0f68f 0000000000000000
                GPR08: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR12: 0000000000000000 00007fffa559b280 
0000000000000002 0000000000000001
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 00007fffa53f0454 00007fffa53f0458 
0000000000000000 0000000000000001
                GPR24: 0000000000000000 00007fffeab0f64d 
0000000000000006 0000000000000000
                GPR28: 0000000000000003 00007fffeab09530 
00007fffeab09b08 0000000000000007
[   32.520767] NIP [00007fffa52e7ae4] 0x7fffa52e7ae4
[   32.521192] LR [0000000108481d8c] 0x108481d8c
[   32.521587] --- interrupt: c00
[   32.521981] Code: 3884c208 4bfc20f1 60000000 0fe00000 60000000 
60000000 60420000 3c62ff94 7fc4f378 38632b20 4bc944cd 60000000 
<0fe00000> eba10068 4bffff34 2c080000
[   32.522823] ---[ end trace 0000000000000000 ]---
[   32.536347] Removed old IMA buffer reservation.
[   32.536473] IMA buffer at 0x3fff10000, size = 0xf0000

This vfree here probably has to go:

         ret = kexec_add_buffer(&kbuf);
         if (ret) {
                 pr_err("Error passing over kexec measurement buffer.\n");
                 vfree(kexec_buffer);
                 return;
         }

