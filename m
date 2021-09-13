Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E63409A1A
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhIMQ41 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 12:56:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239478AbhIMQ41 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 12:56:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DFA4oY017367
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nzEod4q31lAx1RssKCOXitvQKGDYcM4GVIgOn4JpFdU=;
 b=ZaJxFfQDVsSAR9l2rPHgjkhlYVDVHpoQfAqhqym7J66LW+Fo5wK105DkKsRUTwSLwGmu
 3Dn8GmlmFFpZTvAI8cPQPjI9EJBty1hunnCg6KahEgs/lNhBgCO8sQTySKmHf9Hq1NNY
 OaBUqkTQ0NkFveI9Uc5n7Jhj4leWQ7mI7oZGHDmQCqKos/Semo7AyAYWwUMRbGcjLA98
 fioLzGbU3BF3cLomxI+BpqzxTDbwFHITbejHfoXD5HEKooue1JNoNWmvJiAm5kbotlBf
 i5Qv+Sl5w1onA4tTWfjeZ3C31Q1QX1ZMO3YmSXRiEsKJg1SrE0kD6spFT6HcHs/VGM3V Pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b232an5ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:55:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DGrJZe014851
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:55:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m39k034-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:55:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DGt5w443581896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:55:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A936AA4065;
        Mon, 13 Sep 2021 16:55:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C0DA405B;
        Mon, 13 Sep 2021 16:55:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 16:55:04 +0000 (GMT)
Message-ID: <7dac3fc6fb3bea56add4336bdea142ea9a25a2da.camel@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] tests: Extend sign_verify test with
 pkcs11-specific test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 12:55:04 -0400
In-Reply-To: <20210908192343.4147739-9-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
         <20210908192343.4147739-9-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i7uc2JDpKod8UoQj-sivd7R9Lvjbuo8e
X-Proofpoint-ORIG-GUID: i7uc2JDpKod8UoQj-sivd7R9Lvjbuo8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130046
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 15:23 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Extend the sign_verify test with a pkcs11-specific test.
> 
> Since the openssl command line tool now needs to use a key provided by
> an engine, extend some command lines with the additional parameters
> '--keyform engine'. These parameters are passed using the global variable
> OPENSSL_KEYFORM, which is only set when pkcs11 URIs are used.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.  Much easier to review as an independent patch.
> ---
>  tests/functions.sh     | 45 ++++++++++++++++++++++++++++++++++++
>  tests/sign_verify.test | 52 ++++++++++++++++++++++++++++++------------
>  2 files changed, 83 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 91cd5d9..dce278b 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -272,3 +272,48 @@ _report_exit() {
>    fi
>  }
>  
> +# Cleanups when exiting
> +_at_exit() {
> +  _report_exit
> +  if [ -n "${WORKDIR}" ]; then
> +    rm -f "${WORKDIR}"
> +  fi
> +}

There's one caller of _report_exit().  I don't see a need to define a
new function.

thanks,

Mimi

