Return-Path: <linux-integrity+bounces-1317-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21E85CC9F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 01:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21391B21545
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A3382;
	Wed, 21 Feb 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PchX5T0x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E5384
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474587; cv=none; b=cIrRHOJowySPxLuyJ8Ihcjj2x8kPGKzuCNbS0rEfv2eIlLERR+F8/+QPaSzWmiD9D39k2n58s18uRgEhXsV06l1v0MFQ0CkdgPBObZGQZk+Ve4ijd8NHODLCjOEneIP5MvqaEVqm91ikitk/Cs9/Ow83Z0PBYUw1/8R527UYP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474587; c=relaxed/simple;
	bh=zoH9jrB0y/ur0dNCFwD/6gOkWAPLCV9JeF5+z3OOOuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Cz5VdR2ULERtaYRPN+2iBHhoMpDruiDji4dRxh1H3bUr4FKfUfnJru/BugQrGvsmB+5+s7JhGo/V4lmrNlORTfkSNr/8TNWbDYnLN4ZGzu57JQxsPwjiCuhulu/xFpXrmv7Lm+owC7edbUkCLvLQEDhctjv8GQXANepcn1gL4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PchX5T0x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNgEFN000566;
	Wed, 21 Feb 2024 00:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rcO+TJMdPCMC8NOIaeSY5fHZCNuyMF1SpOl1n2oAYHU=;
 b=PchX5T0x3WtTcbzPkveDc5yYR2+ayBnsgGyF36NsR/uoakSpuCBoM9WVV6an3mvM4V8X
 O/28ETw1+ZSEovVUFm+05itejzzzZG0dvTdVrmookvm9v+HmprEXQPWcx2CAslUavaZn
 D/dKl5uUnn1XvieUMjZxVC9Kdaza6Z0GY9lI3/LyYs2Ux4ebJavP6LKDTUmgH6MTcjoa
 9Ny5KxjBrixE/4UZQg8nzxTnG0GcXlpczLXsMqvph5hsk9gQVYWxgRGPPeREeQIMR2eS
 PwrI4qBm6/Pd/hmlnlpJ2hjPNycHcuT3gXPLUxjAoDUab1LQ9YOtH4xfRp+c6JT5zCmo tQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd569hbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:15:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNKo0r017265;
	Wed, 21 Feb 2024 00:15:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmbgp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:15:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41L0FbnL18285244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 00:15:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506935805F;
	Wed, 21 Feb 2024 00:15:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114595805C;
	Wed, 21 Feb 2024 00:15:36 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.5.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 00:15:35 +0000 (GMT)
Message-ID: <e4c7084d434d1d6176e38b705c26f604c9513dc4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/8] ima: kexec: measure events between kexec load
 and execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Tue, 20 Feb 2024 19:15:35 -0500
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: cOdVztsAt7ht06BFwqSiNxRLHclnmyy0
X-Proofpoint-ORIG-GUID: cOdVztsAt7ht06BFwqSiNxRLHclnmyy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210000

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.

'Kernel' should not be capitalized since it isn't a proper name.  'Linux' would
be capitalized (e.g. The Linux kernel).

-> "The IMA measurement list is copied at kexec 'load', not kexec 'execute',
before being carried over to the new kexec'ed kernel.

Mimi

> 
> New events can be measured during/after the IMA log snapshot at kexec 
> 'load' and before the system boots to the new Kernel.  In this scenario,
> the TPM PCRs are extended with these events, but they are not carried
> over to the new Kernel after kexec soft reboot since the snapshot is
> already taken.  This results in mismatch between TPM PCR quotes and the
> actual IMA measurements list after kexec soft reboot, which in turn
> results in remote attestation failure.
> 
> To solve this problem - 
>  - allocate the necessary buffer at kexec 'load' time,
>  - populate the buffer with the IMA measurements at kexec 'execute' time, 
>  - and measure two new IMA events 'kexec_load' and 'kexec_execute' as
>    critical data to help detect missing events after kexec soft reboot.
> 
> The solution details include:
>  - refactoring the existing code to allocate a buffer to hold IMA
>    measurements at kexec 'load', and dump the measurements at kexec
>    'execute'
> 
>  - IMA functionality to suspend and resume measurements as needed during
>    buffer copy at kexec 'execute',
> 
>  - kexec functionality for mapping the segments from the current Kernel
>    to the subsequent one, 
> 
>  - necessary changes to the kexec_file_load syscall, enabling it to call
>    the ima functions,
> 
>  - registering a reboot notifier which gets called during kexec 
>    'execute',
> 
>  - introducing a new Kconfig option to configure the extra memory to be
>    allocated for passing IMA log from the current Kernel to the next,
>    
>  - introducing two new events to be measured by IMA during kexec, to
>    help diagnose if the IMA log was copied fully or partially, from the
>    current Kernel to the next,
> 
>  - excluding IMA segment while calculating and storing digest in function
>    kexec_calculate_store_digests(), since IMA segment can be modified
>    after the digest is computed during kexec 'load'.  This will ensure
>    that the segment is not added to the 'purgatory_sha_regions', and thus
>    not verified by verify_sha256_digest().
> 
> The changes proposed in this series ensure the integrity of the IMA
> measurements is preserved across kexec soft reboots, thus significantly
> improving the security of the Kernel post kexec soft reboots.
> 
> There were previous attempts to fix this issue [1], [2], [3].  But they
> were not merged into the mainline Kernel.
> 
> We took inspiration from the past work [1] and [2] while working on this
> patch series.
> 
> V4 of this series is available here[6] for reference.
> 



