Return-Path: <linux-integrity+bounces-1964-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5F2895C94
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CA91F26D89
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114415B55A;
	Tue,  2 Apr 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A+ld4brv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49D15B964;
	Tue,  2 Apr 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086233; cv=none; b=ujakWtC1X1bQfA5sEMZRsiiCEqjoKk/btVkDvfTiG5ln0E4vIlRA/T43ibZTSAozlAr2l9JloCqSFLnuvkQYEFGVrL+0BxiUSQtnQUrxMcY9F2mOjQtIuFPZoxro6Prqzx7chSAtW8DMVE256h7GCTLQovQUFWS9+TsVyP0eDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086233; c=relaxed/simple;
	bh=vRWeZ4wLl6K6OAEg47hnNnPSj1tZrLt7BHdvAHXaxbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm7eA6Jjz8DV1tkewR1av0nr4Z+gu/cm5R0Qcpf3LFn+yi/0k4ffKKY2RmHGDrz6aLZWcg9i7e6oxPAGiV+rw0NSrJCCE20VGj7eB3gv5+yaiqlZUHPCGDi8u9un0fFW1t2IJaQ5VLgF9+jLB6RuiaSxB4a3FmbUIAhSwcaREvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A+ld4brv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432JOkmM029203;
	Tue, 2 Apr 2024 19:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FLKcoy4KD5ED4v2BnCoO/X4hnM4GQdSh3uwIQkosmQ4=;
 b=A+ld4brvDFVKBuYUMaQbLr801BffuyuZCROWBrGOGkHOjONQjlZ/nt63WMCamee10A/q
 vHnH8wSHH7yBu7Omkr6UpslcKz2rF+SsAqA5+8CqqZ2xvT4TBlyD8HDaH38OUYP68szW
 EiMgBcrqZsTRv2qkVsrC5MyZ3XeSamcZ+uqb4xV3zoih8DNbHT06ojh4P2BgmHTgU42c
 nVM4g0XiTHoUR62DJvo1F/NiW0vcelXnM8P04qQbYdNPIBb4H55DcesfOFI6yklHx1ci
 HSWDPN/a3MCdWOiBzAx6ABZJihVkI2XZX9Hf8KA19UdxkeBywcG+AlfyddEl2p60k3Ey Ig== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8quy025c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 19:30:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432ISwld008422;
	Tue, 2 Apr 2024 19:30:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2u0yr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 19:30:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432JUFes25887408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 19:30:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 452DB58083;
	Tue,  2 Apr 2024 19:30:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25795805F;
	Tue,  2 Apr 2024 19:30:14 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 19:30:14 +0000 (GMT)
Message-ID: <2fb01074-e7a2-403c-8d46-d2b2323c231e@linux.ibm.com>
Date: Tue, 2 Apr 2024 15:30:13 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
To: =?UTF-8?B?R2FicsOtZWwgQXJ0aMO6ciBQw6l0dXJzc29u?= <gabriel@system.is>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
 <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
Content-Language: en-US
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GMeB6XCmwZMmneqqs8nC2mHVyUaS0XXm
X-Proofpoint-ORIG-GUID: GMeB6XCmwZMmneqqs8nC2mHVyUaS0XXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=798 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020143

On 3/31/2024 12:52 PM, Gabríel Arthúr Pétursson wrote:
> The TPM specifications have a standardized set of templates for the
> Endorsement Keys, and a recommendation on a template to
> create/provision the shared SRK.

The original TCG guidance document for an SRK used arrays of zeros for 
the unique field.

This was either a holdover from TPM 1.2, where arrays were 20 bytes,
or a misinterpretation of text that said: NULL.

The reality is that it's a TPM2B, and the size(s) can be zero.

The answer for the EK is different. It has to use the TCG
standard.  The EK is not a 'guidance document'.

