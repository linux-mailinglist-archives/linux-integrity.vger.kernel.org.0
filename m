Return-Path: <linux-integrity+bounces-6348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7ABAC9788
	for <lists+linux-integrity@lfdr.de>; Sat, 31 May 2025 00:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01E41667B9
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AA27AC25;
	Fri, 30 May 2025 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbVDkgFD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3A2609D6;
	Fri, 30 May 2025 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748642647; cv=none; b=loFE63PcpvOAlAQl/hz7rllsNAijhOx3TYDRQHhJHcoBY6U9JUkbi4rpZwWyQKwEPx3sZwrPkUiyZRkenWoqmnHe081FG/e1QQgNiz5r1bN3i6kq52xyycdPAaNGB4dxBsobMwES/T2kaXv8Q+GhLBQG9ioLG8LWSQHw89wf2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748642647; c=relaxed/simple;
	bh=s1w9Bcs78aaLHN+aqiNcLkh6Ysfh9KIjWttvW5o9N6s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YGpHp135JfR9w4spmBNpsjNmeS3eztcdTQUKivxjrv3fBY8JZX4RN6BUDOjS2NUgkb7EhcswngGvKdjNYlH9i/6hxOqrUFOACNV0OlKFJAZKQKuE4br+ynJ15hVPybHTdxnvHzl+Izz3f+Vt0ncQ91yc42PbCsVu8/zQfO7igkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbVDkgFD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UKiE4R028695;
	Fri, 30 May 2025 22:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s1w9Bc
	s78aaLHN+aqiNcLkh6Ysfh9KIjWttvW5o9N6s=; b=CbVDkgFDDSuoXdLMXGYUE8
	7bi3J8N4VDrWu5oPSSZQbGtom31fJHStsuqiUHczXN1uWeUe9/jFIoXxFwSYikjv
	8MPLdy3VLc09zPXOrWB0nCUguxwb33v0/4/JowIz5TF5wsaGCh3pjTj/VJ/NOVcf
	GvqSD6ngbxlM/qRvdyaKOsaMGYYrBCMP9l0Lxzq0ukmfIJa8+EvzBo06sQygsf/G
	pP58guRLATDOv7IFpXsNlorXy+pLEhjK7EY2SpbASUo1UO5RQN0zLrdN/OwxKRQ1
	gVQurU/ung0lozyZU5LTQhL8tn78gkNSpyXM4Z+X+DPN2ZXBK7XsWKWscl8N1xxg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gx0fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 22:03:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54UM2lRq025801;
	Fri, 30 May 2025 22:03:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gx0fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 22:03:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54UIlhcG026919;
	Fri, 30 May 2025 22:03:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu53k3qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 22:03:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54UM3bYc30278346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 22:03:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28D745805D;
	Fri, 30 May 2025 22:03:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8FEE58059;
	Fri, 30 May 2025 22:03:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.157.60])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 May 2025 22:03:35 +0000 (GMT)
Message-ID: <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250409185019.238841-56-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
	 <20250409185019.238841-56-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 May 2025 18:03:35 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tsgP7vh6WhVDl0kunu51buKQurUhYF8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE5NyBTYWx0ZWRfX1ky5U6F6i9Zf oyHktkmy6MHsWDe81dVLdUU+fMQYtRkc9g/rw5z0uHLpyGuQjLgixaY227oRQDzUvQRd9r2XA5S TCnmdSFX+MbCcGPV0giJkHsAOEapuzIYU6LWbHD2WmkgGm7nN+eirtbE7xl/svyREzUDIQGuT9G
 TINGSd0Y13KdVohtU62QVVPim7MjybKA1zOY7tC/IM+DsMBsjbcuANyNvSktSNKV3WpdMpS2StX YcFwxkGpFegP8h8Z4Gt5g/juMCCof/aZ4okyTWo+EDIyeNpoRxnDfJxenUMRnR2Z+9nbyn5xjfc DQljZAv8M+JjDdINca238UkWd7NI/LCqA1TiycCIzmfBde2YNac7vtEP67IIntCYDiUkDApblqy
 rvg87V8VHzbNdZHjgSVFeyOs3EjDhZdGd5rIRBtdLMrW//lMkzbsrEnJpCYb3C5biVH3gDTw
X-Proofpoint-ORIG-GUID: Hx40OjmTH3wUWazzBIKhE12YMIqrWnAr
X-Authority-Analysis: v=2.4 cv=UflRSLSN c=1 sm=1 tr=0 ts=683a2b3b cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=XALlg6NdOko_BaNf98IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_10,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=839 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300197

On Wed, 2025-04-09 at 14:50 -0400, Paul Moore wrote:
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism.=C2=A0 There were two challenges to doing this conversion: the
> first simply being the number of initcalls across IMA and EVM, and the
> second was the number of resources shared between the two related,
> yet independent LSMs.

There are a number of the initcalls under integrity/platform/, which load a=
rch
specific keys onto the platform and machine keyrings, which shouldn't be
included in this patch.

>=20
> The first problem was resolved by the creation of two new functions,
> integrity_device_init() and integrity_late_init(), with each focused on
> calling all of the various IMA/EVM initcalls for a single initcall type.
> The second problem was resolved by registering both of these new
> functions as initcalls for each LSM and including code in each
> registered initcall to ensure it only executes once.

With the above change, there obviously will be a lot fewer initcalls, but i=
t
might still make sense to keep the common ima/evm function.

Mimi

