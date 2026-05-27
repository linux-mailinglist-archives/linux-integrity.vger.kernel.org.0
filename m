Return-Path: <linux-integrity+bounces-9690-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEsEEGX4FmrUywcAu9opvQ
	(envelope-from <linux-integrity+bounces-9690-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 15:57:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D35E56E6
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8FFB302F1BF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C03DC4CB;
	Wed, 27 May 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EQHtVPcI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAA3148D3;
	Wed, 27 May 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890253; cv=none; b=UUcekBjDEorr2ERfemo+gdxRlZL8SmrY4S6hclqpumgTG+gKGFyjbs+edei6j5OIKwAis7/ZgT6NxYHCnQTcJea04ZM0xUxLkpwANabC728OZLPoAVGC5oSgHltmrXJRlf7yXD4rlpcuf+72vz55jWLF18kXTRTQPMlNJRw01Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890253; c=relaxed/simple;
	bh=zvlOlKFO5Ea8ZWoxLGLkvjRdz6BrBzYnlRX14u+yQ3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKt9SQDogvpjW1n8da3UTeD3nxjqwhPEXDmbYThtvK7UlFXqGOCJlAiMjYp3wmar4PTva9YByOULwP/KX+3Fjqlt3Qww0r3DtFJFz7EyuJP+Z4WDNx6l49zc2HskwifFbFhDKi3C6L2d6Xu8oe5ideIJbtFZ0zmTb+tTjRi17zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EQHtVPcI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QNtAf2686076;
	Wed, 27 May 2026 13:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XmuqR0
	b41raTzm3aWHkmUjaUX9RCWIBNdoHdims9XLM=; b=EQHtVPcIq62ecBESz9VdAj
	U6i0R3TLcWmeerRAxT+Akz8cgGIJsZO9yHMPTJcXvRQgC5cFfhAVsk3bfVfczqSR
	qSfTtZu54+4YjHumGmjfk3NpGDD+lq4xOdzSFnVXTZGxCZ4/BqZ+j5cx7yYNDNVr
	V3EZhrYeX3NmZCWfdbTRPQl5PqV8cmGazPCm/DIaehjWu3H857JCsd8htBf/3NmU
	LoP+cz26KxteFn6irSTPYQhJX9m8+3La/GfrLF5F6ME54sqXhCjZRdf1Wa2u1mcb
	IwJ9PJO85CXxyVmj5VTvhxmyCWHAMawFuws7NQ2z98A4t2zRJS1cgXZva+CrHXBQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nusqhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:57:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RDsHUl019929;
	Wed, 27 May 2026 13:57:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb391u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:57:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RDv4SK29295182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 13:57:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 708925804B;
	Wed, 27 May 2026 13:57:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F3A58055;
	Wed, 27 May 2026 13:57:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 13:57:02 +0000 (GMT)
Message-ID: <23a3b9bb-af97-4285-a03d-7b6e7ccb274e@linux.ibm.com>
Date: Wed, 27 May 2026 09:57:02 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzMyBTYWx0ZWRfX5fBf/K24EuzO
 nsdv6eYPHATZbMRT5JqGcW9mfVnSbQgMnV33bmFilJ4hC0Qx03ABlxrUxBnoRtK4FMi7eHJdD23
 DS3XntGu4apmc9wMjiR9Ip2toZOoV1OGZcWC+tnleDmZEEp6HClwlCav9pCl51R+pqDcj0Weycx
 tMh82DTwRb2jIFk/Tmosd+VY1CXNQrqxkcknn1MHAqk38MUDBAd8AdAsc3t2Ku/rMoeu0o1sqfV
 mY6tn8CZhPwa/lrR4fcy0C6Bpaiubtpq6/g4sy4VDZOv2VzuFbOnKHHHM+Iy3VWJUENY+lI5sUD
 exVajXD669sqWHoqpGL3/8/ypKn7n0Me9B2sOwZ/RmGaQkZ20mGWFc4k4ULdqJd4vXmQuVIP8sT
 LVbLzSeJdbE+v7WVIfp+gS17M7UlwbLOh/NrHGuw7E3PSAGwPCzI+QfcRkuppOvFmBSPCfpiKuC
 HHYM681UH4uzBrOlzzA==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a16f832 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=0HL81np-4nXxjsgZigQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _8K7wRkzeIx9ZU8S6Hmi0OD4GBlx-QKK
X-Proofpoint-GUID: RBiMu1fVFZe6KM06mXCyXsRsp6HhymSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270133
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9690-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.ibm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D90D35E56E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/29/26 12:03 PM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 

> Usage
> =====
> 
> The IMA staging mechanism can be enabled from the kernel configuration
> with the CONFIG_IMA_STAGING option.
> 
> If it is enabled, IMA duplicates the current measurements interfaces
> (both binary and ASCII), by adding the _staged file suffix. Both the
> original and the staging interfaces gain the write permission for the
> root user and group, but require the process to have CAP_SYS_ADMIN set.
> 
> The staging mechanism supports two flavors.
> 
> Staging with prompt
> ~~~~~~~~~~~~~~~~~~~
> 
> The current measurements list is moved to a temporary staging area, and
> staged measurements are deleted upon confirmation.
> 
> This staging process is achieved with the following steps.
> 
>    1.  echo A > <original interface>: the user requests IMA to stage the
>        entire measurements list;
>    2.  cat <_staged interface>: the user reads the staged measurements;
>    3.  echo D > <_staged interface>: the user requests IMA to delete
>        staged measurements.
> 

I have a IMA log sharder (based on FUSE; does more 'copying' than 
'sharding') that successfully uses this method.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>


