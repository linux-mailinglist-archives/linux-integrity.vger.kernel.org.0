Return-Path: <linux-integrity+bounces-7429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B264BD575E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51D594F76E4
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC02BE646;
	Mon, 13 Oct 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HJixZkDP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02629AB15;
	Mon, 13 Oct 2025 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375867; cv=none; b=Bp5l0Xd7urLlLV/pQ1moxPTj4b1kQwkWRZeR4fMKTk6sXKHnQTyTkGdo7lMM8ctKRqN2NlI3Y0zd5mT5ra1kVpFjwdKYk5nZ1yJykMuhmd+Nfs1B9aYLIpWbI0YsI45jOrvXU9+kfGhcdQALTKq9R1PrltTjgkUNZE2K9sqvi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375867; c=relaxed/simple;
	bh=1o7vfzVg+O2k5uGA7m8xD7/nkzsuOXh0/XQRGfNcP1w=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rUR7y5G6wMeJLdoEw1YhoauQ2hHWL6NLQcxf4oKbKr0lAjYUk4yOfkzhagb5oCr2MbPFcrs35xkh31m7143CjVC+5JT5kE5KT56oEKvrShmofcK2mZMtamd12EPaRY9YEEnVVhgRzEs98GZ7yJ5rQCYzkA9Gr0rHBpEsb2ga9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HJixZkDP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DC9hlt021492;
	Mon, 13 Oct 2025 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1o7vfz
	Vg+O2k5uGA7m8xD7/nkzsuOXh0/XQRGfNcP1w=; b=HJixZkDPgraMKVAWzWMjhr
	OrtTYqbyxuIA3TYm7xrmNLCja/QD0gYPpR4C1D6xhFCf/J4cOvLPg42enYUufKHC
	F+/d8HryRw/FZ/79f9ceCOgAAc0QneE9Oox75exAZ92H+4Usc9l1JITfOFpT3gNT
	frI3rVVQfTG3x9DbQK71r+tJAb1VhrfzbDXBceZv1NN73I9NJ+AHJyFjO4HsIjr6
	bUlwfDQdrb9xTNvfigD4myX0g0j9fLSuO9lkf7DqbGM56PVNUxoxCckScKpHhTz4
	eix5emzwAIH7AqiDsRcD7/ANQlBqplXpqY/7XIHje7yqHFmqbVmIvOf7am4azXCw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8j95p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 17:17:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DF4Xw1018372;
	Mon, 13 Oct 2025 17:17:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf0kdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 17:17:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DHHIap27919028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 17:17:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC19358050;
	Mon, 13 Oct 2025 17:17:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD17558045;
	Mon, 13 Oct 2025 17:17:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.176.159])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 17:17:16 +0000 (GMT)
Message-ID: <37ad10dadabf11ea2fe5c5492fc0c4f8d14dbeda.camel@linux.ibm.com>
Subject: Re: [PATCH] keys: Remove redundant less-than-zero checks
From: Mimi Zohar <zohar@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
        David Howells
 <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore
 <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
In-Reply-To: <20251011144824.1257-2-thorsten.blum@linux.dev>
References: <20251011144824.1257-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Oct 2025 13:17:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qdNTxGCkyxrS5rcDBi2RZf9HHFpZFwcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXx9mdWTQVrL0B
 bzdqEl3JcXIqlsvt6480+7soduV1W+Qc6YquFgEK39PbOCTKEFOGy5Lx8vsMs28g5/DIP+znjoT
 1MtrciXOErYm2h/TO8XXmKmOQWEZzpeKg8qNDEZLNqWOZtY5haFbb9C+j/cEccppayfcmsvJXCZ
 nZPskNhsaH1zpDgCHKydOVbqq8rbdSkFp5b+9Dj1MRTEDayKD2awij8QkGezwp7J0FUDieKszvx
 tHv4oXAboCdJLvccVStg2f3uRcy63G8utLTji2AQu4JUv5XVNeW7kohYj7wlViRMbcKPvdcx/lx
 Ev9l5/oZ7vkwzI5yDbvDAcZuDOesOqG3/yBntRIn9bNIhsltwEwnzIlj1EbCdfNH/br/SiISu32
 GsGA+buQIYOr8z6kVrFoXrn1g+kzmg==
X-Proofpoint-GUID: qdNTxGCkyxrS5rcDBi2RZf9HHFpZFwcD
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ed341f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=RXRK5r3OJC2qLSDDhugA:9
 a=QEXdDO2ut3YA:10 a=vyftHvtinYYA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On Sat, 2025-10-11 at 16:48 +0200, Thorsten Blum wrote:
> The local variables 'size_t datalen' are unsigned and cannot be less
> than zero. Remove the redundant conditions.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


