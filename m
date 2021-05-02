Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607E370A0D
	for <lists+linux-integrity@lfdr.de>; Sun,  2 May 2021 06:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhEBE2k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 May 2021 00:28:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhEBE2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 May 2021 00:28:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14243PDZ175943;
        Sun, 2 May 2021 00:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lkJ7uw1E/i0beIQNleI4oVycercEZtCor2YyN6Sga6I=;
 b=iHC5ZcXTc2Mveo8tFgbd8x2clOdWQ3248axo4fZXw5wIz82oHT8ff94bI6r7nawFQXf2
 xMYopj56/tZAPsT+Jo6LkosfvqdpkCFX/we3QR7VWbtTl5in4QcAwkLEDv4kBoSweSIg
 9sqp4M+BoKkcxLlmPqjvRQzvXUUQzUE0zK1/hsqLrTci5XMeX9gih1pYtGWk2dDn2Vp0
 xBI7KI+My08fh6mklggpV6qTtMQ0wOWeHVVt5rXcz4TMoNg/7NZQ/UNpGudAstrOR9pT
 wftiYd6gXdW4Php1Z6s6Yh/W71GbuC5uyNiZMn+6OtNuLfsg+77XdlZytW+Ua+ZknnKl AA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 389kw4s15e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 00:27:48 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1424Rk14016765;
        Sun, 2 May 2021 04:27:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 388x8h8569-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 04:27:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1424RIHY36962728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 May 2021 04:27:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BB2E42042;
        Sun,  2 May 2021 04:27:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B9634203F;
        Sun,  2 May 2021 04:27:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.36.166])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  2 May 2021 04:27:41 +0000 (GMT)
Message-ID: <6eb8f66b6f297bcab82c2f5e8c4cd2d4dbcffda7.camel@linux.ibm.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.13
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 02 May 2021 00:27:40 -0400
In-Reply-To: <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
References: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
         <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oNuFlK-ehvk2G6FgO20jpZbVKnrPch3p
X-Proofpoint-ORIG-GUID: oNuFlK-ehvk2G6FgO20jpZbVKnrPch3p
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-02_02:2021-04-30,2021-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105020028
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-05-01 at 15:49 -0700, Linus Torvalds wrote:
> On Wed, Apr 28, 2021 at 6:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > In addition to loading the kernel module signing key onto the builtin
> > keyring, load it onto the IMA keyring as well.
> 
> This clashed pretty badly with the other cert changes.
> 
> I think the end result looks nice and clean (the cert updates mesh
> well with the _intention_ of your code, just not with the
> implementation), but you should really double-check that I didn't mess
> anything up in the merge and whatever test-case you have for IMA still
> works.
> 
> I only verified that the kernel module signing key still works for
> modules - no IMA test-case.

I'm really sorry I forgot to mention in the pull request that Stephen
was carrying a merge conflict fix.  Everything looks good.  I tested
it, making sure that the kernel module signing key is loaded onto the
builtin and/or IMA keyrings properly.

thanks,

Mimi

