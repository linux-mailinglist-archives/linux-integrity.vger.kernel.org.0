Return-Path: <linux-integrity+bounces-4689-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87265A25F40
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191BD16494B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BE20ADC4;
	Mon,  3 Feb 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MSBGqSiH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC020A5F6
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597881; cv=none; b=dHnG9uysf1VBU0WISs9/Q1Q74B2/sLWL4BxJuel78o3K2+MeJ1PL9GmQ2NixJt5e1im+WzcF7oNw0jPnnzRZcvX9tY+uhfg8ajME1AtW2rGZp2F5+TYAp/mfxqe6XfzA6njevyIaMa4bLnw4bY5r1k0NEHXjEDohxhruwh/OmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597881; c=relaxed/simple;
	bh=jpeu/Mu2hCJT+reIxwu/o2sQ+sJlERQnbivCXU1sqZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtYkeomDCKKy5wdExFAYfUuzXvFxhi5sQzxPRzT1WUITobr+bPnt/KWvXW+/yT2HoCuMGpYk5FAPwlgxUUR6li0FcIbstbI8E+3z234nxYikE783TXH3ypXcOgJTFhYGOXEPRIWAN7YvM4xIBI4YF/SG/DwxtYsTrKNOlzhWrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MSBGqSiH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513CBePj006338;
	Mon, 3 Feb 2025 15:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jpeu/M
	u2hCJT+reIxwu/o2sQ+sJlERQnbivCXU1sqZc=; b=MSBGqSiHep5xq26lfQ+RMS
	UT7gVrKrnG7lTapwSqjqYZYtP4O/xGy+c+/vrGlviSduaC6/uf0oUnEbSaQvggx/
	UeGEQ716IRxenjPTIBTVYOHXg/q9Hm4qfxA0O2F6VmkHAWAng32hB4Yhj/lSCe2u
	ibQ5+oMZqVrA9NG24NLaJ7iuxKp35Sx27vB4M/kDqT94mcW180yf2S/4gku5R20/
	6EjWox2r4insEzMNUQiBhd8Bm4fH2hoQnN3s/gIftt330vrnm0kJ7M129PYKO81o
	e/S2Itir108YoxV8sdZFrMxsT3VOhfXPe6LTI9CLdwScb0FqOqbnb3Ludq2aubKw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jmmybbv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:51:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513FVkEk024510;
	Mon, 3 Feb 2025 15:51:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxmy297-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:51:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513FpBtV30081764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 15:51:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85B3F5805C;
	Mon,  3 Feb 2025 15:51:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0805D58059;
	Mon,  3 Feb 2025 15:51:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.5])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 15:51:10 +0000 (GMT)
Message-ID: <5fbed0841d699981ffa57c532e259b56e7e8931f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/10] IMA: Add example policy for ima_violations.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 03 Feb 2025 10:51:10 -0500
In-Reply-To: <20250114112915.610297-5-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-5-pvorel@suse.cz>
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
X-Proofpoint-GUID: OdBjVgxyGsZrG6bpa9OMAP5T97ANrbMU
X-Proofpoint-ORIG-GUID: OdBjVgxyGsZrG6bpa9OMAP5T97ANrbMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=718 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030114

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Peter.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


