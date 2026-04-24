Return-Path: <linux-integrity+bounces-9331-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eER4L97f62mdSQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9331-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 23:25:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 226224637B1
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62AE301AD21
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA8331202;
	Fri, 24 Apr 2026 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gv4uBpx7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D834A788;
	Fri, 24 Apr 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065909; cv=none; b=Qt8Yvl5Sh+WNLu+CwgykejhD/7Dh2f/MIx/BNRlcz4lZmZGTO8XH1J2KR/kmoMFb/t0dh4czjKlUI1Xb5XblUgphk/pDZjbvhO7/s03yx8MWzHEQcyrzDsyI57IFzaIzn2zngeOXZNZybW0XGOpodOsTBPVhvol+lPrY4tY5N8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065909; c=relaxed/simple;
	bh=LeeGTRmer4kJjvzYRNt1FQGUsSGON7EYs4Opf8HSvF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMwPGBaLXQn3NJZx8CiHsiQ+p4kp3w0yuaXmOF0Crm/SX6EHwijw01etUw9puP9Qb/vLELC8JjqFbPag8+aPPbskHQqsDRiMqoSy9QJgSxK0IbaLEmiLTOv2jFgnEJt+hw0ZAwQwWMKiPbapXO5v38ZylLtNuDGjpDuN/wMM3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gv4uBpx7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OAPLrn3514974;
	Fri, 24 Apr 2026 21:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cKqU+K
	zLqmmz5PqQx281ISya1zz9md2eKxqLEEYUbfc=; b=Gv4uBpx74XNn9QkbxwTuLn
	PWszZ7UMEgLs7vWt1+g+sOrzqsno0/H7FPuGJz7our9/2NwLndgdSp1uaUtMvm3G
	ZHuyPpCSOJYX5aYRBOoh1uhU76mX1zsmHU6+zAHC0Rr38h+muhO7CG4S6LXuLSNX
	0eWs+wpoLSG3cDsxfnhIxeTxHXRX70AX4eQ141yGOJXY/ZON2Ae4cTvWu3YE0ESD
	cnHFk50pIRAutfyTeB8ttK2jbCs4hNnkYOCjfXrr5YqcGNzD3Uu1o0YpMFvVqhRb
	Qkkctgmtow8Lg4ogjY4P0dvGS2CpOtBlc0zblTLHtw3eY5aM7vsR354ssrDgyq/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2g0r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 21:25:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OLKNru031900;
	Fri, 24 Apr 2026 21:25:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyck2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 21:25:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OLP0KP31851166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 21:25:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89FB58052;
	Fri, 24 Apr 2026 21:25:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F52958056;
	Fri, 24 Apr 2026 21:25:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 21:25:00 +0000 (GMT)
Message-ID: <cb9bbe9e-094f-4952-8adc-7ee14780b913@linux.ibm.com>
Date: Fri, 24 Apr 2026 17:24:59 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Fix sigv3 signature handling for
 EVM_IMA_XATTR_DIGSIG
To: Kamlesh Kumar <kamlesh0hrs@gmail.com>, zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kamlesh Kumar <kam@juniper.net>
References: <20260424113946.16561-1-kam@juniper.net>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260424113946.16561-1-kam@juniper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIwOCBTYWx0ZWRfX7PZo5LAaqhZs
 exzjECXXak1j+UyB7Sa0WHf1d4uYpcBBxGPu3psd8aEK+V8DkQ4pjpYm9Wd7fgz3iZiiDjxVHrx
 J/xdBz4/wLH2nZydUv1W0tlUixeNzIhveWsmn9pHqe4ysJdpeYmL/lPOfzmpiEC6oOWiSBEFbSk
 TFf3DZSR+6gmmIXi7nxj4JiurmQKRrnYSeDINiuU0/XP8HKR44ju+5NyZCa3P4oA0I7AInET/lE
 tZoNAgBXD483PnKQ/tP1l7S3nG7pIhYJOZnRH+PCe3yNBwnMGN8Q1StcLdALNfdtuq0K2t2mdln
 11BDS/GzgUYA2r5H90aas2u01HgXRqzmTyPu8osjHZYBoergsnWQGcNPxFROFSq0XDAsZU4LKFk
 npPfeA/TuE+zZBmxapJUas6ec0yEJeeqCJaqGORw8e5xV10eFBMKnCNfTngJd+L6njbdSPfZsgs
 K0tX4Rpc9GLRm2GN16A==
X-Proofpoint-ORIG-GUID: GYcKugbro2Z8W-mJbbqVuwV52mhg2gyM
X-Proofpoint-GUID: ri6L__QCnydnfVOfvhP5KDzhnk9pB-cT
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ebdfae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=OUXY8nFuAAAA:8
 a=VnNF1IyMAAAA:8 a=K50TDT6L_iEZZMke8KIA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240208
X-Rspamd-Queue-Id: 226224637B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-9331-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]



On 4/24/26 7:39 AM, Kamlesh Kumar wrote:
> ima_get_hash_algo() only recognizes version 2 signatures when the xattr
> type is EVM_IMA_XATTR_DIGSIG. Since sigv3 signatures also use
> EVM_IMA_XATTR_DIGSIG as the xattr type, version 3 must be accepted as
> well to correctly determine the hash algorithm.

Thanks. I tested this with your patch. I can sign now with evmctl 
ima_sign --v3 -a sha512 ... even if sha256 is the IMA default and IMA 
verifies it now. Before I had to use evmctl ima_sign --v3 -a sha256 ...

> 
> Additionally, ima_validate_rule() does not include IMA_SIGV3_REQUIRED in
> the allowed flags bitmask for MODULE_CHECK, KEXEC_KERNEL_CHECK, and
> KEXEC_INITRAMFS_CHECK hook functions. As a result, policy rules with
> "appraise_type=sigv3" are rejected for these functions.

# echo "appraise func=KEXEC_KERNEL_CHECK appraise_type=sigv3" > 
/sys/kernel/security/ima/policy
-bash: echo: write error: Invalid argument

This rule is now accepted with your patch.

> 
> Add version 3 to the accepted versions in ima_get_hash_algo() for
> EVM_IMA_XATTR_DIGSIG, and add IMA_SIGV3_REQUIRED to the allowed flags
> for MODULE_CHECK, KEXEC_KERNEL_CHECK, and KEXEC_INITRAMFS_CHECK in
> ima_validate_rule().
> 
> Signed-off-by: Kamlesh Kumar <kam@juniper.net>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/integrity/ima/ima_appraise.c | 5 +++--
>   security/integrity/ima/ima_policy.c   | 3 ++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index de963b9f3634..2dd231567710 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -195,8 +195,9 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>   		return sig->hash_algo;
>   	case EVM_IMA_XATTR_DIGSIG:
>   		sig = (typeof(sig))xattr_value;
> -		if (sig->version != 2 || xattr_len <= sizeof(*sig)
> -		    || sig->hash_algo >= HASH_ALGO__LAST)
> +		if ((sig->version != 2 && sig->version != 3) ||
> +		    xattr_len <= sizeof(*sig) ||
> +		    sig->hash_algo >= HASH_ALGO__LAST)
>   			return ima_hash_algo;
>   		return sig->hash_algo;
>   	case IMA_XATTR_DIGEST_NG:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index f7f940a76922..b1c010e8eb13 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1313,7 +1313,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   				     IMA_GID | IMA_EGID |
>   				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>   				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
> -				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
> +				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS |
> +				     IMA_SIGV3_REQUIRED))
>   			return false;
>   
>   		break;
> 
> base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525


