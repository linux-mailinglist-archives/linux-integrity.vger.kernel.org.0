Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F697375C18
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 22:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEFUL2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 May 2021 16:11:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231270AbhEFUL2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 May 2021 16:11:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146K3QUK153757;
        Thu, 6 May 2021 16:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ANJjDpNQ8636QtLnQrHn186lLMefa5Ur4+RxzIwRH8=;
 b=Va4Qt0fC75a4y4YCyaBNgIdJAPxEHPywS/nZHIyJrAcPCZp2BFlDbRPnSj/NOx9j/0wu
 NyhMTh6F6RbBhfXQSP6dxxZQrnBFrChsPVQlR+tGde9q8Cg6pGlg5ZAT6ucwUs0cyW7P
 PwB5qsxkdI2rwnB3Fx7i+jMFjtN7wYs/ds0z0FMPLvYa58XVDksDnn7n0+kzJXuxgmT7
 T9O3MePb9szfzJKRmSDaDaV2toRGaqF2LlMYURawrzUG2WZZOgwg8DvfzCboD0uAOP0G
 uzur150aZxw1jLXrUgwdQNBalYV4togMrzfDhQFG+cE7Tk7lShd+M8IsB5K5ToUpDf0D 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38cnx0285w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:10:27 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 146K402D158935;
        Thu, 6 May 2021 16:10:27 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38cnx0285n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:10:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146K7gvl019308;
        Thu, 6 May 2021 20:10:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 38bedre870-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 20:10:26 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146KAQjw12976480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 20:10:26 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05FF12405B;
        Thu,  6 May 2021 20:10:25 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0FD124055;
        Thu,  6 May 2021 20:10:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 20:10:25 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] ima-evm-utils: Add --keyid option
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210506034702.216842-1-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a187174e-9a57-9aad-790b-41eaca424e35@linux.ibm.com>
Date:   Thu, 6 May 2021 16:10:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506034702.216842-1-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YpxkrVp-77CAP3PuLSd4NzHHU4uBiMab
X-Proofpoint-ORIG-GUID: 6dbSDpFkBJT2sbP7A6UQz5MKwLh4JjbI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 11:46 PM, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate. When keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
> Certificate @filename could be used instead of the hex number. And,
> third option is to read keyid from the cert appended to the key file.
>
> These commits create backward incompatible ABI change for libimaevm,
>   thus soname should be incremented on release.

I hope this will not be forgotten about. Maybe it should be part of this 
series here?


