Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C862E36CFC0
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhD0X4c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:56:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236547AbhD0X4b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:56:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RNWvoO098022;
        Tue, 27 Apr 2021 19:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=46iY7jFbhjcupIQtKDb3AFYljhceRGKQ3g1Ou2G2UAs=;
 b=Bk7af0WSbvxTbqaG99F9skp3zYAZvNUK05VAs8QsgKF1L3inUFTqgTXZa/ilHUkFDbKT
 TBuUyFiruVBGAjskSfmuH5PRMQZCVc8oa3psGSYJNWaWa5x8Rf4l3CUDzGYTMlfTvFoi
 5RK2xXh61hexE5EUBCABUADTFkNYkjC2vmr4/Z/DOwrZAx5oNLpFzZu54psPKdFq1Dgu
 b14GqrjNWLr1TetPiQzUrH3DC0RZ1FPrtwJyXzEzpPck2huCo6uHqYE+nh5e+kPhviiQ
 tqUiWwaHyQuIZvpikW4P+bZX1GMsXP47inJZCIOuN9J5svE8xwxDpkySNCRNyawS0j2d hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386swdkvhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:55:46 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RNWvMo098019;
        Tue, 27 Apr 2021 19:55:45 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386swdkvhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:55:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RNr88r015200;
        Tue, 27 Apr 2021 23:55:45 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 384ay9q67p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 23:55:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RNtiiH37159370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 23:55:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CA0B136051;
        Tue, 27 Apr 2021 23:55:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 017BE13604F;
        Tue, 27 Apr 2021 23:55:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 23:55:43 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] tests: Add program to create IMA signature with
 new API call
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
 <20210427193133.1718367-3-stefanb@linux.ibm.com>
 <20210427222601.ednotpq7gur36g62@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e1f787a6-3308-6083-dbc5-2705fb7e7b88@linux.ibm.com>
Date:   Tue, 27 Apr 2021 19:55:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427222601.ednotpq7gur36g62@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P-6wva6Eof7zi6MbGC_fyZAiVW1UeecP
X-Proofpoint-GUID: XS2fE-0xyf7r1whT2FabtxKLJj8WU70t
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_13:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270160
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/27/21 6:26 PM, Vitaly Chikunov wrote:
> Stefan,
>
> On Tue, Apr 27, 2021 at 03:31:32PM -0400, Stefan Berger wrote:
>> Since the new API call is not used by evmctl, implement a test program
>> 'create_ima_signature' to use it. Extend _evmctl_sign to also created
>> IMA v2 signatures with RSA keys using this test program and compare the
>> results.
>>
>> Evmctl's signature creation path is unmodified at this point, so the tests
>> ensure that the existing sign_hash_v2 and the new sign_hash_v2_pkey create
>> identical (RSA) signatures.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tests/Makefile.am            |   6 ++
>>   tests/create_ima_signature.c | 111 +++++++++++++++++++++++++++++++++++
> Why not add this to evmctl?


evmctl has 3 callers to the 'competing' function sign_hash(), all of 
which of course let the code path under sign_hash() read the key from 
the file (and access the keypassword via a global variable :(( ). I 
didn't want to pull up the reading of the key into evmctl, which we 
would have to do in case we wanted to call this new function. Also then 
the question is which callers to replace? All of them, or which ones?

