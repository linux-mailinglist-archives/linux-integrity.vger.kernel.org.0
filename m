Return-Path: <linux-integrity+bounces-9199-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mItIEaLl32n9ZwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9199-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 21:23:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA04075C9
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 21:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C98983015FC9
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F925382F3A;
	Wed, 15 Apr 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZXzf4qz+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E4346798;
	Wed, 15 Apr 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280988; cv=none; b=L1xweF4QBDjBDE4FUovWNRYP1/cf1fUGP8qA5IvIrBCz7omgkEQeO4wxn9wbreBT01zZk85M6ICTpwDQcA9jV3qySxEk93P+++ae1GfH/Q/Tnh8Q3/wc7h+VFgZBl5rHcuDHzunuGYmXZuWJWTQG45bqSUIEhuVn1gcyjTus2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280988; c=relaxed/simple;
	bh=5RkGz1K0hReBzWwrXMrKH8V/FDNJ2qE0UhivQHQOhbk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ESM/GwPa4yG1xNsGyGNkBUiO1FwY2QssRvPdW5gnDBGCZnrtNe5Z9RiOdcno//ftAWrb+wpOaXZc+IOPi3dnUnKT3hEVfXnqK4/m3CFKgUiEQTPPmf+MhMY7/RP6N+h8cjsfoyghR+qD+6pJgDUDDXcLWFRAJBzyjlJwAI6om/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZXzf4qz+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F80FhS2405341;
	Wed, 15 Apr 2026 19:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=in8TXy
	LIlJgKKPPq5RDQYo1/Peg0PWhsclNE0NDcTNE=; b=ZXzf4qz+ipfIAVrIpejB1Y
	q8jqaS+8p/D6pUI+viQb7sTYAKSs76CDd+Ehkz/DgYzE2UrQh03DoFYe+cmseZT5
	/mYDMk6BYVizYoUw6W/veO7nrE1bFK/GJ6gjcwe94M8kka8yqaKuKOJ5QQ4EV6j5
	V1C3YUVldAOJBinxsGMJCmVyypELltVZqS9foyWOSB3dVj7Vn6XS32mA68HKAu3p
	LZ3poldfoko3jaD9aJj0QMqeQJOoMMKxsQCtB4Ad4PIWlLU/ea1o0UWRduyWllRU
	Wcp7WaoaP5YAh2mWloTs6bYwS1bX8Gq3F6TVs1O1zyI7KDpu1MnGx3ICdPoSrOBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k9aws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:22:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FH64bW003557;
	Wed, 15 Apr 2026 19:22:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnfqa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:22:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FJMger18088524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 19:22:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7BBC58062;
	Wed, 15 Apr 2026 19:22:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC4E15805C;
	Wed, 15 Apr 2026 19:22:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 19:22:41 +0000 (GMT)
Message-ID: <29a582527e1c35470cd1696df2febbf8d6d28d7e.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Use KEXEC_SIG_FORCE for rejecting unsigned kexec
 images
From: Mimi Zohar <zohar@linux.ibm.com>
To: Chi Wang <wangchi05@163.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chi Wang <wangchi@kylinos.cn>
In-Reply-To: <20260415102319.431379-1-wangchi05@163.com>
References: <20260415102319.431379-1-wangchi05@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 15:22:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zEeQo_FnsEhp2ZIf3d0YhwqMbe847zSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE4MCBTYWx0ZWRfX+HgzdXPsYHxr
 pK4ZWDAO7AmbMuxz4R3wbX1ejsRBrnqAVRhaA1Pbm+HSU/70w9iid1eHtZ2uvPHfU+Le4Lx/+2b
 c0NPFhh6LWKf6iomCAgs8ZyqfbTeAfv3+vkDoPL4gyOI+pZxNtud2tXcTH9eAEENuf+p4PCkSRB
 CgA2q/8t+0/W2irSl8fXCHlgADqtUIxMRtwUReXHrHjA5a1VAu7FuYdU6zfPKnYAeyd/TL4bln1
 QMlm+BjDuwLziZSLpoarnd+eCjFu28WZOQUOS+w8NARsnkzOhg0WNaiB6xgLXUy3Rrr91Hk3JC3
 crewm14A9DIdmKBk1jLSaQ0Koi/aSbm5si7frxwjVTtPwcGOGHUisKRgooCQv2b3e/POzSJtT+O
 BWV+4pqgz3PxlFM7hHMTQG3ba5gKZatL5VhAmzpkp9za31FLuWf/iDAMJY76ffBEZ/krBoCffX3
 MpLRdVcTG5+EFR5g3gA==
X-Proofpoint-ORIG-GUID: PaTimbr5IOY6weNz41rJCksfW0EtvI93
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69dfe584 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=FlH4Kd1zI9MFz2v0kxAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150180
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,huawei.com,gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-9199-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 28AA04075C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 18:23 +0800, Chi Wang wrote:
> From: Chi Wang <wangchi@kylinos.cn>
>=20
> Following the split of KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORC=
E,
> only KEXEC_SIG_FORCE indicates that unsigned kernel images must be reject=
ed.
> KEXEC_SIG alone enables signature verification but permits unsigned image=
s,
> so it should not trigger the IMA appraisal denial for kexec_load.
>=20
> Update the condition in ima_load_data() to check for KEXEC_SIG_FORCE
> instead of KEXEC_SIG.
>=20
> Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG a=
nd KEXEC_SIG_FORCE")
>=20
> Signed-off-by: Chi Wang <wangchi@kylinos.cn>

It isn't enough to check whether CONFIG_KEXEC_SIG_FORCE is configured, sinc=
e it
is possible to require the kexec kernel image to be signed at runtime.  Bas=
ed on
the IMA policy, IMA will call set_kexec_sig_enforced() to require the kexec
kernel image to be signed.

Mimi

> ---
>  security/integrity/ima/ima_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 1d6229b156fb..ec70e78ab8cd 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -953,7 +953,7 @@ static int ima_load_data(enum kernel_load_data_id id,=
 bool contents)
>=20
>  	switch (id) {
>  	case LOADING_KEXEC_IMAGE:
> -		if (IS_ENABLED(CONFIG_KEXEC_SIG)
> +		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)
>  		    && arch_ima_get_secureboot()) {
>  			pr_err("impossible to appraise a kernel image without a file descript=
or; try using kexec_file_load syscall.\n");
>  			return -EACCES;
> --
> 2.25.1

