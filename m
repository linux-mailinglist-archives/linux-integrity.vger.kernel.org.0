Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009B2931CD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgJSXKp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 19:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388045AbgJSXKp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 19:10:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JN3OZi050802
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 19:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3f+GA4GjU8ce1/3oSSKUYbI59kLG3xZ83jSJjL9yf8k=;
 b=N1YO4BSlWyWXXERerR3OaZ+6LkooP0TPDTREU7FGqHAxkxRgKhCXeWWkG910aXAOBkIW
 CiHM3apDEESSdFuLI+xefrOWpCynFiPP6jhb/Bi3YPdc2GAS7JUOeEeVBZCNSGPDeFMH
 OdpIoAWL+oJuINt2Kg7MCqyld0JSTetulMb8L4qPIEBung1NDyDoktb46O4FarnqrqQW
 uL9eDpIj4LTVpQHiytbWL9lmi80jqdVV+4gAXfCGwNNfOYNMYPG4KBHsha43Oq+5YAya
 nDBJk52gfmrl1h/DU8dM4fYkLyIK2kxeyzX+QBA63XzahrwWNxNP8uJtUt6ElTvffI/4 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349k7phhb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 19:10:45 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09JN3c1h052147
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 19:10:44 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349k7phhaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 19:10:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09JN8AKj030957;
        Mon, 19 Oct 2020 23:10:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 347r881awc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 23:10:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09JNAeNv29163994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 23:10:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3C67AE04D;
        Mon, 19 Oct 2020 23:10:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44CEAE045;
        Mon, 19 Oct 2020 23:10:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.104.43])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Oct 2020 23:10:38 +0000 (GMT)
Message-ID: <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <petr.vorel@gmail.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Mon, 19 Oct 2020 19:10:37 -0400
In-Reply-To: <20201019200803.35255-1-petr.vorel@gmail.com>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_13:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190154
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Dmitry Eremin-Solenikov]

Hi Petr,

On Mon, 2020-10-19 at 22:08 +0200, Petr Vorel wrote:
> This is required, because when TPM HW available (i.e. -c /dev/tpm0),
> evmctl ima_boot_aggregate returns sha1:xxxx.
> 
> skip requires to move cleanup().
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Nice.
> ---
> Hi Mimi,
> 
> this Fixes problems on current Debian, which has still disabled CONFIG_IMA
> (FYI [1]). I was not able to figure out how to get it working with
> sample-* files, but maybe there is a way.
> 
> Although it sound strange, people may want to build and check evmctl
> even on a system with disabled CONFIG_IMA (both Debian and Ubuntu have
> outdated ima-evm-utils (1.1)).

Oops, I need to keep Dmitry in the loop better.  I'm hoping to release
v1.3 shortly.

> 
> Kind regards,
> Petr
> 
> [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA

I wasn't aware that because of lockdown, IMA was disabled.  Thank you
for reporting and updating the IMA w/lockdown status.

Mimi

