Return-Path: <linux-integrity+bounces-1857-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577E88AF34
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Mar 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8105B46F5D
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Mar 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038F3DAC03;
	Mon, 25 Mar 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fq6VwD3d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4F4C7D;
	Mon, 25 Mar 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382763; cv=none; b=B7wSARw60ttzEDSx/BEhRiZerh9s4iTIkJjeMyxCStXHsqOKIiSiaSgoi+it6V5Zw4qbbLV2mBbjeiAT/+KMHtsjfKK55sovBc/aLv/krw3QLo9ZjT/Ck3JaWnLSmPilvsYUTOV89E+BR8nekB9fe6jnlh+4CTSIPKjuhlq9asM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382763; c=relaxed/simple;
	bh=dVVLMKHbPKk5loN9gGOiMZFD4IZunaqsL/JFE4p+Ias=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCP76YRMxPbAT8RoQ7SrHOFb4SqKRmYsbUuqe2YkLAovcQ5cogoIH3kOjH4OLVwjYGhVScJSjVPJ4ZWOIK1q8Pxd8JNShvydZezGWjNRaE+k5qOMdWRc1QFXxSWKPOiN829T4Y09mAqxRFsWzdXfB0r1dXBiPlKjbTLhMatG+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fq6VwD3d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDriIS019480;
	Mon, 25 Mar 2024 16:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dVVLMKHbPKk5loN9gGOiMZFD4IZunaqsL/JFE4p+Ias=;
 b=fq6VwD3dH0rSOA4mVE74gf8EJt4eEAM0nM5Mj/OyMSSVU43GXIST/CFJAWOh2Sgud45h
 X/TrHWvkQGu3gnb7iwIi+R997zxJJdUelyfV49ld2vLhM3QESGYUp7N6QoQTbBXbWCLo
 KySRkqKO834WYNNYW0VR7U73jSZvQHFnwCE2W/0vNYOhmOLbO+J7GF6LKT9O8pCdplOk
 f35mRpDnOJk9qi3VgsPrvgC/Y48LjOsuaPxzzcKx1tG7IKVRzp67Jgv0wiyFqbl4kzWB
 sjNA3Q03BMyWGrIHZJQVIAIqgP8CN5aBEoI1tumgX6VfWZdaDQ9MkXmBtIDJzdJlwpaE /Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x36e68udm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:05:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PFvhxp003753;
	Mon, 25 Mar 2024 16:05:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42hnyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 16:05:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PG5SYJ22676032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 16:05:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D059F58052;
	Mon, 25 Mar 2024 16:05:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9521858063;
	Mon, 25 Mar 2024 16:05:28 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 16:05:28 +0000 (GMT)
Message-ID: <8ff7a52e-1a0d-4d07-b8e2-9f91ebda9c2e@linux.ibm.com>
Date: Mon, 25 Mar 2024 12:05:26 -0400
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
X-Proofpoint-GUID: 4MD60MkRdidG_eIRKqHTOswqsHkNs-9_
X-Proofpoint-ORIG-GUID: 4MD60MkRdidG_eIRKqHTOswqsHkNs-9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=851 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250090

This indicates that the TSS is trying to connect to a
TPM over a socket interface. This is typical for a software TPM
aka a TPM simulator.

I suspect that you do not have a TPM simulator running.

On 3/5/2024 5:31 PM, Samuel Lee wrote:
> # tsscreateprimary -hi p -st -opu primary.pub
> TSS_Socket_Open: Error on connect to localhost:2321
> TSS_Socket_Open: client connect: error 111 Connection refused
> createprimary: failed, rc 000b0008
> TSS_RC_NO_CONNECTION - Failure connecting to lower layer

