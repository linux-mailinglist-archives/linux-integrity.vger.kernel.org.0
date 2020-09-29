Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D027DA42
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 23:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgI2VjV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 17:39:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgI2VjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 17:39:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TLXAvO181048;
        Tue, 29 Sep 2020 17:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=monExn7EQTsZRTejbD7TuStj+tMEisGciB966Ur7vYY=;
 b=rWY3MZdXI26me8iMI0P+HF0clTIXn67vysS/o+1fEeR/MW7HqN1Rsr4Cl7N7+SEo5Yuh
 oDJV4X5rMWhHcQ8CF9eS/+ECB9PViYSQNLmp2kPs8hpT9TVX0opZI12F8hkJIKTf2A0w
 Bw4xU17nelW4ZJrDtsSXzXFWteuX3UqGulZ0HsTbaEhhljSqA5YFnRUdr49djBbEqc1D
 wlA7Qk9CWCxSBJ0o8BEgAKu1/boJPcStOo58Dp0jm6K1+LxUwdrGqqBbj9J5wPSCOn/I
 w6VjexsirLColCeSUTgM6ed7CKKg705vaL+9cwtDVl1thmXHrnebZChJCpibe1lBBiZf nA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vbhmjgdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 17:39:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TLc3YH019803;
        Tue, 29 Sep 2020 21:39:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgrafn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 21:39:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TLdA2a22217144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 21:39:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A89DAE053;
        Tue, 29 Sep 2020 21:39:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED742AE04D;
        Tue, 29 Sep 2020 21:39:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.38])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 21:39:08 +0000 (GMT)
Message-ID: <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] IMA: Rewrite ima_boot_aggregate.c to new API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 29 Sep 2020 17:39:06 -0400
In-Reply-To: <20200929165021.11731-3-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
         <20200929165021.11731-3-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290184
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> The main reason was to see TCONF messages, which are printed into stderr
> in new API (but to stdout in legacy API) and thus visible as the output
> is redirected into the variable.
> 
> Changing boot_aggregate: to sha1: to be compatible with evmctl
> ima_boot_aggregate.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

<snip>

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index c69f891f1..dc958eb5c 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -33,7 +33,7 @@ test1()
>  			tst_res TFAIL "bios boot aggregate is not 0"
>  		fi
>  	else
> -		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
> +		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
>  		if [ "$boot_hash" = "$boot_aggregate" ]; then
>  			tst_res TPASS "bios aggregate matches IMA boot aggregate"
>  		else

The original "ima" template is just the hash digest, without the
algorithm.

Mimi

