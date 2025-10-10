Return-Path: <linux-integrity+bounces-7413-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84ABCC832
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0701A64F94
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2F2820A4;
	Fri, 10 Oct 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fbOvu/jg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A7222587;
	Fri, 10 Oct 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091653; cv=none; b=SEJZIgtmAYB2a7feskDAkzBTe4P1HTMo8u/mrHyuxOcwfHEnudren9wmEYL/o9Hx2DfSIvxahoy5dtffGWex230vWVWo47BZBL/9q6YiRfj6/TElgSI5tSOsZ/rVy0nRDk2IW6acUIKNikLKPDdO9S6qwKv0l6XGV+EgC757UK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091653; c=relaxed/simple;
	bh=RfDIbzmHORuPQ7x+twSNjgIFTI/HQane1QLV/KBiIXs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ZqDq1+8VKDqZUbAYyxbtxsd50Sfmwu95zWIHPlrCL77pRLYcbhgCDzkFVCY4SQAddOnKI1rfX/9k+8ksm+Iez1gKDzUidvNtPJ/mWeyzmW1rACir28+EFD9Pxt/XsKwmYYdoNZ2PvBFlO0L4mF/e7YZiek94f14GCAVwY6IRnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fbOvu/jg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A0T7Kk014342;
	Fri, 10 Oct 2025 10:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RfDIbz
	mHORuPQ7x+twSNjgIFTI/HQane1QLV/KBiIXs=; b=fbOvu/jgyiVe95cgXUWx+N
	kpiw3gSBPZo8dCawxYcuJABatZPSYiBsrX1UD2YPhsTLvHmN6PI14rGT1Rka+YDi
	HxliG7PnixSe3O0GpTpx22TGV54W9diyfEQZz+16AB5L1Ep4/wqfT6dBR6OiB3Hb
	KSTGPBPS1qPEX9uXd+Sx9tuL1SYOOyWmEeipw/fazssIhNXlpEC2gAt1eHvIFnHP
	qetEhjq9ASkUSYpRWBODtVUvb0JJWYAztOhIofSljV1aorR2K6X4xISb7af+1S97
	8QYjYMovb+j9PhSiIfW5WKxmnRo6qIgqkLIYDsIEwcCFvgKl9QaHQj1G3lvszOMQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84sxee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 10:19:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59A9oqP7008218;
	Fri, 10 Oct 2025 10:19:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84sxea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 10:19:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A7wfCn020946;
	Fri, 10 Oct 2025 10:19:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9n1aqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 10:19:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59AAJioU10290112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 10:19:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F61558063;
	Fri, 10 Oct 2025 10:19:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFCF65804B;
	Fri, 10 Oct 2025 10:19:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.74.244])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 10:19:42 +0000 (GMT)
Message-ID: <5cd2d13f3ac7a871d70375ec176df00ab0786760.camel@linux.ibm.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
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
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-67-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-67-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Oct 2025 06:19:37 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e8ddc2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=xVhDTqbCAAAA:8
 a=VnNF1IyMAAAA:8 a=j8Nl3lPmHPPwVPSWmsIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=GrmWmAYt4dzCMttCBZOh:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xEnxsZNCPH2fMBvt38vEVHi74iU4vocZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/0E1I/iobhbf
 jbRu9aZEonXbule3FhHvFpa6SHhp6u/a+9UC+vY/37DQQq7RAfDDJXPU7Pz1+3aW9j+OkOQcfTj
 628BZILxX0rJGHG6TXPXcW2aCZ7/PNGgwQ+TDhkKk0/idvFPK8fUYruvMzTFzcqDBYVEv1WDdbj
 3GX7TpS2sf9NY4UUjLGKXPJGgqJ6SWfsZN4t7W1SYKE1awszSUdPkjWSWLtrCa6A1ULmiJJ6D3u
 MmP5hbK41E9xpvPeQ/iRZbZ3vlLItvFTR/t8Es97MYHFPDMquKsSfQmzjFJl2sHwjUVioC9+7wF
 0Zlnm6stLAhlrbCDweuJnJxTNlrn0FTDMP6bqydkbNIVToHw4ayBn5Km07Dt0DZY8+/Tedk50bN
 nZd3r2oScHwd9nRbrP/yRcW6AJvBIA==
X-Proofpoint-ORIG-GUID: dGARr7QtCUdkereyPYL-XuvYoqC46r1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>=20
> This patch does not touch any of the platform certificate code that
> lives under the security/integrity/platform_certs directory as the
> IMA/EVM developers would prefer to address that in a future patchset.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> [PM: adjust description as discussed over email]
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


