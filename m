Return-Path: <linux-integrity+bounces-2903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E16912255
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432D428A5DA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 10:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F817107F;
	Fri, 21 Jun 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ry2XAr7Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D792197
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965489; cv=none; b=Lwfk4LzgrIza1Qsg6/vIiqlBjwQuTi++kyxdzECglqwsFg8/P7kulViNE1OizzDntuZtzmiwmCMTpWh8nGEHBc73qPThgrq/61+eptpdgypsbwFHscPbzEdWAMIrYWOndBhrSxOrJc7HVHcjiYEjOCPnVf/r7PcvXRuiCGyDl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965489; c=relaxed/simple;
	bh=I4VQ++zq4NUz9W4hU0xxfORLS1Sus7334UibB/61ong=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=KfcsJyMclgwBagxmUIlv/aRIlCxxQtnNJj1TCckKUvP6BJkDP5DldyL9CU7BlGp9cs0+lSZUCXMWRnBYGVWr8y3QQhmruO7xK/JSilUiUdImBQGNmz5oPn20LjOU0veT/0qyibkP3m3VL736Lob4frZFU068IdXICeK5FspsHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ry2XAr7Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LA0E3x023938;
	Fri, 21 Jun 2024 10:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	41IeaC/m6JWajMsaWDvrvXVi4Ns2X8Epxg/5o24YIT0=; b=Ry2XAr7QRJgS3QWl
	1Ewj9yq8alB77jIBw45eJVunan75slKxvEF5VAdiDXPXUSxbFzqduF1AKpgT2SSK
	hx2nuRXcfetY580U0gRaDIXG8OWPAY+SkUtf/VoLWUOLG+ze6HoZ7Vr5EROyBEX4
	n/mCWM1NQ8lIe3yrJ6sdnj5NF7l5YHfa9ya3DPdEmR/ljW0GOkvQ1EqZmDxGd5Vf
	gp6bqt1tj3bgCQkiDuw/YzKWWDmuBCjg56HVwn97rHL2uxZWqI53IB9HoQHGzsTW
	3sN/WO65LED6wstp+LXLUqLS8nb3TkB+4dqdILo13+Reps3aYJohR6ADXMJAcd5b
	YGDiBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw7by81v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:24:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9GsaM031899;
	Fri, 21 Jun 2024 10:24:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrsppk9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:24:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LAOdUD590422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:24:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F92658045;
	Fri, 21 Jun 2024 10:24:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD95B58054;
	Fri, 21 Jun 2024 10:24:38 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.119.207])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 10:24:38 +0000 (GMT)
Message-ID: <5fc85cd29bc8456bfd1cd47b6dbe38bfbaeb4907.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>,
        Stefan Berger
	 <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 21 Jun 2024 06:24:38 -0400
In-Reply-To: <ZnVP1nLxm1vhc1l0@earth.li>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
	 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
	 <ZnVP1nLxm1vhc1l0@earth.li>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nzCqWJ2kak7-RmDarI9RMs2gCZww1GAa
X-Proofpoint-ORIG-GUID: nzCqWJ2kak7-RmDarI9RMs2gCZww1GAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=861 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406210077

On Fri, 2024-06-21 at 11:03 +0100, Jonathan McDowell wrote:
> On Thu, Jun 20, 2024 at 08:59:11PM -0400, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Disable testing provider support on Debian:latest and AltLinux:sisyphus
> > since both now get stuck while running OpenSSL provider-related tests.
> > This is most likely due to an update in a dependency (OpenSSL, libp11,
> > softhsm,  or others).
> 
> This seems to disable it for both Debian stable + testing.  Is it
> actually broken for both?

There is no pkcs11-provider package on stable, so the test is skipped.

> 
> > On AltLinux the issues is related to a pthread_mutex_lock() down the
> > C_Login -> C_OpenSession callpath that blocks forever.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  ci/alt.sh    | 2 +-
> >  ci/debian.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/ci/alt.sh b/ci/alt.sh
> > index f86dcec..f1eefbf 100755
> > --- a/ci/alt.sh
> > +++ b/ci/alt.sh
> > @@ -28,4 +28,4 @@ apt-get install -y \
> >  		xxd \
> >  	&& control openssl-gost enabled
> >  
> > -apt-get install -y pkcs11-provider || true
> > +# apt-get install -y pkcs11-provider || true
> > diff --git a/ci/debian.sh b/ci/debian.sh
> > index e1bae43..34125d4 100755
> > --- a/ci/debian.sh
> > +++ b/ci/debian.sh
> > @@ -59,4 +59,4 @@ $apt \
> >  $apt xxd || $apt vim-common
> >  $apt libengine-gost-openssl || true
> >  $apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
> > -$apt softhsm2 gnutls-bin pkcs11-provider || true
> > +# $apt softhsm2 gnutls-bin pkcs11-provider || true
> > -- 
> > 2.43.0
> 
> J.
> 


