Return-Path: <linux-integrity+bounces-4989-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0AA4526F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983CF3A37EC
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7009BEBE;
	Wed, 26 Feb 2025 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bxpJ58TC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088517B506
	for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534825; cv=none; b=J1YXXswrsl8TDQlNx1UTGQEsoFwbTPBUjIRQsnCQ9nUzM0i2vt0HJ0J6KqMqIAkNEQIT6D7N18FRTTYb7GdA5TYR5e98K5cVpdfT5bupJaRKS8arVv2wCyrvOLKh/IZ4cNyUTc/moXfxlsSW4pAmOy0qKRpGSbqhf8iNZfPInNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534825; c=relaxed/simple;
	bh=VEsg4P6oRGT6ixf/GgmeBh+EWykJYZAa//Z6Ara8LXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8p/zORSqDVPYJ0BnpV98P5Ofwr8VCEQ0GoTFXHEMZGF+tOrefZVZrDJxbzfVJtJH+G+qwc0gMGIuV/z5q7Va3fr1QMK++EsxZbqKWBK7WARo36Z4onvczbX1wpQbrdkNVt9Sz2zD4ST/WwTrELisc/yoZEEowKwjwAHC22qXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bxpJ58TC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1lOFF012922;
	Wed, 26 Feb 2025 01:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dz2CS9
	bMnPdLUKbNnw7pHjLMmneavTkk0oy0mZGq7ro=; b=bxpJ58TCb2F64Uay3swNmh
	Hd43B/kZKc2WL37/jvUmCQn9UB+woMkOZSgfyGkFFJLttpOeKgx4DJ4M88itoclH
	2l1j9tw7Ojfm5B/RpZ/u+ONRqfBv1zr407VvWvR5gw6313qZz5xWY+7FcLK8QEGe
	hFL/mS4WtjTMS2Astbpd4LWT45lmYduRyo8T7kjVycY0qqet6Z8nF3sOu+O3r9/s
	AD36NonbxCwrESHRGO9TcCW9EMBr1+8pqdJTHC3ble818DBI6bpN9m8Rr8G+zBEH
	pX6ouP7WVyF5xlBuvxLVKe7XeRodCMkQIkvxwI4ZOvT0C3fcDw/tCM5UbLVeaW1g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s1984d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:53:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q1o6Au017721;
	Wed, 26 Feb 2025 01:53:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s1984d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PM0cH3002570;
	Wed, 26 Feb 2025 01:53:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jqvja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:53:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q1rSaF63832538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 01:53:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D4E75805A;
	Wed, 26 Feb 2025 01:53:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8275805C;
	Wed, 26 Feb 2025 01:53:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.11])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 01:53:27 +0000 (GMT)
Message-ID: <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
Date: Tue, 25 Feb 2025 20:53:27 -0500
In-Reply-To: <20250225131255.154826-1-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
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
X-Proofpoint-GUID: _sEBG8xeHH7gjnwUI3Es9THnHav1vzsg
X-Proofpoint-ORIG-GUID: 3uqkdp9D9HhoiBECSuu2ezUGUmdxCoi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260009

On Tue, 2025-02-25 at 14:12 +0100, Enrico Bravi wrote:
> The first write on the ima policy file permits to override the default
> policy defined with the ima_policy=3D boot parameter. This can be done
> by adding the /etc/ima/ima-policy which allows loading the custom policy
> during boot. It is also possible to load custom policy at runtime through
> file operations:
>=20
> cp custom_ima_policy /sys/kernel/security/ima/policy
> cat custom_ima_policy > /sys/kernel/security/ima/policy
>=20
> or by writing the absolute path of the file containing the custom policy:
>=20
> echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
>=20
> In these cases, file signature can be necessary to load the policy
> (func=3DPOLICY_CHECK). Custom policy can also be set at runtime by direct=
ly
> writing the policy stream on the ima policy file:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> =C2=A0	"audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> =C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/security/ima/policy
>=20
> In this case, there is no mechanism to verify the integrity of the new
> policy.
>=20
> Add a new entry in the ima measurements list containing the ascii custom
> ima policy buffer when not verified at load time.
>=20
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

Hi Enrico,

This patch set hard codes measuring the initial custom IMA policy rules tha=
t
replace the builtin policies specified on the boot command line.  IMA shoul=
dn't
hard code policy.  I'm not quite sure why you're differentiating between
measuring the initial and subsequent custom IMA policy rules.  Consider def=
ining
a new critical-data record to measure the current IMA policy rules.  Also
consider including the new critical-data rule in the arch specific policy r=
ules.

thanks,

Mimi


