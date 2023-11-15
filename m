Return-Path: <linux-integrity+bounces-58-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF87ED666
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864A91F259DA
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5053DB95;
	Wed, 15 Nov 2023 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lUkytxTW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1E193;
	Wed, 15 Nov 2023 13:56:41 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFLhVJA004961;
	Wed, 15 Nov 2023 21:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9K/cLdVo2ucKzMPx1+SKCSvLmh4Jt/8QKnLodIoP+VA=;
 b=lUkytxTWAYIo3dXMNT+PSP3+sXR4E9I9Psp3s10BkVwQw8qKiMOPgWjg+JKlWiDO/zBb
 aJA/1tOQxVTPmjtfxgoeRB9i8Fl8a8QvaxQ7ak/jYySyuXOPYEz09uoHPuAL84pSTyf/
 P4hTxv5DoAA6hPWo7CQ4BHZyRlhHANb5H59aIrW4QqJBsEmIW/2B7ROSfc3iE/UFT60c
 1w1080gz0+DvW7m6nein+BPKv0c5+78LYHQcAPW03a2ymuPwHsQEtPB+HMryqOZ89iP/
 U6UVDdNzjuNw5H5ofpp+bNMHVJRGvoy72zKA7snJPmShj8KJM/NZBoUbqF44guypaUoQ Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud51q1v6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 21:56:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFLRTAu016535;
	Wed, 15 Nov 2023 21:56:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud51q1uuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 21:56:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKIx1o014619;
	Wed, 15 Nov 2023 21:56:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekt9w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 21:56:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFLu5JX15336128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 21:56:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B99B5805E;
	Wed, 15 Nov 2023 21:56:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D742C58051;
	Wed, 15 Nov 2023 21:56:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Nov 2023 21:56:04 +0000 (GMT)
Message-ID: <ee054131-9d64-4945-b8aa-76b212effa7b@linux.ibm.com>
Date: Wed, 15 Nov 2023 16:56:03 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Extend struct tpm_buf to support sized buffers
 (TPM2B)
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20231024011531.442587-1-jarkko@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231024011531.442587-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hxvq3Jm9IotJVc_jxNKr0IXxcoNd_wRd
X-Proofpoint-GUID: QU_NMfOQm3pNkuK5aTwxgI2p-wXCj569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=690
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150173



On 10/23/23 21:15, Jarkko Sakkinen wrote:

> For TPM1 I tried:
> 
> keyctl add trusted kmk "new 32" @u
> 
> This caused TPM error 18, which AFAIK means that there is not SRK (?),
> which is probably an issue in my swtpm configuration, which is visible
> in board/qemu/start-qemu.sh.in.

FYI: This would create a TPM 1.2 with an SRK with password 'sss':

swtpm_setup --tpmstate=./ --create-ek-cert --take-ownership --overwrite 
--srkpass sss --ownerpass ooo

