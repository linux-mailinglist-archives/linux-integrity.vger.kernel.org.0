Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8F3CEFFC
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 01:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbhGSWyB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 18:54:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358280AbhGSUTG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 16:19:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JKlxbx106523;
        Mon, 19 Jul 2021 16:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jZHWpDjeE6vOHFw8ZDf6MrL5Q086fduFHeEMPfIw1hY=;
 b=MqDv760rWXrusWKJXFTLhFRqBZuKsGQ7YWs98LPjpqGO3p4c668RqyLIyC51dG4DJSgo
 OGRzcfKX3MnjmJ4Usz50s+NKvrpR6xL8gygfHzVV/VoX4g6c0qLmHLuYy51B6bdzT+Qb
 pKHKpJxn8KeTIsfNKVW1gGhDpdDoxH2fXWrUF3msUmIU178gNjROZmKeo7798kCYA9Yo
 W9j4cjQDT0QlN1zN24/AP25PMBm+FD+J2b9iegsqgK2amZj9LgX4MB/MzQsYv5e6xEWf
 +gXzm7Q5hosd5iqCrmzzsuoqusIBu9VPFMrKxGuneXNASw5VscYkn2pN9forv4Hv7gk+ WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wgrcg769-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 16:59:40 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JKn2c5111036;
        Mon, 19 Jul 2021 16:59:40 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wgrcg75k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 16:59:39 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JKxbpj021216;
        Mon, 19 Jul 2021 20:59:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu88w5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 20:59:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JKxZOV36831492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 20:59:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08979A4057;
        Mon, 19 Jul 2021 20:59:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05F0A4040;
        Mon, 19 Jul 2021 20:59:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 20:59:32 +0000 (GMT)
Message-ID: <e2f33ad4dca9eba9b2a05a00de571e9f94022343.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Date:   Mon, 19 Jul 2021 16:59:32 -0400
In-Reply-To: <20210705090922.3321178-4-roberto.sassu@huawei.com>
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
         <20210705090922.3321178-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oViPlRVS_7IGirnDVCX6rF6hGwCr-Wry
X-Proofpoint-ORIG-GUID: KdozGSTi1aeAoprdV8zr6m1zsnR43faD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_10:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Mon, 2021-07-05 at 11:09 +0200, Roberto Sassu wrote:
> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
> 
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.

I agree ima_measure_critical_data() is special.  Both this patch
description and 1/3 describe "what", not "why".  Please provide the
motivation for these changes at least in the cover letter, if not in
the patch description.

thanks,

Mimi

