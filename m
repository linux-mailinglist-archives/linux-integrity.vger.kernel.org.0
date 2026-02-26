Return-Path: <linux-integrity+bounces-8569-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD+kKVNAoGmrhAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8569-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 13:45:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8731A5DB9
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A625303D2CA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2793859C8;
	Thu, 26 Feb 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+X9J8rA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D014261B9B;
	Thu, 26 Feb 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109741; cv=none; b=pkb+k1LmVZt/OXBMicxz5o1Z85OQYFfW33OBwkqttfbloTokvnCkQMff+qQeHtTamP4X5GYrSNrsI8wc2MlkocIuTuCORVTqrzgXQcIV5Sm9AaQqBfxN5S5oob+wtavJ+rh96RMCO4zuCRnjlkMrb3H6OUvlA4JHy9GcOAvMMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109741; c=relaxed/simple;
	bh=IcNay0btSOXeeAE+kAiTYTA7H/ekXPFYc0x4SXrQGwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMwYcgHO1xuFXOWTlGS2vkkqS22USBGxdBr0PAI5UJ3qAL9c3HIql2tAWMjZHxHsVEDt61xZa5QUs8ly8zuiKx+Hpl1ljVK+HO687vBezjiOyRpPzzZiuqKNIR/akx62K2974caUTHONzHK1Z82XtOFbYba6TZvT6+Je9XG5x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+X9J8rA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q493Wp2713427;
	Thu, 26 Feb 2026 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=41aTUf
	zGa4ZfEXMXDAU3CDN2adSNbMjM07L4F0tJvg8=; b=L+X9J8rA88lWvXn+ijgWP0
	/XJeOUauzAKwg1J2eYqk6k1RJd4HpqZGoTGUK/FgRsWTJuLXQFejCcBC/iZByF6t
	1s0pS/ocO776SmFWhWcr1Hk6KYuKclljgsCld9PM1/gWsUs3/3AHSNU0WA8eKluV
	ZKJpB02NCFQTR/ldbpCpdH81ojTQaA4gaAAOCP7PZgm0yppZrs8hFsV2oYOkeTwd
	SsZmDvw+av7toQQ8ksBbnYyx7dDYo3ZWQVEerUUNkPgp0Fd0f5xYpZh/yu2Bm57M
	9IHT3QQpXTQVQi5i3WdDvIFnPb8spAsZi74yf5jX1YS7eSEozneVXOi7QvyzkLdA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cdhh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 12:42:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QB9Qpl003386;
	Thu, 26 Feb 2026 12:42:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8k34qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 12:42:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QCg21W21234390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 12:42:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FF2958054;
	Thu, 26 Feb 2026 12:42:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA7B25803F;
	Thu, 26 Feb 2026 12:42:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 12:42:00 +0000 (GMT)
Message-ID: <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
Date: Thu, 26 Feb 2026 07:42:00 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IMA and PQC
To: Eric Biggers <ebiggers@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>,
        =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
        dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        roberto.sassu@huawei.com, simo@redhat.com, zohar@linux.ibm.com,
        michael.weiss@aisec.fraunhofer.de
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk> <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260226001049.GA3135@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExNCBTYWx0ZWRfX25OFoWMW75Pw
 wDfGunJuHnlJ0zriWVZDtbkuIN0N0kXBXvP0kZKWvjdQ1LI22alQTCw8s5iGalNYxd128SadDob
 eRRNxrDVzr88sXxMj81bIksnSWknNrXl4Bqmao30StuKaPuMC9Inp33iGk9iaLa1JDSDUuivsXK
 rtW+wbu7/jLsF4pYFPCcm2Z/iGia+6Cq7KiMWC+kgSfqHK509mhqEcrDE8015Ux6wlHpjzZdPI5
 qJi3JTC0DLlZffODO7JZmfyZdWPhKglI36ZMKd/5jisBoTNcV/djDQloGDwyvyrAGuV3zcvMSUQ
 HUCewC8+bp1pHZ69rtSSK5JDLKR5qACyxlyBf5A26KNJi7iBUkJIf0O0PcWJzyJMUyJ7oxgNHpD
 UEt7WkiCtcblRZ1b7AIJNzoDaun4wYD3EH22asFYCAtfFbTW42l/aQcI5/BCQwJn/zM8127dhhq
 buWLq8lsYyJGvePJtzQ==
X-Proofpoint-ORIG-GUID: dLyHBasPuk35xkQkVwjL6WfHqoq8z0qU
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a03f9c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=or4u6VGYAAAA:8 a=LpeavwYcytEc06GjzjIA:9 a=QEXdDO2ut3YA:10
 a=f52p4T1hNPgkgD0SKpRM:22
X-Proofpoint-GUID: -d0xVr0Tbl_weNYPZuUqlD4u7ZGPQL9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8569-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keymaterial.net:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0B8731A5DB9
X-Rspamd-Action: no action



On 2/25/26 7:10 PM, Eric Biggers wrote:
> On Wed, Feb 25, 2026 at 09:25:43AM -0500, Stefan Berger wrote:
>> To avoid duplicate work: Is either one of you planning on writing patches
>> for IMA to use ML-DSA and convert the current ML-DSA to also support HashML?
>> I had done the work on this before and could dig out the patches again...
> 
> IMA already had to add its own digest prefixing support, since it was
> needed to disambiguate between full-file digests and fsverity digests.
> See 'struct ima_file_id'.  Thus the message signed is at most 66 bytes.

The hash there is still only a hash over a file and that hash is signed, 
isn't it?

> 
> With that being the case, HashML-DSA isn't necessary.  It's not even
> possible to use here, since there are no OIDs assigned for the fsverity
> digests, so it cannot replace the ima_file_id.

For non-fsverify IMA signatures it is 'possible' to use HashML-DSA and 
it's 'working' (recycled old patches yesterday):

Linux: https://github.com/stefanberger/linux/commits/dhmlsa%2Bima.202602025/

ima-evm-utils: 
https://github.com/linux-integrity/ima-evm-utils/pull/19/commits

> 
> I'll also note that HashML-DSA is controversial (e.g. see
> https://keymaterial.net/2024/11/05/hashml-dsa-considered-harmful/),

The problem with this is that NIST would have to react to these 
controversies as we race to support PQC. If something is wrong with the 
standard then it would be best for NIST to withdraw/modify HashML-DSA 
asap. Otherwise it's the best to follow the standard IMO because if you 
don't you get criticism otherwise.

> since it was added to the ML-DSA specification at a late stage without
> sufficient review, and what it does can be achieved in better ways.

In case of doubt I would use the standard, though. It's probably not a 
good idea for everyone to implement their own (bad) solution.

> Which is exactly what we are seeing here, since again, IMA needs to do
> the digest calculation and prefixing itself anyway.

Use the standard...

    Stefan

> 
> - Eric


