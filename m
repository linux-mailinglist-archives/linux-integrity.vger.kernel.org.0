Return-Path: <linux-integrity+bounces-5439-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74985A7178A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E50F7A3F55
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AA1E8330;
	Wed, 26 Mar 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FODUjmFh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00601E5B96;
	Wed, 26 Mar 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995748; cv=none; b=aioNrHSB3asNN+q7XUQhWPSdP+XUvJ4yNiVDNLV7sKkfb4KfUtVKR9F+xFbH94tKB7XSVibmb63Rd3s1LO5TpzUx41dVqxafqMQh2ZixcANpi94zbgZzko7PX8Rvxs4zU1MOAlas3bEWY/3q4J4PMZZTyfYZP1ybgS4l27PU+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995748; c=relaxed/simple;
	bh=tteZ20yxhDdqVPorIBYZzO8eJKvaXA15e1oKhp0gFLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbkOUDeQ7/sd/PM8JmhKu45QVBtlEIyd0wGGQ7LoMUqbRIl/MFELtK97ClzgBNfX/JuH4fg6fz3jVXVMpTAp4C9ol3goELnkkKvB8H/gfw63F3Mnt0yxcFqZzI9nKQFjMDMzZE+T4KO1yMYutf/o3h7BgH38lZWLIZm5jCeAy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FODUjmFh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9DWoV011248;
	Wed, 26 Mar 2025 13:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9HqIjW
	wHscTutHOsqJlpiuhjVcn0U0agpHLbpzbPenw=; b=FODUjmFhQ3zBbwTJAWCRy0
	x89E5bjKW0ezH4bAOEwai9WlahHmQkMagXvlAQPhamnyB25dNQajanCpOGO6/dzA
	YRI0kdOYoncW9HCTlFYYYsQScBK1WaboVCgaRUCDwJ3QcaydcG9E0zCEAnwUbDem
	TpQiUPNlgjmlH15hLebZ/pAkOJ0b7TeGYLM6a20rXRXF4mWvmrQNwNK1GVFa0m7N
	NZa0gqsJUgrT7Ggj13Xcw49fvRzzZq0Hthz/pzWd42dgA3wYh61Si/Uapcxi/T/U
	v1UyPg8AdUrsUSGfHALeB0fgRoCHpyIWZxT7uYmBfO8UnQR9t8lk7mp8tIRNewYg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqkwfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:28:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QCsmUV010621;
	Wed, 26 Mar 2025 13:28:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqkwfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:28:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QAQL1P012239;
	Wed, 26 Mar 2025 13:28:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m8e2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:28:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QDSi0D31064730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:28:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7DA5805A;
	Wed, 26 Mar 2025 13:28:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32285805C;
	Wed, 26 Mar 2025 13:28:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.116.195])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 13:28:43 +0000 (GMT)
Message-ID: <701cd62e1d74e4a35105ff573516857111266e95.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 01/13] ima: don't expose runtime_measurements for
 unsupported hashes
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Mar 2025 09:28:43 -0400
In-Reply-To: <87a598s0c7.fsf@>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-2-nstange@suse.de>
	 <0e7ca7094baf8f9968e72b43441745c420d61215.camel@linux.ibm.com>
	 <87a598s0c7.fsf@>
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
X-Proofpoint-ORIG-GUID: ZBWYN3CAIO7caCJD632HuynB-20_BJzK
X-Proofpoint-GUID: TKJmAZ8gxiL6f_WIuJji6x7pNY2pZK8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260082


> > > I would argue that it's likely that no existing userspace tool is rel=
ying
> > > on this fallback logic -- they either wouldn't consume the hash value=
 from
> > > the measurement list directly but recreate it by themselves, as is re=
quired
> > > for verification against PCRs, or, if they did, they would somehow as=
sume a
> > > hash algorithm and expect the hashes in the measurement list to be of=
 that
> > > type. If of the latter kind, this could even lead to hard to debug
> > > verification failures. For example, from looking at keylime's current
> > > code, the verifier logic seems to assume that the template hashes fou=
nd
> > > in the provided measurement list are of the configured 'ima_log_hash_=
alg'
> > > type. In particular, it does not check against padded SHA1 upon
> > > mismatch.
> >=20
> > The downside, if none of the TPM bank hash algorithms are configured as=
 builtin
> > in the kernel, is the lack of a measurement list.
>=20
> Yes. Just for the record, going forward SHA256 will be, with [v2 05/13]. =
So
> unless the SHA256 bank is disabled by firmware, it should be fine then.

When IMA goes into TPM-bypass mode, the measurement list still needs to exi=
st.=20
We cannot depend on the SHA256 TPM bank being enabled, nor SHA256 always be=
ing
the default IMA file hash algorithm.

For this reason sha256 [v2 05/13] needs to be added to the list of "extra"
hashes, if the TPM sha256 bank is disabled.

Refer to the comments on [02/13] for alternatives.

> > If the purpose of this patch set is to actually remove IMA's dependency=
 on a
> > working SHA-1, at some point the Kconfig "select CRYPTO_SHA1" needs to =
be
> > removed.  Otherwise the kernel will be built with SHA1 builtin
> > (CONFIG_CRYPTO_SHA1=3Dy).
>=20
> I should have described it better. In the first step at least, the goal
> is to remove the runtime dependency only. Because when SHA1's
> ->fips_allowed in crypto/testmgr.c gets flipped to false, SHA1
> instantiation would fail with -ENOENT if the kernel was booted with a
> fips=3D1 on its command line. Users not interested in FIPS, i.e. the vast
> majority, might still want to use SHA1 and there's no real reason not
> to.

Thank you for the explanation.

>=20
> But yes, it would definitely make sense to drop the CRYPTO_SHA1 dep, at
> least at some point. Perhaps by simply moving it to the new
> IMA_COMPAT_FALLBACK_TPM_EXTEND. I would personally not do that now
> though, just in case there'll be some unexpected fallout from this
> series.

As long as there is a way of testing the changes, I'm fine with not removin=
g the
select.


Mimi

