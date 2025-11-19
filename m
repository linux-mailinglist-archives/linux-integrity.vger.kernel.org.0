Return-Path: <linux-integrity+bounces-7638-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B7C6FA84
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8889128E23
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBD35F8B5;
	Wed, 19 Nov 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VXwgIrj2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759E33C195;
	Wed, 19 Nov 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566200; cv=none; b=juTSktJ0lBhbm3Iskwc7/hVg8zNf1KvJCqkQBL5EijcQj2/pV48+lVBMb/aMrl98lgnaJWhFil5SqM43uPQgm5PWNqAkq1tYiPU4eJlSmX8ijO+/qSVf3rrupEyPrFkMklM3CUysiBVVE5c2+wQXuR99oYTFPn67UhYZ6riwCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566200; c=relaxed/simple;
	bh=9+bfJz/6I8aRoScteWrYNqbPnvWMzfdijiEhQ43E8TU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=LvqCWCpiqb06PJqjQNVRuOUi/lv97AnswIyzj6yi76eFMlj3veN1zeO0GZpk6+eoW+N0+emqPw1G5RkBUCkhA11JO2uaWrppPcsoFnZtFVVXZRemHaUvY7LUCjwaF8mfeMqMzQI/WkAmkQgvyKri2roQDlc9GVSokCkpbndYOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VXwgIrj2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8SExl010859;
	Wed, 19 Nov 2025 15:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1aRhZa
	7snvOM5oWKF8QoQlfa7Ar0YPQolGsuf2AHAsc=; b=VXwgIrj2v5Skg0G1txBtnx
	gLrKZU1XrCXgiUDAU4pPv/REIQd+GOZTiSUnowhZAxA7rwXkxWA3IWHMMG4K6MPj
	dolJmtcw0F56dwDtBEXGVs8qsfosKHfkLrn9lGgl5BPFqirUnPjzgrMTm+S+TWfa
	ZS2apo5uaL6cg75mRHLmUU9mkollHtVfC75NkW0W9iqO10haFMkTUKNJkn2Nce+b
	P41ITs1DIcT18SIwSN6QEY9FYtxuYsIwFdcUJzeDK/Xc2ClP7yAATgXozFQEv3Bk
	AHIROz71zeTBS7RTpnbRf1VXas4zMpqlpYCXlcHfphHD/PUScXXrP5vfIT+qVC3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1h9x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 15:29:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJFTFdZ028527;
	Wed, 19 Nov 2025 15:29:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1h9x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 15:29:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEY4Ww010448;
	Wed, 19 Nov 2025 15:29:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us9h9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 15:29:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJFTG3223855624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 15:29:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2A558043;
	Wed, 19 Nov 2025 15:29:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A935A58055;
	Wed, 19 Nov 2025 15:29:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.42.2])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 15:29:15 +0000 (GMT)
Message-ID: <b4b89006e56e0d1c02e503ea3c2f2ec3a0856b04.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: Access decompressed kernel module to verify
 appended signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Karel Srot <ksrot@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Luis
 Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Fan
 Wu <wufan@kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        open list	
 <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"	
 <linux-modules@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        "open list:SELINUX SECURITY
 MODULE"	 <selinux@vger.kernel.org>
In-Reply-To: <20251119140326.787451-1-coxu@redhat.com>
References: <20251031074016.1975356-1-coxu@redhat.com>
	 <20251119140326.787451-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Nov 2025 10:29:15 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691de24f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=xVhDTqbCAAAA:8
 a=TJo3RIopB0RH3hlNab8A:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: 1Aacmr1lel3MWLuiEaRqdV5WAhY95P6C
X-Proofpoint-ORIG-GUID: Tz2BsdnjY_28B6-MXgTzcSUCq8Xp729G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXxUozr5/BEu6D
 4uHt7aRLp8Nr9REH58s1B1cvJZVsinX18ju3wwKTsH8afes+ylqDPCqNauHUndTJx0TvOCD2riw
 EXn4AY1in877S5dsXJKP7ApNL7FqhmFzm6gEVPJ6VgFQ8lfyihpLgZAfi1JipH0sKtKYkoxfO7E
 +8pHXaA4dYB6yo9UuMiQeCDUWBmqHVp4zTertDYAfuM29BQBSxX8z36DhiJZNUFh5nYdFGiFduk
 cEqcC8mj9PteL/I5up2CjYzb7s0zCIjc0diLqLxgjovhan9mhdoAsAulr1ay7AWcNFORhUB+qg2
 XDf54QGV9AY3G/uhztJlSCMYv6y27tuNNGkIcutS4DLiQTUds2nzKK0pODoQKtkPqpmdNNOZ1b1
 cb+yrg+dIOZXnknFoipTYEYhnqwsVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Wed, 2025-11-19 at 22:03 +0800, Coiby Xu wrote:
> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
> is enabled, IMA has no way to verify the appended module signature as it
> can't decompress the module.
>=20
> Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
> IMA can calculate the compressed kernel module data hash on
> READING_MODULE_COMPRESSED and defer appraising/measuring it until on
> READING_MODULE when the module has been decompressed.
>=20
> Before enabling in-kernel module decompression, a kernel module in
> initramfs can still be loaded with ima_policy=3Dsecure_boot. So adjust th=
e
> kernel module rule in secure_boot policy to allow either an IMA
> signature OR an appended signature i.e. to use
> "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
>=20
> Reported-by: Karel Srot <ksrot@redhat.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, Coiby!  The patch is now queued in next-integrity.

--=20
Mimi

