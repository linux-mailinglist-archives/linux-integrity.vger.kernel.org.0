Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2953220CB
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBVU11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 15:27:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230194AbhBVU11 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 15:27:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MKEe5J139109;
        Mon, 22 Feb 2021 15:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tVmELn3VsCgeksMVtevqHAXOUtGg56LbMNv5Twg88uQ=;
 b=EkDjDcI2/uMtZ0wunrDGnlGtnLnkoFMGQk2BsOrvEAD9wyjJ8OKwPMMqil/U51eHsF0W
 OsR2i6/ITcUflF/SEGcXEtMghe8IX2YHAwZyuY9DIOwH/nOnmf75PCx7i8YBv4MQ3KXf
 PkmeiZdFtsq2kBqskXreSaTs9Aa1kyI5uRveAe3AbeFgLrwsQIfl1K3d57UtWEockzOH
 JAcItK4SK7o/zAIesHp9K3yEXgSNyleOS+kGUp0u2MAygm6Hs3ehIktR6I6nXpu8sn23
 A2MQoorvD5edbhgZqyNxqMkEC2RWBkQpq7vJ7ByBji7TvFYNJVnC6lGPKlteeQMaPYxE ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehs4mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 15:26:34 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MKGTOe030143;
        Mon, 22 Feb 2021 15:26:32 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehs441-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 15:26:31 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MIMwBG014578;
        Mon, 22 Feb 2021 18:37:44 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 36tt28rky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 18:37:44 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MIbhQS35389714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:37:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 992F578060;
        Mon, 22 Feb 2021 18:37:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F9DC7805E;
        Mon, 22 Feb 2021 18:37:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 18:37:42 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] add params and ids to support nist_p384
To:     Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210222175850.1131780-1-saulo.alessandre@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2e829730-bb0c-47eb-70f2-731c184eba33@linux.ibm.com>
Date:   Mon, 22 Feb 2021 13:37:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210222175850.1131780-1-saulo.alessandre@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220173
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/21 12:58 PM, Saulo Alessandre wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>
> * crypto/asymmetric_keys/x509_cert_parser.c
>    - prepare x509 parser to load nist_secp384r1
>
> * crypto/ecc_curve_defs.h
>    - add nist_p384 params
>
> * include/crypto/ecdh.h
>    - add ECC_CURVE_NIST_P384
>
> * include/linux/oid_registry.h
>    - reorder OID_id_ecdsa_with_sha1
>    - add OID_id_secp384r1
>
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>

I would separate this patch into an x509: and certs: part since it 
touches two subsystems.

I can take this series of patches and post my v9 including them at the 
end. This would make it easier for others to test. I would massage them 
a bit, including the separation of the 1st patch into 2 patches, if you 
don't mind, preserving your Signed-off-by. I need to fix something in my 
v8 regarding registration failure handling. Let me know whether this is 
fine with you.

I had tested your patches over the weekend with my endless test tool 
creating keys in user space and loading them into the kernel. It worked 
fine for NIST p256 & p384. Also signing kernel modules with NIST p384 is 
working fine.

So, for the series:

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Regards,

     Stefan


