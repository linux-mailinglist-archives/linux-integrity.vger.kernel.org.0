Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5554005B5
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbhICTSZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 15:18:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349503AbhICTSY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 15:18:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183J4LBl115637
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 15:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=imxUiTV80JROEREFPxdEjxGC1vl5rS6JB0kPi21JiJ8=;
 b=R3YuZmu0+/yiy37qdoNaCR1KxUtaXXsvi5tEP0cGfKCP4MpGNxr3GHIWpRIEh9+3bPHH
 xUTUriFrbWpzRr7etlUjgW3mIfJiqz36FAg+adRi2MvGEM1KAnB/DbZVG9BcxsHZ2UtY
 1E7Ax0qXhrt/IHpOZ8Bw277rxLKRXwCsZQVp4hyeEDBbn4FvZt9nwUIWfGRvgiu/14NI
 0Ju7JFTlv62KkIjPvft4fbEfbsYWIB6GqbCMe1Kvq7YhCTx3VtPogLtda7w6KlWQyDh/
 IY0Pwwwh/tcAVOa/18zFJYTZaKhzfBUXB9NXJWlI6Ah006OBP84K15bho5H/OuWAyhDZ 5Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aurcphs3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 15:17:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183JDBwc020808
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 19:17:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3au6pn3kyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 19:17:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183JHHSV44827100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 19:17:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A158BA4066;
        Fri,  3 Sep 2021 19:17:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC9DDA405F;
        Fri,  3 Sep 2021 19:17:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.70.237])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 19:17:16 +0000 (GMT)
Message-ID: <290fc452e87d999dc8fe2bcc1128ecb5e11b3517.camel@linux.ibm.com>
Subject: Re: [PATCH v2 8/8] tests: Get the packages for pkcs11 testing on
 the CI/CD system
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 15:17:15 -0400
In-Reply-To: <20210810134557.2444863-9-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-9-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TIyl7ODjdUIUb7qMf6bnCMKH1HqTzs9J
X-Proofpoint-ORIG-GUID: TIyl7ODjdUIUb7qMf6bnCMKH1HqTzs9J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Get the packages for pkcs11 testing on the CI/CD system.
> 
> This is the status on various distros:
> 
> - Alpine: could not find package with pkcs11 engine
> - Alt Linux: works
> - Debian: debian:stable: evmctl is not able to find the pkcs11 module but
>           preceeding openssl command line tests with the pkcs11 URI succeeded;
>           cannot recreate the issue locally in the debian:stable container
>           --> disabled on Ubuntu and Debian
> - CentOS7: tests with pkcs11 URI fail on openssl command line level
> - CentOS: works
> - Fedora: works
> - OpenSuSE Leap: package not available in main repo
> - OpenSuSE Tumbleweed: works

In patch 7/8 there's a comment of requiring a certain release.  Should
there be a test for a specific version?  Then only run the pkcs11 tests
if that version or later is installed.

thanks,

Mimi

