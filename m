Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D543D2351
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 14:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGVLsC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 07:48:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbhGVLsC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 07:48:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16MC5UHD167297;
        Thu, 22 Jul 2021 08:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=ZnQxz/2pCHWa04niLAMnLAINUmWogN3eROPizQ9ia2s=;
 b=gNzXUDecHgZ0iGaMiDIYZZATPyicshKq9cP6El8vKKQZJiM4r09NE0fR7KM5Y0YVMezc
 GVKSZ1UaCL1WUL4nOziFLvnpK8EUQ79TjB09Swtw3HmzNgPUwchRSou8Oq/YcYDd0Big
 DLGAcJGYKqzvf8rl/8WAJTv1bOsVlu6c2eEn13fzyyWuf/c83/cwwuEJ4q2BIDA2s5J/
 /c1Q9ssKAGX+Nw9waZ16oLyB3U1fdUD/wXw9iw5h2Qea7klEwuXSFYGAE/0pQZ9IizIU
 VnRKP5UFzMXvLDtncll3JhurThViHXges5jY8UIE+Zj2C3SH/2e/WwDWoGIMUj8en7rK Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y7wrhfut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 08:28:29 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16MC6JuX171569;
        Thu, 22 Jul 2021 08:28:29 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y7wrhfts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 08:28:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16MCCQnu004739;
        Thu, 22 Jul 2021 12:28:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 39upu89fxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 12:28:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16MCSOes30998864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 12:28:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0FFFA4057;
        Thu, 22 Jul 2021 12:28:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44ABFA4059;
        Thu, 22 Jul 2021 12:28:22 +0000 (GMT)
Received: from sig-9-65-201-143.ibm.com (unknown [9.65.201.143])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jul 2021 12:28:22 +0000 (GMT)
Message-ID: <22d8ae657783ae11ad5bb0cca8346d45d1011733.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: Fix incorrect algorithm
 name in hash_info.gen
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Thu, 22 Jul 2021 08:28:21 -0400
In-Reply-To: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
References: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JHh5RnmPW9p31jbE5u6b95aroYFqfc1A
X-Proofpoint-ORIG-GUID: JFFEa365ynn1guD4zGEL_WXm5TCTNJt-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_04:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107220081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Thu, 2021-07-22 at 13:27 +0800, Tianjia Zhang wrote:
> There is no such an algorithm name as sm3-256. This is an ambiguity
> caused by the definition of the macro HASH_ALGO_SM3_256. The sed
> command is only a special case of sm3, so sm3 is used to replace
> the sm3-256 algorithm name.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  src/.gitignore    | 1 +
>  src/hash_info.gen | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/.gitignore b/src/.gitignore
> index 38e8e3c..69d2988 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -1 +1,2 @@
>  hash_info.h
> +tmp_hash_info.h
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> index 5f7a97f..f72db37 100755
> --- a/src/hash_info.gen
> +++ b/src/hash_info.gen
> @@ -86,7 +86,7 @@ sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
>    while read a b; do
>      # Normalize text hash name: if it contains underscore between
>      # digits replace it with a dash, other underscores are removed.
> -    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
> +    b=$(echo "$b" | sed "s/sm3_256/sm3/g;s/_//g")

Please update the comment associated with this change.

thanks,

Mimi

>      printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
>    done
>  echo "};




