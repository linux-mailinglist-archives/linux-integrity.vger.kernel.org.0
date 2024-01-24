Return-Path: <linux-integrity+bounces-871-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4F83AE19
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 17:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAEE284FB6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F57C09A;
	Wed, 24 Jan 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iuvUH/UB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EA7CF08
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112735; cv=none; b=bFkhHwZvFlht31dLcf+A/fBdPRwTpq/PM057ZP9pDN1ni+biOMGmKFFrQHvehDVhqW3OpPcMuQT2PH1emeuk/ngRlvtZzcdJqXD3rUaLMfkrNJ/Vu3iyJ7ue2rxGceYOK9324TNcT7A8FK06Mtjo+IT4R3HNpjsdnniuNjJ/Bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112735; c=relaxed/simple;
	bh=mYxIzHgC3JFpJsysgQdTMx127wC/o0dKlAc6ez8dhOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=JmSLNUNyKZDhT69ltrK1qm4jAnDeSng8mlg+e/LbNyzO4lWzmc4AXnPPLAHptO+Oed3snxXzE73uPdaAhGu9UpHEn3sQjx+9lb9A60B0SnBPkxC54UzAHgtUgpNlILjb6CBsgCTJlseK4XyWcJiz3YaKR0pAIIeAa78wdBcbLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuvUH/UB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OFsxC9020401;
	Wed, 24 Jan 2024 16:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZteOR4YLgf3AB6WQNvcVC14ZS3fMnYJeEjVryHa/6/Y=;
 b=iuvUH/UBHwt7X+sm8UgHNNGCJajDCqvDbl2ZmXFgG0M83Zx/OhkoWUUdZYTsUUxnQjEf
 ld3dxv1XXfcpOUfSc7WawGS9kd2Seo5FRksjxr/sxcCdRsgLaYLYbEcjTximXhFX8zPL
 k5+hRJ4Pd5Y1cJzaOLZMRUm44gM8v7sJ0SK77StP9K5mydxf1qzR/o++HOhhCJXw3RqD
 L7Onm8OHBypWHTUDDcwervpnBCh93MR7l0jbuS2qNY59pcicjqSUuSif8IY+NkAntOqr
 5mUdkyiYonKDlu3X/ehPSyHjtAvhTfA4wtG4GQIP1eYJONt4YULPZpFFsYLULpv0egvf 6A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu59b16hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 16:11:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEr6rl025285;
	Wed, 24 Jan 2024 16:11:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkeexm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 16:11:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OGBAbX32113400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 16:11:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 839D258060;
	Wed, 24 Jan 2024 16:11:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FDAC58056;
	Wed, 24 Jan 2024 16:11:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 16:11:09 +0000 (GMT)
Message-ID: <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 11:11:09 -0500
In-Reply-To: <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: U-lA8UUCvXvhgjlyet0hRQgmeGsrr01_
X-Proofpoint-ORIG-GUID: U-lA8UUCvXvhgjlyet0hRQgmeGsrr01_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240118

On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs
> to be called during kexec 'execute'.
> 
> The below changes need to be part of the same patch to ensure this
> patch series remains bisect-safe by ensuring the IMA log gets copied over
> during kexec soft reboot both before and after this patch.
> 
> Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
> Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
> ima_update_kexec_buffer().  Make the necessary variables local static to
> the file, so that they are accessible during both kexec 'load' - where
> the memory is allocated and mapped to a segment in the new Kernel, and
> during 'execute' - where the IMA log gets copied over.
> 
> Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
> after the new Kernel image has been loaded for kexec.
> ima_kexec_post_load() will map the IMA buffer to a segment in the newly
> loaded Kernel.  It will also register the reboot notifier_block to trigger
> ima_update_kexec_buffer() at exec 'execute'.

This defines two new IMA hooks - ima_kexec_post_load() and
ima_update_kexec_buffer().  They shouldn't be hidden here in the move of copying
the measurement list from kexec load to execute.

If "ima_update_kexec_buffer()" was initially defined as a stub function, the
infrastructure could be set up ahead of time.  This patch could then be limited
to just moving the copy from kexec "load" to "execute", by replacing the stub
function with the real function.

> Modify kexec_file_load() syscall to call kimage_file_post_load() after the
> image has been loaded and prepared for kexec.  Call it only on kexec soft
> reboot and not for KEXEC_FILE_ON_CRASH.

-- 
thanks,

Mimi


