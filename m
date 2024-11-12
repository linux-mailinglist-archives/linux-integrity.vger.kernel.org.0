Return-Path: <linux-integrity+bounces-4095-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E369C620A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 21:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD05284156
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A2217472;
	Tue, 12 Nov 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gydRKv/b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E501A76D2;
	Tue, 12 Nov 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441666; cv=none; b=G5i5rhoVeeS6oNs+LWp7tSfwySo5b3WYGQvXPxeKUitA7UXykyhLskXBC421X7dDKT07ClZ1nwpkcq9zR0/7wCTUtK2S6dZ4K30n8H4LkjNcjS0bpvkfyY4hr56TQI6cFRqQdkabvjV3bNSo9AUtXGW8d+oXaAihjtYFiLc6cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441666; c=relaxed/simple;
	bh=RXwZmyHbDcELcc1EhrddiOHZqNAKbFxq8U7X31wbOAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4LZ3YVyYr+nBol354LmkDj4BTumA5nflUCtAMsq/hyNhabnRc0eQPUcgSDIHDIojHjM8VVQi2OX5L/EARqwIfAeKVlYadR6D6vDz5q2B4ZmwkVtoUX90lN00stsl7e7Zuj4CDx5aMXWY9+LQNnd7hmM17jRrDFNiA9gs4XSHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gydRKv/b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJe5oA018239;
	Tue, 12 Nov 2024 20:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hbhBz1
	Oy+jKfbQqQt1BOFteePij3tic9j7u6NDmqbSE=; b=gydRKv/bl1JXnA+Sr18U47
	VgT1tad+1a0+t4+ElPb5Pk13SX5CgXmxqiu2C2w5s/BO6F6kiYr5aQnY9AQbGIJ0
	ERJV0eLPznDa1CKYM7mwAoVUQTuP4Np9i0rE+DatzGEBSPB0D3xiBvHKByh5W6+s
	akYUR35F4FPw5vxaqFoGebU4qREtUqp003vT2yLjzS9q6MY3synIJajiZO3C+jGh
	IygVhaN1LaCPE6CxlQNms0xoIBqdbhBPmYsHtOzYJWxF6OS0PixVwhemaLc6P9gS
	aIJwLwAO6IzNvVwsZTubcqkc81GDVJLQTvUvmh+4xy7vCgs1cBszCVNBYxwktFhw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcer2kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:00:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ACK0eRb026341;
	Tue, 12 Nov 2024 20:00:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcer2kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:00:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJ6a5b029721;
	Tue, 12 Nov 2024 20:00:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjkvn0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:00:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACK0dUk44761372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 20:00:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1786258052;
	Tue, 12 Nov 2024 20:00:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89AE258056;
	Tue, 12 Nov 2024 20:00:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 20:00:38 +0000 (GMT)
Message-ID: <6679269b50c54bc9796fa4093ff8bbdbced26148.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 15:00:38 -0500
In-Reply-To: <D5KE7X6LMR5Z.AA8PPWDBPQP7@kernel.org>
References: <20241107095138.78209-1-jarkko@kernel.org>
	 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
	 <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
	 <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
	 <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>
	 <D5KE7X6LMR5Z.AA8PPWDBPQP7@kernel.org>
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
X-Proofpoint-GUID: BSxIN89-wLj06R1EaXcmpdmF9rfiGIG-
X-Proofpoint-ORIG-GUID: HMTXxOC6vnppCo9_9Vox7GchxXXu5dm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=534
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120157

On Tue, 2024-11-12 at 19:57 +0200, Jarkko Sakkinen wrote:
> On Mon Nov 11, 2024 at 9:53 PM EET, Mimi Zohar wrote:
> > > The original open coded the empty auth append with struct
> > > tpm2_null_auth since it's the only user.  However, since we do have
> > > another user in trusted keys, it might make sense to consolidate.
> >=20
> > Instead of delaying the current patch from being upstreamed, perhaps th=
is change
> > can be deferred?
>=20
> Yes.

Thanks.  As soon as you repost the patch, I'll re-test.

Mimi

