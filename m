Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55240000B
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhICM4S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:56:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhICM4R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:56:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CXobG170910
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zWNIeZABj4anv3W2WIwyyZTXcZJqZHqlonk8HwuADPM=;
 b=Fpjq6CU5+2dLa7hgP9wxbqMrG9w0aGG0mttBVlmIKlA9ulZa0Iz2eLyRkLMw+08TGoKy
 l1+HvneHF3T7raA8G5LKbVztyf0YjI1AhcsdFmKHOrslBqXdwZBAZ62fuQHriMmlWmfW
 1NZ5BqSZMaVynkyqQwF7EwEuDL2olDP+xiROo6I/Zne4hJdNhpF8BTbgArv8dDk6LZpx
 v8MvVCvcECKW2TwzEGUaSwTtqum59dP/a1yw8NmfRCNbi6FiMnw13RO5Za1S6ogLLy+9
 gHPkC9LpgGoeTD3DjhC79HeGHOWn0Drc0IVnl/exk6fZqKxz9rorsTNaoWFkFXD0ppV+ qA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3auj0wu7n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:55:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183CmB13002589
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:55:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3au6q78fdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:55:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183Cp5VN41157098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:51:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 608DBA405E;
        Fri,  3 Sep 2021 12:55:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F12BA405F;
        Fri,  3 Sep 2021 12:55:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 12:55:10 +0000 (GMT)
Message-ID: <95f0afde0cd006b57e44721b12051d77de2dd0ee.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] evmctl: Handle engine initialization properly
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 08:55:09 -0400
In-Reply-To: <20210810134557.2444863-3-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WFEIt2Pxbm_i0tAynCDJY3kMtgIiwH3Z
X-Proofpoint-ORIG-GUID: WFEIt2Pxbm_i0tAynCDJY3kMtgIiwH3Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=973 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Fix the following issue when passing a not available engine:

First describe the problem and then include details and/or an example. 
For example, "Handle failure to initialize the openssl engine.  For
example, "
> 
> $ ./src/evmctl --engine foo
> engine foo isn't available
> 140322992015168:error:25066067:DSO support routines:dlfcn_load:could not load the shared library:crypto/dso/dso_dlfcn.c:118:filename(/usr/lib64/engines-1.1/foo.so): /usr/lib64/engines-1.1/foo.so: cannot open shared object file: No such file or directory
> 140322992015168:error:25070067:DSO support routines:DSO_load:could not load the shared library:crypto/dso/dso_lib.c:162:
> 140322992015168:error:260B6084:engine routines:dynamic_load:dso not found:crypto/engine/eng_dyn.c:414:
> 140322992015168:error:2606A074:engine routines:ENGINE_by_id:no such engine:crypto/engine/eng_list.c:334:id=foo
> Segmentation fault (core dumped)
> 
> Also, jump to the exit when the setup of the engine failed.

Patch descriptions should not be explaining the details of the code,
but providing the motivation for the patch.  Please remove this line.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks,

Mimi

> ---
>  src/evmctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 58f8e66..ed0ece3 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2765,7 +2765,10 @@ int main(int argc, char *argv[])
>  				ENGINE_free(eng);
>  				eng = NULL;
>  			}
> -			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
> +			if (eng)
> +				ENGINE_set_default(eng, ENGINE_METHOD_ALL);
> +			else
> +				goto error;
>  			break;
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
> @@ -2839,6 +2842,7 @@ int main(int argc, char *argv[])
>  			err = 125;
>  	}
>  
> +error:
>  	if (eng) {
>  		ENGINE_finish(eng);
>  		ENGINE_free(eng);


