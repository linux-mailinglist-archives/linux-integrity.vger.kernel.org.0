Return-Path: <linux-integrity+bounces-4288-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1C9E4734
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 22:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3820C18801A6
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0F18FDDB;
	Wed,  4 Dec 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SbRs7C1F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933F23919F;
	Wed,  4 Dec 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349033; cv=none; b=eUoSK2Cyojmk8gb3saPL0T8kJuQ0ThWFLxsCcEoDmmQgnX7UQY5PV0sPsjlaylYzEwoOKVTrwE0ILtE5mrxkDM6+L1DnKFPlq27qmSiSlPXlEv2CvDkgn++jpcu0wqLyPxZtZa7o8Qv85i347nWK+mKmhRGZqLGykxldGAFmnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349033; c=relaxed/simple;
	bh=hMgoWrdNg7v99cj3sspOX+yIVYCDmoxjgRaVARM3ais=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i6ORqM8QKu2eTzD95lGtelv74RiaQRIYKd37xQ5piv/6zaP0BXRGMbNy9PrxDqhmrX1nuXeKZDBvRlBlGUnr9Th/XPx21rT3FWvqa18B4iKmsCtUbgTkLmEFwuhmjb+n98tPmyFXWGv2Mhfqh+gZzzOPux2+JZ4Le+QWVypnojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SbRs7C1F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EVKuW031768;
	Wed, 4 Dec 2024 21:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nGkvpI
	LNsElyZaDez5O8Da0rWkbUi9ypHT25VUmb1TI=; b=SbRs7C1F8HOXctggnI0uoc
	ga+mKgzcuDeblCdB0HkiCAe6gMMOlrCWkAosVCepsUdCMqOq7P42HNjUXGwSvbmF
	a3I29MlH0Yjeq93VA5fnudarZlhSK0V0MFggEzVAOS/cQsoPltvzXy7Y7SGwbBzI
	MPyFhz9JElkGeKwJRUjnYZh4fEyEm7ue7PiApBjzMlebHKnDS5FGEfcm1sdd23BJ
	LCCPVfjKjaC41pyN8fmaNAUQ/Dwjtat9pdzfA3C+BC9rmOd82vRT/Fh1jSo25x49
	CGUvtM0vDsEUhp2R4HAe2ylVtkWaR8YRh3yE1bDSonCYrprkSW2A6mdKwmAGujmw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43arwga1mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 21:50:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B4LjbEo001756;
	Wed, 4 Dec 2024 21:50:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43arwga1mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 21:50:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4JKujN023542;
	Wed, 4 Dec 2024 21:50:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n5txj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 21:50:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4LoPxD57672074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 21:50:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31515805D;
	Wed,  4 Dec 2024 21:50:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0006D58059;
	Wed,  4 Dec 2024 21:50:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 21:50:24 +0000 (GMT)
Message-ID: <9350fad8-f0e6-44b4-8e69-a281ed0e849b@linux.ibm.com>
Date: Wed, 4 Dec 2024 16:50:24 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU launch failure with TPM passthrough
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c5776544-235b-47bd-bab7-d00d436db893@quicinc.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <c5776544-235b-47bd-bab7-d00d436db893@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SLjHoWWcGDGmZZR4YQiJ9adf7d32jIi9
X-Proofpoint-ORIG-GUID: bCjNMLPnGcZ_FxKuH4ehBLHSkHZG53Gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040166



On 12/3/24 2:58 AM, Yuvaraj Ranganathan wrote:
> Hi Everyone,
> 
> We are trying to launch a VM’s using qemu with TPM passthrough
> (https://www.qemu.org/docs/master/specs/tpm.html) and
> we are encountering the QEMU launch is failing on below experiments,
> 
> Problem 1:
> qemu-system-aarch64 \
>      -M virt -m 2G \
>  -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0 -device tpm-tis,tpmdev=tpm0 \
>      -kernel /mnt/overlay/Image \
>      -drive
> file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-sx-20241118050754.rootfs.ext4,if=virtio,format=raw
> \
>      -append "root=/dev/vda" \
>      -cpu host --enable-kvm -smp 4 -nographic
> 
> 
> qemu-system-aarch64: -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0:
> tpm_passthrough: Could not guess TPM cancel path
> 
> 
> Problem 2: (experimented based on open source discussions)
> qemu-system-aarch64 \
>      -M virt -m 2G \
>  -tpmdev
> passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/device/cancel
> -device tpm-tis,tpmdev=tpm0 \
>      -kernel /mnt/overlay/Image \
>      -drive
> file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-sx-20241118050754.rootfs.ext4,if=virtio,format=raw
> \
>      -append "root=/dev/vda" \
>      -cpu host --enable-kvm -smp 4 -nographic
> 
> qemu-system-aarch64: -tpmdev
> passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/device/cancel:
> tpm_passthrough: Could not open TPM cancel path: No such file or directory

A possibility is to pass /dev/null in this case. When we start VMs like 
with passthrough in libvirt then we also pass /dev/null if the cancel 
sysfs file cannot be found (anymore):

https://github.com/libvirt/libvirt/blob/dba710374d92688f797bf64642cc0d640c301239/src/util/virtpm.c#L67-L93

> 
> On further checking, it is due to /sys/class/tpm/tpm0/device/cancel
> attribute is not created by TPM driver.
> 
> Temporary Solution explored:
> 
> We made the change in TPM driver to use tpm1_dev_group irrespective of
> TPM version.
> tpm2_dev_group is creating only tpm_version_major attribute while
> tpm1_dev_group is creating multiple attributes including cancel + tpm2
> attributes.
> With this change, we are able to launch VM’s successfully using QEMU
> command.
> 
> TPM HW version: 2.0
> QEMU emulator version: 6.2.0
> 
> This seems to be basic issue with QEMU + TPM 2.0 HW.
> Could you please help us know are we missing any procedure in the QEMU
> steps ?
> 
> If the procedure is good, I shall go ahead to post an upstream patch
> with the fix. Need your comments here!!!
> 
> Thanks,
> Yuvaraj.
> 


