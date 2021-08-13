Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428C73EBDDC
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhHMVcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:32:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41116 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234547AbhHMVcU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:32:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DL7XZw069075;
        Fri, 13 Aug 2021 17:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cxHvo/ds5KxsfhWsVSfMIEEZu84Lh+6Tbqbl6aVUMeE=;
 b=N5G2ykahgOfsJo+CO/qFTu7+PMMVQwPG1dClIyurXKNXpNvkwlEXMTTcAHjLP6n6FXUS
 0Uq2dLoNai0GmAFrjVu9CrQgFkbybpRjURDFFccWbu71uRr3+ES7TvqnGK1WqZMZQTmg
 lzQsp74hxG9zaFEThmkhqKGOVQd+FZid+FxXqj/ujKVPHy9Q7Wvi0bhRjGDqHQueng+M
 hrcec6MQ7hyfnpA5LjUhk8/9O83Q/QudBBKdSt1krktq4Toztcd76pAqGEUXnoTLw79V
 MkLY3JhFxnOa7+Zuv0+H8rVQu24iOt8vbXNLYdZO9qcd/Az27O0YiCyRpywEOjLMgJ7z mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3adu36g0gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 17:31:51 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17DL8a4V072527;
        Fri, 13 Aug 2021 17:31:50 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3adu36g0g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 17:31:50 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17DLNglN011142;
        Fri, 13 Aug 2021 21:31:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3abaq4ewb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 21:31:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17DLSRfH58393016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 21:28:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9F05204E;
        Fri, 13 Aug 2021 21:31:46 +0000 (GMT)
Received: from sig-9-65-222-118.ibm.com (unknown [9.65.222.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 290F252052;
        Fri, 13 Aug 2021 21:31:44 +0000 (GMT)
Message-ID: <3e870d0e5c5cbecce5d9fe1c0d613118ddb1bae3.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Improve memory handling for private keys
 and passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Fri, 13 Aug 2021 17:31:44 -0400
In-Reply-To: <20210812214617.og7eclvb53l3hqip@altlinux.org>
References: <20210812212143.2223183-1-vt@altlinux.org>
         <20210812214617.og7eclvb53l3hqip@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xMyPsUwJTxL2UQLxzCur4UJ1Nyd5LcIp
X-Proofpoint-GUID: qxhfR3V59voocYVQYiu-PU4GgMEQ2CZM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_08:2021-08-13,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Fri, 2021-08-13 at 00:46 +0300, Vitaly Chikunov wrote:
> Hi,
> 
> On Fri, Aug 13, 2021 at 12:21:43AM +0300, Vitaly Chikunov wrote:
> > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > secure heap. This facility is only available since OpenSSL_1_1_0-pre1
> > and enabled for 'ima_sign', 'sign', 'sign_hash', and 'hmac'.

From the manpage:
CRYPTO_secure_malloc_init() returns 0 on failure, 1 if successful, and
2 if successful but the heap could not be protected by memory mapping.

Not sure what we would do on failure ( 0, 2), but we should at least
check the return code.
> 
> > setvbuf(3) _IONBF is used to hopefully avoid private key and password
> > being stored inside of stdio buffers.
> 
> I should note that usefulness of this method (of avoiding buffering) is
> not proven. I don't find other implementations doing it. So, I'm open to
> suggestion of removing it.
> 

Probably would be better to split the patch.

> 
> > 
> > Unfortunately, secure heap is not used for the passwords (`-p') due to
> > absence of its support in the older OpenSSL where ima-evem-utils still
> > should work, thus simple cleansing of password memory is used where
> > possible to shorten its lifespan.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > Perhaps, it will conflict with Bruno's patch, we should decide which
> > one goes first if this will be accepted.

FYI, I was able to apply this patch (--3way) with the proposed changes
to Bruno's patch.  

Mimi

