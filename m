Return-Path: <linux-integrity+bounces-3717-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D898A6A8
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E3C1C2088B
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305818EFEB;
	Mon, 30 Sep 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NuxwLe75"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BC189F39
	for <linux-integrity@vger.kernel.org>; Mon, 30 Sep 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705381; cv=none; b=kNtgVRgFKlaqpwmQWO7HqCycO1L4xX6dDwxiAzltBGqqXZd+YI0M+mtrl1O1Iz97I0/XkVZaXPypCiXAq16dsnfScewfiQqieeBMnlHI4EH1aDEiJGNkoLwPBGbS26u9CbVoTQnPQnNh8JfAL1HdDlk0PWIiXQo3k3rbZE0bCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705381; c=relaxed/simple;
	bh=VTRD/Kl11IC5Xn6VrW5Hbm5j8B+sdnT7i6s7vlZyhtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGcTFZw0WNEyt7UIwuQQPzGmd1584jv2LpRKr9zpZkF/QTpXWbbEx6QGMSpnLf4xsO4aF52lR4Guv6n+wyISnLYunpdH+yrV6AV/ul/dMNB/XUOFhspPbWb989008A+QUKQhwgdWLEJZ9ttFMGzZTv4SZoDhAmkwJgRq/cq7Vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NuxwLe75; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCrliL027232;
	Mon, 30 Sep 2024 14:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	ERGiKhyacxZx9nSvEYuSQhE3SpODIX0jvVJoDcOG+8Y=; b=NuxwLe75ZvVlC/E5
	VyOVcOX3PLComUfZAZ0MvpAZxZ6ZgodrkUBm7qyRiqXqCo6APR50Kmbmpxph6CxL
	F3/S//CG6BwfxCMl3FVxDi7Zmd8YWlAUll0NR9e5qw+EjAGWwg4fbVWZYq65S9OP
	XMF1EyfaVKQUm1p7qTyU9MsbERPJpW2iQzTUEpUejNz+TB/sE4hSL4lNrQGJPTtz
	v98qlb71Vzh6xdT2X/T+GZNlCbgBTxLecDvzE1lajLoIEfmJFyzdrzNo8tWZuiTX
	sRGLpbmsWTCcfuf39RQ0TQVlbXEZZCSRQfhE/LiPaHEf/xwX5d0T81wfMbPl+UKJ
	6ufKzA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x77qt49b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:09:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBnTd7013006;
	Mon, 30 Sep 2024 14:09:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6nbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:09:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UE9ORn38797994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 14:09:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3444D5805C;
	Mon, 30 Sep 2024 14:09:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B322C58054;
	Mon, 30 Sep 2024 14:09:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.176.245])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 14:09:23 +0000 (GMT)
Message-ID: <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
Subject: Re: TPM HMAC (really) bad performance
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Sep 2024 10:09:23 -0400
In-Reply-To: <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
	 <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
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
X-Proofpoint-GUID: WxXiZDWCy2oxFfpA-s-b7ucUq90sQb62
X-Proofpoint-ORIG-GUID: WxXiZDWCy2oxFfpA-s-b7ucUq90sQb62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=807 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300102

On Fri, 2024-09-27 at 10:15 -0400, James Bottomley wrote:
> On Fri, 2024-09-27 at 15:53 +0200, Roberto Sassu wrote:
> > On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> > > Hi all
> > >=20
> > > when running the benchmark on my new component, the Integrity
> > > Digest
> > > Cache, I ran into a serious performance issue.
> > >=20
> > > The benchmark is extending a TPM PCR with 12313 entries of the IMA
> > > measurement list, and calculating the time elapsed for the
> > > operation.
> > >=20
> > > Without TPM HMAC: 102.8 seconds
> > >=20
> > > With TPM HMAC: 1941.71 seconds
> >=20
> > Jarkko patch set [1] improved the performance:
> >=20
> > 404.4 seconds
> >=20
> >=20
> > Still quite slow.
>=20
> So this is now the internal TPM overhead.  There's not much we can do
> in the kernel to optimize that.  Your own figures were
>=20
> > No HMAC:
> >=20
> > # tracer: function_graph
> > #
> > # CPU  DURATION                  FUNCTION CALLS
> > # |     |   |                     |   |   |   |
> >  0)               |  tpm2_pcr_extend() {
> >  0)   1.112 us    |    tpm_buf_append_hmac_session();
> >  0) # 6360.029 us |    tpm_transmit_cmd();
> >  0) # 6415.012 us |  }
> >=20
> >=20
> > HMAC:
> >=20
> > # tracer: function_graph
> > #
> > # CPU  DURATION                  FUNCTION CALLS
> > # |     |   |                     |   |   |   |
> >  1)               |  tpm2_pcr_extend() {
> >  1)               |    tpm2_start_auth_session() {
> >  1) * 36976.99 us |      tpm_transmit_cmd();
> >  1) * 84746.51 us |      tpm_transmit_cmd();
> >  1) # 3195.083 us |      tpm_transmit_cmd();
> >  1) @ 126795.1 us |    }
> >  1)   2.254 us    |    tpm_buf_append_hmac_session();
> >  1)   3.546 us    |    tpm_buf_fill_hmac_session();
> >  1) * 24356.46 us |    tpm_transmit_cmd();
> >  1)   3.496 us    |    tpm_buf_check_hmac_response();
> >  1) @ 151171.0 us |  }
>=20
> or 6ms for no session extend vs 24ms for with session extend, so
> effectively 4x slower, which is exactly what the above figures are also
> showing.
>=20
> >  We should consider not only the boot performance.
> > Depending on the use case, IMA can be used after boot and slow down
> > applications performance.
>=20
> Right, but this is IMA fish or cut bait time: are you willing to pay a
> 4x penalty for improved security, bearing in mind that not all TPMs
> will show the 4x slow down, since some have much better optimized
> crypto routines.  If yes, we can simply keep the no flush optimization.
> If no, we'd have to turn off security for IMA extends

Another way of looking at it is that the performance for existing TPMs is
unacceptable with CONFIG_TCG_TPM2_HMAC configured at least for the builtin
"ima_policy=3Dtcb" policy, replaced with a similar custom policy.  Without
Jarkko's patch set it takes ~10 minutes to boot.  With Jarkko's patch set i=
t
takes ~3 minutes. Saying it will work with newer, faster TPMs isn't a viabl=
e
solution for distros.  Either the Kconfig is turned on or not for all syste=
ms.

Is the reason for the performance degradation due to the HMAC or encryption=
?  If
the performance degradation is due to the HMAC, then the last line should b=
e:
"Saying Y here adds some overhead to all kernel to TPM transactions".

config TCG_TPM2_HMAC
        bool "Use HMAC and encrypted transactions on the TPM bus"
        default X86_64
        select CRYPTO_ECDH
        select CRYPTO_LIB_AESCFB
        select CRYPTO_LIB_SHA256
        help
          Setting this causes us to deploy a scheme which uses request
          and response HMACs in addition to encryption for
          communicating with the TPM to prevent or detect bus snooping
          and interposer attacks (see tpm-security.rst).  Saying Y
          here adds some encryption overhead to all kernel to TPM
          transactions.

I'm not quite sure what you mean by "If no, we'd have to turn off security =
for
IMA extends."  Are you leaving it enabled for all other TPM communication, =
just
disabling it for IMA or disabling it entirely based on whether IMA is
configured?

Mimi




=20



=20
=20


