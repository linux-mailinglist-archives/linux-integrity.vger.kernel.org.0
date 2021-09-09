Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB94405CC7
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhIISV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 14:21:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50386 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237172AbhIISV0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 14:21:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189I2k5a094025;
        Thu, 9 Sep 2021 14:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2n8QJ1cbL0OO2VSDXilTS1IiYfGfJtcz0GljvG3/16o=;
 b=P+yQz+O7bULOcKV4ZrP4GuXc8frW3PS4/nByRbbhdjhs9c8rppX9V11WO4zm2qTHYCUw
 DKsqrfWhg50ImiDUiHAZr7cXvbmhQcn7ToaaXwntu51L1okSgVSarDhbhJ1b/4QJXyA0
 KiAYeJzwoR71W+jY9fwC82/env0OeOMHiwmSb0CRB/MVlw733kcBERrjai11jChoUdbE
 1ol6v/6asKG8A7+O1I17qb+LOke+8WedrhXPOrbd0uH0xz/LJAEsHKsE6vv47695Uq66
 bVfEcczr5/sdBcWIGc8pqzViXNNj/8uMwgutwFNwEtwAGbAdcDQHLF/7VqliRzo67NlU Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aygjvm4bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 14:19:51 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189I5Vac107485;
        Thu, 9 Sep 2021 14:19:50 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aygjvm4ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 14:19:50 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189IIFIM031746;
        Thu, 9 Sep 2021 18:19:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3axcnkgd2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 18:19:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189IJj0m40894928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 18:19:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42BAF42042;
        Thu,  9 Sep 2021 18:19:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0714205C;
        Thu,  9 Sep 2021 18:19:40 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 18:19:39 +0000 (GMT)
Message-ID: <babee2bb6710de2f26d1695b4ee8bf4c93a3f2ca.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/12] integrity: restrict INTEGRITY_KEYRING_MACHINE
 to restrict_link_by_ca
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 09 Sep 2021 14:19:38 -0400
In-Reply-To: <B34345FD-38F9-4722-B046-E250ACBD5B8C@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-5-eric.snowberg@oracle.com>
         <c5d8d846cd03a97344700f8ce4f038cdc3e3b8fd.camel@linux.ibm.com>
         <B34345FD-38F9-4722-B046-E250ACBD5B8C@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LS5KTEqwHIoR0uEY6nCUmaD2NdX1mvw-
X-Proofpoint-ORIG-GUID: bk7B5mYRoc7QSMT92GE7LvAcTgbaJF11
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_06:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-09 at 11:53 -0600, Eric Snowberg wrote:
> > On Sep 9, 2021, at 11:25 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> >> Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
> >> restrict_link_by_ca.  This will only allow CA keys into the machine
> >> keyring.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > 
> > Normally the new function, in this case the restriction, and usage
> > should be defined together.  Any reason why 3/12 and 4/12 are two
> > separate patches?  
> 
> I split them since they cross subsystems.

That makes sense.

thanks,

Mimi

