Return-Path: <linux-integrity+bounces-4364-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640189EE8CF
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2628166132
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15813D521;
	Thu, 12 Dec 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KdfQluCM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF521506B
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013814; cv=none; b=fwPWJ7aQMtn7vn+haqAicaZrmWnnRRgXYfYRklJSpRxmyHL+fZWt91z3YIZHUgwFwRXEVAR5xUxRyDcShjKfDMI19/+BaBccXdtLsm90tdnk+61bodFySEchxTeP5woAZ+iLt5o4jOcvDrItPPXRTVCPRbuKLsEi1JccceUT5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013814; c=relaxed/simple;
	bh=6OhKCUwgANfwSgt+bnDM4TVeAece1mITLrFHutxnX1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX7lGyW7GLyiGoEdlkG0cGvflIj3MdpCuKHv8gBGfMggqBluAoIMlGlqPXm96bz00mAmP90oy8DP8cMLOZsTmUSiSwpOLpdLpBnFYW7WlTvs1VZAWOwWvnRplxxp3lKkz3LtNdBQmjewAwFP4Teez0mKOLhWrYBqBG7BZkQ7z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KdfQluCM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC73Sh6005494;
	Thu, 12 Dec 2024 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=veTZQe
	DJ0GD1LXtOGAdZJOldYsKDzUhG628MUhkI/T8=; b=KdfQluCMktqVRBR6jEElqf
	1eGvU9GlMz59dLUMyPRYGnmxmfrIT9RYY9A2H6ecel7goU/51ITjiU3d7oNpCYch
	lyYbxhvm6Lg2e21pqEw5odehXMmFsdDMoBKyC8A01FUo4FUQolAkOlXhYnGF/d8M
	/qIIFWps6b/X3g6kO6ahfk8SWr9yN7dzkJ7Iz6TxUQmQIzjBs7ZlCJJEWMLBlkxz
	cA0TG0G79amSnYZb1fRHrgef/x2Tx9nakm5ekinWiyBYZm+jxWKVhJW/i9VM1CVp
	TNiq/T4JnREj5E+WqD2pbgSgK4fUkG5SlTJCvhMIkSFncCOQcELgPRjS0jPyey3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqkw9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 14:30:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD2lp0016910;
	Thu, 12 Dec 2024 14:29:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yh3j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 14:29:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCETxte22741746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:29:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0562058054;
	Thu, 12 Dec 2024 14:29:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B64C5803F;
	Thu, 12 Dec 2024 14:29:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.69.6])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 14:29:58 +0000 (GMT)
Message-ID: <3da6e0fade05a3087848bc86a55d771901dbf701.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
Date: Thu, 12 Dec 2024 09:29:57 -0500
In-Reply-To: <20241211194836.GE443680@pevik>
References: <20241126173830.98960-1-pvorel@suse.cz>
	 <20241126173830.98960-3-pvorel@suse.cz>
	 <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
	 <20241211194836.GE443680@pevik>
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
X-Proofpoint-ORIG-GUID: 62OGfyyTt3VXsO3FZuZP8LzSiIEc_plY
X-Proofpoint-GUID: 62OGfyyTt3VXsO3FZuZP8LzSiIEc_plY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120104

On Wed, 2024-12-11 at 20:48 +0100, Petr Vorel wrote:
> Hi Mimi, all,
>=20
> > On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > > environment variable LTP_IMA_LOAD_POLICY=3D1 tries to load example po=
licy
> > > if available. This should be used only if tooling running LTP tests
> > > allows to reboot afterwards (because policy may be writable only once=
,
> > > e.g. missing CONFIG_IMA_WRITE_POLICY=3Dy, or policies can influence e=
ach
> > > other).
>=20
> > Thanks, Petr.  Allowing the policy to be updated only if permitted is a=
 good
> > idea.  Even with the LTP_IMA_LOAD_POLICY=3D1 environment variable, the =
policy
> > might not be loaded.  For example, when secure boot is enabled and the =
kernel is
> > configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=3DPOL=
ICY_CHECK
> > appraise_type=3Dimasig" rule is loaded, requiring the IMA policy itself=
 to be
> > signed.
>=20
> Yes, it's an attempt, which can fail for various reasons. I'll add this e=
xample
> of failure to load the policy to the commit message and to the docs.
>=20
> I'd like to detect if policy got updated to avoid wasting time with SUT r=
eboot
> when policy was not updated. But this probably will not be always possibl=
e
> (e.g. (CONFIG_IMA_READ_POLICY not set).

Why do you actually need to be able to read the policy, after updating it?
Either the policy update succeeded or failed.  For example in the signed po=
licy
case, writing a valid policy rule via 'cat' on a system requiring the polic=
y to
be signed always fails.

>=20
> > On failure to load a policy, the ima_conditionals.sh and ima_policy.sh =
tests say
> > "TINFO: SELinux enabled in enforcing mode, this may affect test results=
".  We
> > should stop blaming SELinux. :)
>=20
> This info was added for LTP shell tests, which got often affected by
> SELinux/Apparmor. Because IMA is written in LTP shell API it gets this.
> Error message is printed on TBROK, TFAIL, TWARN. Is this the only part wh=
ere you
> would like to avoid the message? Or do you want to remove SELinux/Apparmo=
r
> warning from all IMA tests?

You have a better feel than me as to whether SELinux/Apparmor could interfe=
re
with these tests.  Unless we have some reason to blame SELinux/Apparmor, I =
would
remove it.

Mimi=20

