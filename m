Return-Path: <linux-integrity+bounces-9615-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NtlDFJpDmob+gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9615-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:09:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D246859DE87
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E19C302927B
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05845314A83;
	Thu, 21 May 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RcsNTaOZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70942D7380;
	Thu, 21 May 2026 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329259; cv=none; b=BnxF2q+z+IULiBhKn0KDnmUUWDk0O8ewPeNqz06NLxPC2HN7dM8cXsKW1NfnmRNtcd0HtQ53tuPrGvZ0vlb+QGeG2HHILIspxc+1harmEuVJeLQ6ASIOKj0vMLI0rLZQEHvUXtvjfbTnva9X58LH2wJu1CUBTmK5LJGn+0+aghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329259; c=relaxed/simple;
	bh=bNyQRNe3I3Nws6McD2M7VMqROUb7wW1OlvHVKmoh6yE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Kir2MCOUICkEmBjwHBHweCDp/3/jBFJZW0Wn+BeEX2g8vR1eFXrryuW+tSHEGPKJ+8+pEKOamB0O8QS8em3PB/CyuAM89S/kUuCF9xgTx6Rw8Ahq0SNGvgmxMQMXMRu4Ls+KacBeBcqt2tCOecgxoAhl8oXpIM15JJNUd/vCgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RcsNTaOZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KIpETb271835;
	Thu, 21 May 2026 02:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y21PSi
	+6gofFP6vMYcH82yovtBlOTOuntdtlB52BhY8=; b=RcsNTaOZn7fdNZiyJisAiN
	isMx9oU9hU3RsbbphD5W3qI5R3Dytg/VCUmnzWI19vvO7hrvGSBo90VEKj70YSLo
	UrejmavQqO86AxWZnyvRqUDVUUglaqcvbIj+d2zOGNrBUqCewxgNdA4JMxUiNCAJ
	dXhV1n9oBwZBJ+Fa4TB6mqWdqPA0TypHuabE5BleDCH9xMgmyHZXO9PxOdUjk/25
	YHgRQwpud/bKVj8w+L3Wz0lqcEnJwL09JuTTbMnmt3q7mXJH3CjuLGRucJGAGQGj
	NloKz5jpOjdL5w03h7K4UP5QzAAXbDmbvtlpQ/ThgIskr+IiJviE3nbN1TEBzGZw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h754rkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:07:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sRJs009657;
	Thu, 21 May 2026 02:07:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754ghtkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:07:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L27Lhi7930498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:07:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC91D58059;
	Thu, 21 May 2026 02:07:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDE458053;
	Thu, 21 May 2026 02:07:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:07:20 +0000 (GMT)
Message-ID: <db872f810f22bf25ff0ae7fe15b44f316b078079.camel@linux.ibm.com>
Subject: Re: [PATCH v5 06/13] ima: Mediate open/release method of the
 measurements list
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-7-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:07:19 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0e68db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=t4nDwWJJuLah8Gv1G-QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: m3_YTh-WZsqd0R9mkkmRxumx8BepOcc8
X-Proofpoint-GUID: C3ldsTRg94NL25-HvTjoop7f3yQiD0CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAxOCBTYWx0ZWRfX4VqLuRYtJ+bi
 b8xeT6BcswWlmhkc7Uq54m7rCJWYI3QRYVJJJYzA3xMhn3Nd4gw6BEwQz9b75jMuLLyV4kS/9bo
 Kep8wMYsHJ7Wk1qolD7FFo0+vsn6N9ifKHeUEYdh2vDMZ+QbkJVlFyH3PBrbYck6FEymJfqharj
 EYhVsLtmx/SFJjyVBqNilGTyFdoQnSlVBy5sh+IWLCtXnVlLzpM7jWHBcnNQfkjT9pVddh8t0tT
 eTrIkwkrDqvHUGk7mxgy+uy3zN/YvsZyzhcfnKIFV80dVwavQFLPtWja1oe3zTfI6t6H9S+lKnl
 RaVLwK0LnLdLeSr2SST7v90HKxd5uYeIx3PnSfAN3u3lv1KUlmFv+1kQKSYNlZkUuR/sGRcoenm
 LxQC3BS+tLHImQEh7PKUVPjwXIZjzRON2t7q73Wc4jZrk4WJ0weV4DSAJLCulszDPJ/Omh4Gl1o
 8ksgL02LZXH6Rlp0SXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210018
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9615-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D246859DE87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ima_measure_users counter, to implement a semaphore-like
> locking scheme where the binary and ASCII measurements list interfaces ca=
n
> be concurrently open by multiple readers, or alternatively by a single
> writer.
>=20
> A semaphore cannot be used because the kernel cannot return to user space
> with a lock held.
>=20
> Introduce the ima_measure_lock() and ima_measure_unlock() primitives, to
> respectively lock/unlock the interfaces (safely with the ima_measure_user=
s
> counter, without holding a lock).
>=20
> Finally, introduce _ima_measurements_open() to lock the interface before
> seq_open(), and call it from ima_measurements_open() and
> ima_ascii_measurements_open(). And, introduce ima_measurements_release(),
> to unlock the interface.
>=20
> Require CAP_SYS_ADMIN if the interface is opened for write (not possible
> for the current measurements interfaces, since they only have read
> permission).
>=20
> No functional changes: multiple readers are allowed as before.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_fs.c | 71 +++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 9a8dba14d82a..68edea7139d5 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -25,6 +25,8 @@
>  #include "ima.h"
> =20
>  static DEFINE_MUTEX(ima_write_mutex);
> +static DEFINE_MUTEX(ima_measure_mutex);
> +static long ima_measure_users;

long?

> =20
>  bool ima_canonical_fmt;
>  static int __init default_canonical_fmt_setup(char *str)
> @@ -209,16 +211,76 @@ static const struct seq_operations ima_measurments_=
seqops =3D {
>  	.show =3D ima_measurements_show
>  };
> =20
> +static int ima_measure_lock(bool write)
> +{
> +	mutex_lock(&ima_measure_mutex);
> +	if ((write && ima_measure_users !=3D 0) ||
> +	    (!write && ima_measure_users < 0)) {
> +		mutex_unlock(&ima_measure_mutex);
> +		return -EBUSY;
> +	}

Thanks, Roberto. The code is really clear and well written.  However, it co=
uld
use a comment indicating the different ima_measure_users values as a remind=
er.

ima_measure_users:  > 0 open readers
ima_meaasure_users: =3D=3D -1 open writer

> +
> +	if (write)
> +		ima_measure_users--;
> +	else
> +		ima_measure_users++;
> +	mutex_unlock(&ima_measure_mutex);
> +	return 0;
> +}
> +
> +static void ima_measure_unlock(bool write)
> +{
> +	mutex_lock(&ima_measure_mutex);
> +	if (write)
> +		ima_measure_users++;

There should only be one writer at a time. ima_measure_users could be set t=
o
zero.

> +	else
> +		ima_measure_users--;
> +	mutex_unlock(&ima_measure_mutex);
> +}
> +

thanks,

Mimi

