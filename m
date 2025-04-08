Return-Path: <linux-integrity+bounces-5671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FCA80DFA
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0FF4E1264
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE41DEFEC;
	Tue,  8 Apr 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="It7Ln4Vk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3C1D63FF;
	Tue,  8 Apr 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122422; cv=none; b=VesIZ6bxQ+4xNwH/7mHC4oWG/dd34KGsfMr3Iof+jFdF4moIKjIkKHRPnkUJsX1dsVRJkxQjyU5Kp1yWMzswmKsOOm9zNz8BXVijkwhFx6VZ5ZVxf4GMQSudoGHlkktfxlRhVc0cyaTSH/UYTGdQnrWkRiCbRPqGWIh/tMSKia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122422; c=relaxed/simple;
	bh=n3N51Ftxd9J9zRsSJVY/HxCOw38xt1zT3G3cDtkTVUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSu0Hsl8WuYU6ynajUPPuQPYjf3UD4bmktU1dCS+bWGH72dFgeNntaUwviGlrKrgx+5om/Q6MTtYhOvLxBJYKkDPI8GT1L7r5FgOGnM9LZMQepcdoQEqCzl7v/XPTmW/yK6TBjd15lgaQD2ezf0R5MKcrdoxLULtgXurio7lV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=It7Ln4Vk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AkvLe025333;
	Tue, 8 Apr 2025 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TAs+0t
	cGs9Gp50zejQZIViX1uDlyODSQhUTm/49LdbA=; b=It7Ln4Vk+6s7KX1Xivhjr+
	TzpfzRODFAH7A8MHjlTSh7v3E5Z08LKo6/JvRlBgOOVkN27fzWLZioj3BxRghx4L
	f6T/g6ADQxGpq0CbFti75J/WMGZEjkhusMoiRHSz/9968OBGVvQ6zDM0E7HBdGcZ
	FZQrL79MwXCgeTEAaEEap59f1/4fHwUeZmIBW86NERAl2zc2FMMArYSEgQofUD/t
	mdGNd56iS/FFzA9lmr+HI5P9Fope45QtXXu0o19R3hdwvcw7dcH15NZjpuZXZrAh
	aU4XxU7hCnfW7B3zWe29CfqhgJVUeVTgs4+SzRuGVmDK5LsJn1z+utk20X3acifw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnvq423e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:21:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BdA7B011518;
	Tue, 8 Apr 2025 14:21:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yk5db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:21:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538ELVBJ24052298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:21:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE29B58053;
	Tue,  8 Apr 2025 14:21:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9D15805D;
	Tue,  8 Apr 2025 14:21:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:21:29 +0000 (GMT)
Message-ID: <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Subject: Re: [PATCH v11 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 08 Apr 2025 10:21:29 -0400
In-Reply-To: <20250402124725.5601-6-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-6-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LFIZAZOa8Py6A9mi7oxapgfZlsbgYwW4
X-Proofpoint-ORIG-GUID: LFIZAZOa8Py6A9mi7oxapgfZlsbgYwW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080098

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> The IMA log is currently copied to the new kernel during kexec 'load'=20
> using ima_dump_measurement_list(). However, the log copied at kexec=20
> 'load' may result in loss of IMA measurements that only occurred after
> kexec "load'.

Ok

> Therefore, the log needs to be copied during kexec=20
> 'execute'.=C2=A0

The above line is unnecessary.

> Setup the needed infrastructure to move the IMA log copy from
> kexec 'load' to 'execute'.
>=20
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec 'execute=
'.
>=20
> Implement ima_kexec_post_load() function to be invoked after the new=20
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the=
=20
> IMA buffer to a segment in the newly loaded Kernel.  It also registers=
=20
> the reboot notifier_block to trigger ima_update_kexec_buffer() at=20
> kexec 'execute'.
>=20
> Set the priority of register_reboot_notifier to INT_MIN to ensure that th=
e
> IMA log copy operation will happen at the end of the operation chain, whi=
ch
> is crucial for maintaining the integrity of the logs

Instead of ", which is crucial for maintaining the integrity of the logs"
say something like=C2=A0", so that all the IMA measurement records extended=
 into the
TPM are copied."

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>=20
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Steven.  With the change to use INT_MIN, the "kexec_execute" record=
 is
now added to the IMA measurement list, extended into the PCR, and included =
in
the IMA measurement list records copied.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


