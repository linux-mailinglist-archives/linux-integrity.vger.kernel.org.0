Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEFC405C07
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhIIR2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:28:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237190AbhIIR2Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:28:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189H3ijA037593;
        Thu, 9 Sep 2021 13:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IKpQQ8Wxt0timzoghIW1iHaMEffLR2BHH7UZAgGXYwo=;
 b=m+yBVsqkesjtSKsReWoVMvUH6rRQoZ2hQ2RMc/D106fvOCxqyu9WnRtYhUxwOL9a8+Eg
 QEe9EmaCBTgFLatWX6+6H83sR18JoeDRVfVvv946ESNz+j4HENJxLUWypqx3Fz3OvrE3
 LJgSTHcXDnSTcw4SGAhyjS5ZEVxNzFdOcL/zhjKbQ0pjZOlFMvTSoBzJZASpubk3GP/5
 /T4uTzjfgwaJ8PWN+pi34pyFxpzJbZyXZZmKhbhOCJXwvhBimJjx2WEwGmfMcjNj1vTs
 4ULdqOLoBYjVmPZgkJu8bsi/NKD8hdXCL8qYcPrbzCuYJcdfi0aV66z1s3AhuYS318v1 EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axmer85kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:26:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189HHGKR089134;
        Thu, 9 Sep 2021 13:26:58 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axmer85jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:26:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189HMFIx027050;
        Thu, 9 Sep 2021 17:26:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3axcnk7xuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 17:26:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189HMZWT55640506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 17:22:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D4952052;
        Thu,  9 Sep 2021 17:26:52 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 08B8C52057;
        Thu,  9 Sep 2021 17:26:47 +0000 (GMT)
Message-ID: <b8ba9facf525c60760b49da6cea50d701ad5613d.camel@linux.ibm.com>
Subject: Re: [PATCH v5 07/12] KEYS: Introduce link restriction to include
 builtin, secondary and machine keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 09 Sep 2021 13:26:47 -0400
In-Reply-To: <20210907160110.2699645-8-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-8-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2MxenG08BZPH0sCn54vK_BkFpLwz7v5y
X-Proofpoint-ORIG-GUID: Gs6CaKwto7JL_gcQvi-hKHp0HL9IN3a8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_06:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

The subject line above is too long.   According to
Documentation/process/submitting-patches.rst the "the ``summary`` must
be no more than 70-75 characters".

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> Introduce a new link restriction that includes the trusted builtin,
> secondary and machine keys. The restriction is based on the key to be added
> being vouched for by a key in any of these three keyrings.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v3: Initial version
> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
> v5: Rename to machine keyring
> ---
>  certs/system_keyring.c        | 23 +++++++++++++++++++++++
>  include/keys/system_keyring.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 08ea542c8096..955bd57815f4 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
>  }
> +
> +/**
> + * restrict_link_by_builtin_secondary_and_ca_trusted

Sorry for the patch churn.  With the keyring name change to ".machine",
the restriction name should also reflect this change.

thanks,

Mimi

