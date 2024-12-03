Return-Path: <linux-integrity+bounces-4274-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A69E14EA
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 09:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2D164AC3
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916E1DE3A7;
	Tue,  3 Dec 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MWSNHbyT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90011DAC9B;
	Tue,  3 Dec 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212695; cv=none; b=E+hxWsrBcEEI7wBNisjG81KTZwNkD9H/SPwRPgMluPTVkEJnpVv92m7CB1P6fPMeDsSGlu2QUzrq5u7bdNXQJIdL3QkGqYLcVNrnXrYkVsQnmGdqQfQt6oIR6weWX402OIhzdybiHOkFTDAlKymbDMW9HyhlM2pM5E2zeXldzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212695; c=relaxed/simple;
	bh=LlAMOkFBWltyk8d13cDz4Chrf+wL/mxVKWgO+2b0Z+E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PDeG6f72auF+XNnMaq5ZmRf41L8XLLJEG+lKs7oX1CjBfmmWRYA01nSMJXmc7VmncX8VsPRkL7sGbHeLgRTTQsovdYm9Q6arv7dbfoGErU9vuI5jedvm/F6iHGl397m+LXU1HJFDDvC2s5pqHERxBKXcb5qUbysq8cuOIJP1ibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MWSNHbyT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JQCjs021372;
	Tue, 3 Dec 2024 07:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yuRrjyJ0isQXXOueNN03As
	MDhQuBXNE367Q7Ha7DMH4=; b=MWSNHbyTE712Rr+v6wd0pKmixSfbzr5SUlEVuT
	m/6+kuCBJA5iFuSrpIVC1GSQIp9rM83ku8CxU5nz+s4oZt8w+H9jYr26EJeNGQRc
	VsTFk6r48x7mir11jALA8GY+sNZeQqx+1AYaX6F2ofkLPFbqUU3h7GW0nY7NW4XE
	cxVskgvU/pLatPWSpl5MdzN8Cjjz48H8HpzxcAiNlR3bCqgCqq4v2xWpje3bfZGr
	EDOno8yp2TA/CIrIYTACXNNXmCfhFzpM6PHVfDdPWFGVprDa6afdC2iS9/RFASme
	VwoRiET5tJ0RvrLElb2xLuzQCcaH0CA6wT2uXAn8PJr9ThqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ufe7810-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 07:58:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B37w74C030608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 07:58:07 GMT
Received: from [10.218.0.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Dec 2024
 23:58:05 -0800
Message-ID: <c5776544-235b-47bd-bab7-d00d436db893@quicinc.com>
Date: Tue, 3 Dec 2024 13:28:01 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
Subject: QEMU launch failure with TPM passthrough
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Ex58Sr52x0azX7Mmh8CY5HmXcPYUwny
X-Proofpoint-GUID: -Ex58Sr52x0azX7Mmh8CY5HmXcPYUwny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=989 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030067

Hi Everyone,

We are trying to launch a VM’s using qemu with TPM passthrough
(https://www.qemu.org/docs/master/specs/tpm.html) and
we are encountering the QEMU launch is failing on below experiments,

Problem 1:
qemu-system-aarch64 \
    -M virt -m 2G \
 -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0 -device tpm-tis,tpmdev=tpm0 \
    -kernel /mnt/overlay/Image \
    -drive
file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-sx-20241118050754.rootfs.ext4,if=virtio,format=raw
\
    -append "root=/dev/vda" \
    -cpu host --enable-kvm -smp 4 -nographic


qemu-system-aarch64: -tpmdev passthrough,id=tpm0,path=/dev/tpmrm0:
tpm_passthrough: Could not guess TPM cancel path


Problem 2: (experimented based on open source discussions)
qemu-system-aarch64 \
    -M virt -m 2G \
 -tpmdev
passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/device/cancel
-device tpm-tis,tpmdev=tpm0 \
    -kernel /mnt/overlay/Image \
    -drive
file=/mnt/overlay/qcom-guestvm-image-qcs9100-ride-sx-20241118050754.rootfs.ext4,if=virtio,format=raw
\
    -append "root=/dev/vda" \
    -cpu host --enable-kvm -smp 4 -nographic

qemu-system-aarch64: -tpmdev
passthrough,id=tpm0,path=/dev/tpmrm0,cancel-path=/sys/class/tpm/tpm0/device/cancel:
tpm_passthrough: Could not open TPM cancel path: No such file or directory

On further checking, it is due to /sys/class/tpm/tpm0/device/cancel
attribute is not created by TPM driver.

Temporary Solution explored:

We made the change in TPM driver to use tpm1_dev_group irrespective of
TPM version.
tpm2_dev_group is creating only tpm_version_major attribute while
tpm1_dev_group is creating multiple attributes including cancel + tpm2
attributes.
With this change, we are able to launch VM’s successfully using QEMU
command.

TPM HW version: 2.0
QEMU emulator version: 6.2.0

This seems to be basic issue with QEMU + TPM 2.0 HW.
Could you please help us know are we missing any procedure in the QEMU
steps ?

If the procedure is good, I shall go ahead to post an upstream patch
with the fix. Need your comments here!!!

Thanks,
Yuvaraj.

