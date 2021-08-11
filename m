Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1238A3E98ED
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhHKTlY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 15:41:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhHKTlX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BJXKQf103750;
        Wed, 11 Aug 2021 15:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Nwavi1JOLI9WGLZ+W3iKHcpufrFlG5I2FU0J8zpqshc=;
 b=nTWKAOM4H7uQAcMm6AZlAQJh1YPmI6To5RM9cTcVMI9t14Wkfk/ZZNdWX4tADABr0ABd
 B7UexbQfCD6MSahhHPJJDZ8vgtaaELygwBXlTyOAkQB14wlXGEeI+YmM/C1Jyf29Pqq5
 koFWRgpXaA3cHnQSILEiP6fECdhxlz5bIPEfBmPQL41maD3blWhnSDrm7JS0FqwowRON
 unnoIpuNf50O9bVBORbLVzcwD33xvluhBiCj2oZ1h4RzxUm9Bk5fkCcsU9lh3nzVW2lK
 E7KIKdbX70iosmRLsUFyx/Fr+MC7U7pqang/ofc+K+R2MpXJ3UDqBdV/omupX+ptfDo8 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abvtevm0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 15:40:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17BJZ2J4113048;
        Wed, 11 Aug 2021 15:40:59 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abvtevkyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 15:40:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BJbj4N031069;
        Wed, 11 Aug 2021 19:40:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3acfpg8bbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 19:40:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BJbdeO47776122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 19:37:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11BAB4C050;
        Wed, 11 Aug 2021 19:40:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05C94C052;
        Wed, 11 Aug 2021 19:40:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.36.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 19:40:52 +0000 (GMT)
Message-ID: <f06d6b278bf228d21bf3ec01da8173e6518557f9.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/5] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     linux-audit@redhat.com
Date:   Wed, 11 Aug 2021 15:40:51 -0400
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bFqnP9XBW_lefSwqjA5v9vF3cphPNZEt
X-Proofpoint-ORIG-GUID: OQXI5cr_vAZZdY6hBum6dWSsqjrRRyUZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_06:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110133
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing linux-audit]

Hi Simon,

On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:

Other than the two questions on " IMA: add a policy option to restrict
xattr hash algorithms on appraisal" patch, the patch set is looking
good.

thanks,

Mimi

> Here is also a short description of the new audit messages, but I can
> send it in a followup mail if that is not the proper place:
> 
> When writing the xattr with an algorithm not built in the kernel (here the
> kernel was built with CONFIG_CRYPTO_MD5 unset), e.g. with
> "evmctl ima_hash -a md5 /usr/bin/strace":
> 	audit(1628066120.418:121): pid=1344 uid=0 auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=set_data cause=unavailable-hash-algorithm comm="evmctl" name="/usr/bin/strace" dev="dm-0" ino=2632657 res=0 errno=0
> 
> With the same command and the policy rule
> "appraise func=SETXATTR_CHECK appraise_algos=sha256,sha384,sha512", we get:
> 	audit(1628066210.141:127): pid=1362 uid=0 auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=set_data cause=denied-hash-algorithm comm="evmctl" name="/usr/bin/strace" dev="dm-0" ino=2632657 res=0 errno=0
> 
> Note that the cause is now 'denied-hash-algorithm' instead of
> 'unavailable-hash-algorithm'. We get that audit message for any algorithm
> outside of sha256/384/512 (including algorithms not compiled in the kernel
> like MD5). In a sense, 'denied-hash-algorithm' takes predecence over
> 'unavailable-hash-algorithm'.
> 
> When appraising files, e.g. trying to execute a file whose xattr was hashed
> with sha1 while the policy rule
> "appraise func=BPRM_CHECK fowner=0 appraise_algos=sha256" is enabled:
> 	audit(1628066349.230:130): pid=1369 uid=0 auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=collect_data cause=denied-hash-algorithm comm="bash" name="/usr/bin/strace" dev="dm-0" ino=2632657 res=0 errno=0
> 
> 
> This series is based on the following repo/branch:
>  repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>  branch: next-integrity-testing
>  commit e37be5343ae2b9419aea1442b07e5d2428b437b4 ("Merge branch 'ima-buffer-measurement-changes-v4' into next-integrity")


