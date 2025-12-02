Return-Path: <linux-integrity+bounces-7762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6120BC9C57E
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36DCC4E23F8
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C32BE625;
	Tue,  2 Dec 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvQ2BJFA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900361A262A;
	Tue,  2 Dec 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695432; cv=none; b=rzTjuqjK0mVA03NOChLSgRq2opbMFKVEc/1+6Vg4mwX60VGoXd5RcstTg2tJ/w5wk8edKAISstvqNzPnnDyOdC7bUq0q6mtKXfeKwaGZ6BmOmhLG2cDTuYlfpczefhgR8ehe5UNvY8WxzwHUbviKHIPbnY88yqRPJX7ggsLJ3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695432; c=relaxed/simple;
	bh=NKQDEFMMODK2a944Kwz5haNjyNIE6BcnNhcuSTSX1mU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=X8uhexiuoxLwKKGhBJ0prNfQO1CuJrktxwdgjt8cdD6Q/7F4zoC6UNYg+7bqUmzjrQv0NwlhdLlWji6Al6NuV7QONuYs0W7+1gpx6MgGd5toyo5bcaMGf1evCfF3UyeyHMbaVLDkdEho0DbWfG2YOXSTM+q6v/U2xEnal1/oa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvQ2BJFA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2B8dHp009614;
	Tue, 2 Dec 2025 17:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/NdiMw
	+URNfDRJcuHIyYSq+jAprVETK7YEXzBTH1eC0=; b=rvQ2BJFATUYbF01XiXFa9H
	43Vo6NXF5mG8fp7zU+NOajs5FZdrPL78pzVQ1uxlRW33xZWpheyMkQLizFR7D1pQ
	YLdwMidBV52QVH+wr+fAPCvPF4UJy0d9Qp/mxcfgYOGjCA1yW9YVWy/Pu5ybgbwj
	CbEbK3ZHqntPuu3AyUXwmC8VCryEfyY0svgHpUrj0lMEFiWFkTX5hPCHD4Cu2NBy
	6J5pafalbCsi9b0r7T0HNYjgCxkjoPTawUkOSbnyq3Hd61SRsPoxDZU7EbvuPW/k
	TCiMjmFYYEq3ugaV7w5aI5esKqeUJZNUFQWcVaPYMFjkqKJPjIUt1k1Yj8c7XD+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9pagb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 17:10:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2H2o3b011428;
	Tue, 2 Dec 2025 17:10:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9pag6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 17:10:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2ENuSk010284;
	Tue, 2 Dec 2025 17:10:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnk5hpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 17:10:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2HA7YL19005962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 17:10:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2FF758054;
	Tue,  2 Dec 2025 17:10:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F7758045;
	Tue,  2 Dec 2025 17:10:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.56.35])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 17:10:06 +0000 (GMT)
Message-ID: <87246cfef670c9a63e1c1a20ec1c259290b317bf.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] evm: fix security.evm for a file with IMA
 signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
In-Reply-To: <7jzx432acnp7mrma7om5ccvrc3ucvm5psscst62bcl5t5yklh7@yxhcvmrgbgli>
References: <20250930022658.4033410-1-coxu@redhat.com>
	 <7jzx432acnp7mrma7om5ccvrc3ucvm5psscst62bcl5t5yklh7@yxhcvmrgbgli>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Dec 2025 12:10:03 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uqGx-OL1xjCmu34IsQ3SdXYZZJTO3cAA
X-Proofpoint-ORIG-GUID: Wrk1xLvSVFpaHXQ0deIoDRywGRxjUQFf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX1Or1l71O6eI3
 ikHc1qo7Nhfbfw7whJPL85sz2bQA2LtWaPu4RU+Ffl+wbnXXBP8N9L+i7a3Gp6ocuwflgKfSlrO
 ne/ObXKio7F8ULK1AJtIuU+bIJPOxvfvWpFxHG6/gtoEWs3u0rZ7Dfr+wXrpZtTWzNp3ayKIvHo
 rq6yI6N/fsQwycR+jnfFU708xq0+ISBK79cQQsg785uqqmBPbXT0SVdKh6Nw/l8xN1M3vH8sn7N
 qqfxd13TRTjuznRWqYLDipT1uuX3Mpl2JeLA7p1T9w3jRqYMucH5nGZDCFIGRBPBUXUiZZ4bx8/
 pQaUvaIuVwuIxSYEVkTgoNf9taMFSRBWjWpZvYxj4xERjRpj+5jZwMWUWzcif52t4olp0hz7YHL
 yfdxNKrqueUBGeAmM4jaqv5YykB/Ww==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692f1d71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NhNiMazW0HjkleIlhl0A:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Mon, 2025-12-01 at 11:15 +0800, Coiby Xu wrote:
> Hi Mimi,
>=20
> I think this patch set just fell off the radar. Can you take a look at
> it when time permits? Thanks! Btw, the patch set is still applicable to
> current next-integrity tree Linus and main tree.

Hi Coiby.  I haven't forgotten about this patch, but would prefer upstreami=
ng it
together with another EVM change.  I'm really sorry about the delay.

--=20
thanks,

Mimi

