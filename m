Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEF431A5B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 15:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhJRNIR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Oct 2021 09:08:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32938 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhJRNIN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Oct 2021 09:08:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IBNJlV022802;
        Mon, 18 Oct 2021 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JHqu1mijRiSzut0WGk7DdYnI3SYAL55J/NlDwTcqUCY=;
 b=SwUDScnagoVD+U13leNari1Y0UhPOI3lh9d4e2Ddnk6go8sRHnLqq07DqE5qWjnjhNPe
 LtRmejNK0bhxRmZ+ytZrW/gu25XCbhwxABWUNiYiJRB3Z+gU0F0yPC36lZgCQm1seTe9
 hAajMlbw+JJ1IxTZTjed4fbkDGgTwUBST6ToK3OLvPHuIGbdKjROcHcN+ZFdIVpx8A6I
 0pJd+w+Wc1oPi1wJh9cwMcxwq0sGMdfl/Qwxg8f8SD7NIxCsYDSl1vdDeq+TlBlqjNGC
 2Whq8EbR43zlChmpTJ8u5yif2hvWxkaXzfLA5bCqpNBrOIYbu4sDn8JECfthR0nUMHB1 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs59b5uv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 09:05:43 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19IBhs4T015460;
        Mon, 18 Oct 2021 09:05:42 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs59b5utm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 09:05:42 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19ID3mu7027884;
        Mon, 18 Oct 2021 13:05:40 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3bqpca4kj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 13:05:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19ID5d3L36962812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 13:05:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B0677807E;
        Mon, 18 Oct 2021 13:05:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4A17805C;
        Mon, 18 Oct 2021 13:05:36 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.92.132])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Oct 2021 13:05:36 +0000 (GMT)
Message-ID: <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] crypto: use SM3 instead of SM3_256
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 18 Oct 2021 09:05:34 -0400
In-Reply-To: <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W9BLSDdp9VyV7_uLEmmOk8JqFF2bjFga
X-Proofpoint-GUID: YMvxSYHVgCPLXkl9E97nxWayjNL_mobb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_05,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110180081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
[...]
> diff --git a/include/uapi/linux/hash_info.h
> b/include/uapi/linux/hash_info.h
> index 74a8609fcb4d..1355525dd4aa 100644
> --- a/include/uapi/linux/hash_info.h
> +++ b/include/uapi/linux/hash_info.h
> @@ -32,7 +32,7 @@ enum hash_algo {
>  	HASH_ALGO_TGR_128,
>  	HASH_ALGO_TGR_160,
>  	HASH_ALGO_TGR_192,
> -	HASH_ALGO_SM3_256,
> +	HASH_ALGO_SM3,
>  	HASH_ALGO_STREEBOG_256,
>  	HASH_ALGO_STREEBOG_512,
>  	HASH_ALGO__LAST

This is another one you can't do: all headers in UAPI are exports to
userspace and the definitions constitute an ABI.  If you simply do a
rename, every userspace program that uses the current definition will
immediately break on compile.  You could add HASH_ALGO_SM3, but you
can't remove HASH_ALGO_SM3_256

James


