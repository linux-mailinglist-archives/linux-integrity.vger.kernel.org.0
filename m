Return-Path: <linux-integrity+bounces-757-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87282C444
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 18:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B47B1C214CE
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561281B5A2;
	Fri, 12 Jan 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M7eyb8MX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E245683
	for <linux-integrity@vger.kernel.org>; Fri, 12 Jan 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CGWfZO005929;
	Fri, 12 Jan 2024 17:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nvfHbUX3NdOOF0RM1HqCVKhl+3u+WtwkaHpacqrG54Y=;
 b=M7eyb8MX3klM9CYxA8pMbfMCqHuamzkhadDe+PyEVLcC5hwoPqgP1LSQBAW/d66M1vqS
 qlD370OmfqWp56qeijRQ7F3AXsfz8pZJzACB1uBXN3eXEC3knCXSAWByi7VyVvVFf0Tf
 vJ+zw3robUrfzKtQK+kzTRYfSA254SDXrWZgWuK5UijSFRGSpx9P6A4PTtQIP6+r0bm1
 nUYMmzGnAfkke4nrVunQlxTUm+FyGSPSlbWcDEWZ8Vlh7EPATSZrz2d9EdFoUC5H8pfa
 EEjIY6foFet0a3r53nO/wZ+M+UiG0JuIrPmAECetb0wM2eTW+vR7LVIgAdSeK8xzhm2I rg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vk91q0tum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:07:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40CFZIEC022787;
	Fri, 12 Jan 2024 17:06:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhk03ene-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:06:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40CH6iAp57737632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 17:06:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AA3B58059;
	Fri, 12 Jan 2024 17:06:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA7458058;
	Fri, 12 Jan 2024 17:06:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.149.108])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jan 2024 17:06:42 +0000 (GMT)
Message-ID: <8f5deffb34c9a948a20e63eae44a1e3343e2ffe4.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/7] ima: kexec: move ima log copy from kexec load to
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Fri, 12 Jan 2024 12:06:42 -0500
In-Reply-To: <c2ec280f-4789-4654-a7b4-7a9534476173@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
	 <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
	 <c2ec280f-4789-4654-a7b4-7a9534476173@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DeISoDk6VTOGzzhmLGE0CHqvdeq2xQVG
X-Proofpoint-GUID: DeISoDk6VTOGzzhmLGE0CHqvdeq2xQVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_08,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401120135

Hi Tushar,

> > This patch moves the ima_dump_measurement_list() call from kexec load
> > to exec, but doesn't register the reboot notifier in this patch.  I
> > don't see how it is possible with just the previous and this patch
> > applied that the measurement list is carried across kexec.
> Ah. That's a good catch.
> I was only checking if I can boot into the Kernel for testing 
> bisect-safe readiness for each patch.  I will ensure the move of 
> ima_dump_measurement_list() and registering the reboot notifier at 
> execute stays an atomic operation in a single patch.

Thanks!

> >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >> index f989f5f1933b..bf758fd5062c 100644
> >> --- a/kernel/kexec_file.c
> >> +++ b/kernel/kexec_file.c
> >> @@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >>   		if (ksegment->kbuf == pi->purgatory_buf)
> >>   			continue;
> >>   
> >> +		/*
> >> +		 * Skip the segment if ima_segment_index is set and matches
> >> +		 * the current index
> >> +		 */
> >> +		if (image->is_ima_segment_index_set &&
> >> +		    i == image->ima_segment_index)
> >> +			continue;
> > 
> > With this change, the IMA segment is not included in the digest
> > calculation, nor should it be included in the digest verification.
> > However, I'm not seeing the matching code change in the digest
> > verification.
> > 
> Fair question.
> 
> But I don't think anything else needs to be done here.
> 
> The way kexec_calculate_store_digests() and verify_sha256_digest()
> are implemented, it already skips verification of the segments if
> the segment is not part of 'purgatory_sha_regions'.
> 
> In kexec_calculate_store_digests(), my change is to 'continue' when the
> segment is the IMA segment when the function is going through all the
> segments in a for loop [1].
> 
> Therefore in kexec_calculate_store_digests() -
>   - crypto_shash_update() is not called for IMA segment [1].
>   - sha_regions[j] is not updated with IMA segment  [1].
>   - This 'sha_regions' variable later becomes 'purgatory_sha_regions'
>     in kexec_calculate_store_digests  [1].
>   - and verify_sha256_digest() only verifies 'purgatory_sha_regions'[2].
> 
>   Since IMA segment is not part of the 'purgatory_sha_regions', it is
>   not included in the verification as part of verify_sha256_digest().
> 
> > Please make ignoring the IMA segment a separate patch.
> > 
> Sure. Will do.

Thank you for the explanation.  Please include in the patch description a
statement about the "sha_regions" not including the IMA segment, so nothing is
needed on the verify side.

> 
> >>   		ret = crypto_shash_update(desc, ksegment->kbuf,
> >>   					  ksegment->bufsz);
> >>   		if (ret)
> ...
> ...
> ...
> >> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >> index c29db699c996..49a6047dd8eb 100644
> > 
> > Suspending and resuming extending the measurement list should be a
> > separate patch as well, with its own patch description.
> > 
> Sure. Will do.

Thanks!

Mimi


