Return-Path: <linux-integrity+bounces-1749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCA87BE9D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Mar 2024 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9406E2884FC
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Mar 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5058ACF;
	Thu, 14 Mar 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BM1UvVEu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8C4D9ED
	for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425526; cv=none; b=k+ZU6EAa2PmcYCzLGuKJBc+Xn+FjgveIh4W2nR5vVy33XLgDj7CVjaQ8xaSNvQMY3ihefEOIROvhm9HhBWWcMmBuD0X0PUHPKIerdIRz0guW1u1es2mD0wVWrqg0Ff2J3JYUQX/ZCCMYVXZ6h4A318rWUUwyvnPBC7s7LLXRIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425526; c=relaxed/simple;
	bh=YZFyzWmqYUePrDkWPykwLSaED13MG+oSgt061jsPQMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Wt9Rg9INQicP2Lw4guKIqDTLEVheNi6FcDmQUjEZ8WShRpACvuD8DD/aLMN7dWwMLkakQxCjcLZl00skDfDymfiMc4gZQZavt13MYvbIvjerV6VZvoyWAyeru3B/0ASvQUQtuOHHEwz+2cnCV1cI7ksvEuzwMW4ulPrn0nUP/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BM1UvVEu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42EDj7fZ031903;
	Thu, 14 Mar 2024 14:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hTyO5AxONFKpWzfnK6ncbVADy35ibsatWxwO+AwoQCw=;
 b=BM1UvVEuywcaY3Y9z/MvY4cJK0wb30wQFjdw0/kwVCtPJJFNiURZAFgPqvcXKQn9cspw
 sQJiVJZKFKABM1vSr8vdJq51f3Xy3QLCEp0B/nvERMoiqVThkfiPgDlXIkooI1Ur3iVp
 YXwl7w33NlVY4Y3VjfSc7DUjbxp2bF/TT07cs9HFDVvh00wNk7ayQPGbSZiggwyJjmOC
 Mw4iDciuR+8i/E/utM1+NSIP48UC2zd04X89611Piqryjc0cPS7umhbLfb8VAkSKErYj
 HHIpUdTp1VRF1LQuGEcN1qnrBtQNxm/+a9k7B0l6k5z0jszIvkEUUCMHhta/HauEjUlr cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv257gg0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:11:32 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EE3Iv6010271;
	Thu, 14 Mar 2024 14:11:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv257gfyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:11:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECbq9r018575;
	Thu, 14 Mar 2024 14:11:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t2cw40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:11:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42EEBS5O24248858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 14:11:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A31E58051;
	Thu, 14 Mar 2024 14:11:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3546458070;
	Thu, 14 Mar 2024 14:11:27 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.17.106])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Mar 2024 14:11:27 +0000 (GMT)
Message-ID: <9f816d3addd19b616783a52e398ad6aa19be364e.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: Mimi Zohar <zohar@linux.ibm.com>
To: Vivek Goyal <vgoyal@redhat.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net,
        dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com,
        gcwilson@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        kgoldman@us.ibm.com, mjg59@srcf.ucam.org, patrick.ohly@intel.com,
        patrick@puiterwijk.org, petr.vorel@gmail.com, roberto.sassu@huawei.com,
        stefanb@linux.ibm.com, stephen.smalley.work@gmail.com,
        tianjia.zhang@linux.alibaba.com, vt@altlinux.org,
        z.jasinski@samsung.com
Date: Thu, 14 Mar 2024 10:11:26 -0400
In-Reply-To: <ZfG73EoStKtANVZb@redhat.com>
References: 
	<9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
	 <ZfG73EoStKtANVZb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rvRarV10rAOi1bk7MYO6ikzRzAbgpwn6
X-Proofpoint-GUID: 5CV9zjfLGxxrkYc03-ZKjlrqKGZwjDNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140103

On Wed, 2024-03-13 at 10:44 -0400, Vivek Goyal wrote:
> On Wed, Feb 21, 2024 at 10:11:34AM +0200, Dmitry Kasatkin wrote:
> > Currently libimaevm provided by this project is used by the tool evmctl,
> > which is also provided by this project.
> > 
> > An issue was reported about using libimaevm with other software. Its
> > GPL2-only license makes it incompatible to use with other licenses, in
> > particular GPL3-only.
> > 
> > To address this issue, change the project license to GPL-2.0-or-later
> > and libimaevm to LGPL 2.0 or later.
> > 
> > Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> 
> I think I have only contributed to evmctl.c and not the the library.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, Vivek.  Both the project and library licenses are changing.

Mimi


