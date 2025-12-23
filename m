Return-Path: <linux-integrity+bounces-8134-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F4DCDAC34
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Dec 2025 23:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2F5300C5F7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Dec 2025 22:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B8219313;
	Tue, 23 Dec 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+x0peDn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3631624C0;
	Tue, 23 Dec 2025 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766529188; cv=none; b=SbeVxcPveEkymXVbDYtrbXOs6RuwkufyzHMXIWlLl5ZkGe4glpI3Ep7ViBAz8CyAGI61i9+stgL0P3JQP86CVjmQdEMtzhVmM86Hly4FqbwULAJVz2qmzszlR+o1kVDoO3QpX5mglgn4NC3Fl5avBPZrj7RE7BQMtwKXddkmvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766529188; c=relaxed/simple;
	bh=Fopdh603CQTT10896Z20gpo2SSvmF/o0M3R3fNxpAzU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ql3xU4kgG+UOnHNQA/zIHCGU3ejv6rHC5G6FovIqn/l+lutezDw943tnCFyO/JLbZkrCV5zFDrwJ057V4i4cpiHZc/T0nD1ojHA3izzczE5LrCJom/rF8TlttAYLo7/wlDMtfPtkE99h9oSazwRNoouxPY3I/Dp0S7nbg6P82L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+x0peDn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNExln9003146;
	Tue, 23 Dec 2025 22:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DH2X4C
	oi53+Ydia//Ib0Jip+APf6u237n9coHTJNB9c=; b=o+x0peDnJdjFqrgtts7bDm
	4/HX67f+ajReZzpUaNH/t5Di+4GsC4AURCx8j8gIlrRUS8DzYaB0wwP22jowoO/c
	6G3yl73qO0ls47S7TEciy2OnogRVZBQZ2u0LHwijrnE1KuUqJJ7WYbnqz/anjF/X
	tcgzHFtOpT5YGaD6as4RMQM1ipUom7S+/06JHkKtH4XkatVNJTCuCgQvYNyO3PJx
	39mUehomAk7VXVGLWZpf59ryifz7bJ9E7By+U45W98+siQzIoEee2c22kQQVID/8
	jMgl3Updh5xV82I+CoQHaB+gFfwDBaEXC4QqqFk/KiHlIuGw3jmBBRNauZs72Sug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4evgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 22:32:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BNMWbeN020236;
	Tue, 23 Dec 2025 22:32:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4evgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 22:32:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNKll7H030183;
	Tue, 23 Dec 2025 22:32:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b66gxwhg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 22:32:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BNMWZ6U19137058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 22:32:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFCFC58065;
	Tue, 23 Dec 2025 22:32:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4F9B58056;
	Tue, 23 Dec 2025 22:32:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.160.131])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Dec 2025 22:32:34 +0000 (GMT)
Message-ID: <9a26898f46406314be1308e5416c0d51cedf44a4.camel@linux.ibm.com>
Subject: Re: [PATCH V2 1/1] IMA event log trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
        paul@paul-moore.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
        gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
        sushring@linux.microsoft.com, linux-doc@vger.kernel.org
In-Reply-To: <b9d7bcea-3784-4ad6-b494-374db0c00cc6@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
	 <20251210235314.3341-2-chenste@linux.microsoft.com>
	 <d80958ec-f139-41e9-afa0-a5aca94221de@linux.microsoft.com>
	 <c93907cb0f08f9baa320488989aa87e7867ee9da.camel@linux.ibm.com>
	 <b9d7bcea-3784-4ad6-b494-374db0c00cc6@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Dec 2025 17:32:34 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=694b1886 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9tRBcEDlKUlfiG1y_IYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GJ0Sf3WYduDmX7aQQsYDRJNnrNQ7gZui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE4NyBTYWx0ZWRfX82gw8e3Ej1YK
 uR3ER0RbQvMJDng+kDhvIcpww8bubrjpQtK2aVuCSPN9cPo0YZnbOOJH1E3dsS9aq+n4pzFbllW
 LVvYKJdU1noI24gIaXWwnGUZANMQlrET738Xw9pTGxWsqyu7zdZk28CeylQ5QZJjD1697pUxO07
 RxYp8iXEcx+eukoOeWMdkRVpBjpR2F8iUQX6F7rdIOoBQGA7w2n/RAo5BhPtzphsx2XV3Vhdnmy
 OmLTSp9iBaRi9nqebJUtvOmgTwZcKmjOsrJptpSidWONAk8mJF1PFBYMMprk9evaEBovMOOGJI9
 PcRNKHHipXniz7jJV4jY3oIUX83c3A+mVnrNjhx1lUgZSNTYF7PuUfmNJuXPpSK2tqdsMcKSAbZ
 BoNwCW8p5V3//OmySE76rxlGVUXekXmIomfPq+qbXBu8Nq3l4qSU9D54ZXj2CAOmWYyRk4wtUBx
 Dfic+lj30WL5u5+uuxw==
X-Proofpoint-GUID: zKZjc7fslhq8_ETL89wlljnzRjR-jAGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512230187

On Tue, 2025-12-16 at 11:59 -0800, steven chen wrote:
> > > > +{
> > > > +	struct ima_queue_entry *qe, *qe_tmp;
> > > > +	LIST_HEAD(ima_measurements_staged);
> > > > +	unsigned int i;
> > > > +	long cur =3D number_logs;
> > The variable name "number_logs" is confusing.=C2=A0 As I mentioned in t=
he patch
> > description, there is one measurement list with multiple records.=C2=A0=
 There aren't
> > multiple logs in the kernel (other than the staged list).
>=20
> Will update it to "req_value". Thanks!

Please refer to the section titled "Naming" in Documentation/process/coding=
-
style.rst.  Since this is the number of records being deleted, perhaps a be=
tter
variable name would be "num_records".

--=20
thanks,

Mimi


