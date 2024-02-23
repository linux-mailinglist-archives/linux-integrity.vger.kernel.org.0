Return-Path: <linux-integrity+bounces-1441-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3784861A45
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97F91F27750
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC81420CB;
	Fri, 23 Feb 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsG29Mi7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6EA1419BA
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710165; cv=none; b=a7kKDZEb3u1ivmekw9f7WXagG6CXdpesCfrcCFs8HqO6s4pv2eWaZ5h8LhZ5oD33V9HhkgEUu/0le4sS13pTgfuHURaA29VLnZj1LX/4PvkOkTfwKYPKqQitXp7UfH4hO2jfYgUEy1miCRYlHSFrNYlSOavUURUBRH34Lq9sluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710165; c=relaxed/simple;
	bh=RlfhOtO3UO6qwqkBPV4qYfBcLavXE9RbEXJm+8/Tjg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=uCMBW87dX2SP6EL0vfh1f3r7kSCWzBXaWzdlMm0VpKexbaYzDuLH/EYGsboKHe0NLHKrQbuUAubWGo4osLh4igfQlEvPQE/97/naFigaTel+4oNu0qkqy8b99Is5eDcNuwBu7xcEFD/YgW0cUnz65zT6AGx2BsTnUYhOOhIRDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsG29Mi7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFvxjM000470;
	Fri, 23 Feb 2024 17:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+HfvkCHeO+aI7p4F37FQvcimewRtCLbk4DhJ4KbXvZA=;
 b=fsG29Mi7nf1V2UaY86cCagOd3Hm0Ul2x6hJMoZ4hHYnMogNHu869rbR6hqAdHmAt7imd
 Pde+v4w4Qn1YgjfNSJrtuHaN0Kau0LSZWPvTiGyovPkmYlH55bxceIvdHoNa+kY1fm12
 M/cv5o1Y1XNSotN0V/e2t5Yl6vkV5WKXPq+03T7wBwKv3jYHlXL5wBHn84HWUN8xOI7v
 yUfEEY4XwSP4kWrW+Ry4hLmE+Jg1lRv9g1Zd6qSQbJNSYCepFaoUwgX+LBo51NLNAKaf
 I8w6fV7KonHrHSwu8yPSPnn25XsjG5qeqDDP14PpDxVvD6KNjbOELAcGzfZ1L/fV3TbJ Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wexf7tgkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:42:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHfxji003517;
	Fri, 23 Feb 2024 17:42:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wexf7tgjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:42:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGmDe6003606;
	Fri, 23 Feb 2024 17:42:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u784k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:42:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHg4wV10552096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:42:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A12758045;
	Fri, 23 Feb 2024 17:42:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C7758052;
	Fri, 23 Feb 2024 17:42:02 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.113.106])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:42:02 +0000 (GMT)
Message-ID: <5dd2108599f11c9f9ea73a4f127ec969347bc78f.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: Mimi Zohar <zohar@linux.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: a.mardegan@omp.ru, git@andred.net, dbaryshkov@gmail.com,
        ebiggers@google.com, sorenson@redhat.com, gcwilson@linux.ibm.com,
        James.Bottomley@HansenPartnership.com, kgoldman@us.ibm.com,
        mjg59@srcf.ucam.org, patrick.ohly@intel.com, patrick@puiterwijk.org,
        petr.vorel@gmail.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com,
        stephen.smalley.work@gmail.com, tianjia.zhang@linux.alibaba.com,
        vt@altlinux.org, vgoyal@redhat.com, z.jasinski@samsung.com
Date: Fri, 23 Feb 2024 12:42:01 -0500
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
References: 
	<9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
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
X-Proofpoint-ORIG-GUID: xZdLczHeQR9ggWwzbWaPzz3T6B_GD8P0
X-Proofpoint-GUID: 6qe2Wy-EYkjggExqoq_W05TdPGvJF8R7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=990
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230129

On Wed, 2024-02-21 at 10:11 +0200, Dmitry Kasatkin wrote:
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

Thanks, Dmitry!

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


