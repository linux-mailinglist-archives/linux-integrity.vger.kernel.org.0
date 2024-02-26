Return-Path: <linux-integrity+bounces-1471-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FA867BFB
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2225EB28868
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9412BF1B;
	Mon, 26 Feb 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EFQFJFuF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C912C53E
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964510; cv=none; b=EmYqNV6VMOod3Tcz0Mvx70kEErrhamU8bAMJvh5MzW1/rG6vuDKro9rurj9Pxff6da+EyBF5kLK2MOWksuahUv9WR+CUUcH5szbqu4/wYyLFGB0nSkiHF796sPxE5qayJC6bHtXMCRNvUREypbTt0w5FP6RBbRjYYn5hbnit3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964510; c=relaxed/simple;
	bh=WIJOgo6aIiwYPssObQq5oT7jfzw5yXnVhTD8qtXidWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/0NlLi1By+Mnyo70pIwaX+EtzX0mZOJXK0rN0hjBOjidFN/HGWC/UR7wMA3Xr2XVSlQrmWgRV0PUhwuz9zSnGlyk7xa+9wg7NRqZl6+d+8zz1lSyeOflo5LclBH8TfNbymIjPh4q6CoMXj6VHNvHc1/AX9V+j8DNySuGpCnJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EFQFJFuF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFwQOa032494;
	Mon, 26 Feb 2024 16:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+0lbWbzyPDy4LYqkz+Tk2d31OQnGXZgFH8Xb1rfv0p8=;
 b=EFQFJFuFAxWq6mRqCBgnQV2pM7iMG6y1yIHZ6o/EZFWMVXbResgbrQf04mwpwMgGgQ76
 qbzvly2rEg7ZRwfA4RzNhnY0Kmanecbf2pkcOkj2Fr2lY7q0Z9rxpN1CmZRct44+sFGv
 7bjf7zoFVHXfWJnMDwb8H8nfrPPR/yDSp8h8DL4zPsx3AKyqGU4BkQ/wXbkuf2qrlFqn
 U9P3aIwtF/TyPh/JWY4Uy174hCxD5+H/qldmL0QTBcVrqpt4VhQ42n6xTjKnrt4EbQwn
 mvWuzVxqr8glxfCxP+mUGEXnaWv4X2Dy/Xzye3C1Yodiv1iqD0mwjaZBLmfEOGtvq5gw SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgwrk8j7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:21:12 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QG04AL006123;
	Mon, 26 Feb 2024 16:21:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgwrk8j7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:21:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFTLB2024122;
	Mon, 26 Feb 2024 16:21:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k1wqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:21:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGL6cZ61407502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:21:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E3258061;
	Mon, 26 Feb 2024 16:21:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 492945806C;
	Mon, 26 Feb 2024 16:21:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.110.210])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Feb 2024 16:21:06 +0000 (GMT)
Received: (from gcwilson@localhost)
	by localhost.localdomain (8.17.1/8.15.2/Submit) id 41QGL3sk1670870;
	Mon, 26 Feb 2024 10:21:03 -0600
X-Authentication-Warning: localhost.localdomain: gcwilson set sender to gcwilson@linux.ibm.com using -f
Date: Mon, 26 Feb 2024 10:21:02 -0600
From: George Wilson <gcwilson@linux.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net,
        dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com,
        James.Bottomley@hansenpartnership.com, kgoldman@us.ibm.com,
        mjg59@srcf.ucam.org, zohar@linux.ibm.com, patrick.ohly@intel.com,
        patrick@puiterwijk.org, petr.vorel@gmail.com, roberto.sassu@huawei.com,
        stefanb@linux.ibm.com, stephen.smalley.work@gmail.com,
        tianjia.zhang@linux.alibaba.com, vt@altlinux.org, vgoyal@redhat.com,
        z.jasinski@samsung.com
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <Zdy6bkPUF8tYV4iM@us.ibm.com>
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: idTFRr78BGKJFgt0frGQOHZixAnp9PND
X-Proofpoint-ORIG-GUID: bgsk8_Ao7oKJSiR_RyO67S21EEjNoLxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxlogscore=800 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260123

On Wed, Feb 21, 2024 at 10:11:34AM +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Acked-by: George Wilson <gcwilson@linux.ibm.com>

