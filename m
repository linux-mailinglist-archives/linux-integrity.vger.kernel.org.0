Return-Path: <linux-integrity+bounces-5007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CEFA48361
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B03B747A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2026E620;
	Thu, 27 Feb 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BW+CAklg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7C26E650;
	Thu, 27 Feb 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670933; cv=none; b=WsCg6cVl7nnV3UNz4cFD3Nz059KD6OL3+oO/N2Dn6YeeWQ4yxvpTblfVEFJryCWT3fjGHbrp3REqb4zM8VkLIZ/w38wohLWfdsXff+rIYrVK+RMmDMIneBoznq9GIh5gS2UR1ow7bxPPQiG1hCV27VpLwoInief8GYD2M/EAXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670933; c=relaxed/simple;
	bh=3jpunIAT4e3NlXpAl9K6jRlP/gp2ZIZ0EvV0Gf6zwGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMzWf/07V4HxPFHHMHQth5/Xw6PcdLD0Ez/goSb6vmhCxnAp9ElwOiXrVx8SE+2Ns13m2Ep9XSI9xiG81doE+6v+ZoFhqfmS9vUtDwtnFxFeYFIPo07u+6hMCmE6aX5D3I+8f6RR507Y80FmscGVQQclBXA6Ix1ml42XMhz5dtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BW+CAklg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R7X61p018108;
	Thu, 27 Feb 2025 15:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b+Bxbc
	Zny328vBDeBNuKHl0X5uSvYbJu041HX++8d1c=; b=BW+CAklgFMbwmvwJ90u4Cz
	mGP1D83BRyX61YNQHEY8kV+H6JQ4YacQTXeG1c78yGqs8Q3t8c4FQxCgveayhtBh
	9ZJZ8RZEEiva0HfPWBq4mzbjMOf48a9btMSLgtbkPEoi5y/krwOYVAXlGseySA9z
	pwc4FBoJyKXqcYFAxvQn6gEL7ZK2r2znBEHlNi2NXE9oiyfOo8Bylf1Ow39QxrQ3
	NgzCQFh5Dg3TsF7aUbQbKt00lieJXTHChOzoOyRJhifPbGl9mDMq98ZcIo2oIsmc
	S8RoG4cXl+NA0GQqti70Z7ySNzmWTR7a7hqMsbTuPBVUyLLXLGiE6ccvzHXL/IaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpab3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RFZC10020841;
	Thu, 27 Feb 2025 15:41:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpab3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFOYFd012131;
	Thu, 27 Feb 2025 15:41:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9ysjqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RFfeVx8782300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 15:41:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC38858045;
	Thu, 27 Feb 2025 15:41:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E248458054;
	Thu, 27 Feb 2025 15:41:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.182.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 15:41:38 +0000 (GMT)
Message-ID: <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com,
        Mike Rapoport <mike.rapoport@gmail.com>
Date: Thu, 27 Feb 2025 10:41:38 -0500
In-Reply-To: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
	 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
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
X-Proofpoint-ORIG-GUID: Ch4kdlH88UqRX1-HCo1ZOA_UlxSUa3fp
X-Proofpoint-GUID: 91rmgt_eP3x3zo_lmBXUAyyK5DSmDO87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270117

[Cc'ing Mike Rapoport]

On Mon, 2025-02-24 at 14:14 +0800, Baoquan He wrote:
> Hi Steve, Mimi,
>=20
> On 02/18/25 at 02:54pm, steven chen wrote:
> > Currently, the mechanism to map and unmap segments to the kimage
> > structure is not available to the subsystems outside of kexec.  This
> > functionality is needed when IMA is allocating the memory segments
> > during kexec 'load' operation.  Implement functions to map and unmap
> > segments to kimage.
>=20
> I am done with the whole patchset understanding. My concern is if this
> TPM PCRs content can be carried over through newly introduced KHO. I can
> see that these patchset doesn't introduce too much new code changes,
> while if many conponents need do this, kexec reboot will be patched all
> over its body and become ugly and hard to maintain.
>=20
> Please check Mike Rapoport's v4 patchset to see if IMA can register
> itself to KHO and do somthing during 2nd kernel init to restore those
> TPM PCRs content to make sure all measurement logs are read correctly.
> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)

Hi Baoquan,

I was hoping to look at Mike's patch set before responding, but perhaps it =
is
better to respond earlier rather than later with my initial thoughts.

The IMA measurement list isn't stored in contiguous memory, but has to be
marshalled before being carried across kexec, and then unmarshalled to rest=
ore
it after the kexec.  Roberto Sassu has been thinking about changing how the=
 IMA
measurement list is stored so marshalling/unmarshalling wouldn't be necessa=
ry.=20
Making both this change and using KHO going forward would be a good idea.

However, that sort of change wouldn't be appropriate to backport.  So the
question comes down to whether being unable to attest the measurement list,
because the measurements are copied too early at kexec load, but the TPM is
being extended through kexec exec, is considered a bug.  If that is the cas=
e,
then I suggest finish cleaning up and upstreaming this patch set so that it
could be backported.

thanks,

Mimi

