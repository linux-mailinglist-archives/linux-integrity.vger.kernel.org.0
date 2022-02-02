Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16E4A7122
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiBBMzu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 07:55:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbiBBMzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 07:55:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212AekuH015286;
        Wed, 2 Feb 2022 12:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zeswlkAxStLCD9AUMlaDRFijspzLCsEycfEF1UtQJuU=;
 b=Bi91+InWGHvs8TcgtwsHaIRwxJiB2MNV0i6IOKvZcKjuCWzo9DjSHc8nCo5Mnm7UwZ1x
 jc5pBgDeInyHLYujULcZDEhrsA66JvTdOnP1G0/w1n16wlTcXMeyDAizsjVBsi+n5MbS
 5MhFm5wNAMh/jauPYjFQDbLGDG/b5G2Pnap0zi95Ws6YUe80ssZtU0dadpp9iwjUuzhZ
 uPao6uNSy6QRcIg7Oob04pDnayvdG1n8BrjwYMAimBc2Zm3CZ1r0iUPHwf36LCG6d0j3
 cGGEoNdVdCFXIvL7O6Tox/WjbF6aoVfXok9rUivTITFYMvBxOtWY3AsHZU848b7Nydrs 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dym3gf8pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 12:55:46 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212Cdrrc021978;
        Wed, 2 Feb 2022 12:55:45 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dym3gf8p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 12:55:45 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212CmdP6020595;
        Wed, 2 Feb 2022 12:55:44 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3dvw7bdhc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 12:55:44 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212CthED42861006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 12:55:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 997EBAE05F;
        Wed,  2 Feb 2022 12:55:43 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C097AE064;
        Wed,  2 Feb 2022 12:55:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 12:55:43 +0000 (GMT)
Message-ID: <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
Date:   Wed, 2 Feb 2022 07:55:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Content-Language: en-US
To:     Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220202065906.2598366-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UJG6tWGYH90PXu3y_n590Xc3XPIe-SW5
X-Proofpoint-GUID: p5qSS0QwBzqR_LRhObcAjxcm6MWyq742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_06,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 01:59, Vitaly Chikunov wrote:
> Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> does not pass in/out sizes check in keyctl_pkey_params_get_2.
> This in turn because these values cannot be distinguished by a single
> `max_size' callback return value.
> Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> algorithms.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

How do you use pkey_query?

$ keyctl padd asymmetric testkey %keyring:test < cert.der
385037223
$ keyctl pkey_query 385037223 ''
Password passing is not yet supported
$ keyctl pkey_query 385037223
Format:
   keyctl --version
   keyctl add <type> <desc> <data> <keyring>
[...]

$ keyctl unlink 385037223
1 links removed


