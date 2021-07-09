Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596843C272E
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhGIQCm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 12:02:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232351AbhGIQCl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 12:02:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169FWtDj181659;
        Fri, 9 Jul 2021 11:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1Po+rMtMFJxfuFZqCeL6KxfLyqZR7O/9IyCglXOMvmw=;
 b=QRcFJ4IFOXT2/bFp1H7JBrOUzU/3dt7tXIjJjZcE9t6SkXFDRba3nFZEeZN0NZE8glbr
 PIEOQD1ixymNS4gABUbSJIQq1xk7Tn8O3qyB5wuo83sZKqc0UJVqZ0g/5YnIKLmzZ4ZK
 KdgjFia1ELuvwZ1oqMCyaW8bIiQ1Cz+WYWGdeTTwfmwueKmTf9qm2//w73qbG5YqOthW
 Dmjxp2Nrt+0OgszOoQc54rR6bvWD/gsJ78vV5E9u/gF2W/Dc9bOqaYRrklnpa0cTiLqZ
 9QRyVwu2VUonUvJsPjD5cBl4e/wFpjNz+eZ4BFWThfDuY+sgbOkYFmAuaNF8QFVkHpb1 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39phqkwh5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 11:59:24 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 169FX7Bo182394;
        Fri, 9 Jul 2021 11:59:23 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39phqkwh5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 11:59:23 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 169FwB1J028432;
        Fri, 9 Jul 2021 15:59:22 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 39ju3dn5hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 15:59:22 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 169FxLoY37945660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jul 2021 15:59:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 740BE124073;
        Fri,  9 Jul 2021 15:59:21 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A6C124066;
        Fri,  9 Jul 2021 15:59:16 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.163.3.233])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jul 2021 15:59:15 +0000 (GMT)
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
 <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
 <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
 <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
 <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
 <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
 <490941a5197bf4bcf0d6f95610085ee4d46ed9bb.camel@linux.ibm.com>
 <839EF700-7A2C-4282-AF97-768FAD1A9957@oracle.com>
 <ef480c8f83780eea4ff8fdcd35c6208760b5e1d7.camel@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <51434508-e2ad-c9f9-2612-2a9162cec71d@linux.vnet.ibm.com>
Date:   Fri, 9 Jul 2021 11:59:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ef480c8f83780eea4ff8fdcd35c6208760b5e1d7.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m6PXIplm1CJI8HDYe7ntOIno-_i_X63y
X-Proofpoint-GUID: WKRt1Pulw0vog-lQfrySLYMyxXTXdSvD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_09:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090078
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/8/21 9:10 PM, Mimi Zohar wrote:
> Definitely not ".trusted_platform" keyring, as it would be too
> confusing with the existing "trusted" key type [1].  At least for now,
> leave it as ".mok".

Since this keyring is meant only for "CA" keys, can we name it as ".ca" ?

Thanks & Regards,

     - Nayna

