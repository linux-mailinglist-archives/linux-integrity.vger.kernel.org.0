Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D834742B9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Dec 2021 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhLNMiA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Dec 2021 07:38:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229879AbhLNMh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Dec 2021 07:37:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEC9FVr026528;
        Tue, 14 Dec 2021 12:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hbZqTvW5RpWfz1tHUyVuzB89t1W/UKtkT/ce8c4PuTM=;
 b=AiCoTmCmwtSe9EgSNa7rl3KV2YbtNu9tE6yYyOtaOF0NCWSPRrf1vj3q9OPMYf1cyOAA
 QLD0QP1H746M+zpFvHkWr7BfgZWH636nbCE4kswt4iyFlkTWt1+5wEKIMRKPoP3/IG2f
 ntFR6EtWhoNvZ0WDmLp/SI03waXgbJ4m4lAWKafXmNBypFfatd2WKW4AASNumlVoCmgj
 tyaCBSooJJWTRQxB/In/yrH1hp87iQgCWNk1uhIjve4Ye3qn0MVKOiSJjVTriK7UM8AR
 3b8r+GBKAZOVMATB+Fah+JpkVZCjfl5hgvfbI3nYiSUwCwrn3sEDHuvLkROkqAPcF5Qh ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9raktus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 12:37:38 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BEBiSas008727;
        Tue, 14 Dec 2021 12:37:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9raktu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 12:37:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BECWLqs017901;
        Tue, 14 Dec 2021 12:37:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3cvkmaehnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 12:37:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BECbXVC43647348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 12:37:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFC87A405B;
        Tue, 14 Dec 2021 12:37:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B43FA4066;
        Tue, 14 Dec 2021 12:37:31 +0000 (GMT)
Received: from sig-9-65-91-220.ibm.com (unknown [9.65.91.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Dec 2021 12:37:31 +0000 (GMT)
Message-ID: <ec2ec0a9a7ba1adc6e54bbf7051a83ba90a39c0b.camel@linux.ibm.com>
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Yael Tiomkin <yaelt@google.com>, linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Tue, 14 Dec 2021 07:37:30 -0500
In-Reply-To: <20211213192030.125091-1-yaelt@google.com>
References: <20211213192030.125091-1-yaelt@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D5ObSYjxBMxL_UG1wLCE99QXZ86MxLfD
X-Proofpoint-GUID: YPhVzS-YIZzTG2fikzYR2viNWL3Iff8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_06,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112140072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Yael,

On Mon, 2021-12-13 at 14:20 -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. To support encryption of
> user-provided decrypted data, this patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data>.
> 
> Signed-off-by: Yael Tiomkin <yaelt@google.com>

Other than the comment below,
    Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Could you also provide an LTP test for defining, exporting, and loading
an encrypted key based on user provided key data?

thanks,

Mimi

> ---

> @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
>      82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0
>      24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
>  
> +Instantiate an encrypted key "evm" using user-provided decrypted data::
> +
> +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm.blob`" @u
> +    794890253

The existing references to "evm.blob" refer to the encrypted key data. 
Here "evm.blob" is unencrypted data.  Perhaps name it something like
"evm.user-provided-data" data.

> +
> +    $ keyctl print 794890253
> +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b382d
> +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0247
> +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> +

