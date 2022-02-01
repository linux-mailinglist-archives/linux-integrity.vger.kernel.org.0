Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1334A5548
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 03:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiBACiT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jan 2022 21:38:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232321AbiBACiS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jan 2022 21:38:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2112Vn2p029687;
        Tue, 1 Feb 2022 02:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xvpN2y2THhIqK++StzkIAxtch5lSAOLB+RUdPTRHiAM=;
 b=Qda/1dlrxIVb+pBlj0kBHNDxI4yNCD3OsH+KOjbDdR3+orspAVflNyvgMo7vlNwZFGR6
 En8hgesRYFlxPWM8s4EVY8grO4PnbnQyLZFTdbi1bwPWW+Ue3QLoPWrm+gQHivsFLeFR
 Kq/78OmGPvlWTrUWtSYgQo28MdEeDJJ0WvAD+xqw+D001WRb9Kq/UKh3cvVEQnWSVr8j
 yl89rk0tHeh0gdewiUyARETIDlNc5WtjT7gCjnKFBKld8wJ8mzaQdNgIwekPi/DHjpJY
 6rimiE8HypPvtfNR9A2HRZ4W6gdR5jTiuHlUKojpSO/Ege73Yywn9IonGsfrXx8USc7K Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxv5j03je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 02:38:13 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2112Yc7F007472;
        Tue, 1 Feb 2022 02:38:13 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxv5j03j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 02:38:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2112ITGt011215;
        Tue, 1 Feb 2022 02:38:12 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7b21ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 02:38:12 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2112cBqr41353718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 02:38:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5572FAC05E;
        Tue,  1 Feb 2022 02:38:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14AE8AC059;
        Tue,  1 Feb 2022 02:38:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 02:38:11 +0000 (GMT)
Message-ID: <26f513aa-abb6-ec9e-d388-b6ce32e36396@linux.ibm.com>
Date:   Mon, 31 Jan 2022 21:38:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] Fix bugs in public_key_verify_signature()
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20220201003414.55380-1-ebiggers@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220201003414.55380-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TB1G90OoUEYTbZuec5i6tWAIMA4OVFgM
X-Proofpoint-ORIG-GUID: AIhNOBL5bNBd8OwMV8pDqZnSbcT8f_zR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/31/22 19:34, Eric Biggers wrote:
> This patchset fixes some bugs in public_key_verify_signature() where it
> could be tricked into using the wrong algorithm, as was discussed at
> https://lore.kernel.org/linux-integrity/20211202215507.298415-1-zohar@linux.ibm.com/T/#t
>
> I'd appreciate it if the people who care about each of the supported
> public key algorithms (RSA, ECDSA, ECRDSA, and SM2) would test this
> patchset to make sure it still works for their use case(s).  I've tested
> that X.509 and PKCS#7 with RSA still work.

I have tested that self-ECDSA-signed x.509 certs can still be loaded and 
ECDSA-signed files are still verified by IMA. It works for NIST P256 and 
P384.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>


>
> Note, I have *not* included a fix for SM2 being implemented incorrectly.
> That is another bug that I pointed out in the above thread.  I think
> that bug is for the people who actually care about SM2.
>
> This applies to v5.17-rc2.
>
> Eric Biggers (2):
>    KEYS: asymmetric: enforce that sig algo matches key algo
>    KEYS: asymmetric: properly validate hash_algo and encoding
>
>   crypto/asymmetric_keys/pkcs7_verify.c    |   6 --
>   crypto/asymmetric_keys/public_key.c      | 126 ++++++++++++++++-------
>   crypto/asymmetric_keys/x509_public_key.c |   6 --
>   3 files changed, 91 insertions(+), 47 deletions(-)
>
>
> base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
