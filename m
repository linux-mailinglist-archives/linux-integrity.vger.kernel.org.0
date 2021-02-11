Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E500431957F
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 23:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhBKWCE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 17:02:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhBKWCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 17:02:03 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BLc5Io148905;
        Thu, 11 Feb 2021 17:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d/HqxlKlb26pm/VqCgs0DTnrXPTkCkRwt+28fyA5ybg=;
 b=PQ9RWi8NhcKyL0/4jdX0Vj6MEpiOiJl0gmNwatCGTTt7RsPZ/7qHQVe5FJs5MSuncSQQ
 U2u6cujBBg3AuKweXrYr7814YMLKgZIjxzLnZXMySFA2hc+cFXmI1LfYFdfJz1ZSrAt3
 PkoSuf4++1aleXgQx3w4hWU4H+SlPSrqECT75JDUcAL2RZSZyv0Lf9DgJ4yoSCZw1W2O
 ILA1Fj0UvxaKgsuq0fxnbpBcgsf12jNd72Mk1wUFPjyj869KZv/z/fjZsfR60hUWnFqr
 kwXdA7wrJmYyVlhWxEaHY/PyoWrKKt3eRmFcs6pBSw/OV3C/94dL9HB06RWH1jkUrqhT QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nck68fp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 17:01:21 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BLcHYe149142;
        Thu, 11 Feb 2021 17:01:18 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nck68fna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 17:01:18 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BLv2uo005777;
        Thu, 11 Feb 2021 22:01:16 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 36hjr9tyf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:01:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BM1FDP3408802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 22:01:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F9B0124077;
        Thu, 11 Feb 2021 22:01:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DB0B124078;
        Thu, 11 Feb 2021 22:01:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 22:01:15 +0000 (GMT)
Subject: Re: [PATCH 2/5] keys: generate self-signed module signing key using
 CSR
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-3-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c9e509fb-59df-28b4-654c-543cd922239c@linux.ibm.com>
Date:   Thu, 11 Feb 2021 17:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210211195435.135582-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110168
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 2:54 PM, Nayna Jain wrote:
> Loading a key on the IMA trusted keyring requires the key be signed
> by an existing key on the builtin or secondary trusted keyring.
> Creating a Certificate Signing Request (CSR) allows the certificate
> to be self-signed or signed by a CA.
>
> This patch generates a self-signed module signing key using CSR.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>   Makefile       |  3 ++-
>   certs/Makefile | 15 +++++++++++----
>   2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index af18aab6bbee..9c87fdd600d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1473,7 +1473,8 @@ MRPROPER_FILES += include/config include/generated          \
>   		  .config .config.old .version \
>   		  Module.symvers \
>   		  certs/signing_key.pem certs/signing_key.x509 \
> -		  certs/x509.genkey \
> +		  certs/x509.genkey certs/signing_key.key \
> +		  certs/signing_key.crt certs/signing_key.csr \
>   		  vmlinux-gdb.py \
>   		  *.spec
>   
> diff --git a/certs/Makefile b/certs/Makefile
> index f4c25b67aad9..b2be7eb413d3 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -60,11 +60,18 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>   	@$(kecho) "### needs to be run as root, and uses a hardware random"
>   	@$(kecho) "### number generator if one is available."
>   	@$(kecho) "###"
> -	$(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> -		-batch -x509 -config $(obj)/x509.genkey \
> -		-outform PEM -out $(obj)/signing_key.pem \
> -		-keyout $(obj)/signing_key.pem \
> +	$(Q)openssl req -new -nodes -utf8 \
> +		-batch -config $(obj)/x509.genkey \
> +		-outform PEM -out $(obj)/signing_key.csr \
> +		-keyout $(obj)/signing_key.key -extensions myexts \
>   		$($(quiet)redirect_openssl)
> +	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
> +		-outform PEM -out $(obj)/signing_key.crt \
> +		-signkey $(obj)/signing_key.key \
> +		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
> +		-extfile $(obj)/x509.genkey \
> +		$($(quiet)redirect_openssl)
> +	@cat $(obj)/signing_key.key $(obj)/signing_key.crt >> $(obj)/signing_key.pem


Could you not just rename signing_key.key to signing_key.pem (as it was 
before) and that would be it? Why do you need the .crt in that pem bundle?

    Stefan


