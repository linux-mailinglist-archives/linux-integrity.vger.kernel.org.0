Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A018F405C10
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhIIR2t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:28:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241827AbhIIR2j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:28:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189H3jru188562;
        Thu, 9 Sep 2021 13:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CR/nvOUdAvIQtLdTlccpbGY4QPolrwG1SvKun38fPk4=;
 b=H3XwWLobPdarjIsFI+eFhSJ4MqECKwRXHnJtqvRfGDhZh2xb4t5NH7lu6eeWpApHPS/u
 y7mfZEVKDsZ81tST8XzzDj3DlgSEOvU2ynxd16/Nr8fWN/CSwqqJ3V6AfYlCbM3MmIwr
 uwqCliPUePi+iypeKYb40+0RG0U39dFMDAuSm3UGlI6qL6AH6EQZWV6IOaZs+0+BMYOv
 3+mS/lgiaFBtp3E4QGeeH1/1syD8o7tDNHcse1QCs6my0SN6+pZXdeU8LYidoYOe4cDz
 meqj8U21PicmSjuE9TufykKoQ4F0jUhIFN5IVJyXXCbz3EIP+y5ur9PI19ywkpbOd6H2 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayn4xadsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:27:15 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189H4Bnl193025;
        Thu, 9 Sep 2021 13:27:14 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayn4xadrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:27:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189HNMTK032223;
        Thu, 9 Sep 2021 17:27:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3axcnp0ptr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 17:27:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189HR95o44433814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 17:27:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62E911C054;
        Thu,  9 Sep 2021 17:27:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1349B11C04A;
        Thu,  9 Sep 2021 17:27:05 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 17:27:04 +0000 (GMT)
Message-ID: <869f89657dddfd22c512ae5a1280ede93c0112cc.camel@linux.ibm.com>
Subject: Re: [PATCH v5 08/12] KEYS: integrity: change link restriction to
 trust the machine keyring
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
Date:   Thu, 09 Sep 2021 13:27:04 -0400
In-Reply-To: <20210907160110.2699645-9-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hfT3xieBQrcBLVJp_aiGXdYIiFJqEn5v
X-Proofpoint-GUID: vz9KJ9a_5bWAhgf6Ga_B4z4HdPA0g2pS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_05:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 955bd57815f4..747f0c528fec 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -89,7 +89,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>  	if (!restriction)
>  		panic("Can't allocate secondary trusted keyring restriction\n");
>  
> -	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
> +	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +		restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;

Returning the new restriction in a function named
get_builtin_and_secondary_restriction() is kind of weird.  Renaming the
function to get_secondary_restriction() would be clearer.

thanks,

Mimi

