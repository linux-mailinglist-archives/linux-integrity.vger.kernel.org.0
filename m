Return-Path: <linux-integrity+bounces-6455-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E864ADB2F2
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jun 2025 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B184316214F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jun 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08091322A;
	Mon, 16 Jun 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1FPs9Wd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E372BEFE6;
	Mon, 16 Jun 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082701; cv=none; b=atgu4jKxFenOgCgiMkiZrei22sa8aOWI7kQxLTCfxLcb3sFfh0lx/z8WhZ5VQw0mZWtxyPceJrWpiWt1usuhewlT1LBWiJAIz8jNPYV9llzYIQDMLJ5qXDc91FKQSG74wSI4Z+2UpjOZ4KOVqA79QpAmrtdFEXLSsRL2+wvkuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082701; c=relaxed/simple;
	bh=nG63h+o71iH5qZj+sDQMygVt5j0UNa7UHj+v68Nbjt4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CA5KGAfMDNEJG2xN6JGV4IEoivAOqhHRhR8SZYZXpQiuz/fcMY3XepjA1LwuKY04AGqYyy16pBXgZlfA2Rnp6o4+SCMi1XXRRazcbgo3M2LxJWN7ZdMXMTmBx9QZLy7yrJzreai4U0x4yPLsGOZXb1bYagUZ1+N8tz2fnx1W79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1FPs9Wd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCxxVj023219;
	Mon, 16 Jun 2025 14:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HQibyb
	fKSneV6BzjwRy5a7vJvWS9T25Q9V9pcFnb8JI=; b=B1FPs9WdtatEvkmZol40Uw
	r2yBnZtJG1a9frb0wITebzNTsP8J7WN6Pwrp/cbdwghlO2SWJ7r02oiLl4dx8ZnO
	IWlGD1CoX2UNm++HgWz2b30aKMUXuJg5WFjqTPZ7szcx2XfJN09QllmvuBCxQXbj
	yIDIgz4gmdx5rqIt3Gh8zPP24pZcUESj5v+pOGU+nbYINRnzGZSSJV0YzboDvrTh
	Y6mAcx6o/j3AWNhFT4utjbHtyiWkgPAa0aIRN5tYUacJab8LXHwAzGmbBZqciq7Y
	1GieBDmIXakPPSfndwb/LSG6BbpeZ/oH1x9K8vRWGd5LYwI5yiCAs+PIg45FlbQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp18bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:04:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCqr2v000762;
	Mon, 16 Jun 2025 14:04:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdnxdnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:04:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GE4gjh9962090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:04:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7B058052;
	Mon, 16 Jun 2025 14:04:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E5F5805E;
	Mon, 16 Jun 2025 14:04:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.78.137])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 14:04:41 +0000 (GMT)
Message-ID: <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: add a knob ima= to allow disabling IMA in
 kdump kernel
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, coxu@redhat.com, piliu@redhat.com,
        pmenzel@molgen.mpg.de, chenste@linux.microsoft.com,
        kexec@lists.infradead.org
In-Reply-To: <20250614022342.5988-1-bhe@redhat.com>
References: <20250614022342.5988-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 10:04:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFv6YYeTGdevxX5fjR_ZZeAOtqjB4hxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX824tsbTXqqpz GTEhThlZznVglfKIadaABCoEWarASEQR9plzOS7pc5VI0Ag7sPkW96uaRGbIq20P0UDmUe7lzCD +2jpc243sL1W3/1dJSCbqZhSkAwf/DHpM8y8Fehiy+tgen/yN716NvdYmjJ47/Y99pFJ+VuxgDc
 C1Ph5REP7TJ/SlEYuvdJqLM8pWCFEjm5JOb1jKIlQRhVkyl7X2BMOpVwdx4CQ0JqRobhlZfZ+/d YdZdMpm92tU2qXc2HusX2juD8WdtBBVkur1PvZBYHvYSb8f0c9uE30OvARPHfQks4rJvc9p2oGt rM94am+MMyyH7FcyYn6ENKdRLxBYmwbsxNFRPvTsp6LZ1gwbWcDf2GCuHHRujcE8FgV9MhxCN7D
 h9i45eHc2vNuvdtihKGGhgs6JCXVMHgBHAuKVVjOkbbaIYWes2vMvTaYfeCG1ZEF3wM/w+6a
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6850247b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=-XTtKo6BakjCtqxwOl0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PFv6YYeTGdevxX5fjR_ZZeAOtqjB4hxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=630 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087

On Sat, 2025-06-14 at 10:23 +0800, Baoquan He wrote:
> Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> extra memory. It would be very helpful to allow IMA to be disabled for
> kdump kernel.
>=20
> Hence add a knob ima=3Don|off here to allow turning IMA off in kdump
> kernel if needed.
>=20
> Note that this IMA disabling is limited to kdump kernel, please don't
> abuse it in other kernel and thus serious consequences are caused.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
> - Remove rdundant word 'only' and rephrase sentences in patch log code
>   comment, and rephrase patch subject, thanks to Mimi's comments.

Thanks, Baoquan.  The patch is now queued.

Mimi



