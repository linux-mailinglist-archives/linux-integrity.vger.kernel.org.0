Return-Path: <linux-integrity+bounces-7033-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B800B49219
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B793717B22D
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709930AD09;
	Mon,  8 Sep 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0sZgex0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115AF4F1;
	Mon,  8 Sep 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343220; cv=none; b=VZVZ3Gp2l2kwccgpU4+K0rAWVoqhEymnMD0KwgBvbR51IbvxAi0MX/xMi+y7fv28qGouFc6C6m3t1MTMbpS2nDdc8lTPMSabIyExCWVMbRSCW1Y8epT0PHW1TCg1Ure3W6Xk5JpZP1zQqgTH2Cih2xbS/wIKm+P+KRkNb0qNxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343220; c=relaxed/simple;
	bh=4ejeLhZ6tG5k/CAQk8S8fF5V4jQskUGzKNkhFGcv3xo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UZI8y4u6tcwBXe+L7KP6/TsTRv7bXJu58laZdNQkxT8fjfnsEvfld26rGgU5ea/+hImHnUYAPimWpcGJwTRUyp6bGWR0UcZyqgtQSx79dtGYGPFCcjOlMdJzod1dfaSaxsAj0Lhll7X/mk+zKab3qj/SOhmTpuzMmp9078xaO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0sZgex0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588BXErN009608;
	Mon, 8 Sep 2025 14:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jvlbpr
	Waq3FVs5LaKh8dQji8AHiVaMt9q3PcZwfUrLk=; b=H0sZgex0NzlHbcsy8InDsX
	dTEdcs+9/NhS56zKI3C+aUN9xADydlxM6T+6Qb8BMg+Fm0jsfygFTxzbLfe5q1AB
	cxZy9Cvtp5Wm5nASHxsHiFxyu9/Js/E/3NdVz3CbEvhG0M6lpUGMB3DlJd/Y7GhR
	nEUrQnlehlUlV8y3G2OQ4JAEYMxLk87g2ghODxN9nhdo12FWooRbiEARqTk2CHLl
	EFd8LFvDtkqIYqVfDjXJ5HqzTCAhP1ihqERYwLCQSRBHjdnh84MB1fLL2IakYgxS
	RgVF0erfNv+1GSOkpipo907J4cRadrb6k0ao0ON1a6rvxZVJerq1Be2JyHAfMQJQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff26cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 14:53:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588EmH3v007957;
	Mon, 8 Sep 2025 14:53:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff26c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 14:53:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588CgNhV007895;
	Mon, 8 Sep 2025 14:53:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pem43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 14:53:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588Er5tb15925792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 14:53:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0157F5805A;
	Mon,  8 Sep 2025 14:53:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E6ED58051;
	Mon,  8 Sep 2025 14:53:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.92.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 14:53:04 +0000 (GMT)
Message-ID: <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	
 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
References: <20250902042515.759750-1-coxu@redhat.com>
	 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
	 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Sep 2025 10:53:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nCth1x5t4Ggujz5ZK94I6HudKIYhfAv8
X-Proofpoint-GUID: S2B6xdoBFwUWmzAOdF2f1yTmkOYzfUm6
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68beedd3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=iol2u-jmQgTjznvq4PsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX0USws6mBdETW
 DPf4UiNAqPLj+yGOXQeXrfQqkviTrOlDazWiSygyB7CoXOoRH0dX3J5+R905oMa4KAserwdnkQx
 fb+8Jiowb+US7SHk6BgfMGxqAVsMAlyRRBx+/diy1fONCNgz82PbXtflja0/6pAlAjqMQcAUiuo
 m0YI5KtFmLDgQtil0NCvOkUxTCbau4nDrmceq+wIbQwhMR9juNN8rBhn1LTPHW52WiyStLkSKXf
 UihzgRezxRCPMY47OgMHQTOmoUboypHZKv4pJevKbjbNAmUPOkrfzWS1nVBaNdAR+m/o78Ih//K
 /k4wigAhyZ5gK7MbuBQUN71mBtFzLzm0y3xCl0nlhAutOD3FjQxYfdj2WDkgdAABgGUifQh1dMX
 MjbcuscL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

Hi Coiby,

On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
> >=20
> > Even without an IMA appraise policy, the security xattrs are written ou=
t to the
> > filesystem, but the IMA_DIGSIG flag is not cached.
>=20
> It seems I miss some context for the above sentence. If no IMA policy is
> configured, no ima_iint_cache will be created. If you mean non-appraisal
> policy, will not caching IMA_DIGSIG flag cause any problem?

Sorry.  What I was trying to say is that your test program illustrates the
problem both with or without any of the boot command line options as you
suggested - "ima_appraise=3Dfix evm=3Dfix ima_policy=3Dappraise_tcb".  Writ=
ing some
other security xattr is a generic problem, whether the file is in policy or=
 not,
whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should insta=
ll
the IMA signature regardless.

SELinux doesn't usually re-write the security.selinux xattr, so the problem=
 is
hard to reproduce after installing the rpm-plugin-ima with "dnf reinstall
<package>".

thanks,

Mimi

