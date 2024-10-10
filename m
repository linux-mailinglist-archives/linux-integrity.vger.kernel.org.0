Return-Path: <linux-integrity+bounces-3778-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3B997AFB
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 05:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44751C23E26
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9E18593B;
	Thu, 10 Oct 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFRa6cBT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060672AEFC;
	Thu, 10 Oct 2024 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529339; cv=none; b=QMzzncNS+KzHKBHpnUNiK6WmfGicHN+vDB+cGYl1aABO7y5kOEab215CCEzDoRerdORYFNj/J++SGSdp2COWc2UUzQvMHisJa3hEr/azasHZkPgKUz1EmAdvi1Wvpwm2jQdEMGojQVY9XIzJ2qaUglaDJh4pfy2CgnJRDvvfgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529339; c=relaxed/simple;
	bh=4BgPCK+F3LiivdMjYfBfIZJiX2GAwTIMuPjuDQpPFBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDLm0zUNUHFrBRF7MY/z8kfN9dWOciTa9vbWCSXomWYUPfZzQKFF09UCU3Xx8YFTNA7rJrpQF/mHcpjqMooJsFP5sDaSKIyKoQ4heFpocv6xYZ1rAd2emk6OQ5TUskf0NJxvlQs0L1ARaf+Yxp6YOgpUFnFpuzTHSmEeMbC6oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFRa6cBT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A302ie032232;
	Thu, 10 Oct 2024 03:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	HtPgc7a33i+KxQeGQwFZGzpWFHyY7NpEQ7Dwhb4PZE8=; b=SFRa6cBTBlbHerBI
	N53+ZGT7A3S0zNEkkDJDoWgAlvCyR6mB9jFkmU6Hk3FfYvQW4bwHIwAcrmsXVWIj
	jGW9U2LetZwBhgDTqQGrrEkKHQIlshd1u12IOx27TDYzmUhth7yHGOZ3K1ewIq5i
	Nt6/PX+WyWsaVM5NnAZeRKD/Y0ImG2udxe0PjA6wQ+VYRi/GnGTxenKQy0wzf7J4
	tw9UeTkKQwT4K2LxcoLdIe7f2eG7DoeN9ibx/ISki+PzvrGDX5R5soJXAmwjnZFS
	EwqaXTMp2yeUrtXtkSEn/Ex9LN2NBIxOVLRRjrQKoNGW9iwJcN9T8XO2ERSTn5//
	zIR+rw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266mpg00r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A302p2032247;
	Thu, 10 Oct 2024 03:00:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266mpg00g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499NPiFR022861;
	Thu, 10 Oct 2024 03:00:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg153fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49A301NB40501566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 03:00:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2946B58055;
	Thu, 10 Oct 2024 03:00:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A52758043;
	Thu, 10 Oct 2024 03:00:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.45.194])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 03:00:00 +0000 (GMT)
Message-ID: <7a4f5be16e822236901e8cae032b0bee417d5f50.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: stop avoidably reading i_writecount in
 evm_file_release
From: Mimi Zohar <zohar@linux.ibm.com>
To: Mateusz Guzik <mjguzik@gmail.com>, roberto.sassu@huawei.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Wed, 09 Oct 2024 23:00:00 -0400
In-Reply-To: <20240806133607.869394-1-mjguzik@gmail.com>
References: <20240806133607.869394-1-mjguzik@gmail.com>
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
X-Proofpoint-ORIG-GUID: C5HIWflkvMbHnIq5KDRL2uOAhffbOyub
X-Proofpoint-GUID: LzIkJNG4EN0eC1IZLxcRruNI0sWvK33e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_23,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=611 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100017

On Tue, 2024-08-06 at 15:36 +0200, Mateusz Guzik wrote:
> The EVM_NEW_FILE flag is unset if the file already existed at the time
> of open and this can be checked without looking at i_writecount.
>=20
> Not accessing it reduces traffic on the cacheline during parallel open
> of the same file and drop the evm_file_release routine from second place
> to bottom of the profile.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Sorry for the delay.  It's now queued in next-integrity.

thanks,

Mimi



