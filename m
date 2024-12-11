Return-Path: <linux-integrity+bounces-4350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE39ECC24
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 13:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD228295B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A61229134;
	Wed, 11 Dec 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DljNplhp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CF238E23
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920597; cv=none; b=f8GgqIYr0Z6R/DTjTgYiiONf4h8r3o4Y2K6tEnlkoXJQTDJgV4muI0ej+GHuc+RyzZKnjfIQqcIlyp6jOps4vJDIRIMCG6vxF9zVJcj8jgkgq5Tkn+rSW3pSlf9TezH0OmOb6JAQOXzw+60vGf/bl+KeiIQI9v7UdUCZ2hofwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920597; c=relaxed/simple;
	bh=2QWjvMWlAvOZgtL9Gcgr5khcSNDksxdxj1U4OoYJokg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYcJyy8+Oq4dOCs3vWm0YNK+2vJ+4dfHV+G5AZeE8wCk7bD22JMILqnB4hTb3qmwUGRnIoz7cymTASADOr9AZTcDa+CfsApF+gULMSzom74CXb/brG0D2UQn+E5YQSmJB52lL0vvWfdhgfKwle/UgUYZvXIi1C/RhKl5MQL05oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DljNplhp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBI4ML003958;
	Wed, 11 Dec 2024 12:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2QWjvM
	WlAvOZgtL9Gcgr5khcSNDksxdxj1U4OoYJokg=; b=DljNplhpJHSKKEE2Dgquoz
	0H76S5iTz92bgY6HXcG68WKgc7sG1CMQj8dKeJhUFNaiGLEVXO42ddTWV6PQTjnE
	vzXlyEN74DpbrzWsnA2zh9cmis3+dz+f0DlTS02x9BOdlcNWAgpLy6W6JDQ39UXj
	0xyW8MJYEMBd9svGoNmYPjj0Y3RuINoBIxfEvRsDKcx2MIoBrWB4i+5as8GmvN7x
	ilxLZH4R5Ror5cvx0p8E80oa+tl0R2+5tBp+in04Q8AVPlKeyREPZO4W0rho7c3u
	r5jjASWnlEH2IIW2ShQPjMONAV8xCm4RsJDo8gowvlWs1YWIlBUDWmJxYmFPBhUg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xm187-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:36:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB9brVf032589;
	Wed, 11 Dec 2024 12:36:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn9ddk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:36:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBCaTTA29295308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:36:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB11158059;
	Wed, 11 Dec 2024 12:36:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79F8058053;
	Wed, 11 Dec 2024 12:36:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.71.1])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:36:29 +0000 (GMT)
Message-ID: <b6464e2c5c0195ffd882e6cc484b2f12e7383349.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] ima_{kexec,keys,selinux}: Set minimal kernel version
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Wed, 11 Dec 2024 07:36:29 -0500
In-Reply-To: <20241126173830.98960-4-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
	 <20241126173830.98960-4-pvorel@suse.cz>
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
X-Proofpoint-GUID: ZdNj9DrtCNVPZkmotR9V-85r0AEK5Gjz
X-Proofpoint-ORIG-GUID: ZdNj9DrtCNVPZkmotR9V-85r0AEK5Gjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=878
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110091

On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> The functionality IMHO was not backported to the enterprise kernels.
>=20
> This helps to avoid false positive in ima_kexec.sh:
> ima_kexec 1 TWARN: policy not readable, it might not contain required
> policy '^measure.*func=3DKEXEC_CMDLINE'
> ima_kexec 1 TBROK: unable to find a correct measurement
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

