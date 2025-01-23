Return-Path: <linux-integrity+bounces-4625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39354A1A903
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7357A4148
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644A142E9F;
	Thu, 23 Jan 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="reQZ26Mm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3CEC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653916; cv=none; b=ECcuvbcYKElW58za00l067SQHsAGvvUSryicew9HY4X6Hg5xsfEvXZ70taWA9rHZJHCECW+pJ/w1KRTctiJZmv30B6F3IsiEpFmt3sPdM7LZjWY95jEdlQZ4aTxKQxLe5yGgXnpAaW3e6Z3dQo7NtSHdrzbgdj1HkeogxFKHpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653916; c=relaxed/simple;
	bh=iC1Ol4B6J7WAsOqx2Uu1ARSsPfzUfNXpK7+sP7ePZkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQeFX5F/vuQUeAKaW3TD/c/QgmncLNWy2Gf93EjynZSudagNvclz97ZGIBhnmE6ZGrl350R7PplVaaw9U7m+BrDaVFhTisHmuHTSY7ZqPSdaec7si0w59iJDZbc6+rI2QC2NKcY/6tQHyKglqunOPTP2iXbr8XYg7waOW+e/F/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=reQZ26Mm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFdTUu001971;
	Thu, 23 Jan 2025 17:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iC1Ol4
	B6J7WAsOqx2Uu1ARSsPfzUfNXpK7+sP7ePZkc=; b=reQZ26MmTjP/82hFGl1g35
	Tedo20IQCvBcpMUVf/LUAlrlbONPjFJgjQ98FRtKUIymcDDLK+8iUrTimJIhL1Wt
	UOCmz/+rl8OzFG858fXnr9/+o3XuX+LxQ8t3aRGhOUgGUSp2wB3nQDYMjqjlbrlX
	sWdenpOvlLX79/JlKq+aBQmicM5gt6x7Bk8ajmXZxHLhwH7k698tFKUBdGfxPyLd
	k6f4XZ8tp/QJ4GHTu6u6/LCPNb7EohsVtpr7RJG8OeUmZPABidm6/8Fwoyx++g+f
	GlYxqjNWV/VbTKjJjL1/PooioAoNNu6h8uMLIzkUMyPd1iXq+qSYNCsVhlxqzHsA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44brku0jhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:38:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEZCq6019266;
	Thu, 23 Jan 2025 17:38:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsptw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:38:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHcLEb32834158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:38:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9629D5803F;
	Thu, 23 Jan 2025 17:38:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A5CA58054;
	Thu, 23 Jan 2025 17:38:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:38:21 +0000 (GMT)
Message-ID: <55aeca6cb2bec965d6cebc7fcc2031064fd4a36a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 03/10] IMA: Move requirement check to ima_setup.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:38:20 -0500
In-Reply-To: <20250114112915.610297-4-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-4-pvorel@suse.cz>
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
X-Proofpoint-ORIG-GUID: 2u9YeCeRO8UczegE8MyJAbHIpM0W6AnE
X-Proofpoint-GUID: 2u9YeCeRO8UczegE8MyJAbHIpM0W6AnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=735 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

