Return-Path: <linux-integrity+bounces-9328-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L0sDZjY62lISAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9328-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:54:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5F46359F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905E030086F0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691643FB7DC;
	Fri, 24 Apr 2026 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RoJXI2eR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2363E4C7E;
	Fri, 24 Apr 2026 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064054; cv=none; b=NL0bvA6gMRN5Eehppy7uDTT88VsNfNUjP81KxglWfpfCZWtnOdH3zuQAve3lJc6PUqOSsn8dxWSpSgIIf7Qs8Kn+AhhEpIqAl9HWabeQioshAbhEQUIyOSyN5XoY5/KDT1xcsZlqtEn3ZQ5WyjCh32bE4V4zU7soIYjq0L9+Gao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064054; c=relaxed/simple;
	bh=lIKeU+Qy0EadWyDhE2p4BIH/6J1iOl8VLiE8n9n4u/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uANRRiJjw2b/SPKXkxCeny3yJpyHwo6tcRb+zSd83yGQDIpcoc3VBkRwyCVb7ZrP5Kt4j21RpPWjx7ddQfQOFngZ6UVakdSpXdCmPBCbTjd4PgjmQzMjWsHKb9YSW9V/hUFyccD/aALoYte3dx/mwkJlLschOYvupHePT0eU47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RoJXI2eR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OBP1Qs3514984;
	Fri, 24 Apr 2026 20:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GQEmqb
	ENEJuPwnv49ba5Tw1tG9osvqD3RYmWyVy8RDY=; b=RoJXI2eR/Nis/W9ZHO9KRK
	re5N22FdRGrQyrRnAtwJxCzPuJRTSiJaErAJPzMf4PAkxmHZyaS1KIUYjAHjCc7I
	2hWu0s13kD8zOeJrBTD9XQymiVL23AmF7LUaMJdeJsuHX0TG6yTEQU2822Wo2g24
	/gXogRD0QL7EdGpYL0wBc5brnKPftaZmQyQF2ENoAaE1x+POH3JE4YJNKbtiYJ73
	uPzf07v7Q4RHG5jBfJTST4Vvaxy9lVOStfV+PpEU55irm+Ypc6mmXvBlV7Jy/ck2
	+jwqNyX3cAOOO+ZrTp4akxJzYENff2PS4sO7ntCXT9ZoK/kpgalRs/JEdwq/gF9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2fwhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:54:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OKoZrM021377;
	Fri, 24 Apr 2026 20:54:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky4fkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:54:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OKs50m24511002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 20:54:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE42F58055;
	Fri, 24 Apr 2026 20:54:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4747758059;
	Fri, 24 Apr 2026 20:54:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 20:54:04 +0000 (GMT)
Message-ID: <7fa63e8a-1ffb-4dcd-af01-0811768ecda9@linux.ibm.com>
Date: Fri, 24 Apr 2026 16:54:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
To: Arun Menon <armenon@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
References: <20260324071803.324774-1-armenon@redhat.com>
 <acJqVjZ7eSxOpSL5@kernel.org> <acKGZ33ItHvMkQ_5@fedora>
 <adYTLq0qgWpA1kIS@kernel.org> <aen3zxxedDXlekRb@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aen3zxxedDXlekRb@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIwMyBTYWx0ZWRfXyxow3KZrz6Xw
 7Rj1ESrJweyghEGAGThn8czGOZn4aT6A7vX0UH4/neigYXJ6ahB8q5pIrvdLUsIxXmaG0mq8Xt+
 BZ9nSdc4szSxDT82F8vVewXZvlCs2yDo2JOLxoU6rsgsh6a98ETAXCgSzhGPiLub0sQae+e/s8+
 fRDPJ1ATcbjX26v/c2lKfKeHnahzN8aSUSY+E5h115VOERMxfTR1vf1xDwlFFiWpREw8aW4wkZ8
 qaXd4pLpECTUrPwBdJFQgi5hfaZvXD/pleP2MaTrvg1zEyEU9WE75AnX33zPU9y0oShRFu10Eai
 aVBs0yBYZFN9XEqq7E/l0995ujNNs5q+3z6vhVVF9Ne5zTLlgRebrJalAKWCVu8bpy1k9RN3V3l
 EJ5dnpGQKdT5OSwhBz+5UU+upE4GksJSyURRJXUHzgkyn+EVNs/rHcEvZVMGhEL7YZcVqRSooZ3
 sU893FC3Gfl1qWeUuww==
X-Proofpoint-ORIG-GUID: a1y3ARGhd4OHwwFP-pjZWww6jlI_hLJH
X-Proofpoint-GUID: S73xGG5TUqSJc33m3DAJioMQ60sOva6P
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ebd86f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xt6ew7UTAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=ciYI8vHzxm8BiOPmu2cA:9
 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240203
X-Rspamd-Queue-Id: 8EB5F46359F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	TAGGED_FROM(0.00)[bounces-9328-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_WP_URI(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]



On 4/23/26 6:43 AM, Arun Menon wrote:
> On Wed, Apr 08, 2026 at 11:34:54AM +0300, Jarkko Sakkinen wrote:
>> On Tue, Mar 24, 2026 at 06:11:11PM +0530, Arun Menon wrote:
>>> Hi Jarkko,
>>>
>>> On Tue, Mar 24, 2026 at 12:41:26PM +0200, Jarkko Sakkinen wrote:
>>>> On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
>>>>> The new version of TCG TPM v185 (currently under review [1]) supports
>>>>> sending data/commands in chunks for the CRB (Command Response Buffer)
>>>>> interface. This is in line with the initiative to support PQC algorithms.
>>>>>
>>>>> This series implements the logic to send and receive larger TPM
>>>>> cmd/rsp between the linux guest and the TPM backend in chunks.
>>>>> Currently, the TPM CRB driver is limited by the physical size of the
>>>>> MMIO window. When userspace attempts to send a payload that exceeds this
>>>>> size, the driver rejects it.
>>>>>
>>>>> This series introduces chunking support. The driver now checks the CRB
>>>>> interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
>>>>> backend, the driver will slice oversized commands into MMIO-sized
>>>>> chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
>>>>> with CRB_START_INVOKE. Responses are also read back in a similar chunked
>>>>> manner.
>>>>>
>>>>> If the backend does not support chunking, the driver retains its legacy
>>>>> behaviour and enforces the standard size limits.
>>>>>
>>>>> This feature also requires the QEMU to interpret the data in chunks and
>>>>> forward it to the TPM backend and subsequently dispatch the TPM response
>>>>> in chunks back to the linux guest. This is implemented in [2]
>>>>>
>>>>> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
>>>>> [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
>>>>>
>>>>> Arun Menon (4):
>>>>>    tpm_crb: Add definition of TPM CRB chunking fields
>>>>>    tpm_crb: Add new wrapper function to invoke start method
>>>>>    tpm_crb: Implement command and response chunking logic
>>>>>    tpm: Increase TPM_BUFSIZE to 64kB for chunking support

64kb? I am only increasing the TPM buffer to 8kb. More does not seem to 
be necessary.

>>>>>
>>>>>   drivers/char/tpm/tpm.h     |   2 +-
>>>>>   drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
>>>>>   2 files changed, 137 insertions(+), 59 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.53.0
>>>>>
>>>>
>>>> When QEMU has the feature available?
>>>
>>> The QEMU patches are in review at the moment,
>>> here is the link: https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
>>> Hoping to have them merged soon.
>>
>> Right, and additional question: what about swtpm?

I am waiting for https://github.com/trustedComputingGroup/tpm to show 
rev185 with PQC support so that I can merge my patches based on 'their' 
PQC support into the public libtpms repo.


