Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23023F0D1F
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Aug 2021 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHRVIK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 17:08:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233971AbhHRVIG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 17:08:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IL3BbY133808;
        Wed, 18 Aug 2021 17:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UqysfXSW3XBh8JzYK5+ZkwKBrhVnnOCU1GUfHc6CBH4=;
 b=h9rWZB9EHEt1bGvg6skwARtld1hKrAfPsRp6eb4rc9K9CazgTARfVAhuhfaIx5bdQbU4
 em1wAZMSREIiuPuh5k61N4srwPrIMdc0gxfhcf21cz+t5uizK67cuv2wH9EDFIbk7aqi
 D1Ji0ICfqNPDYuq7wTT15ug9Srp5bywKZ2PAc0jNB+9JEe8y5QzPshcN0rMVyMuDaUrY
 yr7Uzx9MW+/9OowT0Mpnq4VWQAjF/rzeLsnUiRjM1xQ8wwDCm22J/jwTtY5wgOah/Dhc
 mTP3PxiesX0WASYED4aXlCccr2cJJ9YaYAFy+BHFu9BduYZWh4pqV5IhvZ2AFt1m0sqT Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ah9g4rjfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 17:07:27 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17IL3I1Y134632;
        Wed, 18 Aug 2021 17:07:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ah9g4rjf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 17:07:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IL3GIf031593;
        Wed, 18 Aug 2021 21:07:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ae5f8f631-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 21:07:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17IL7M5543123042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 21:07:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A084C059;
        Wed, 18 Aug 2021 21:07:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17BC14C04A;
        Wed, 18 Aug 2021 21:07:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.4.127])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Aug 2021 21:07:20 +0000 (GMT)
Message-ID: <0f85d155b154c7358eaf4bb2c65f391587e3809d.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Improve memory handling for private keys
 and passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Wed, 18 Aug 2021 17:07:20 -0400
In-Reply-To: <3e870d0e5c5cbecce5d9fe1c0d613118ddb1bae3.camel@linux.ibm.com>
References: <20210812212143.2223183-1-vt@altlinux.org>
         <20210812214617.og7eclvb53l3hqip@altlinux.org>
         <3e870d0e5c5cbecce5d9fe1c0d613118ddb1bae3.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SSnEWjCcUG1UhzufHp3aXzBkyHXz7CzW
X-Proofpoint-GUID: nZdPSVTQi_x3xMSyi5YtP-WyJ2Qsci8l
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_07:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-08-13 at 17:31 -0400, Mimi Zohar wrote:
> Hi Vitaly,
> 
> On Fri, 2021-08-13 at 00:46 +0300, Vitaly Chikunov wrote:
> > Hi,
> > 
> > On Fri, Aug 13, 2021 at 12:21:43AM +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1
> > > and enabled for 'ima_sign', 'sign', 'sign_hash', and 'hmac'.
> 
> From the manpage:
> CRYPTO_secure_malloc_init() returns 0 on failure, 1 if successful, and
> 2 if successful but the heap could not be protected by memory mapping.
> 
> Not sure what we would do on failure ( 0, 2), but we should at least
> check the return code.
> > 
> > > setvbuf(3) _IONBF is used to hopefully avoid private key and password
> > > being stored inside of stdio buffers.
> > 
> > I should note that usefulness of this method (of avoiding buffering) is
> > not proven. I don't find other implementations doing it. So, I'm open to
> > suggestion of removing it.
> > 
> Probably would be better to split the patch.

According to the man page "OPENSSL_secure_malloc() allocates num bytes
from the heap.  If CRYPTO_secure_malloc_init() is not called, this is
equivalent to calling OPENSSL_malloc()".   OPENSSL_malloc() is
supported in the older openssl versions.

Does it make sense to replace allocating memory for the password via
malloc() with OPENSSL_secure_malloc()?  For older openssl versions,
define OPENSSL_secure_malloc() and OPENSSL_secure_free() as
OPENSSL_malloc() and OPENSSL_free().

This doesn't solve the memory handling for private keys and passwords
for older openssl versions, but it is a path forward.

thanks,

Mimi

