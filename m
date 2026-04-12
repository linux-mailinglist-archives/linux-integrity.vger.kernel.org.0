Return-Path: <linux-integrity+bounces-9163-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIT2IiDp22laIgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9163-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Apr 2026 20:49:04 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CD3E5818
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Apr 2026 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B703006B12
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Apr 2026 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED3364025;
	Sun, 12 Apr 2026 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Am89wA0z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B5362133;
	Sun, 12 Apr 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019662; cv=none; b=nUU2da3QquJbr+Ha8GaH2vQsvVwE8p9rmK0L/xNA+9MIZ5RVHJepy7Pn5oSW0kPNfRYlooIJ6lGYXH44Ulbi3DSsXhcBztxyBH1iV3H+g8WhEwAj3QeSis6ceU041K+v670m+NJmxbYxCu8GJt6LkoBwOo6ArvPn6tDhjE3SFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019662; c=relaxed/simple;
	bh=9Obmst+vffFZ2JuGzK4zifDXwljV3xYV6tNooPgFR9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipLnf8cWFvdtdKg0buD7ROUFNRvwh/roVN3d51ZUTxNjztO/BnPlsazCXb9EJ75sPsibtoWabSNi5NoijR842vk8RFUAqPCboflNgmpC77eyaFVbL9zmGG16552DyJgC0+d1QXzF9zcuWtVPL4UR+KEpZDAzRzK76Tg9zWyxmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Am89wA0z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CBteJE2081391;
	Sun, 12 Apr 2026 18:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xj9+2x
	m71UDvoJ8SbcfXc1BJI9JWIvui23ZYPXOYMds=; b=Am89wA0zf+c60FC9KOPmVI
	GMAl5E98UDykqjUYqlsMORhUkV9YJGflXW5eU2rXinL0EXSsC4aN0iGVeetFajwq
	xs6lPiZ+tC4gePmWcwHbBJmR7X+5+Vd02g2rWupEN3iy9E9DISna8IYnrrMl5w6l
	N/YHy7AH25OafBaRn2aRMkquOjEPon7gTa6VlDsrsYWf2oeGFhOkSZObjeo1CIyn
	/zszkPyyu4JFHqfMUxhc2PnQzHsDhERR14tF4cXW4RMedniE2y01YVTw+NXlLrJS
	8Vf1lxN4LFUrAiwTv4nP7DQzib2sUrTtgLAIVyabbgghNpPGtMEAbZFaT7HEuiSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkcrb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 18:47:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63CGD3P5025831;
	Sun, 12 Apr 2026 18:47:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1a3hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 18:47:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63CIlM8L22151690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Apr 2026 18:47:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E40E58056;
	Sun, 12 Apr 2026 18:47:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3928F5803F;
	Sun, 12 Apr 2026 18:47:21 +0000 (GMT)
Received: from [9.61.16.31] (unknown [9.61.16.31])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Apr 2026 18:47:21 +0000 (GMT)
Message-ID: <129b137c-be9b-4b01-824f-beec7111377c@linux.ibm.com>
Date: Sun, 12 Apr 2026 14:47:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KEYS: trusted: Debugging as a feature
To: Jarkko Sakinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260409160752.988713-1-jarkko@kernel.org>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20260409160752.988713-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dbe8bd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rlHd4n21sRncWQMmDL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BUR2Qn7W8kE29AgtgCgbdcxV3guvnvO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE4NCBTYWx0ZWRfX77VwhTiXgwV4
 YmhhxjLCtyUOzManSjWGLizoRjiP1OHmHzYLmpWuWNQ3qSeB5+Cx4THYkppN14MOwUa8t5FcxjR
 Lhe+vAArsZYkf08TioNwHQK559UdkHvfHHlyCMGu5xFjMw9ZoizFiezziTieHP1Vqk9ZorbNRLE
 6adDjweFl+6KdqOScFFfWW5tmYj0gGme6+WclsWpp9Qu4JDMXHTuZOjJgyJDlxIk8I2giE8gc7v
 3j9z1RW5Ow3o8UyMnPMep8fNdgLZiDGe8gLHDgIbVqoWISNHpLrLrzotr/OV/UieGqQ1OjO9V2N
 XJkFx7HPwne01+SOvgGlsJIFq9SbnQEf49OLsW0v4IsejZjHn54rvsKvYel836DSctmowkdBaz6
 LfGxXvsYdPvDpBXZSrU+ibTrsCjg6vGu4QGCnY78GiOJRwY8J4UfK90yRET8dCZph6u9VWh7/Vr
 N7epiJjidGNwOJiURGA==
X-Proofpoint-ORIG-GUID: BUR2Qn7W8kE29AgtgCgbdcxV3guvnvO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120184
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9163-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nayna@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 314CD3E5818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/26 12:07 PM, Jarkko Sakinen wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
>
> TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> feature in Linux kernel. Introduce CONFIG_TRUSTED_KEYS_DEBUG for trusted
> keys, and use it to replace these ad-hoc feature flags.
>
> Given that trusted keys debug dumps can contain sensitive data, harden the
> feature as follows:
>
> 1. In the Kconfig description postulate that pr_debug() statements must be
>     used.
> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> 3. Require trusted.debug=1 on the kernel command line (default: 0) to
>     activate dumps at runtime, even when CONFIG_TRUSTED_KEYS_DEBUG=y.
>
> Traces, when actually needed, can be easily enabled by providing
> trusted.dyndbg='+p' and trusted.debug=1 in the kernel command-line.

Thanks Jarkko. Additional changes looks good to me. I just realized that 
the kernel command-line parameters document may need to be updated to 
include these parameters.

Apart from that, feel free to add my

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

     - Nayna



