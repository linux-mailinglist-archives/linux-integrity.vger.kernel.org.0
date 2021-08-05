Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A23E162B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhHEN7X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 09:59:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241742AbhHEN7T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 09:59:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175DXIjH130747;
        Thu, 5 Aug 2021 09:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1rXeo9LZ8sdgK8+jRm8mIWKvquz5FEKRdek01spIM8E=;
 b=B0OoL5oYUsPJpYeA6PqJXliiBRQAHefNVtcUiP5tpe9sCWs0KCftnLM5DE2VXaMtJM9J
 VXV0uqEvKw3zNIP8qXwxl43ZKe0gb25TNPBB2gaRSJMKeAJdpkhe3RU8n/TIaf2YXL7g
 j6SdWZBKJ6/h68srAz9BlDcAe8P8dqyhAMOoPphiqEgjkDjSPLKHzMxfqDDiC12lfiRa
 dNg46SWLivT1ejINKzj3X27j+VwXgaT6CEBQxroIiza4DD5BQaBlVIOZiEPaf65Rmy5a
 47K3dPUYhL18WLPNUc7piQZImw46uXFV11HcVob6y8zMl8Z7PMqjYjjcsSBpUt4EAlb3 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a87f6fqcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 09:58:22 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175DXVIX131536;
        Thu, 5 Aug 2021 09:58:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a87f6fqc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 09:58:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175DwAwq032297;
        Thu, 5 Aug 2021 13:58:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3a4wshub58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 13:58:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175DwGBp55378366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 13:58:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C31744C06D;
        Thu,  5 Aug 2021 13:58:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F914C046;
        Thu,  5 Aug 2021 13:58:10 +0000 (GMT)
Received: from sig-9-65-205-127.ibm.com (unknown [9.65.205.127])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 13:58:09 +0000 (GMT)
Message-ID: <de325c9efacda817c42ee83244baa0de4b246aa8.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        "glin@suse.com" <glin@suse.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Thu, 05 Aug 2021 09:58:09 -0400
In-Reply-To: <3D8EF15C-E3D6-4C9A-9BA2-9F4201AC3ED3@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
         <2BBC3A71-6E0D-47A2-842A-11C279A5DC56@oracle.com>
         <5ac7f5fc866dd271ecfc9be17fef7fa47babbc6e.camel@linux.ibm.com>
         <3D8EF15C-E3D6-4C9A-9BA2-9F4201AC3ED3@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qlBak8HRa1stUzgHPBPY4JRURS4dDkrj
X-Proofpoint-GUID: UZYE_32BMS_GhwZ0JBjQt8a9HtnpvsW8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_04:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 02:56 +0000, Eric Snowberg wrote:

> Ok, I’ll update the current code to just load CA keys into the mok in v3.  This would
> simplify the new restrict_link_by_ca function. 

Thank you!
> 
> With that change, do you see any issues with how I’m doing the linking?  With the 
> mok keyring linked to the secondary keyring, the platform keyring may only contain 
> a subset of the keys it originally contained.  But, as I described above, I don’t believe
> it will lead to a regression since all keys get referenced. Thanks.

I think there is a problem.  Only the builtin keys should ever be on
the builtin keyring.  The builtin keyring would need to be linked to
the mok keyring.  But in the secondary keyring case, the linking
should be the reverse, where the mok keyring would be linked to the
secondary keyring, similar to how the builtin keyring is linked to the
secondary keyring.

        if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
                panic("Can't link trusted keyrings\n");


thanks,

Mimi

