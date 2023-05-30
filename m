Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B5716B70
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjE3RqG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjE3RqB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 13:46:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3896FD9;
        Tue, 30 May 2023 10:45:59 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UHhDn9025404;
        Tue, 30 May 2023 17:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D70WWLtoNscqH6i7mk78YhwrreiuX9n+hLmEciva19U=;
 b=D8yOCt+dAW9L2av8EqkM95WRDaoeRCJwRRg+5zRm589vAPFpIYqaUppaL3jaLklCVO90
 mgzT3cHLLJqaOMYtB9XrsnKN90kyZZXmRHdIMxqCeLhIczPOLkcBrrqY9vjoEJWmj6Ew
 6ye+KAW4jxJKuBdHH0XwKm+vq9igqeczv2Ks+Syci41q7Letdc8rxltUufjGwlrZQEp8
 5vSOtqf9N9G5eEb6dcn+EJOFkPChh39kosjjLucaJP6l5cuy25eaYH9qDhPAiRuGtmFF
 BrCj1nt6ZUR+/02Xw0wdBwDx9mw2kyDlsSkfrzkulw7eOfmHMl3gmS9HfMl/Gus+0zJU Bg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwjej5vu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 17:45:51 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDdMuA009536;
        Tue, 30 May 2023 17:45:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5qwby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 17:45:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UHjn5X6947354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 17:45:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85FDC5805E;
        Tue, 30 May 2023 17:45:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2D7E58045;
        Tue, 30 May 2023 17:45:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 17:45:48 +0000 (GMT)
Message-ID: <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
Date:   Tue, 30 May 2023 13:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20230530020133.235765-1-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230530020133.235765-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XenJoXPzC-n5mu-ndWws4ddie8fZNLS1
X-Proofpoint-GUID: XenJoXPzC-n5mu-ndWws4ddie8fZNLS1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=632
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/29/23 22:01, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> 

> -	rc = copy_to_user(buf, proxy_dev->buffer, len);
> +	if (buf)
> +		rc = copy_to_user(buf, proxy_dev->buffer, len);
> +

Looking through other drivers it seems buf is always expected to be a valid non-NULL pointer on file_operations.read().


https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/tlb.c#L1279   simple_read_from_buffer will pass the pointer to the user buffer along and it ('to') ends up in copy_to_user(to, ...);


Same here: https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L41
