Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12433D39CF
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhGWLOv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 07:14:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234764AbhGWLOr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NBXj0j033109;
        Fri, 23 Jul 2021 07:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Cn+P9qBH5i4kbzklhGtWVm8zBdiTsR+I3UT44kiMZ/8=;
 b=fT2Bss9MTkdeJdWNNy2nFs6CUjE+uFi5qnmcPuA7Fm6uTSNn+ns2lMPCAbRriknGBQ23
 r9OZRQfxIRI7iwUfT+RnzGT75razkWScKLGUIZiNglZNf69t3LrYeVCIHVAeVGRGwuYo
 R9cxYDwoPA/6sYTSSO17b32G1LRw4GtPyU0SjV8Cz9W/rNzRBpblIQTSeIF3n7xMkVxh
 DcqpRgmVINHex1zcO1PULpcObuuxO8BvfeO+iIB1/ItB47DDN2P6StkUMJj2/epT+9Hk
 EPtME8UlItQ9hS1d0C+rsJJJiOwM5nygd4iltFp+XmrEaO6XUTySOropSgE+66FqbeEc kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yuubtgp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:55:15 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NBYYfA035905;
        Fri, 23 Jul 2021 07:55:15 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yuubtgn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:55:15 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NBmY8B012118;
        Fri, 23 Jul 2021 11:55:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 39upu89u55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 11:55:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NBqgon22151486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 11:52:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59406AE057;
        Fri, 23 Jul 2021 11:55:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7481AE051;
        Fri, 23 Jul 2021 11:55:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.74.193])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 11:55:08 +0000 (GMT)
Message-ID: <4b3c3c5e26e3f64bd3c0cea5eca6b7e515f58627.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] ima-evm-utils: Fix incorrect algorithm
 name in hash_info.gen
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Fri, 23 Jul 2021 07:55:07 -0400
In-Reply-To: <20210723064108.14681-1-tianjia.zhang@linux.alibaba.com>
References: <20210723064108.14681-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lfXFnGf4i_WSUrgTwRiFJ7CZvsJQmRP5
X-Proofpoint-GUID: BtXUpaUeMzfwuu47z0V0JNOiubc6oP8D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_05:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Fri, 2021-07-23 at 14:41 +0800, Tianjia Zhang wrote:
> There is no such an algorithm name as sm3-256. This is an ambiguity
> caused by the definition of the macro HASH_ALGO_SM3_256. The sed
> command is only a special case of sm3, so sm3 is used to replace
> the sm3-256 algorithm name.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  src/.gitignore    | 1 +
>  src/hash_info.gen | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/.gitignore b/src/.gitignore
> index 38e8e3c..69d2988 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -1 +1,2 @@
>  hash_info.h
> +tmp_hash_info.h
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> index 5f7a97f..f52bb4d 100755
> --- a/src/hash_info.gen
> +++ b/src/hash_info.gen
> @@ -84,9 +84,10 @@ echo "};"
>  echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
>  sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
>    while read a b; do
> -    # Normalize text hash name: if it contains underscore between
> -    # digits replace it with a dash, other underscores are removed.
> -    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
> +    # Normalize text hash name: sm3 algorithm name is different from
> +    # the macro definition, which is also the only special case, and
> +    # underscores are removed.

Thank you for updating the comment.  Do you mind if I tweak it a bit:

^which is also the only special case of an underscore between digits. 
Remove all other underscores.

Mimi

> +    b=$(echo "$b" | sed "s/sm3_256/sm3/g;s/_//g")
>      printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
>    done
>  echo "};"


