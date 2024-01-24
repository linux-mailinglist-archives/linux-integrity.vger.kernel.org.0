Return-Path: <linux-integrity+bounces-870-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59483ACEC
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8341B34E99
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76218624;
	Wed, 24 Jan 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxXRarEr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744D7E764
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107316; cv=none; b=aLZ/BkAqYpoP449m3dfgoLV+SWdf2+lAJ37UEwhPxX1YPPvSs10rc3uxPFQGgWJK+hR0I6e778CbNilirExRNJdi/PVouewV+gZP97FJiJcyc9kqC7Y7IVKOgMGKSEz1G8vGkK4FjWuzciUpO1zc6n0mYT3ZC8n458KD6npTFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107316; c=relaxed/simple;
	bh=B+IpDtGpkH6WmmUJ2N2o3nFsnHEuHCbM+53ACfRGmg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=jrThIRpXV6PJbdLrxpD0rCKJeqS8icd/9sWjZLo12NnNKJws1kXdJENteLczyerUxRQRryasV3zIoDjsOz97GroheMivdtQcb5Io8uD4Jr8WaBvO+z1E+qKP3DDAaPxLajaqT6pcs7kqdd6KCQYrVsQowa4QipNtxzugRhSMByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxXRarEr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEVINV011699;
	Wed, 24 Jan 2024 14:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kUDUI2diuLmgUXW1TbdLkA/b0n6yNko80q1zfHTGvaA=;
 b=RxXRarEru99zJVmVOXTA0Lc6lpW4WPcxyN8wNmkmatELw/Zy82Kta1R0WgBwAkYdrUtE
 bGBPX2XjvrpmnMZlx1+P26vcs2+h6JlycrPSQZw/q2ca1GKAVla9QROQPoOGi3DVVcqV
 /c4twPvTIH45cYCmLgIpjrZsctu1DoA3CEz59GAan9bUcVWXhPJOqoR3cgtL7TOmamKM
 sSofnQi6Xp+jwBBLzyQ0lWsZPNDQUciU6pImt9FwEWxlbB+/2hiaAmHzp7WgrAI3FTRZ
 ouAX1xP2zTjIb/9ymHfWn0XsFlTusddLC5FOcDP0kppOX64Fk5ScYEY7sWbPAuLgbwGk 5Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu4cq04dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:35:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE3h5x025653;
	Wed, 24 Jan 2024 14:35:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgp69r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:35:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OEZSXP32113162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:35:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75E15805A;
	Wed, 24 Jan 2024 14:35:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68645803F;
	Wed, 24 Jan 2024 14:35:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 14:35:27 +0000 (GMT)
Message-ID: <494fc3a82053e71a33bccca3fe6683c59b78b6cf.camel@linux.ibm.com>
Subject: Re: [PATCH v4 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 09:35:27 -0500
In-Reply-To: <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: vsTsSPOGVNndbowt-T3biROb9CxEirDB
X-Proofpoint-ORIG-GUID: vsTsSPOGVNndbowt-T3biROb9CxEirDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240105

On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:

The problem statement could be written as:

The amount of memory allocated at kexec load, even with the extra memory
allocated, might not be large enough for the entire measurement list.  The
indeterminate interval between kexec 'load' and 'execute' could exacerbate this
problem.

Mimi

> There could be a potential mismatch between IMA measurements and TPM PCR
> quotes caused by the indeterminate interval between kexec 'load' and
> 'execute'.  The extra memory allocated at kexec 'load' for IMA log buffer
> may run out.  It can lead to missing events in the IMA log after a soft
> reboot to the new Kernel, resulting in TPM PCR quotes mismatch and remote
> attestation failures.
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
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>



