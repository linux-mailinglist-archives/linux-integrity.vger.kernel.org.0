Return-Path: <linux-integrity+bounces-7634-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE930C6F073
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311D7506729
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C535E540;
	Wed, 19 Nov 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CnmDNwn+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6233D6C2;
	Wed, 19 Nov 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559019; cv=none; b=uOSnAHswQ4PMeYijhaLrYSOZ23NMQ24j6tc0yDlFi1aZ6GWvd+OZ8Gv/jmrN9poE3co59ooJu/Xcieb7CFYwvLM2AVgB8yPcVQm0AX7J5NxTedwgyJXFkwnbAySoqqwgStoevtkDmadJTdCafaRgNa4TaOIl1LaeDS9iXiqeNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559019; c=relaxed/simple;
	bh=ZN4AbYKSO+elMpSisR23OSjSrZecBtx/1RE+VDH1Suo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UcF3U80a+6Gm8ZaTKK5Xam9iXlPyqA42OB6Mim3J37cYLlkaMpDOcO4JsuGKQquIuxqftQIg1nNgSzJluUtFH7tSmBnkS0aQlyF1rbVGYL9eH6d+Gb+YLMcDLujtH3nKIIVrcEBGIte9u1LFx/8yYv7Xwr2QRLrrDe95QtwKRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CnmDNwn+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7F4F3030539;
	Wed, 19 Nov 2025 13:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pp0BPr
	x4QQ8IPLh4YGWT2aRGVFvIUWM0A4jPzmzuT/U=; b=CnmDNwn+qGF7BhVBErirjg
	rhJ/4spwG6t7V3d+np8SFbO2ghxQZFsMJNfvBK5mQtvE2uFalweP7UwYJtVltys2
	QY1vwx6hrDmeMnpQOjAMfRHZaMI3xewTOBHeIg2oExhTM73SQYBvPLnWmEwJ3fGY
	WhgX0ebL3RRtLb40ceKZ6EGlmQx5bq/GFyyRt3Jk8H7So9+p1ud93AnFo+gMmnsw
	gROsInYsHlvDRauI2ldMvkDEaa5PAWn9KUdaHDZKeG/ErzsepFXJZVQ4pHWKoFYF
	RnP+5cJCETVA43KxZLmyzr+nfojDPaGd2r0FWsUr9Fom2JgfZEoZAs89vQfoVa1Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtys5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:29:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJDEZCk019471;
	Wed, 19 Nov 2025 13:29:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtys5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:29:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBjY6h022370;
	Wed, 19 Nov 2025 13:29:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un0u2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:29:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJDTY3E30868190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:29:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FBA95805E;
	Wed, 19 Nov 2025 13:29:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0271F58052;
	Wed, 19 Nov 2025 13:29:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.42.2])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 13:29:32 +0000 (GMT)
Message-ID: <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Access decompressed kernel module to verify
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
In-Reply-To: <20251119034718.618008-1-coxu@redhat.com>
References: <20251031074016.1975356-1-coxu@redhat.com>
	 <20251119034718.618008-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Nov 2025 08:29:22 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P_RZBhkMaJP8RkyNy_jG9_o_hlXl0yfa
X-Proofpoint-ORIG-GUID: nlDCFULz3fsdXwXqJBYB8PSkJMNItcFH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX/Z3FBPnspJIh
 rAVaN5WJM64fYOUYKkpDeAB9CteQH8GHunf1Z6BKuJS5IFLf++UPx/TNf6kl0pZzmy6sm+cnDh5
 Mn9U/gUaOkYP1rvlH82C8W+MRz9gVR/Q5luqdNsRZWyTlufxFkiggG4nEj0Bce9w9CRc26V/2AM
 u/c+RrJlg+1UDFo/oWSFm4l0fKCpWq8AXjwrBMY+sP4GY/OWmeRjQ6C9xqb6emShI+cgaKIJ51/
 a1dN+yIcnUBTpcozyOrKrt6uwqBAj5AsMrzg3aFluak34ZpoQbmTdbdbqVbdUiRZ3BDsbst2Ft6
 QbE31WAROaXtY3VDur2uGKkDXkKNT72BRehDcQnFmKYuVxH2pdm7SFNS4uOytluk6pB5Vl/akMy
 G1kKOLZZBp6Bm+V2aixs+yn4mAqxFQ==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691dc640 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=xVhDTqbCAAAA:8
 a=TJo3RIopB0RH3hlNab8A:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

Hi Coiby,

On Wed, 2025-11-19 at 11:47 +0800, Coiby Xu wrote:
> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
> is enabled, IMA has no way to verify the appended module signature as it
> can't decompress the module.
>=20
> Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
> IMA can know only to collect original module data hash on
> READING_MODULE_COMPRESSED and defer appraising/measuring it until on
> READING_MODULE when the module has been decompressed.

This paragraph is a bit awkward.  Perhaps something like:

-> so IMA can calculate the compressed kernel module data hash and defer
measuring/appraising ...

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

Thanks, Coiby!

The patch applies cleanly to linus' tree, but needs to be applied to next-
integrity.  Please re-base.

--=20

thanks,

Mimi

