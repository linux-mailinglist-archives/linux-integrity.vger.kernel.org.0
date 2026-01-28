Return-Path: <linux-integrity+bounces-8352-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFMxAjFTemnk5AEAu9opvQ
	(envelope-from <linux-integrity+bounces-8352-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 19:19:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2BCA7AF9
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D54A730022E2
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E434F48C;
	Wed, 28 Jan 2026 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OhZzhdo7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF9345751
	for <linux-integrity@vger.kernel.org>; Wed, 28 Jan 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624247; cv=none; b=mQDyfxpwgjT9T2u571me8KN8EsybxNwOJWmC01Wjs677lOG8eajCO+sdIgXPopoOy1ALgyAM/HbCM9C3lVveWGYDiIt1576FE4QnT5dIkkEYOE1mm+1r+bKhLOp3ZtwcrabGWfeIQ7Urq1s2FcbMfcllk6MFCbftrqe4QX7yZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624247; c=relaxed/simple;
	bh=l3l36art6lfD98RxbSAygBC7R7tYCr6mDTNSTuc4L7c=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ogs287DXCLaZSY7UZhtb6K3Xtlyczh3b6VB5rspwPFwqnDWZgZIFuSAuQXQ+H2AQNxXd2BhtnxRItDsDmVgnAnBOks+8SREoyIE6Dv1Lmlc6qwI+2xRg0613vQPERV3vPbPFwnkEypM003davKe3RYEoZMmNyRjr/+HNR1wYWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OhZzhdo7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9kqbn003816;
	Wed, 28 Jan 2026 18:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eRXuKq
	RFz2WiWmwABW14vT9HmUAACDs+EATLssEMjuk=; b=OhZzhdo7scdsogVkWYpgYY
	LO6y2TLPUQr/+Tte9FmBIc84EvjCk4UAmY+sR8AenLnvRKOSNkpG1aayWD1Mkmaj
	7mpWfYvyvOmLZnsGS3AeqNuaBF5Lf+jK3KtCRtdai2bAgE2hIjEG5x0JPcb3RK99
	gyWb67LggdTGTQBcM9UDtuw6lGH68tSvOeRF8M+riSdB2c5vqKlXxOroWDCJThdS
	5t2yr9wxa8eV2z9ny2A3uMz8SDxk9n8D3r6jYEXzMOhEvYg8quDJ//uinfo/CY9s
	evLeGg9PAwzlKJQYONsIhOfzX1MSsrQpSKywZK9Cb2+J2sU/tZAE/+VoTLF//SFA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg2rky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 18:17:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SFXPhx006692;
	Wed, 28 Jan 2026 18:17:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8syenth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 18:17:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60SIHE8n18612960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 18:17:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB3658062;
	Wed, 28 Jan 2026 18:17:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E04758055;
	Wed, 28 Jan 2026 18:17:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 18:17:14 +0000 (GMT)
Message-ID: <daf396f955b3aec1802fc99a464b94a947a7c1d0.camel@linux.ibm.com>
Subject: Re: [PATCH] ima_setup.sh: Fix signed policy requirement check
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org, Li Wang <liwang@redhat.com>,
        Cyril
 Hrubis	 <chrubis@suse.cz>
In-Reply-To: <20260128125852.37411-1-pvorel@suse.cz>
References: <20260128125852.37411-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Jan 2026 13:17:14 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697a52ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gZqqgoKqdoXuXVtkYhUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 23YsqnmL4T6uTZCjkmE3Y8fvpn5Jl3A4
X-Proofpoint-ORIG-GUID: 23YsqnmL4T6uTZCjkmE3Y8fvpn5Jl3A4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE1MSBTYWx0ZWRfX34TOdnR5d5AM
 KVUZyi4eDsvlob6T3OUVEbRqq9Z0sZPy39qUvS3c2UA9QTVbYI4VpFCgHJe9FoKPRy37StbnIO7
 oX96IzSHXVUTCXN+lkTbUITsN3zGIb7u84j45jgZzy/RgtCTNziGOojlzLMiFK4UHgYVIq6tbWi
 88gNlx6MLAQ+qA9bmnMIBLtgElpwICqYq3DyqQ/rRfCRCluYcNAFlCxGKN3uSZg4y0a5mf2OLbm
 M9sWK6B6U5nuj4r8kK8vf6HviC994+CYsnD0CoNNg3Sh16RSsUCjKQ22md8dBVMvDD5Y+vcsJZp
 RoG0XlvzPtdhay2d8IsbHPP8PQvfKKeD4sXvVygjH3b2w/4Eu123uafY7qkj+Lg0N3492LQkWAE
 5m0U43/xRB1+uNOT1s9ezmt/5F621uqw/JIAoiG1nORXy56dM7DRs6I4/Grv3Jj8FIeElHmMZoM
 680tl2q3K/XhpddZZMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_04,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601280151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8352-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,linux.ibm.com:mid,ima_policy.sh:url];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9B2BCA7AF9
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 13:58 +0100, Petr Vorel wrote:
> tst_require_kconfigs() quits testing with tst_brk TCONF, but that first
> hides the explanation in ima_conditionals.sh (which also calls tst_brk
> TCONF) but also quits testing in ima_policy.sh (which calls tst_res
> TCONF). Therefore use tst_check_kconfigs binary instead.
>=20
> Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to=
 be signed")
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> FYI Fix needed before the release.

Thanks, Petr!

Tested-by: Mimi Zohar <zohar@linux.ibm.com>

>=20
>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index df0b8d1532..b69d7c31d9 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -469,7 +469,7 @@ require_evmctl()
>  # d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
>  check_need_signed_policy()
>  {
> -	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
> +	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_check_kconfigs \
>  		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_=
ARCH_POLICY'
>  }
> =20

