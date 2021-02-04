Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5A30F3AE
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhBDNI6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 08:08:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236029AbhBDNI5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 08:08:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114D47DJ152103;
        Thu, 4 Feb 2021 08:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=UmlAZeRcLNSCUSJOz0dG/9kvZqucqkvKYZNhX3ejIao=;
 b=oQtiaYQi7o7wAVKHYpfUK+cczTuYoU0+BgeVAy1kGdzL4HXsjsuD4sKz3q4vw8GsQy13
 598+mo4+y+HBVM4hWMpp3udMIsceeSQxqy4J6f5rIG23TlvOR3ponFtrxeZUUwWbK7Ms
 alHTmtTsToLuyVX7yd72lDonYSTOUjpdErm9ZKjhApYSIua3zQYXEv9UNYiKpoSOksDD
 GVGIaBG1xLwvh3RAShB1uar/V9qzgaRb9M1lMvADwspa2UTOwNU/vPFNar36NhMh/MMu
 1xXy+uTs/CwQ2NYZmRWbaLnGo1JUNo+C3/csA6asYuHNtBUK9v9ydRgP2FO7SFW/XG4U 9A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gh7qrquj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 08:08:13 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114D6jhi022729;
        Thu, 4 Feb 2021 13:08:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36cy38mx4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:08:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114D87hE34865610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 13:08:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0934AE051;
        Thu,  4 Feb 2021 13:08:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5331EAE057;
        Thu,  4 Feb 2021 13:08:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.103.15])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 13:08:06 +0000 (GMT)
Message-ID: <5b69d40d6eda71f22b1490a613372779fd3a196a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] ima_evm_utils: Add tests for ECDSA signature
 checking
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Date:   Thu, 04 Feb 2021 08:08:05 -0500
In-Reply-To: <3e320725-6f97-43b9-070d-129696fe17e0@linux.ibm.com>
References: <20210202155625.3555769-1-stefanb@linux.ibm.com>
         <3e320725-6f97-43b9-070d-129696fe17e0@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_07:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-02 at 12:42 -0500, Stefan Berger wrote:
> On 2/2/21 10:56 AM, Stefan Berger wrote:
> > This series of patches fixes the calculation of the keyid in the
> > sign_verify.sh script when it runs on older distros, such as CentoOS 7
> > or Ubuntu Xenial, and then adds ECDSA signature checking using elliptic
> > curve keys.
> 
> This series passes all relevant Travis tests. Te one failure seems 
> unrelated to the modifications in this series.
> 
> https://travis-ci.com/github/stefanberger/ima-evm-utils/builds/215764182

Yes, this is a known failure.  The tip of the next-testing branch
changes "eoan" to "groovy" - 056a7d284c15 ("travis: Use Ubuntu 20.10
groovy").

thanks,

Mimi

