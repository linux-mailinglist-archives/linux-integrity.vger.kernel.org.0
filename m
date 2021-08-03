Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3F3DF374
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhHCRC7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 13:02:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234313AbhHCRCy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 13:02:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173GeB6r050725;
        Tue, 3 Aug 2021 13:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MDBxIUawbm49JyOfQS1cf24GJsUXapOiLraOXIEq5J8=;
 b=bpMsecEPcjRYfjsg28xplQ4jl24je6dsDt6kvmVh8gAdPfMUDcEjiZtPgc9evxufZylZ
 2WLsjUvF700/c94KGUNoSsxmINmWbVRrFc8I2N6PHa5krWtMyNSi/V/4EQ5e7oCmh+4d
 Lqc4zkdBH6HT01k3RWdDm+9O1xkHzrysWrZZGZEhtdnqbVRjncdUc7Ijb0beLW2z+aL9
 0NN/uOXHnB23JcV7MEMrcWPvzH0p0KCxF4bp1uiV3ToSEWs2qs+d5ZtC/Aux0P1NAyM8
 SuERmMVVYRWPgkrd1YsArem/ZBj8Kv/ovBzfYUB5bouWoCTdtCZOEP3ZJvPkgznxCX0P DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76auqc0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:01:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 173GeGDA050936;
        Tue, 3 Aug 2021 13:01:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76auqbyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:01:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173GvZR6004197;
        Tue, 3 Aug 2021 17:01:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3a4x58psfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 17:01:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173H1VZV55640356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 17:01:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BA415204E;
        Tue,  3 Aug 2021 17:01:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.88.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A48B952054;
        Tue,  3 Aug 2021 17:01:25 +0000 (GMT)
Message-ID: <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Date:   Tue, 03 Aug 2021 13:01:24 -0400
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jDB4OEcti4Hsw9NPjhd4mwZjq4CRGf-A
X-Proofpoint-ORIG-GUID: bK1hKs2bUBz3pY1FYqq74SJ5nMcq0C3Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:

> When the kernel boots, if MokListTrustedRT is set and
> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
> mok keyring instead of the platform keyring. Mimi has suggested that
> only CA keys or keys that can be vouched for by other kernel keys be
> loaded into this keyring. All other certs will load into the platform
> keyring instead.

I suggested only loading the CA keys stored in the MOK db onto the MOK
keyring.  Like the builtin trusted keyring, the MOK keyring would also
be linked to the secondary keyring.   Assuming the secondary keyring is
defined, all other properly signed MOK db keys  - signed by keys on the
builtin, secondary or MOK keyring - would be loaded onto the secondary
keyring.

As previously discussed, this might require reading the MOK db twice -
once to load the CA keys on the MOK keyring, a second time to load the
remaining properly signed keys onto the secondary keyring.


thanks,

Mimi

