Return-Path: <linux-integrity+bounces-4691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3626A2601C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794FC1887F96
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB32046BF;
	Mon,  3 Feb 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RTWYSVid"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8020AF80
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600304; cv=none; b=IV+SalriKyliWrRXGihPT30sokgcIIYE4GQBaxJ2sWeiHkXAfvGcnTKtQ1oeCmep/DCugwcWe2TYggoibAKK3mkh/ki+9PiPVRMfY0Oov/5n8S5zRkYVjPqBVkc9GU243yA0Wy45ybWbbRiT+85F+SbUvoCMldag2w9/g0GjNB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600304; c=relaxed/simple;
	bh=8ninUaP7Ur5ud3unUnrfpJo3vM//1pdO7UrkyiYt7cg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ir3Bw1XL3Cg5WT6sP0s/LtMXJkiiSWPIMJ4fbZj/pEmifTB0n2e4l6utRxXZr4VMvAWTg37MyKSa/NwJNN8EWjQd9MgMilqojY7IqTeWJ7ck/Don8w2652gAHUyNXMvxrS64HbDMNVXhO0NjMKg00ejw2vPsxQ+uFcZn+RFLGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RTWYSVid; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137WuCZ014569;
	Mon, 3 Feb 2025 16:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U+2+3C
	YO4cJ9IUa+j/NrGC7uuUK+CXz36ht8K6d8ygg=; b=RTWYSVidEFFG6/79GLIa8E
	vXwTG+S3RdZLUDo7otR+xudxYIB+LSw3yKva4Jn+tSpYgH/3y1mOjKzwLDZO+NTM
	TDsb/qKLSlaEXrv6gTERixK6ovmgwaylVs2HdF/eg878sBD0mqIHDupg3hd1ZQFG
	y39sDoZHwhoPJF2iE5DmqM1ERo7qhEPk+aYOzYohsYLOtVtmaibzl+CvxhhOXeIp
	MFU6rpFiq59OhVCMrGtVSzB+H0T3DRIkH0pjE9azl0ZfBw/RKO2OuR5cBpVs8glW
	TrXwM+iKrUluVI4Ww6wPeR+eBLhwOVsGgMJA8KMkoITbAr+KHiyXkfrJkFvSu7uQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnjffh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 16:31:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Cv66W005254;
	Mon, 3 Feb 2025 16:31:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jq050-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 16:31:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513GVZHw22544778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 16:31:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3745805E;
	Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 697A25805A;
	Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.5])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Message-ID: <44b924ca0fde4c916eba8a98551e44a65072d2e2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 08/10] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 03 Feb 2025 11:31:35 -0500
In-Reply-To: <20250114112915.610297-9-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-9-pvorel@suse.cz>
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
X-Proofpoint-GUID: 6J2nfkXEeQv3qrNB3ZDUHerzpdJ-vZXi
X-Proofpoint-ORIG-GUID: 6J2nfkXEeQv3qrNB3ZDUHerzpdJ-vZXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030120

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> environment variable LTP_IMA_LOAD_POLICY=3D1 tries to load example policy
> if available. This should be used only if tooling running LTP tests
> allows to reboot afterwards because policy may be writable only once,
> e.g. missing CONFIG_IMA_WRITE_POLICY=3Dy, or policies can influence each
> other.
>=20
> Loading may fail due various reasons (e.g. previously mentioned missing
> CONFIG_IMA_WRITE_POLICY=3Dy and policy already loaded or when secure boot=
 is
> enabled and the kernel is configured with CONFIG_IMA_ARCH_POLICY enabled,=
 an
> appraise func=3DPOLICY_CHECK appraise_type=3Dimasig rule is loaded, requi=
ring the
> IMA policy itself to be signed).
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good.  Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


