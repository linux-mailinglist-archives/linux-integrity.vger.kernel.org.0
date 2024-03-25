Return-Path: <linux-integrity+bounces-1856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0888AB5D
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Mar 2024 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B2A2E4EBB
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Mar 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A345C900;
	Mon, 25 Mar 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mMF+IEqQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391EA5C8FC;
	Mon, 25 Mar 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382609; cv=none; b=IAK05FPT0CmtL9ui68e53e/Uo+uDl3kCY23PlWPlg8tQM26F1xAB/x7breOj6kkLxxq8uABfAgRUoLgM9xv2jPGRNBOmp+ExI52yc6jk3Jr5Q6vOJ5hgKjfd1GpRTlI0VDp7x8QoU9ZYFUikEJB9omaUn4mPb7zzbpsOa1NPL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382609; c=relaxed/simple;
	bh=lqLEd5huLtgmKEsfrk97E+iShwK9un0d/cE9W3qxfNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5kdPXYXJGQq7WnvC8jwXZPaDQalSM4O2ooVERKquw01qEFQO1Rz9MzNkQP+7Kp5nGiEjh6oAj3FignLLwv0hfRW6SDqUkekiQ+sTF1Fi8YTfytnDX62240BD+PthLjAzegaUiPDPLepagxAvZGFW8wq8bVZXTDI9ft2O+o719o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mMF+IEqQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDOcuQ000609;
	Mon, 25 Mar 2024 16:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ysViygD1U7IgI4tE+Ni1R03dcM4gag7kWP+7mggR5xs=;
 b=mMF+IEqQa4HckZQ7n+uxNtAIc87dslMpaLWRNUc6Sk0PhnJcyJ0W5bWW0wN4WiDuRAgi
 wq99hbeiA7mQT3p9xYwlCMNCxrq8tFDAfkyb247MhoFE58p9MZ+vl3CEd6rv2zfv6JIu
 SkS9DGecNqnThd4by44bYKd5v8MFcPGZp811Cz8aaS5VgzsiWimlJfBy7yxl+XiBEsNg
 hTaKKvjelloEUJyJ+SGm5H9x+ZS6DRozHcdZKDqeXP1Vu2OCHQw4H5j9ZqnG13bSMqC3
 GAgSFc7R9UnY482cgMJhv7A0HkG+++YaSK5pJ+/EjRPlK4iGnUr6QJyBwZWTNyduZWrv Ww== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x36e68u9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:03:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PEGq5x028623;
	Mon, 25 Mar 2024 16:03:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp25yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:03:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PG3H2554722884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 16:03:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EE6A58067;
	Mon, 25 Mar 2024 16:03:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24FD258066;
	Mon, 25 Mar 2024 16:03:17 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 16:03:17 +0000 (GMT)
Message-ID: <7580c505-7db9-4a34-887b-888918ea11b7@linux.ibm.com>
Date: Mon, 25 Mar 2024 12:03:15 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with TPM2 Encrypt/Decrypt Functionality and TSS API
 Integration
To: Samuel Lee <slee@gateworks.com>, tpm2@lists.linux.dev
Cc: linux-integrity@vger.kernel.org
References: <CAGL1gLNsEPXG6dXXJLk2Ucd_UAjMoa3_OS=uca5G4FvPjAMPNg@mail.gmail.com>
Content-Language: en-US
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CAGL1gLNsEPXG6dXXJLk2Ucd_UAjMoa3_OS=uca5G4FvPjAMPNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ohvPOignfPDhzPmtPdDMKzJsiAcCtIYT
X-Proofpoint-ORIG-GUID: ohvPOignfPDhzPmtPdDMKzJsiAcCtIYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250089

The TPM 2.0 Library specification is a library of possible functions.  A 
platform specific specification (e.g., PC Client) specifies which 
commands are mandatory.

I assume that the TPM you are using does not implement TPM2 Encrypt/Decrypt.

In general, check the platform specific specification and use only
mandatory features for interoperability.

On 3/5/2024 5:31 PM, Samuel Lee wrote:
> Dear TPM 2.0 Mailing List Community,
> 
> I am currently facing an issue while attempting to utilize the TPM2
> Encrypt/Decrypt functionality in conjunction with the TSS API
> integration.

