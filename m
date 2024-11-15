Return-Path: <linux-integrity+bounces-4126-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CB9CD67B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2024 06:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94031F22A66
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2024 05:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723655E73;
	Fri, 15 Nov 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WiVPTPTP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D12F26
	for <linux-integrity@vger.kernel.org>; Fri, 15 Nov 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647435; cv=none; b=ELQpAIEcVK4mFyuugalqt8q69NJ97piLJo3UP++c9hrYLO/uOEnCFNELvhX205dOWdtVs4YWhWl+yYVhO7porPO1k1pCguk6TYtRw0/834CPZuTtjybIZ+xzfsVVse2c122eQ5MF7t91LO1ww8rDexXVUbnMU2mEDFsmuA50ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647435; c=relaxed/simple;
	bh=kbvONSHCWbwAPnnloQS7K7wJEz0eKUzOAID3oHtKl+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssc1bMp6v0YE3jQ3xKEr+YZFFXmc/juAvd2rweO7j/G/JUohYxy1b1RRXX1B6nGG1WJWLDchOypZkRU1aIT9lLV9mwygtZVBM3NqXEGCrg2Wg15ZQNJH157dbqa07wpAzBzaPIsI5dQZuixchevKrnsivg0Y0wRe8vJpzH4Fkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WiVPTPTP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0kHpl015146;
	Fri, 15 Nov 2024 05:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YRUYBk
	Te4kBch3RjQ6hcAX6cCIoUtWoiASLRsd3/EiY=; b=WiVPTPTPu5GtzEC/yVrBdk
	o6nzMj50T0gWArBhpxatatulE0KprOgbZyP/lueE98IS0APHqPvRh0vGJYXJ3ZG5
	xgZuxWbPdWkZks+p0fbY8jykDJsuj4Q+CrFQChbOTaQtduINp7qDL3NEHX9IQrk+
	ZkC95dTwcxrEbuEEFkBvOkxqNFopiGKuj9Iyb/jnBXQCly8SQ2kZT2kCiQ6Zoe1J
	FwaoaLdX2hjBwRgXThzVbVoLRrJZoaJ9MUuBjhomLSxYEX0/Qgfbo/Kmks/4Pctu
	Ec7JQ6fPd0nyMWGvW8Pki4A4wU6uMyqLMDmtZqXMxXvZIVHZJHpHVj/DiIe26V0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc10dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:10:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF41nYt008404;
	Fri, 15 Nov 2024 05:10:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0f2rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:10:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AF5AOLP49021382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 05:10:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3B258059;
	Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2CF58065;
	Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.114])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Message-ID: <219c37a46024eb2c8ae5af342ec26802519f26e7.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima_boot_aggregate: Fix openssl 3.0 deprecation
 warnings
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Fri, 15 Nov 2024 00:10:23 -0500
In-Reply-To: <20241101143726.1278291-1-pvorel@suse.cz>
References: <20241101143726.1278291-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xRLfgMMeLG_P_f_NwX-hIWoF5TlD9l0x
X-Proofpoint-ORIG-GUID: xRLfgMMeLG_P_f_NwX-hIWoF5TlD9l0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150041

On Fri, 2024-11-01 at 15:37 +0100, Petr Vorel wrote:
> From the docs:
> https://docs.openssl.org/3.0/man7/migration_guide/#deprecated-low-level-d=
igest-functions
>=20
>     Use of low-level digest functions such as SHA1_Init(3) have been
>     informally discouraged from use for a long time. Applications should
>     instead use the high level EVP APIs EVP_DigestInit_ex(3),
>     EVP_DigestUpdate(3) and EVP_DigestFinal_ex(3), or the quick one-shot
>     EVP_Q_digest(3).
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Sorry for the long delay in responding.  The patch nicely cleans up all the
warnings.

thanks,

Mimi

> ---
>  .../integrity/ima/src/ima_boot_aggregate.c    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggrega=
te.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index 62468e0d19..68d12fc3c2 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -24,6 +24,7 @@
> =20
>  #if HAVE_LIBCRYPTO
>  #include <openssl/sha.h>
> +#include <openssl/evp.h>
> =20
>  #define MAX_EVENT_SIZE (1024*1024)
>  #define EVENT_HEADER_SIZE 32
> @@ -61,7 +62,11 @@ static void display_sha1_digest(unsigned char *pcr)
>  static void do_test(void)
>  {
>  	FILE *fp;
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_MD_CTX *c =3D NULL;
> +#else
>  	SHA_CTX c;
> +#endif
>  	int i;
> =20
>  	if (!file)
> @@ -85,12 +90,24 @@ static void do_test(void)
>  		}
> =20
>  		if (event.header.pcr < NUM_PCRS) {
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +			if ((c =3D EVP_MD_CTX_new()) =3D=3D NULL)
> +				tst_brk(TBROK, "can't get new context");
> +
> +			EVP_DigestInit_ex(c, EVP_sha1(), NULL);
> +			EVP_DigestUpdate(c, pcr[event.header.pcr].digest,
> +					 SHA_DIGEST_LENGTH);
> +			EVP_DigestUpdate(c, event.header.digest, SHA_DIGEST_LENGTH);
> +			EVP_DigestFinal_ex(c, pcr[event.header.pcr].digest, NULL);
> +			EVP_MD_CTX_free(c);
> +#else
>  			SHA1_Init(&c);
>  			SHA1_Update(&c, pcr[event.header.pcr].digest,
>  				    SHA_DIGEST_LENGTH);
>  			SHA1_Update(&c, event.header.digest,
>  				    SHA_DIGEST_LENGTH);
>  			SHA1_Final(pcr[event.header.pcr].digest, &c);
> +#endif
>  		}
> =20
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
> @@ -107,15 +124,30 @@ static void do_test(void)
> =20
>  	/* Extend the boot aggregate with the pseudo PCR digest values */
>  	memset(&boot_aggregate, 0, SHA_DIGEST_LENGTH);
> +
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_DigestInit_ex(c, EVP_sha1(), NULL);
> +#else
>  	SHA1_Init(&c);
> +#endif
> +
>  	for (i =3D 0; i < NUM_PCRS; i++) {
>  		if (debug) {
>  			printf("PCR-%2.2x: ", i);
>  			display_sha1_digest(pcr[i].digest);
>  		}
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +		EVP_DigestUpdate(c, pcr[i].digest, SHA_DIGEST_LENGTH);
> +#else
>  		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
> +#endif
>  	}
> +
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_MD_CTX_free(c);
> +#else
>  	SHA1_Final(boot_aggregate, &c);
> +#endif
> =20
>  	printf("sha1:");
>  	display_sha1_digest(boot_aggregate);


