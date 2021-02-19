Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA831FD6A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBSQxZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 11:53:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhBSQxZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 11:53:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JGYdxj117101;
        Fri, 19 Feb 2021 11:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kaAqwSwiV9bHR5MZ/ojgaoy1ShCOB01Lxp/uWhkct/8=;
 b=kr+AbqfQfzTQFmwWaRc08BbeXQz306Oo60AzwZVJDBPoaxyhSAqQVeIrJbZcNGjxkl/m
 G/3vOvxqg2HZ0DE25t0LKxWMtbKukp3JePmCh+2Kdp2pjSgud7LP3iHdhxE0xpxXkcYb
 uhlG2eaOhhOS9hIE5u8gK0huaOhfGp1CgdqL3jndRruFVf9bgxZ/aYtarHUfNS/VPfls
 6Vi/tgxs/dxk/RYOQansX7eaYfsPcGCCZQn+9D+E7f3Rd8GvKxCu3V16+KjrO/ZQo4Wh
 oGFUEr2NQwtgf06lTRBX1Qw0WDtpF3ZhNATzwTvde8Msbala8eOSVfmkLSoky4R3zhak lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tgna1am2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 11:52:39 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JGZHU9120830;
        Fri, 19 Feb 2021 11:52:39 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tgna1ak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 11:52:39 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JGm6c6028923;
        Fri, 19 Feb 2021 16:52:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 36spsn8mk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 16:52:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JGqYKq48103746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 16:52:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09EF6AE058;
        Fri, 19 Feb 2021 16:52:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED08AE045;
        Fri, 19 Feb 2021 16:52:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.144.116])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 16:52:31 +0000 (GMT)
Message-ID: <0e2a789456a970ebdde9a65717b15d478af73ae3.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Add support for using elliptic curve keys for
 signing modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        nayna@linux.ibm.com, saulo.alessandre@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 19 Feb 2021 11:52:30 -0500
In-Reply-To: <20210219154114.2416778-1-stefanb@linux.vnet.ibm.com>
References: <20210219154114.2416778-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-02-19 at 10:41 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch adds support for using elliptic curve keys for signing
> modules. It uses a NIST P256 (prime256v1) key if the user chooses an
> elliptic curve key.
> 
> A developer choosing an ECDSA key for signing modules has to manually
> delete the signing key (rm certs/signing_key.*) when falling back to
> an older version of a kernel that only supports RSA key since otherwise
> ECDSA-signed modules will not be usable when that older kernel runs.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan!

Tested with this patch applied on top of "[PATCH v8 0/4] Add support
for x509 certs with NIST p256 and p192" and "[PATCH v2 0/5] ima: kernel
build support for loading the kernel module" patch sets.

Tested-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

