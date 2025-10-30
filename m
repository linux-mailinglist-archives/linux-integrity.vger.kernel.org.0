Return-Path: <linux-integrity+bounces-7548-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED64C214EA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C881A63E6E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB8243946;
	Thu, 30 Oct 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oTgwNcen"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736B2D979C;
	Thu, 30 Oct 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843072; cv=none; b=WTyPzfXW3udU0rJrMBU53jfIPWFRElk3Xl0k76jMGudLEL6a8iN+HyEiGVqbACsbMnfhI7dj0ZIZX4u7203vO8putBrnYPOZOshMvRIFHAblCUPktGgCH/j3gvKIMnGv16N9KNHCbkG2Q9OcQvNEdL6ImZrguF6fP2Q8o7SDxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843072; c=relaxed/simple;
	bh=2ic4LVU5/Oxi2Op4dNIyqBBDQ2zl/XXPIxprjHLv62A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DZFi9o8iTCt3KOYiKhKXb3rVm0DGtV1BZ/kzegvNvDD0gHiRyzfjpN5N+b1WVPuC1WbO7WrCU+ji9CkEUy1eXSF6alGGhB/9qn+MVFDnxDlF00GG83StkurNsLK/LucdUQSaHxgNsp20Tfdfl/b2itIeP9LzqgVwdpLw/jRZSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oTgwNcen; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCrRwe026249;
	Thu, 30 Oct 2025 16:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1oTIaC
	H20fiWXauaGQLUQRTSozuropFqm9E2OFsgnMw=; b=oTgwNcen7ekRS3Qql8SsT/
	Zo4ytT8o4cRWYXnTf0ch/g1WJQm9lNIYnstlfPDSYvcVA2dI95lBkhP0RXNyZgYe
	UhG8oBR+xfDBzdgntUc9l1mtVWbbFOq5t0SDFavWPV4AVQHazh4Wpv9jI5PZIb/0
	MNNmy6cX1pJ5FuyQ4t3LN8brU0DpEByH6I5YXHN7VNjtifxvZhduI4uXE40rmi11
	0UBPxWOW+QfMZLBi3BlgRvjXgwLeK5oQa58SfvpjJEehlOqRS56ff0sDYFfXzBXk
	3rnlpT42XnaKy3YNJkV36XbDR5Hxy/uHSjvNXHaBzWQjzGhpu2iCYuqc74djjFgA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aase0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 16:50:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59UGf3BA010478;
	Thu, 30 Oct 2025 16:50:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aase0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 16:50:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGMeEx030747;
	Thu, 30 Oct 2025 16:50:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwsv5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 16:50:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UGonVM15794900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:50:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4914D5805A;
	Thu, 30 Oct 2025 16:50:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E9458051;
	Thu, 30 Oct 2025 16:50:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.181.209])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 16:50:48 +0000 (GMT)
Message-ID: <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Karel Srot <ksrot@redhat.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	 <linux-security-module@vger.kernel.org>,
        open list	 <linux-kernel@vger.kernel.org>
In-Reply-To: <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
References: <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
	 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
	 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
	 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
	 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
	 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
	 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
	 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
	 <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
	 <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Oct 2025 12:50:48 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=6903976b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=H2F7xvbIi8gHOqbJ6IIA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 7vaOKA8cIxehTG0D-140iunaPXZKhfWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXxcbT3lCeLuKF
 2eaUcofGTWfWvaVe26MiOSbVEYWSOZYEB3DHw3W4c5stlkhJXLVY2Ijpc9Ts0XZ4DANBSjVSxjy
 gaxyCE3m8j/yY2YRWLRKMFbqvFhpDhLHgi17fSWx3Q61539UxuJbNvQgx/T8Hwe5Ofw/a+qki6v
 j/HKK2RhcvEfmAe4wJTq7WyBAwHk83Dkrz0c0BXh7UYuYZEVDU/n7iJqNz8vnCNzEecrcrzEAAW
 wlf+gRkdpNt9nwQfLhWK8V/ioxDabEIQTB7dsNY/w9q8knk36EkBdjW9f0qf97/w4INy2DupED7
 N2EVnRg5Jxfn5lKJWXHomN2/hTGb5rFvcuGKHqBO8G1Ln+xEwHC98oH8ZBcW0tbzyGqOXaHfSZY
 0iYnn6E8lXHNIwOwxqe9n79Hn1jKqA==
X-Proofpoint-GUID: -AWS4RjG18ZQrkcEg3zFlMVwRQb5uVLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Thu, 2025-10-30 at 21:42 +0800, Coiby Xu wrote:
> > >=20
> > > Another question is whether we should allow loading a kernel module w=
ith
> > > appended signature but misses IMA signature. Both IMA arch specific p=
olicy
> > > and init_module syscall only require appended signature verification.=
 On
> > > the other hand, we only allow "appraise_type=3Dimasig|modsig" but not
> > > appraise_type=3Dmodsig. How about we allow loading a kernel module wi=
th
> > > valid appended signature regardless of its IMA signature? We won't ca=
ll
> > > set_module_sig_enforced but as long as we know is_module_sig_enforced=
()
> > > is true, we allow the module in IMA.
> >=20
> > Based on the policy, IMA enforces signature verification. Only if
> > CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not =
define an
> > IMA kernel module appraise rule. However, custom policies could still r=
equire
> > both types of signatures, not necessarily signed by the same entity.
> >=20
> > The option "appraise_type=3Dimasig|modsig" allows either an IMA signatu=
re OR an
> > appended signature.
>=20
> Thanks for the clarification! If I understand you correctly, some users
> may want to enforce IMA signature verification and we should provide
> such flexibility. Then do you think it's a good idea to change the kernel
> module rule in ima_policy=3Dsecure_boot to=20
> "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig" so
> ima_policy=3Dsecure_boot can also work for in-kernel decompressing
> modules?

Yes, that's fine.  Unlike the arch specific policy rules and the Kconfig
appraise rules, which persist after loading a custom policy, the builtin se=
cure
boot rules do not persist.

Mimi



