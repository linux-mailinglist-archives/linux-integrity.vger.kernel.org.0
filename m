Return-Path: <linux-integrity+bounces-9787-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nSHEHBa0KWrEcAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9787-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 20:59:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC666C66B
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 20:59:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=oJSPLods;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9787-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9787-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63AD230D6563
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E862D46B3;
	Wed, 10 Jun 2026 18:59:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4832110E
	for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2026 18:59:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117971; cv=none; b=U8hBsX6OQy4k0Z3yzbNuAMH3zsEkdvkrTt1YFXupuOGbUYoz7lFVlmUBCn0BuREz6s+cW57bl/3bJeutwh1ZNGRyMq7heK4Mq6fSrHF6FrTWPXBdzzrh2Ia6wZVnXhE5/XNmHEmT8bc+6mz+DvRjthT27a9D5d/sb01hZbtf+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117971; c=relaxed/simple;
	bh=AYsozwGTHL1SD0ijRc5Niwpf+ORqv2vfJ9yueJ7Mtjw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CRX0iXLdHmIVhB0w64pttF+RPmgS/nlxgA5bzpzA8a0j5kbKqy6ibnWLm8L4rQepB+5eYoUkU/sCvjYI9D1GRWFBPYeH+OE0aKmdKtQPcsrEMt/LFfaAbc1XepCP8hM9R+x/Nxk2yAymdqRjN8RfvRIptIEer4MbRrz3BXJfGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oJSPLods; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AE34jF3385579;
	Wed, 10 Jun 2026 18:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nNE9MF
	DmCxo3H3yVsjfJF8+y/vQBi03zzRHrzKjjiT8=; b=oJSPLodsa4NcsqsIbTD+aZ
	IXNJ5RzbbIMBYjo5DSkHrOj4WYZUcvslGZ5FW1G8oynWSN3PvZh+EZGwLvfg9oYG
	3NsSQyT2LAHikAzc7GPHnF1lPrTWlNLKF6g9fq3yuxaBBm4XsWsQiqED8Qf+kyXV
	Di6rjKLYHtwNK2UGSLOE+Cf/2uZpB6tuxgogcV2I+8tUaaP8tl7msGvEmB6iKPfk
	B0Fsk7xAHUvI7wesN/14gkyoFVRFlM45YkYxxRaJaf2PI1H2qDxLajppf+oVZV8P
	DZo0gMnYiFjIhVCHiEoRRnJJMPybxSzC/VYOQoXxj3/LwTRW6ehQo8sNk+XSXW5g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9yea8r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 18:59:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AInwY3011527;
	Wed, 10 Jun 2026 18:59:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyfrd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 18:59:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AIwkx927984576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 18:58:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC22158059;
	Wed, 10 Jun 2026 18:59:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D7C758043;
	Wed, 10 Jun 2026 18:59:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 18:59:17 +0000 (GMT)
Message-ID: <2658c55c9d6a97ee8edca682d27369138aab67f5.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v3 2/2] ima: measure buffer sent to securityfs
 policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260526135118.289633-3-enrico.bravi@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
	 <20260526135118.289633-3-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:59:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfXy6os3zbj6VT4
 j83Ml5UR2DxKArD5NNslzo3U9cAix++QcMwvc29IT5oLvp+kW+l73JL1PLb7DYP4gTwq3IoBlOL
 ANEW9JcGsSTuA6G9IrvTfsaq/Qh24eNVD5/JWRFQrTgLlnj53hK61s8UQPbAaQW+dw/scRtANa5
 Zy7fyiZ/5HPNMFL5/3bZB625UOhvC+btktM8b2SU0/kR2CDE3HVLpnbc7a9dl7ntLELgEkMp8q9
 DUnfr+s/qFO7lm1iA1D69rccoDNSbH3A4PDZ5VHrpwVn7Mi+TwSkTrYvSOmjHlEXdywuo4JHB7A
 IIch2CwyU3HPJonkzvjJ9POzcQ1+1hDsQ6Gv6p7oUmnNEsupQmvDtcdHv2rxE5dC34QkOIeGk+s
 Hn4YD9dCNLhF2TwRnDVCiPfK2+Hgkos2GBboEog+sEzbB+Ar2KMk8i+1J8XfXO8SBePMaiW8ZjL
 NhIepEO443qaG+6OGsQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a29b407 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=i0EeH86SAAAA:8
 a=Wjwe3WzzfdviBRpyiGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XXTOIHeFop_JYCKbp6VnvhZN3LFqaO_J
X-Proofpoint-ORIG-GUID: zWfcwyWOPPRQnDhl3Vj3DSCp_XCJHVYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100176
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9787-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BADC666C66B

On Tue, 2026-05-26 at 15:51 +0200, Enrico Bravi wrote:
> When a signed policy is not mandatory, it is possible to write the IMA
> policy directly on the corresponding securityfs file:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy

Or by cat'ing the entire IMA custom policy file.

>=20
> Add input buffer measurement, regardless of whether the new policy
> will be accepted or not, that can be caught when
> 'measure func=3DPOLICY_CHECK' is enabled (e.g., ima_policy=3Dtcb).

Enrco, Roberto, a reason for measuring invalid or malformed IMA policy rule=
s
needs to be provided here.

In addition to the "ima_policy" critical data, why is this mechanism needed=
?


> The
> measurement template is forced to ima-buf.

Please include directions for verifying the measurement record here in the =
patch
description.

>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_fs.c     |  1 +
>  security/integrity/ima/ima_main.c   | 19 +++++++++++++++++++
>  security/integrity/ima/ima_policy.c |  3 +++
>  4 files changed, 24 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a223d3f30d88..320c80a1a847 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -426,6 +426,7 @@ void *ima_policy_next(struct seq_file *m, void *v, lo=
ff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
>  void ima_measure_loaded_policy(void);
> +int ima_measure_policy_buf(const char *buf, size_t buf_len);
> =20
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 75cb308cf01f..601718e02429 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -362,6 +362,7 @@ static ssize_t ima_write_policy(struct file *file, co=
nst char __user *buf,
>  				    1, 0);
>  		result =3D -EACCES;
>  	} else {
> +		ima_measure_policy_buf(data, datalen);
>  		result =3D ima_parse_add_rule(data);
>  	}
>  	mutex_unlock(&ima_write_mutex);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 1d6229b156fb..174110da0030 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1204,6 +1204,25 @@ int ima_measure_critical_data(const char *event_la=
bel,
>  }
>  EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> =20
> +/**
> + * ima_measure_policy_buf - Measure the policy write buffer
> + * @buf: pointer to the buffer containing the policy write data
> + * @buf_len: size of the buffer
> + *
> + * Measure the buffer sent to the IMA policy securityfs file.
> + *
> + * Return 0 on success, a negative value otherwise.
> + */
> +int ima_measure_policy_buf(const char *buf, size_t buf_len)
> +{
> +	if (!buf || !buf_len)
> +		return -ENOPARAM;

Please return -EINVAL.


> +
> +	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
> +					 "ima_write_policy_buf", POLICY_CHECK,
> +					 0, NULL, false, NULL, 0);

Parallel to "ima_policy_loaded" consider naming the record as
"ima_policy_written".

The indentation is off by a character.

> +}
> +
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> =20
>  /**

[...]

thanks,

Mimi

