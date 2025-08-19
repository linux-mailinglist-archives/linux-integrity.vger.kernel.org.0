Return-Path: <linux-integrity+bounces-6878-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3EB2CBAC
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA61BC731B
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EED30E840;
	Tue, 19 Aug 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z9Rwj5bt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE030BF71;
	Tue, 19 Aug 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627080; cv=none; b=gLhzqITuwckP5Zn7cYLYEOmBM2lzOx/XV8Cyfn08ZgdvyK27fo9ULogqKwozkG7kzWrcKIANPa6ixri2G7IM8yo1KpUGj7QQkHOY6ppQxZZOEG7LpD+tXiOa6/y693WA1ne6cREnD/akiysrKjtoBeHfE5yWOeZHTDp7bPll1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627080; c=relaxed/simple;
	bh=xUQemggxCTkPmlVeF7uoN2wIhAxQRgSnHSp8j1ZtmlI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=APklvTUCJVp1y6m9v+YuTSRHJjgmv//lPgDVMC5W6sqY66jBeSsxxfygKJtE8RmAYxQdrPo4B/wU6YjWxKCHovGCY8I+13j6t8YoGVGkMQIm5J4lzxHfaghGLvqXuWKJWQT0A3nXG6Fcc8wwuSRJkQLMX8iK/Uv+Am6CymLNTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z9Rwj5bt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JAPYtG009349;
	Tue, 19 Aug 2025 18:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xUQemg
	gxCTkPmlVeF7uoN2wIhAxQRgSnHSp8j1ZtmlI=; b=Z9Rwj5btOzFAwHzMS1bNzY
	FPWem4usLyc5Mop59BftvHg9HiHmY98qtBAb2zV/7uilPb4T/Jy1Y1epyUka41aY
	YnqgmmEq0PHqifeHvslXAZnK6uR5ondczmu8uoOKsDmphVFy90Z42fpxajjx2qi8
	dHgy8YUUB9wdfI+o2iCgYNYRruNG9MbeCIPDgeZS1pEhbUjWWdxJKtMLS3g0nmX5
	WMbSS5j4NQwepL1rGroh9KInqBYvvOEz0TdIyCYqs52+ARkFaSxSTESG2PGyHiKa
	AuDS/YgmnXQhRdQbVPSWK0nzOJ5ns0yUE6y2kS68IyM2T+u9bKHxOAFIraO81a1g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfds0b3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 18:11:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JI06O3010006;
	Tue, 19 Aug 2025 18:11:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfds0b3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 18:11:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHkjiD011683;
	Tue, 19 Aug 2025 18:11:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k4aubmf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 18:11:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JIB30p60096982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 18:11:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9F158062;
	Tue, 19 Aug 2025 18:11:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C8D5805D;
	Tue, 19 Aug 2025 18:11:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 18:11:02 +0000 (GMT)
Message-ID: <0725dc50a83b82dfe8cedbcffb7529152f37a26a.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] Convert lib/digsig.c to SHA-1 library
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-crypto@vger.kernel.org
In-Reply-To: <20250815021733.25689-1-ebiggers@kernel.org>
References: <20250815021733.25689-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Aug 2025 14:11:02 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hp7Od9TYyCrfRhL2qVChjfzmXJJcCiJb
X-Proofpoint-GUID: mQvzuh_mLaP2uUPW3QWaExIG4yOhwGIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfXwJzdD/HB3HdE
 UeDopDh6698OOJKjEcZdNEzFMH/OZ6bSKn15YfFhNZEgAUUphsalZ0OzJ4lso4I93+nIRmanvrT
 chz47eBof5CUb0TL914Q462qylkVGTCbqjacebq96kP7xwkuSq/VXYDrLXhoTn0RJytC3Si7GqC
 G5Y2c5+Gd8xpqgCLWgJm7Ea4ZVZGTz7q5mkLDMiWTnB2VVVS9YIG5fCkjmtz09m/nM+/2sgBycd
 2z5zzkiInSYUAiiwr57RNwCs6I7epg5M2QBI83Ryu28GPuwp07+aVJu/7tgMAPD6Rbgt2cFiiDn
 DhO+oIh9vAsgzTxTPoT/bx5b9An3KCIvH5Mw8Uwlrhc0WdfsRuakOrQrRQTzXnYug7ZhnDAHBcw
 awGfvPSX
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a4be39 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=iQxIiCT5EglVh45UXwYA:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001

On Thu, 2025-08-14 at 19:17 -0700, Eric Biggers wrote:
> This series converts lib/digsig.c to use the SHA-1 library API.
>=20
> Please consider taking this series through the integrity tree.
>=20
> Eric Biggers (2):

Thanks, Eric.

Mimi


