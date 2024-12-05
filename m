Return-Path: <linux-integrity+bounces-4292-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC69E51FA
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED09C1674E4
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEC18D622;
	Thu,  5 Dec 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NzowN2fo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8E194C6E;
	Thu,  5 Dec 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393989; cv=none; b=rwDndqdpXmS3jBWE/JXx+ZbW8MaB2PHCOf00IG4r/0SIiEVRryKdfvTDWuogJo2asxKulte1yKmuP8aS5mtXhk56F4s1DeDaoWxFBuFw5wRch5Bt1fIxXoE36BImdCmpRBm3gsaOO9TtRObvRz/6plEoXRgs2+92ztJ+iYfbZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393989; c=relaxed/simple;
	bh=xPmF8sCE9+YUleQYaoUbqBMUANXA8Rm2na9QQFkcZUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gW0cbIFfdIRUTegBs3OHRVZHQ5YvwfpfOpKohMgOWUWVB0yfq/bpNEj6CphkcZCBpbVwvkQbnfpRQfoHg6ngJoURXI6hbxM/xZAVsTmG3gk8uP/v2E2uWqJHRvPHyy0QT3Q/MWWvDwnKOS/LxurTxY9n+8Z8jE0xP68eRtNghxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NzowN2fo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57Tgin005905;
	Thu, 5 Dec 2024 10:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NJf/Clhu2D8nxTnU/1zK4WNQtqRHz6bsGaMjOMTsliw=; b=NzowN2fowzHvdEwu
	SgHzWdUIkHUqUDFmDGColE3R869TVTLRbnsfGG2/BCztE03z2RxsY4AfTlp8drVI
	zKDP4OABFDzS2E0Ho9IEkOEsQ0CbD/SSl8a37llssvfrCg64bz2SPzGbW2Pb1PBA
	UEwvvIcIixvLkon/f1Ff7aHxm8/B5+kOzehVU4QASnMLzEwyHuESw3Lh7U+k9Usy
	SRf6+v7zOy73Dcswa1lZBYb7jBBXB1CmeeNaWsuN0r1V/DFp3TJ84RRE/uLW0+cF
	c0bBvIQdhLKLVlgYtPBW3CrNXy291LWzj1H8qK3T9fpklTB+dysf2KHEChqMnxKv
	6qwBdA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3eq6ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 10:19:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5AJdNk023553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 10:19:39 GMT
Received: from [10.217.238.57] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 02:19:37 -0800
Message-ID: <14410f36-17fc-4dc6-9a00-80d0af775a27@quicinc.com>
Date: Thu, 5 Dec 2024 15:49:34 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU launch failure with TPM passthrough
To: Stefan Berger <stefanb@linux.ibm.com>, <peterhuewe@gmx.de>,
        <jarkko@kernel.org>, <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <c5776544-235b-47bd-bab7-d00d436db893@quicinc.com>
 <9350fad8-f0e6-44b4-8e69-a281ed0e849b@linux.ibm.com>
Content-Language: en-US
From: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
In-Reply-To: <9350fad8-f0e6-44b4-8e69-a281ed0e849b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S-uNxnGiBEjsMAGaNyYzikGyxU2pk7IG
X-Proofpoint-ORIG-GUID: S-uNxnGiBEjsMAGaNyYzikGyxU2pk7IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050073



On 12/5/2024 3:20 AM, Stefan Berger wrote:
> 
> 
> On 12/3/24 2:58 AM, Yuvaraj Ranganathan wrote:
>> Hi Everyone,
>>
>> We are trying to launch a VM’s using qemu with TPM passthrough
>> (https://www.qemu.org/docs/master/specs/tpm.html) and
>> we are encountering the QEMU launch is failing on below experiments,
>>
>> Problem 1:
>> qemu-system-aarch64 \
>>      -M virt -m 2G \
>>  -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0 -device tpm-
>> tis,tpmdev=tpm0 \
>>      -kernel /mnt/overlay/Image \
>>      -drive
>> file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-
>> sx-20241118050754.rootfs.ext4,if=virtio,format=raw
>> \
>>      -append "root=/dev/vda" \
>>      -cpu host --enable-kvm -smp 4 -nographic
>>
>>
>> qemu-system-aarch64: -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0:
>> tpm_passthrough: Could not guess TPM cancel path
>>
>>
>> Problem 2: (experimented based on open source discussions)
>> qemu-system-aarch64 \
>>      -M virt -m 2G \
>>  -tpmdev
>> passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/
>> device/cancel
>> -device tpm-tis,tpmdev=tpm0 \
>>      -kernel /mnt/overlay/Image \
>>      -drive
>> file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-
>> sx-20241118050754.rootfs.ext4,if=virtio,format=raw
>> \
>>      -append "root=/dev/vda" \
>>      -cpu host --enable-kvm -smp 4 -nographic
>>
>> qemu-system-aarch64: -tpmdev
>> passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/
>> device/cancel:
>> tpm_passthrough: Could not open TPM cancel path: No such file or
>> directory
> 
> A possibility is to pass /dev/null in this case. When we start VMs like
> with passthrough in libvirt then we also pass /dev/null if the cancel
> sysfs file cannot be found (anymore):
> 
> https://github.com/libvirt/libvirt/blob/
> dba710374d92688f797bf64642cc0d640c301239/src/util/virtpm.c#L67-L93
> 
>>
>> On further checking, it is due to /sys/class/tpm/tpm0/device/cancel
>> attribute is not created by TPM driver.
>>
>> Temporary Solution explored:
>>
>> We made the change in TPM driver to use tpm1_dev_group irrespective of
>> TPM version.
>> tpm2_dev_group is creating only tpm_version_major attribute while
>> tpm1_dev_group is creating multiple attributes including cancel + tpm2
>> attributes.
>> With this change, we are able to launch VM’s successfully using QEMU
>> command.
>>
>> TPM HW version: 2.0
>> QEMU emulator version: 6.2.0
>>
>> This seems to be basic issue with QEMU + TPM 2.0 HW.
>> Could you please help us know are we missing any procedure in the QEMU
>> steps ?
>>
>> If the procedure is good, I shall go ahead to post an upstream patch
>> with the fix. Need your comments here!!!
>>
>> Thanks,
>> Yuvaraj.
>>
> 

Thanks Stefan, this suggestion worked.

Thanks,
Yuvaraj.


