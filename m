Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79C43CBDFA
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhGPUsw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 16:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230415AbhGPUsu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 16:48:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GKYEjb185019;
        Fri, 16 Jul 2021 16:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=WABzUU79HHHgkIQwhmCkc0oXpoC+v9TZEgoEX894v6M=;
 b=Cr2ZMrEi7bIOk+wQS9aV/UrdzSXQwyQZlVu9gIwNGAtvWonLmKH33Exc4idUgx0MREzc
 1G61wo+D7XdE7qKN7UhI0RRPahJLknKyrAbpZIjLkT3le7/bUvpVpjuZDA8C0McpvhhD
 Y2tmXUyk7SDRBvTOXUNaIe3UQrAu4K9SzJSrF5BlxTu1aUfCpEpiib33JrGdipK42kzv
 U/YkozA2AFvqDWvzh2CNEuBizsWXXYvcxQLWcm83kuf9uGecpMOL0x+jbA3lZQLFSGsP
 j+qUT8t/OFkHWWLcQFr0jAPkYqkSQGeREdyPpB8/SjfnK0NJFqU5Ypom0JL5Xvbev7Rv Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tw2s8vtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:45:53 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16GKaHaE190362;
        Fri, 16 Jul 2021 16:45:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tw2s8vte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:45:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GKhdHL029440;
        Fri, 16 Jul 2021 20:45:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 39s3p78ycy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 20:45:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GKhXtc36372800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 20:43:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 286D7AE051;
        Fri, 16 Jul 2021 20:45:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB50DAE045;
        Fri, 16 Jul 2021 20:45:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 20:45:47 +0000 (GMT)
Message-ID: <866b61f6a4d95c68fbbbd2bd5511112795565c24.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: add an option to restrict the accepted hash
 algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>
Date:   Fri, 16 Jul 2021 16:45:46 -0400
In-Reply-To: <42353811-d8b1-0093-333a-3ca20bcf4861@viveris.fr>
References: <1fcf5b7f-00bc-7963-cb9e-c7e7e8278c9b@viveris.fr>
         <5dd1cc267f4b820c115e85210e1137c73c4e2562.camel@linux.ibm.com>
         <42353811-d8b1-0093-333a-3ca20bcf4861@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2esnr9u16i3R_bC_N858jWviE4vjwzh9
X-Proofpoint-ORIG-GUID: vCtEQaFcXVZ13RHbq5gLJK12xqUp85eg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107160130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Fri, 2021-07-16 at 09:18 +0000, THOBY Simon wrote:
> Off the top of my head, I see three main alternatives to expose this
> functionality:
> 1) Instead of supplying them at runtime in the kernel cmdline, add compile-time
> toggles that hardcode in the kernel the list of authorized algorithms and the
> expected behavior (verifying on write and/or verifying on appraisal). It would
> basically be the same thing as the proposed patch, but without involving new
> command line parameters. 

We also want to avoid defining new kernel Kconfig options, as much as
possible.

> 2) Use the ima_hash paramter as the sole authorized algorithm. I suppose this
> is what you meant by "limit file signature algorithms to those enabled on the
> system, unless you meant the algorithms built in the kernel with the
> CRYPTO_* compile options ?

By "limit file signature algorithms to those enabled on the system", I
was referring to the latter, not the"ima_hash" parameter.   That would
at least prevent writing file signatures based on unsupported hash
algorithms.   Thinking about it some more, the "ima_hash" might work
for some cases.  Continued below.

> 3) As you suggested, extend the policy DSL to limit the permitted hash
> algorithms. This yields the added advantage of flexibility: you can decide
> to restrict hashes for only some category of files/file systems, even though
> I'm don't see many use cases for such flexibility (but I hold no doubt
> someone somewhere would find some use to it).

In the embedded case, it's unlikely that different files would use
different hash algorithms for files signatures, but in the general case
different software packages could contain file signatures based on
different hash algorithms.

Defining an appraise rule "hash" option for enforcing sounds good.  The
"hash" option would be an allow list, which could be used for
transitioning from one hash algorithm to another.

In terms of writing the file signatures, the simpliest solution would
be to limit it to the "ima_hash" algorithm.   This might work in the
embedded case, but for the more general case it wouldn't.

> I would love to know if you think one of those alternatives would be better
> suited that the others for IMA, or if you thought of another option.

> As a side note, I would also like to thank profusely Lakshmi for his remarks
> on the patch  description and the process itself, as they will prove quite
> valuable when submitting new revisions of this patch!

Indeed, thanks Lakshmi!

thanks,

Mimi

