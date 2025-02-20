Return-Path: <linux-integrity+bounces-4949-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E11A3E664
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E7F4237FE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BC1D54D1;
	Thu, 20 Feb 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p4yxtUyu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA21B4247
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086166; cv=none; b=iOTecMrlj2JkNdFSM28fhnUoJWKcKuS23KMerzoAhMVT+VZdtBxx8OX9MC/qWaoAOx6ZyySNBtzoKRX4vhvQrOa6uNaWprUaJQm9ad/GYq4TIAAvwIXqAfSB9BltjDgmAC5BWIvr9Rqy5Kib7QVxKjhAn005oVif2jTYifn17Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086166; c=relaxed/simple;
	bh=KKKudD7b1M56mMxTzo1faarVkPV9oBQ13xd4LX3SJ6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQAb8HOSBkBuAYbLJxkU3bTqaNpuDXndF8GUoc0DBL3A7K0uYM3CR9eTZRec/kF9gxqQY12mKjLDnclS+nSovpa47M2q86E36N2vmtyBnETS16vWyHTMT9Y9KIMynnbt9W1Tb+n1nfciql0kkUupJPUzzp+1YhJyhAwN81szwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p4yxtUyu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1dLN007549;
	Thu, 20 Feb 2025 21:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0+SSpa
	iQhgd2WYpjOq9gVihxbgIZFBAhB/CajQJeevk=; b=p4yxtUyud/iTB57D2M+0du
	zMvkN0vCJ7efHfjlh9VJChYHNSzA60RnUBgPRWvemSNep6GFtCVcgCG7nwn4qODM
	eXZ/mQRWG+IKLB59r80Ihjqhw00D03X4Pua0kORmZpPoGk1A2YbCMv3v7r8CBrY6
	VamNbHUCLBELo2sM/HDeKE5Vr/0J0oI+OrzNsqyaJgnlhXuufPHszG0f3M1wqKMV
	gs2geW7pgwcCXqu+C1CrK/3N9AV6msLoJnKZLAXpjbFWNyNNxGlFKpdy0Tl6rocA
	zN0VibM9JhED5BjcW8qS/3LbW+pGd6JnZalrLuUzDru1SK6AS0QN4SlEySoniJ0A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5f33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:15:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLEQO1027050;
	Thu, 20 Feb 2025 21:15:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025ca7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:15:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KLFq8V23003692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 21:15:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2471E58052;
	Thu, 20 Feb 2025 21:15:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A351D58054;
	Thu, 20 Feb 2025 21:15:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 21:15:51 +0000 (GMT)
Message-ID: <63e4b47ebb2729f36111badcaae589a36eb24422.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>
Date: Thu, 20 Feb 2025 16:15:51 -0500
In-Reply-To: <20250220184631.GA2713854@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik> <20250220184631.GA2713854@pevik>
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
X-Proofpoint-ORIG-GUID: WUSEN2V-jgVmJSTDr-vfR_-4A49AQX7W
X-Proofpoint-GUID: WUSEN2V-jgVmJSTDr-vfR_-4A49AQX7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=878
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140

Hi Petr,

On Thu, 2025-02-20 at 19:46 +0100, Petr Vorel wrote:

> Is it this considered as a security feature? If yes, than failures on van=
illa
> kernel are ok, we just need to later add kernel hashes to let testers kno=
w about
> missing backports. If it's a feature (not to be backported) we should tes=
t new
> feature only on newer kernels.

I posted these LTP patches as RFC since the kernel patches themselves haven=
't been
upstreamed.  I'm still waiting for some kernel patch reviews. Posting these=
 LTP patches
might help with that.

Having multiple open-writers or ToMToU violations doesn't provide any benef=
it in terms of
attestation.  It just clutters the audit log and the IMA measurement list. =
 Not extending
the TPM would be a performance improvement.  I'm not sure it would be class=
ified as a
security feature or bug fix.

Mimi

