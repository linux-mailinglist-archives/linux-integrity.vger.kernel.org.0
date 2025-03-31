Return-Path: <linux-integrity+bounces-5528-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1843A76589
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11683AA075
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533C1E0489;
	Mon, 31 Mar 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGk0LocN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D4154C15
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423319; cv=none; b=SPijfNMraPS8gKWvQD6qgQR/XdA48j7kR8s3fovG1viHWnX3xf26++SuL8Vd5NhF/ol+7Nj23VPDCPvHJOy9c6IHuqQmqHFbF3kwE0h83dVxOg8bJxjhm4ignjdiS9M67ywY4ZKwFigeCfzPOPM83AF766hG0eTUMMGdIrbQR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423319; c=relaxed/simple;
	bh=i0bklRsEEbf5bOka58mumRDoVltp41/cz8kXrYV08WE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNOn6Dd60/kHc8dHxAMMpMCs2pzgmnCbRD2s8kqTEb3PJ1HoT34Qzi0svFGZeel72PJqpwUrXghvsMQpANT9+kUgZov/iyaFkAGogmeoHka91g/lhOhcg6kxYbDV9gMuBqsvY3q0vFA1257Ely5Ozr4anIFtQW3JExynXtxNebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGk0LocN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VA6Z4a002260;
	Mon, 31 Mar 2025 12:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DAS3Qf
	VduVCmO3oX+ysteuIaBnDDCBZMqPHqxm0kNe8=; b=oGk0LocNUBfehVIwZr/grj
	UvMef8S9twmN3yxGUvo552Ofwt1juMQMZn8aJiHSjlGakHRobWQt89NmpS8Hu5QY
	IcvEFhyByTnfVveMgKc8oYP7k+gV6Kmj52N6Pu82xhpE3mDHOmlGdcm39FoZtavS
	miEVv9XfBFtxEa4Wm61pnXq8femlwKyNZWwH4UEA0ZztJ4ZcJMuNneP3kaVAJaEw
	SPirWiiu1U3sCGdFrfV731ZOUD8HznAamsvRpUmbieyza1tN68yJD1x6DRYgtQXr
	Kvlc+VtpaOYriDmZk9jpzuMrWEDGviceu97LkKk0/YjJmCF7wlbG/7yTPXFlvwqw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45q602m8d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 12:15:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9sde8009923;
	Mon, 31 Mar 2025 12:15:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nnp6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 12:15:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VCF9AD14942800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 12:15:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3672758067;
	Mon, 31 Mar 2025 12:15:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF44658065;
	Mon, 31 Mar 2025 12:15:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.25.252])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 12:15:08 +0000 (GMT)
Message-ID: <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Mon, 31 Mar 2025 08:15:08 -0400
In-Reply-To: <20250331061611.253919-1-bhe@redhat.com>
References: <20250331061611.253919-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6HTO2PTXK2LFu8-IhktYn7Za56xczjAB
X-Proofpoint-ORIG-GUID: 6HTO2PTXK2LFu8-IhktYn7Za56xczjAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310085

On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
> It doesn't make sense to run IMA functionality in kdump kernel, and that
> will cost extra memory. It would be great to allow IMA to be disabled on
> purpose, e.g for kdump kernel.
>=20
> Hence add a knob here to allow people to disable IMA if needed.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 28b8b0db6f9b..5d677d1389fe 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,11 +38,27 @@ int ima_appraise;
> =20
>  int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
>  static int hash_setup_done;
> +static int ima_disabled =3D 0;
> =20
>  static struct notifier_block ima_lsm_policy_notifier =3D {
>  	.notifier_call =3D ima_lsm_policy_change,
>  };
> =20
> +static int __init ima_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) =3D=3D 0)
> +                ima_disabled =3D 1;
> +        else if (strncmp(str, "on", 2) =3D=3D 0)
> +                ima_disabled =3D 0;
> +        else
> +                pr_err("invalid ima setup option: \"%s\" ", str);
> +
> +	return 1;
> +}
> +__setup("ima=3D", ima_setup);

I understand your wanting to disable IMA for Kdump, but this goes way beyon=
d
that.  Please don't make it generic like this.

Please refer to ima_appraise_parse_cmdline().

Mimi

> +
> +
> +
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc =3D ima_template_desc_current()=
;
> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>  {
>  	int error;
> =20
> +	if (ima_disabled) {
> +		pr_info("IMA functionality is disabled on purpose!");
> +		return 0;
> +	}
> +
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);


