Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46673374D4F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 04:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEFCM6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 22:12:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229673AbhEFCM6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 22:12:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14623LMP108856;
        Wed, 5 May 2021 22:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lezD/6vTob2gJs8KUuUqsxLh1HiaeKmbFIi4UITsAKg=;
 b=P+/W3gbG9tn8aW1+nMsS+Qzuwo4oXWwxwCWdSE7r3l8sJ4TmFB3hvBEfdwuEqpkdPtw/
 Vf26Muh/eTuCcslrKnVW3ngjIygtEw6VKB9vuz4AYZvNv+Z5uM2Ap/mBkFBdhPNC6fDG
 2OhipTa81UHc+aldHNI2/Y0rQ3kkN7IIuk/8c6NrhGiAo4inKGyNZ8GPn59vKZKBxmeK
 Pqgb5uuPhC+EIsC+uCu1C43zzsZjofz/Yi3lRa+v2kbKcO77gKQsEI39snVVvfzmmtoB
 kYZnqnbivtDIQUE9RB87l7GViLw6Gk4EjYMEmAGq1jwSNwr/VXS+b3o4n5GObxNyqa6N fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c60bhstd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:11:58 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14623SoD112414;
        Wed, 5 May 2021 22:11:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c60bhst8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:11:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14628C5H026998;
        Thu, 6 May 2021 02:11:56 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 38bee0tpf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 02:11:56 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1462BuuM42074388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 02:11:56 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13CB2AC05B;
        Thu,  6 May 2021 02:11:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C2FAC059;
        Thu,  6 May 2021 02:11:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 02:11:55 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-3-vt@altlinux.org>
 <ed882d26-47a8-9b45-6c96-83d2f64982f2@linux.ibm.com>
 <20210506005453.6czsllqawzye4pzb@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <bf75b0aa-db69-f835-bfc7-6132baa9cf13@linux.ibm.com>
Date:   Wed, 5 May 2021 22:11:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506005453.6czsllqawzye4pzb@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R-lXVozD4BmV72PBlyRRxNHc6Qn52R0n
X-Proofpoint-ORIG-GUID: IyNPV3nTH88Qfd7CC-6EvZrNEqubY7L3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_11:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=859 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


>> That's confusing, two times the same result, one time in host order, on time
>> in network order. Why not just one return value in host order?
> Pointer API is similar to calc_keyid_v2().
>
> Do you sugegst to change calc_keyid_v2() API too?

No, we have to leave the existing API as-is.


>
> To introduce non-confusing API that contradict other parts of API would
> be more confusing than it already is.


Indeed. Sorry for the confusion.


 šš Stefan


